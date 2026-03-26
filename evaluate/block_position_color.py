#!/usr/bin/env python3
"""UI image similarity evaluator based on component detection."""

import cv2
import numpy as np
from scipy.optimize import linear_sum_assignment
from dataclasses import dataclass, field
from typing import List, Tuple, Dict, Optional
import argparse
import os
import csv
from pathlib import Path
import json


@dataclass
class UIBlock:
    """UI component block."""
    x: int
    y: int
    w: int
    h: int
    area: float = 0.0
    aspect_ratio: float = 0.0
    color_hist: np.ndarray = field(default_factory=lambda: np.array([]))
    dominant_color: Tuple[int, int, int] = (0, 0, 0)
    block_type: str = "unknown"  # 'text', 'button', 'card', 'image', 'container'
    confidence: float = 0.0

    @property
    def center(self) -> Tuple[float, float]:
        return (self.x + self.w / 2, self.y + self.h / 2)

    @property
    def bbox(self) -> Tuple[int, int, int, int]:
        return (self.x, self.y, self.w, self.h)

    def normalized_center(self, img_w: int, img_h: int) -> Tuple[float, float]:
        cx, cy = self.center
        return (cx / img_w, cy / img_h)

    def normalized_size(self, img_w: int, img_h: int) -> Tuple[float, float]:
        return (self.w / img_w, self.h / img_h)


