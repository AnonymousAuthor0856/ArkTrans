#!/usr/bin/env python3

import cv2
import numpy as np
from typing import Dict, List, Tuple
from dataclasses import dataclass
import re

@dataclass
class TextBlock:
    text: str
    x: int
    y: int
    w: int
    h: int
    confidence: float
    
    @property
    def area(self) -> int:
        return self.w * self.h
    
    @property
    def center(self) -> Tuple[float, float]:
        return (self.x + self.w / 2, self.y + self.h / 2)

class TextSimilarityEvaluator:
    
    def __init__(self, use_gpu: bool = False, lang: str = 'en'):
        self.use_gpu = use_gpu
        lang_map = {'en': ['en'], 'ch': ['ch_sim', 'en'], 'ch_en': ['ch_sim', 'en']}
        self.lang_list = lang_map.get(lang, ['en'])
        self.ocr = None
        self._init_ocr()
        
    def _init_ocr(self):
        if self.ocr is None:
            try:
                import easyocr
                print("初始化OCR文字识别（首次运行会下载模型）...")
                self.ocr = easyocr.Reader(
                    self.lang_list,
                    gpu=self.use_gpu,
                    verbose=False
                )
                print("OCR初始化完成！")
            except ImportError:
                raise ImportError(
                    "EasyOCR未安装，请运行:\n"
                    "  pip install easyocr"
                )
    
    def extract_text(self, image_path: str) -> List[TextBlock]:
        results = self.ocr.readtext(image_path)
        
        text_blocks = []
        for result in results:
            if isinstance(result, (list, tuple)) and len(result) == 3:
                bbox, text, confidence = result
                x_coords = [p[0] for p in bbox]
                y_coords = [p[1] for p in bbox]
                x = int(min(x_coords))
                y = int(min(y_coords))
                w = int(max(x_coords) - x)
                h = int(max(y_coords) - y)
                
                text_blocks.append(TextBlock(
                    text=text.strip(),
                    x=x,
                    y=y,
                    w=w,
                    h=h,
                    confidence=confidence
                ))
        
        return text_blocks
    
    def normalize_text(self, text: str) -> str:
        text = text.lower()
        text = re.sub(r'\s+', ' ', text)
        text = re.sub(r'[^\w\u4e00-\u9fff]', '', text)
        return text.strip()
    
    def calculate_text_similarity(self, text1: str, text2: str) -> float:
        t1 = self.normalize_text(text1)
        t2 = self.normalize_text(text2)
        
        if not t1 and not t2:
            return 1.0
        if not t1 or not t2:
            return 0.0
        
        from collections import Counter
        
        counter1 = Counter(t1)
        counter2 = Counter(t2)
        
        intersection_size = sum((counter1 & counter2).values())
        
        dice_similarity = 2 * intersection_size / (len(t1) + len(t2))
        
        return float(dice_similarity)
    
    def match_text_blocks(self, ref_blocks: List[TextBlock], 
                         gen_blocks: List[TextBlock],
                         position_threshold: float = 0.3) -> Tuple[int, float]:
        if not ref_blocks or not gen_blocks:
            return 0, 0.0
        
        matched_pairs = []
        used_gen_indices = set()
        
        for ref_block in ref_blocks:
            best_match = None
            best_score = -1
            
            for i, gen_block in enumerate(gen_blocks):
                if i in used_gen_indices:
                    continue
                
                ref_cx = ref_block.center[0]
                ref_cy = ref_block.center[1]
                gen_cx = gen_block.center[0]
                gen_cy = gen_block.center[1]
                
                max_dist = 100
                dist = np.sqrt((ref_cx - gen_cx)**2 + (ref_cy - gen_cy)**2)
                position_sim = max(0, 1 - dist / max_dist)
                
                text_sim = self.calculate_text_similarity(ref_block.text, gen_block.text)
                
                combined_score = 0.3 * position_sim + 0.7 * text_sim
                
                if combined_score > best_score and text_sim > 0.6:
                    best_score = combined_score
                    best_match = i
            
            if best_match is not None:
                dice_sim = self.calculate_text_similarity(ref_block.text, gen_blocks[best_match].text)
                matched_pairs.append((ref_block, gen_blocks[best_match], best_score, dice_sim))
                used_gen_indices.add(best_match)
        
        if not matched_pairs:
            return 0, 0.0
        
        avg_dice_similarity = sum(p[3] for p in matched_pairs) / len(matched_pairs)
        return len(matched_pairs), avg_dice_similarity
    
    def evaluate(self, ref_image_path: str, gen_image_path: str) -> Dict:
        try:
            ref_blocks = self.extract_text(ref_image_path)
            gen_blocks = self.extract_text(gen_image_path)
        except Exception as e:
            print(f"OCR提取失败: {e}")
            return {
                'ref_texts': [],
                'gen_texts': [],
                'matched_pairs': 0,
                'text_score': 0.0,
                'coverage_score': 0.0,
                'overall_text_score': 0.0,
                'error': str(e)
            }
        
        ref_count = len(ref_blocks)
        gen_count = len(gen_blocks)
        
        matched_count, avg_dice_similarity = self.match_text_blocks(ref_blocks, gen_blocks)
        
        if ref_count > 0:
            coverage = matched_count / ref_count
        else:
            coverage = 1.0 if gen_count == 0 else 0.0
        
        if matched_count > 0:
            overall_score = avg_dice_similarity
        else:
            overall_score = 0.0
        
        return {
            'ref_texts': ref_blocks,
            'gen_texts': gen_blocks,
            'matched_pairs': int(matched_count),
            'text_score': float(avg_dice_similarity),
            'coverage_score': float(coverage),
            'overall_text_score': float(overall_score)
        }

if __name__ == '__main__':
    import argparse
    
    parser = argparse.ArgumentParser(description='文字相似度评估')
    parser.add_argument('--ref', type=str, required=True, help='参考图片路径')
    parser.add_argument('--gen', type=str, required=True, help='生成图片路径')
    parser.add_argument('--gpu', action='store_true', help='使用GPU（默认CPU）')
    
    args = parser.parse_args()
    
    evaluator = TextSimilarityEvaluator(use_gpu=args.gpu)
    result = evaluator.evaluate(args.ref, args.gen)
    
    print(f"\n文字评估结果:")
    print(f"  参考图文字数: {result['ref_texts']}")
    print(f"  生成图文字数: {result['gen_texts']}")
    print(f"  匹配文字对: {result['text_matched']}")
    print(f"  文字相似度: {result['text_score']:.3f}")
    print(f"  文字覆盖率: {result['text_coverage']:.3f}")
    print(f"  文字最终分: {result['text_overall']:.3f}")