class UIBlockDetector:
    """Multi-strategy UI block detector."""

    def __init__(self):
        self.min_block_area = 200
        self.max_block_area_ratio = 0.8
        self.min_aspect_ratio = 0.1
        self.max_aspect_ratio = 10.0

    def detect(self, image: np.ndarray) -> List[UIBlock]:
        """Detect UI blocks using multiple strategies."""
        if image is None:
            return []

        h, w = image.shape[:2]
        all_blocks = []

        mser_blocks = self._detect_mser(image)
        all_blocks.extend(mser_blocks)

        edge_blocks = self._detect_edges(image)
        all_blocks.extend(edge_blocks)

        color_blocks = self._detect_color_regions(image)
        all_blocks.extend(color_blocks)

        merged_blocks = self._merge_overlapping_blocks(all_blocks, w, h)
        filtered_blocks = self._filter_and_classify(merged_blocks, image)

        return filtered_blocks

    def _detect_mser(self, image: np.ndarray) -> List[UIBlock]:
        """Detect text and small components using MSER."""
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

        mser = cv2.MSER_create()
        mser.setMinArea(100)
        mser.setMaxArea(50000)
        mser.setDelta(5)

        regions, _ = mser.detectRegions(gray)

        blocks = []
        for region in regions:
            if len(region) < 5:
                continue

            x, y, w, h = cv2.boundingRect(region.reshape(-1, 1, 2))

            if w < 20 or h < 10:
                continue

            block = UIBlock(
                x=x, y=y, w=w, h=h,
                area=w * h,
                aspect_ratio=w / max(h, 1),
                confidence=0.7
            )
            blocks.append(block)

        return blocks

    def _detect_edges(self, image: np.ndarray) -> List[UIBlock]:
        """Detect containers and cards using edge detection."""
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

        blurred = cv2.bilateralFilter(gray, 9, 75, 75)
        edges = cv2.Canny(blurred, 50, 150)

        kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5, 5))
        closed = cv2.morphologyEx(edges, cv2.MORPH_CLOSE, kernel, iterations=2)

        contours, _ = cv2.findContours(closed, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        blocks = []
        h, w = image.shape[:2]
        total_area = h * w

        for cnt in contours:
            area = cv2.contourArea(cnt)

            if area < self.min_block_area:
                continue
            if area > total_area * self.max_block_area_ratio:
                continue

            x, y, bw, bh = cv2.boundingRect(cnt)

            aspect = bw / max(bh, 1)
            if aspect < self.min_aspect_ratio or aspect > self.max_aspect_ratio:
                continue

            peri = cv2.arcLength(cnt, True)
            approx = cv2.approxPolyDP(cnt, 0.05 * peri, True)

            rect_area = bw * bh
            extent = area / rect_area if rect_area > 0 else 0
            confidence = 0.6 + 0.3 * extent

            block = UIBlock(
                x=x, y=y, w=bw, h=bh,
                area=area,
                aspect_ratio=aspect,
                confidence=min(confidence, 0.95)
            )
            blocks.append(block)

        return blocks

    def _detect_color_regions(self, image: np.ndarray) -> List[UIBlock]:
        """Detect color regions using color clustering."""
        lab = cv2.cvtColor(image, cv2.COLOR_BGR2Lab)
        filtered = cv2.pyrMeanShiftFiltering(lab, 20, 45)
        filtered_bgr = cv2.cvtColor(filtered, cv2.COLOR_Lab2BGR)
        gray = cv2.cvtColor(filtered_bgr, cv2.COLOR_BGR2GRAY)

        thresh = cv2.adaptiveThreshold(
            gray, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
            cv2.THRESH_BINARY_INV, 25, 10
        )

        kernel = cv2.getStructuringElement(cv2.MORPH_ELLIPSE, (5, 5))
        cleaned = cv2.morphologyEx(thresh, cv2.MORPH_OPEN, kernel, iterations=1)
        cleaned = cv2.morphologyEx(cleaned, cv2.MORPH_CLOSE, kernel, iterations=2)

        contours, _ = cv2.findContours(cleaned, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

        blocks = []
        h, w = image.shape[:2]
        total_area = h * w

        for cnt in contours:
            area = cv2.contourArea(cnt)

            if area < self.min_block_area * 2:
                continue
            if area > total_area * 0.5:
                continue

            x, y, bw, bh = cv2.boundingRect(cnt)

            aspect = bw / max(bh, 1)
            if aspect < self.min_aspect_ratio or aspect > self.max_aspect_ratio:
                continue

            block = UIBlock(
                x=x, y=y, w=bw, h=bh,
                area=area,
                aspect_ratio=aspect,
                confidence=0.5
            )
            blocks.append(block)

        return blocks

    def _merge_overlapping_blocks(self, blocks: List[UIBlock], img_w: int, img_h: int) -> List[UIBlock]:
        """Merge overlapping blocks, keep highest confidence ones."""
        if not blocks:
            return []

        blocks = sorted(blocks, key=lambda b: b.confidence, reverse=True)

        merged = []
        used = set()

        for i, b1 in enumerate(blocks):
            if i in used:
                continue

            for j in range(i + 1, len(blocks)):
                if j in used:
                    continue

                b2 = blocks[j]
                iou = self._compute_iou(b1.bbox, b2.bbox)

                if iou > 0.6:
                    used.add(j)
                elif self._is_contained(b1.bbox, b2.bbox):
                    used.add(j)

            merged.append(b1)

        return merged

    def _filter_and_classify(self, blocks: List[UIBlock], image: np.ndarray) -> List[UIBlock]:
        """Filter noise and classify blocks."""
        h, w = image.shape[:2]
        total_area = h * w

        result = []

        for block in blocks:
            x1 = max(0, block.x)
            y1 = max(0, block.y)
            x2 = min(w, block.x + block.w)
            y2 = min(h, block.y + block.h)

            if x2 <= x1 or y2 <= y1:
                continue

            roi = image[y1:y2, x1:x2]
            hsv_roi = cv2.cvtColor(roi, cv2.COLOR_BGR2HSV)

            h_hist = cv2.calcHist([hsv_roi], [0], None, [16], [0, 180])
            s_hist = cv2.calcHist([hsv_roi], [1], None, [16], [0, 256])
            v_hist = cv2.calcHist([hsv_roi], [2], None, [16], [0, 256])

            cv2.normalize(h_hist, h_hist, norm_type=cv2.NORM_L1)
            cv2.normalize(s_hist, s_hist, norm_type=cv2.NORM_L1)
            cv2.normalize(v_hist, v_hist, norm_type=cv2.NORM_L1)

            combined = np.vstack([h_hist, s_hist, v_hist]).flatten()
            sum_val = np.sum(combined)
            if sum_val > 0:
                combined = combined / sum_val
            block.color_hist = combined

            mean_hsv = cv2.mean(hsv_roi)[:3]
            block.dominant_color = tuple(int(v) for v in mean_hsv)
            block.block_type = self._classify_block(block, roi)

            if block.area < self.min_block_area:
                continue
            if block.area > total_area * 0.7:
                continue

            result.append(block)

        result.sort(key=lambda b: b.area, reverse=True)
        return result

    def _classify_block(self, block: UIBlock, roi: np.ndarray) -> str:
        """Classify block type based on geometry."""
        aspect = block.aspect_ratio
        h, w = roi.shape[:2]

        if aspect < 0.15:
            return "divider"
        elif aspect > 5:
            return "divider"
        elif h < 40 and aspect > 2:
            return "text"
        elif aspect > 2.5:
            return "text"
        elif aspect > 1.5:
            if block.area > 5000:
                return "button"
            return "text"
        elif aspect >= 0.8 and aspect <= 1.5:
            if block.area > 10000:
                return "card"
            elif block.area > 3000:
                return "button"
            return "image"
        else:
            if block.area > 8000:
                return "card"
            return "button"

    def _compute_iou(self, bbox1: Tuple, bbox2: Tuple) -> float:
        x1, y1, w1, h1 = bbox1
        x2, y2, w2, h2 = bbox2

        xi1 = max(x1, x2)
        yi1 = max(y1, y2)
        xi2 = min(x1 + w1, x2 + w2)
        yi2 = min(y1 + h1, y2 + h2)

        inter_area = max(0, xi2 - xi1) * max(0, yi2 - yi1)
        union_area = w1 * h1 + w2 * h2 - inter_area

        return inter_area / union_area if union_area > 0 else 0

    def _is_contained(self, bbox_outer: Tuple, bbox_inner: Tuple, threshold: float = 0.9) -> bool:
        x1, y1, w1, h1 = bbox_outer
        x2, y2, w2, h2 = bbox_inner

        xi1 = max(x1, x2)
        yi1 = max(y1, y2)
        xi2 = min(x1 + w1, x2 + w2)
        yi2 = min(y1 + h1, y2 + h2)

        inter_area = max(0, xi2 - xi1) * max(0, yi2 - yi1)
        inner_area = w2 * h2

        return inter_area / inner_area > threshold if inner_area > 0 else False


class UIBlockMatcher:
    """UI block matcher."""

    def __init__(self):
        self.position_weight = 0.4
        self.size_weight = 0.3
        self.color_weight = 0.3

    def match(self, blocks1: List[UIBlock], blocks2: List[UIBlock],
              img1_shape: Tuple, img2_shape: Tuple) -> List[Tuple[int, int, float]]:
        """Match blocks using Hungarian algorithm."""
        if not blocks1 or not blocks2:
            return []

        h1, w1 = img1_shape[:2]
        h2, w2 = img2_shape[:2]

        n1, n2 = len(blocks1), len(blocks2)
        cost_matrix = np.ones((n1, n2), dtype=np.float32)

        for i, b1 in enumerate(blocks1):
            for j, b2 in enumerate(blocks2):
                sim = self._compute_similarity(b1, b2, (w1, h1), (w2, h2))
                if sim > 0.3:
                    cost_matrix[i, j] = 1.0 - sim
                else:
                    cost_matrix[i, j] = 1.0

        row_ind, col_ind = linear_sum_assignment(cost_matrix)

        matches = []
        for i, j in zip(row_ind, col_ind):
            sim = 1.0 - cost_matrix[i, j]
            if sim > 0.3:
                matches.append((i, j, float(sim)))

        return matches

    def _compute_similarity(self, b1: UIBlock, b2: UIBlock,
                           size1: Tuple, size2: Tuple) -> float:
        pos_sim = self._position_similarity(b1, b2, size1, size2)
        size_sim = self._size_similarity(b1, b2, size1, size2)
        color_sim = self._color_similarity(b1, b2)

        total_sim = (
            self.position_weight * pos_sim +
            self.size_weight * size_sim +
            self.color_weight * color_sim
        )
        return total_sim

    def _position_similarity(self, b1: UIBlock, b2: UIBlock,
                            size1: Tuple, size2: Tuple) -> float:
        cx1, cy1 = b1.normalized_center(size1[0], size1[1])
        cx2, cy2 = b2.normalized_center(size2[0], size2[1])

        dist = np.sqrt((cx1 - cx2) ** 2 + (cy1 - cy2) ** 2)
        sim = np.exp(-dist * 3.0)
        return sim

    def _size_similarity(self, b1: UIBlock, b2: UIBlock,
                        size1: Tuple, size2: Tuple) -> float:
        nw1, nh1 = b1.normalized_size(size1[0], size1[1])
        nw2, nh2 = b2.normalized_size(size2[0], size2[1])

        w_sim = 1.0 - abs(nw1 - nw2)
        h_sim = 1.0 - abs(nh1 - nh2)

        area1 = nw1 * nh1
        area2 = nw2 * nh2
        area_sim = 1.0 - abs(area1 - area2) / max(area1 + area2, 1e-6)

        return 0.3 * w_sim + 0.3 * h_sim + 0.4 * area_sim

    def _color_similarity(self, b1: UIBlock, b2: UIBlock) -> float:
        if len(b1.color_hist) == 0 or len(b2.color_hist) == 0:
            return 0.5

        h1 = b1.color_hist / (np.sum(b1.color_hist) + 1e-9)
        h2 = b2.color_hist / (np.sum(b2.color_hist) + 1e-9)

        intersection = np.sum(np.minimum(h1, h2))
        return float(np.clip(intersection, 0.0, 1.0))


class UISimilarityEvaluator:
    """UI image similarity evaluator."""

    def __init__(self):
        self.detector = UIBlockDetector()
        self.matcher = UIBlockMatcher()

    def evaluate(self, ref_path: str, gen_path: str) -> Dict:
        """Evaluate similarity between two UI images."""
        ref_img = cv2.imread(ref_path)
        gen_img = cv2.imread(gen_path)

        if ref_img is None:
            raise ValueError(f"Cannot load reference image: {ref_path}")
        if gen_img is None:
            raise ValueError(f"Cannot load generated image: {gen_path}")

        ref_blocks = self.detector.detect(ref_img)
        gen_blocks = self.detector.detect(gen_img)

        matches = self.matcher.match(ref_blocks, gen_blocks,
                                     ref_img.shape, gen_img.shape)

        pos_score, size_score, color_score = self._compute_scores(
            ref_blocks, gen_blocks, matches,
            ref_img.shape, gen_img.shape
        )

        match_ratio = len(matches) / max(len(ref_blocks), len(gen_blocks), 1)
        overall_score = (pos_score * 0.4 + size_score * 0.3 + color_score * 0.3) * (0.7 + 0.3 * match_ratio)

        return {
            'ref_path': ref_path,
            'gen_path': gen_path,
            'ref_blocks': len(ref_blocks),
            'gen_blocks': len(gen_blocks),
            'matched_pairs': len(matches),
            'match_ratio': match_ratio,
            'position_score': pos_score,
            'size_score': size_score,
            'color_score': color_score,
            'overall_score': overall_score
        }

    def _compute_scores(self, ref_blocks: List[UIBlock], gen_blocks: List[UIBlock],
                       matches: List[Tuple], shape1: Tuple, shape2: Tuple) -> Tuple[float, float, float]:
        """Compute position, size and color scores weighted by area."""
        if not matches:
            return 0.0, 0.0, 0.0

        h1, w1 = shape1[:2]
        h2, w2 = shape2[:2]

        total_ref_area = sum(b.area for b in ref_blocks)
        total_gen_area = sum(b.area for b in gen_blocks)
        total_area = total_ref_area + total_gen_area
        
        weighted_pos_sum = 0.0
        weighted_size_sum = 0.0
        weighted_color_sum = 0.0
        matched_ref_area = 0.0
        matched_gen_area = 0.0

        for i, j, _ in matches:
            b1 = ref_blocks[i]
            b2 = gen_blocks[j]
            
            matched_ref_area += b1.area
            matched_gen_area += b2.area
            area_weight = (b1.area + b2.area) / 2

            cx1, cy1 = b1.normalized_center(w1, h1)
            cx2, cy2 = b2.normalized_center(w2, h2)
            dist = np.sqrt((cx1 - cx2) ** 2 + (cy1 - cy2) ** 2)
            pos_sim = np.exp(-dist * 2.0)
            weighted_pos_sum += pos_sim * area_weight

            nw1, nh1 = b1.normalized_size(w1, h1)
            nw2, nh2 = b2.normalized_size(w2, h2)
            size_diff = abs(nw1 - nw2) + abs(nh1 - nh2)
            size_sim = max(0, 1.0 - size_diff)
            weighted_size_sum += size_sim * area_weight

            if len(b1.color_hist) > 0 and len(b2.color_hist) > 0:
                color_sim = np.sum(np.minimum(b1.color_hist, b2.color_hist))
            else:
                color_sim = 0.5
            weighted_color_sum += color_sim * area_weight

        matched_total_area = matched_ref_area + matched_gen_area
        area_coverage = matched_total_area / total_area if total_area > 0 else 0
        
        total_matched_weight = (matched_ref_area + matched_gen_area) / 2
        pos_score = weighted_pos_sum / total_matched_weight if total_matched_weight > 0 else 0
        size_score = weighted_size_sum / total_matched_weight if total_matched_weight > 0 else 0
        color_score = weighted_color_sum / total_matched_weight if total_matched_weight > 0 else 0
        
        return (
            pos_score * area_coverage,
            size_score * area_coverage,
            color_score * area_coverage
        )

    def visualize(self, ref_path: str, gen_path: str, output_path: str):
        """Visualize matching results."""
        ref_img = cv2.imread(ref_path)
        gen_img = cv2.imread(gen_path)

        ref_blocks = self.detector.detect(ref_img)
        gen_blocks = self.detector.detect(gen_img)

        matches = self.matcher.match(ref_blocks, gen_blocks,
                                     ref_img.shape, gen_img.shape)

        h1, w1 = ref_img.shape[:2]
        h2, w2 = gen_img.shape[:2]
        target_h = max(h1, h2)

        scale1 = target_h / h1
        scale2 = target_h / h2

        new_w1 = int(w1 * scale1)
        new_w2 = int(w2 * scale2)

        ref_resized = cv2.resize(ref_img, (new_w1, target_h))
        gen_resized = cv2.resize(gen_img, (new_w2, target_h))

        vis_img = np.hstack([ref_resized, gen_resized])

        colors = [(0, 255, 0), (255, 0, 0), (0, 0, 255), (255, 255, 0), (255, 0, 255)]

        for idx, block in enumerate(ref_blocks):
            x = int(block.x * scale1)
            y = int(block.y * scale1)
            w = int(block.w * scale1)
            h = int(block.h * scale1)
            color = colors[idx % len(colors)]
            cv2.rectangle(vis_img, (x, y), (x + w, y + h), color, 2)
            cv2.putText(vis_img, str(idx), (x, max(15, y - 5)),
                       cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 1)

        for idx, block in enumerate(gen_blocks):
            x = int(block.x * scale2) + new_w1
            y = int(block.y * scale2)
            w = int(block.w * scale2)
            h = int(block.h * scale2)
            color = colors[idx % len(colors)]
            cv2.rectangle(vis_img, (x, y), (x + w, y + h), color, 2)
            cv2.putText(vis_img, str(idx), (x, max(15, y - 5)),
                       cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 1)

        for i, j, sim in matches:
            b1 = ref_blocks[i]
            b2 = gen_blocks[j]

            p1 = (int(b1.center[0] * scale1), int(b1.center[1] * scale1))
            p2 = (int(b2.center[0] * scale2) + new_w1, int(b2.center[1] * scale2))

            cv2.line(vis_img, p1, p2, (0, 255, 255), 1)
            mid_x = (p1[0] + p2[0]) // 2
            mid_y = (p1[1] + p2[1]) // 2
            cv2.putText(vis_img, f"{sim:.2f}", (mid_x - 10, mid_y),
                       cv2.FONT_HERSHEY_SIMPLEX, 0.4, (0, 255, 255), 1)

        cv2.imwrite(output_path, vis_img)
        print(f"Visualization saved: {output_path}")


def batch_evaluate(ref_dir: str, gen_dir: str, output_csv: str, vis_dir: Optional[str] = None):
    """Batch evaluate images with same names in both directories."""
    ref_path = Path(ref_dir)
    gen_path = Path(gen_dir)

    ref_images = set()
    for ext in ['*.png', '*.jpg', '*.jpeg']:
        ref_images.update([p.name for p in ref_path.glob(ext)])

    gen_images = set()
    for ext in ['*.png', '*.jpg', '*.jpeg']:
        gen_images.update([p.name for p in gen_path.glob(ext)])

    common_images = sorted(ref_images & gen_images)

    if not common_images:
        print(f"No common images found")
        print(f"Reference images: {sorted(ref_images)[:5]}...")
        print(f"Generated images: {sorted(gen_images)[:5]}...")
        return

    print(f"Found {len(common_images)} image pairs")

    evaluator = UISimilarityEvaluator()
    results = []

    for img_name in common_images:
        ref_img_path = str(ref_path / img_name)
        gen_img_path = str(gen_path / img_name)

        print(f"\nProcessing: {img_name}")

        try:
            result = evaluator.evaluate(ref_img_path, gen_img_path)
            results.append(result)

            print(f"  Blocks: ref={result['ref_blocks']}, gen={result['gen_blocks']}")
            print(f"  Matches: {result['matched_pairs']} ({result['match_ratio']*100:.1f}%)")
            print(f"  Overall: {result['overall_score']:.4f}")

            if vis_dir:
                os.makedirs(vis_dir, exist_ok=True)
                vis_path = os.path.join(vis_dir, img_name)
                evaluator.visualize(ref_img_path, gen_img_path, vis_path)

        except Exception as e:
            print(f"  Error: {e}")

    if results:
        avg_position = np.mean([r['position_score'] for r in results])
        avg_size = np.mean([r['size_score'] for r in results])
        avg_color = np.mean([r['color_score'] for r in results])
        avg_overall = np.mean([r['overall_score'] for r in results])

        print("\n" + "=" * 60)
        print(f"Total samples: {len(results)}")
        print(f"Avg position: {avg_position:.4f}")
        print(f"Avg size: {avg_size:.4f}")
        print(f"Avg color: {avg_color:.4f}")
        print(f"Avg overall: {avg_overall:.4f}")
        print("=" * 60)

        with open(output_csv, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            writer.writerow([
                'filename',
                'ref_blocks', 'gen_blocks', 'matches', 'match_ratio',
                'position', 'size', 'color', 'overall'
            ])

            for r in results:
                writer.writerow([
                    os.path.basename(r['ref_path']),
                    r['ref_blocks'], r['gen_blocks'], r['matched_pairs'],
                    f"{r['match_ratio']:.4f}",
                    f"{r['position_score']:.4f}",
                    f"{r['size_score']:.4f}",
                    f"{r['color_score']:.4f}",
                    f"{r['overall_score']:.4f}"
                ])

            writer.writerow([
                'AVERAGE',
                '', '', '', '',
                f"{avg_position:.4f}",
                f"{avg_size:.4f}",
                f"{avg_color:.4f}",
                f"{avg_overall:.4f}"
            ])

        print(f"\nResults saved: {output_csv}")
    else:
        print("No images processed successfully")


def main():
    parser = argparse.ArgumentParser(description='UI image similarity evaluator')
    parser.add_argument('--ref', type=str, help='Reference image path')
    parser.add_argument('--gen', type=str, help='Generated image path')
    parser.add_argument('--batch', action='store_true', help='Batch mode')
    parser.add_argument('--ref-dir', type=str, help='Reference directory')
    parser.add_argument('--gen-dir', type=str, help='Generated directory')
    parser.add_argument('--output', type=str, default='ui_similarity_results.csv')
    parser.add_argument('--vis-dir', type=str, help='Visualization output directory')

    args = parser.parse_args()

    if args.batch:
        if not args.ref_dir or not args.gen_dir:
            parser.error('--batch requires --ref-dir and --gen-dir')
        batch_evaluate(args.ref_dir, args.gen_dir, args.output, args.vis_dir)
    else:
        if not args.ref or not args.gen:
            parser.error('Single file mode requires --ref and --gen')

        evaluator = UISimilarityEvaluator()
        result = evaluator.evaluate(args.ref, args.gen)

        print("\nResults:")
        print(f"  Ref blocks: {result['ref_blocks']}")
        print(f"  Gen blocks: {result['gen_blocks']}")
        print(f"  Matches: {result['matched_pairs']}")
        print(f"  Position: {result['position_score']:.4f}")
        print(f"  Size: {result['size_score']:.4f}")
        print(f"  Color: {result['color_score']:.4f}")
        print(f"  Overall: {result['overall_score']:.4f}")

        vis_path = args.output.replace('.csv', '_vis.png')
        evaluator.visualize(args.ref, args.gen, vis_path)


if __name__ == '__main__':
    main()
