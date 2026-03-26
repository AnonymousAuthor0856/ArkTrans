#!/usr/bin/env python3
"""Evaluation pipeline for UI image comparison."""

import os
import csv
import json
from pathlib import Path
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass, asdict
from datetime import datetime
import numpy as np
from block_position_color import UISimilarityEvaluator
from text_similarity import TextSimilarityEvaluator as TextEvaluator


@dataclass
class EvaluationResult:
    """Evaluation result for a single sample."""
    image_id: str
    language: str
    llm_name: str
    compiled: bool
    ref_blocks: int = 0
    gen_blocks: int = 0
    matched_pairs: int = 0
    match_ratio: float = 0.0
    position_score: float = 0.0
    size_score: float = 0.0
    color_score: float = 0.0
    ref_texts: int = 0
    gen_texts: int = 0
    text_matched: int = 0
    text_score: float = 0.0
    text_coverage: float = 0.0
    text_overall: float = 0.0
    error_msg: str = ""


class EvaluationPipeline:
    """Evaluation pipeline with customizable input/output."""
    
    def __init__(self, 
                 base_dir: str = ".",
                 kotlin_gen_dir: str = "kt_post",
                 swift_gen_dir: str = "swift_post",
                 output_dir: str = "evaluation_results"):
        self.base_dir = Path(base_dir)
        self.evaluator = UISimilarityEvaluator()
        self.text_evaluator = None
        
        self.ref_dirs = {
            "kotlin": self.base_dir / "suc" / "kotlin_img",
            "swift": self.base_dir / "suc" / "swift_img"
        }
        
        self.gen_dirs = {
            "kotlin": self.base_dir / kotlin_gen_dir,
            "swift": self.base_dir / swift_gen_dir
        }
        
        self.output_dir = self.base_dir / output_dir
        self.output_dir.mkdir(exist_ok=True, parents=True)
        
        self.vis_dir = self.output_dir / "visualizations"
        self.vis_dir.mkdir(exist_ok=True)
        
        self.intermediate_dir = self.output_dir / "intermediate"
        self.intermediate_dir.mkdir(exist_ok=True)
        
        (self.intermediate_dir / "ocr").mkdir(exist_ok=True)
        (self.intermediate_dir / "matches").mkdir(exist_ok=True)
        (self.intermediate_dir / "per_llm").mkdir(exist_ok=True)
        (self.intermediate_dir / "per_image").mkdir(exist_ok=True)
    
    def _init_text_evaluator(self):
        """Initialize text evaluator (lazy loading)."""
        if self.text_evaluator is None:
            print("  Initializing OCR...")
            self.text_evaluator = TextEvaluator(lang='en')
        
    def get_all_llm_names(self, language: str) -> List[str]:
        """Get all LLM names for a language."""
        gen_dir = self.gen_dirs[language]
        if not gen_dir.exists():
            return []
        
        llm_names = [item.name for item in gen_dir.iterdir() 
                     if item.is_dir() and not item.name.startswith('.')]
        return sorted(llm_names)
    
    def get_all_image_ids(self, language: str) -> List[str]:
        """Get all original image IDs for a language."""
        ref_dir = self.ref_dirs[language]
        if not ref_dir.exists():
            return []
        
        image_ids = []
        for ext in ['*.png', '*.jpg', '*.jpeg']:
            for img_path in ref_dir.glob(ext):
                image_ids.append(img_path.stem)
        
        return sorted(image_ids)
    
    def check_compiled(self, language: str, llm_name: str, image_id: str) -> bool:
        """Check if sample compiled successfully (image exists)."""
        gen_dir = self.gen_dirs[language] / llm_name
        if not gen_dir.exists():
            return False
        
        for ext in ['.png', '.jpg', '.jpeg']:
            if (gen_dir / f"{image_id}{ext}").exists():
                return True
        return False
    
    def evaluate_single(self, language: str, llm_name: str, image_id: str, 
                        generate_vis: bool = True, save_intermediate: bool = True) -> EvaluationResult:
        """Evaluate a single sample."""
        result = EvaluationResult(
            image_id=image_id,
            language=language,
            llm_name=llm_name,
            compiled=False
        )
        
        if not self.check_compiled(language, llm_name, image_id):
            result.error_msg = "Compilation failed: image not found"
            if save_intermediate:
                self._save_intermediate_result(result)
            return result
        
        result.compiled = True
        
        ref_path = self.ref_dirs[language] / f"{image_id}.png"
        if not ref_path.exists():
            for ext in ['.jpg', '.jpeg']:
                alt_path = self.ref_dirs[language] / f"{image_id}{ext}"
                if alt_path.exists():
                    ref_path = alt_path
                    break
        
        gen_path = None
        for ext in ['.png', '.jpg', '.jpeg']:
            alt_path = self.gen_dirs[language] / llm_name / f"{image_id}{ext}"
            if alt_path.exists():
                gen_path = alt_path
                break
        
        if not ref_path.exists():
            result.error_msg = f"Reference image not found: {ref_path}"
            if save_intermediate:
                self._save_intermediate_result(result)
            return result
        
        if gen_path is None:
            result.error_msg = "Generated image not found"
            if save_intermediate:
                self._save_intermediate_result(result)
            return result
        
        intermediate_data = {
            "image_id": image_id,
            "language": language,
            "llm_name": llm_name,
            "ref_path": str(ref_path),
            "gen_path": str(gen_path),
        }
        
        try:
            eval_result = self.evaluator.evaluate(str(ref_path), str(gen_path))
            result.ref_blocks = eval_result['ref_blocks']
            result.gen_blocks = eval_result['gen_blocks']
            result.matched_pairs = eval_result['matched_pairs']
            result.match_ratio = eval_result['match_ratio']
            result.position_score = eval_result['position_score']
            result.size_score = eval_result['size_score']
            result.color_score = eval_result['color_score']
            
            intermediate_data["ui_evaluation"] = {
                "ref_blocks": result.ref_blocks,
                "gen_blocks": result.gen_blocks,
                "matched_pairs": result.matched_pairs,
                "position_score": result.position_score,
                "size_score": result.size_score,
                "color_score": result.color_score,
            }
            
            if generate_vis and result.compiled:
                self._generate_visualization(
                    str(ref_path), str(gen_path), 
                    language, llm_name, image_id, result
                )
        except Exception as e:
            result.error_msg = f"UI evaluation error: {str(e)}"
            intermediate_data["ui_error"] = str(e)
        
        try:
            self._init_text_evaluator()
            text_result = self.text_evaluator.evaluate(str(ref_path), str(gen_path))
            result.ref_texts = len(text_result['ref_texts'])
            result.gen_texts = len(text_result['gen_texts'])
            result.text_matched = text_result['matched_pairs']
            result.text_score = text_result['text_score']
            result.text_coverage = text_result['coverage_score']
            result.text_overall = text_result['overall_text_score']
            
            intermediate_data["text_evaluation"] = {
                "ref_texts": result.ref_texts,
                "gen_texts": result.gen_texts,
                "matched_pairs": result.text_matched,
                "text_score": result.text_score,
                "coverage": result.text_coverage,
                "overall_score": result.text_overall,
                "ref_text_list": [
                    {"text": t.text, "x": t.x, "y": t.y, "w": t.w, "h": t.h}
                    for t in text_result['ref_texts']
                ],
                "gen_text_list": [
                    {"text": t.text, "x": t.x, "y": t.y, "w": t.w, "h": t.h}
                    for t in text_result['gen_texts']
                ],
            }
        except Exception as e:
            print(f"    Warning: text evaluation failed - {e}")
            intermediate_data["text_error"] = str(e)
        
        if save_intermediate:
            self._save_intermediate_result(result, intermediate_data)
        
        return result
    
    def _save_intermediate_result(self, result: EvaluationResult, data: dict = None):
        """Save intermediate result to JSON."""
        try:
            save_dir = self.intermediate_dir / "per_image" / result.language / result.llm_name
            save_dir.mkdir(parents=True, exist_ok=True)
            
            save_path = save_dir / f"{result.image_id}.json"
            
            save_data = {
                "image_id": result.image_id,
                "language": result.language,
                "llm_name": result.llm_name,
                "compiled": result.compiled,
                "error_msg": result.error_msg,
                "ui_scores": {
                    "position": result.position_score,
                    "size": result.size_score,
                    "color": result.color_score,
                },
                "text_scores": {
                    "ref_count": result.ref_texts,
                    "gen_count": result.gen_texts,
                    "matched": result.text_matched,
                    "similarity": result.text_score,
                    "coverage": result.text_coverage,
                    "overall": result.text_overall,
                },
                "details": data or {}
            }
            
            with open(save_path, 'w', encoding='utf-8') as f:
                json.dump(save_data, f, ensure_ascii=False, indent=2)
                
        except Exception:
            pass
    
    def _generate_visualization(self, ref_path: str, gen_path: str,
                                language: str, llm_name: str, image_id: str,
                                result: EvaluationResult):
        """Generate visualization image."""
        try:
            vis_subdir = self.vis_dir / language / llm_name
            vis_subdir.mkdir(parents=True, exist_ok=True)
            
            vis_path = vis_subdir / f"{image_id}.png"
            self.evaluator.visualize(ref_path, gen_path, str(vis_path))
            
        except Exception as e:
            print(f"    Warning: visualization failed {language}/{llm_name}/{image_id}: {e}")
    
    def evaluate_language(self, language: str) -> Dict[str, List[EvaluationResult]]:
        """Evaluate all samples for a language."""
        print(f"\n{'='*60}")
        print(f"Evaluating {language.upper()}")
        print(f"{'='*60}")
        
        llm_names = self.get_all_llm_names(language)
        image_ids = self.get_all_image_ids(language)
        
        print(f"Found {len(llm_names)} LLMs: {', '.join(llm_names)}")
        print(f"Total images: {len(image_ids)}")
        
        results = {}
        
        for llm_name in llm_names:
            print(f"\nEvaluating LLM: {llm_name}")
            llm_results = []
            
            for i, image_id in enumerate(image_ids):
                if (i + 1) % 10 == 0:
                    print(f"  Progress: {i+1}/{len(image_ids)}")
                
                result = self.evaluate_single(language, llm_name, image_id)
                llm_results.append(result)
            
            results[llm_name] = llm_results
            
            compiled_count = sum(1 for r in llm_results if r.compiled)
            avg_pos = np.mean([r.position_score for r in llm_results])
            avg_size = np.mean([r.size_score for r in llm_results])
            avg_color = np.mean([r.color_score for r in llm_results])
            avg_text = np.mean([r.text_overall for r in llm_results])
            print(f"  Done: compiled {compiled_count}/{len(image_ids)}")
            print(f"        UI: pos={avg_pos:.3f} size={avg_size:.3f} color={avg_color:.3f}")
            print(f"        Text: {avg_text:.3f}")
            
            self._save_llm_intermediate(language, llm_name, llm_results)
        
        return results
    
    def _save_llm_intermediate(self, language: str, llm_name: str, 
                               llm_results: List[EvaluationResult]):
        """Save intermediate results for a single LLM."""
        try:
            save_dir = self.intermediate_dir / "per_llm" / language
            save_dir.mkdir(parents=True, exist_ok=True)
            
            save_path = save_dir / f"{llm_name}.json"
            
            compiled_count = sum(1 for r in llm_results if r.compiled)
            
            data = {
                "language": language,
                "llm_name": llm_name,
                "total_images": len(llm_results),
                "compiled_count": compiled_count,
                "compile_rate": compiled_count / len(llm_results) if llm_results else 0,
                "average_scores": {
                    "position": float(np.mean([r.position_score for r in llm_results])),
                    "size": float(np.mean([r.size_score for r in llm_results])),
                    "color": float(np.mean([r.color_score for r in llm_results])),
                    "text": float(np.mean([r.text_overall for r in llm_results])),
                },
                "individual_results": [
                    {
                        "image_id": r.image_id,
                        "compiled": r.compiled,
                        "position": r.position_score,
                        "size": r.size_score,
                        "color": r.color_score,
                        "text": r.text_overall,
                        "error": r.error_msg,
                    }
                    for r in llm_results
                ]
            }
            
            with open(save_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
                
        except Exception:
            pass
    
    def save_language_results(self, language: str, results: Dict[str, List[EvaluationResult]]):
        """Save results for a language to CSV."""
        output_file = self.output_dir / f"{language}_results.csv"
        
        all_image_ids = []
        for llm_results in results.values():
            for r in llm_results:
                if r.image_id not in all_image_ids:
                    all_image_ids.append(r.image_id)
        all_image_ids = sorted(all_image_ids)
        
        with open(output_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            
            header = ['image_id']
            for llm_name in sorted(results.keys()):
                header.extend([
                    f"{llm_name}_compiled",
                    f"{llm_name}_position",
                    f"{llm_name}_size",
                    f"{llm_name}_color",
                    f"{llm_name}_text_count",
                    f"{llm_name}_text_matched",
                    f"{llm_name}_text_score",
                    f"{llm_name}_text_coverage",
                    f"{llm_name}_text_overall"
                ])
            writer.writerow(header)
            
            for image_id in all_image_ids:
                row = [image_id]
                for llm_name in sorted(results.keys()):
                    result = None
                    for r in results[llm_name]:
                        if r.image_id == image_id:
                            result = r
                            break
                    
                    if result:
                        row.extend([
                            "pass" if result.compiled else "fail",
                            f"{result.position_score:.4f}",
                            f"{result.size_score:.4f}",
                            f"{result.color_score:.4f}",
                            f"{result.gen_texts}",
                            f"{result.text_matched}",
                            f"{result.text_score:.4f}",
                            f"{result.text_coverage:.4f}",
                            f"{result.text_overall:.4f}"
                        ])
                    else:
                        row.extend(["fail", "0.0000", "0.0000", "0.0000", "0", "0", "0.0000", "0.0000", "0.0000"])
                
                writer.writerow(row)
            
            avg_row = ['AVERAGE']
            for llm_name in sorted(results.keys()):
                llm_results = results[llm_name]
                compiled_count = sum(1 for r in llm_results if r.compiled)
                avg_position = np.mean([r.position_score for r in llm_results])
                avg_size = np.mean([r.size_score for r in llm_results])
                avg_color = np.mean([r.color_score for r in llm_results])
                avg_text_score = np.mean([r.text_score for r in llm_results])
                avg_text_coverage = np.mean([r.text_coverage for r in llm_results])
                avg_text_overall = np.mean([r.text_overall for r in llm_results])
                
                avg_row.extend([
                    f"{compiled_count}/{len(llm_results)}",
                    f"{avg_position:.4f}",
                    f"{avg_size:.4f}",
                    f"{avg_color:.4f}",
                    "",
                    "",
                    f"{avg_text_score:.4f}",
                    f"{avg_text_coverage:.4f}",
                    f"{avg_text_overall:.4f}"
                ])
            writer.writerow(avg_row)
        
        print(f"\n{language.upper()} results saved: {output_file}")
        return output_file
    
    def save_summary(self, kotlin_results: Dict, swift_results: Dict):
        """Save summary table."""
        output_file = self.output_dir / "summary.csv"
        
        all_llms = set()
        all_llms.update(kotlin_results.keys())
        all_llms.update(swift_results.keys())
        all_llms = sorted(all_llms)
        
        with open(output_file, 'w', newline='', encoding='utf-8') as f:
            writer = csv.writer(f)
            
            writer.writerow(['metric'] + all_llms)
            
            kotlin_pos_row = ['kotlin-position']
            for llm in all_llms:
                if llm in kotlin_results:
                    avg_score = np.mean([r.position_score for r in kotlin_results[llm]])
                    kotlin_pos_row.append(f"{avg_score:.4f}")
                else:
                    kotlin_pos_row.append("N/A")
            writer.writerow(kotlin_pos_row)
            
            kotlin_size_row = ['kotlin-size']
            for llm in all_llms:
                if llm in kotlin_results:
                    avg_score = np.mean([r.size_score for r in kotlin_results[llm]])
                    kotlin_size_row.append(f"{avg_score:.4f}")
                else:
                    kotlin_size_row.append("N/A")
            writer.writerow(kotlin_size_row)
            
            kotlin_color_row = ['kotlin-color']
            for llm in all_llms:
                if llm in kotlin_results:
                    avg_score = np.mean([r.color_score for r in kotlin_results[llm]])
                    kotlin_color_row.append(f"{avg_score:.4f}")
                else:
                    kotlin_color_row.append("N/A")
            writer.writerow(kotlin_color_row)
            
            kotlin_compile_row = ['kotlin-compile_rate']
            for llm in all_llms:
                if llm in kotlin_results:
                    results = kotlin_results[llm]
                    compiled_count = sum(1 for r in results if r.compiled)
                    compile_rate = compiled_count / len(results) * 100 if results else 0
                    kotlin_compile_row.append(f"{compile_rate:.1f}%")
                else:
                    kotlin_compile_row.append("N/A")
            writer.writerow(kotlin_compile_row)
            
            swift_pos_row = ['swift-position']
            for llm in all_llms:
                if llm in swift_results:
                    avg_score = np.mean([r.position_score for r in swift_results[llm]])
                    swift_pos_row.append(f"{avg_score:.4f}")
                else:
                    swift_pos_row.append("N/A")
            writer.writerow(swift_pos_row)
            
            swift_size_row = ['swift-size']
            for llm in all_llms:
                if llm in swift_results:
                    avg_score = np.mean([r.size_score for r in swift_results[llm]])
                    swift_size_row.append(f"{avg_score:.4f}")
                else:
                    swift_size_row.append("N/A")
            writer.writerow(swift_size_row)
            
            swift_color_row = ['swift-color']
            for llm in all_llms:
                if llm in swift_results:
                    avg_score = np.mean([r.color_score for r in swift_results[llm]])
                    swift_color_row.append(f"{avg_score:.4f}")
                else:
                    swift_color_row.append("N/A")
            writer.writerow(swift_color_row)
            
            swift_compile_row = ['swift-compile_rate']
            for llm in all_llms:
                if llm in swift_results:
                    results = swift_results[llm]
                    compiled_count = sum(1 for r in results if r.compiled)
                    compile_rate = compiled_count / len(results) * 100 if results else 0
                    swift_compile_row.append(f"{compile_rate:.1f}%")
                else:
                    swift_compile_row.append("N/A")
            writer.writerow(swift_compile_row)
            
            kotlin_text_row = ['kotlin-text']
            for llm in all_llms:
                if llm in kotlin_results:
                    avg_score = np.mean([r.text_overall for r in kotlin_results[llm]])
                    kotlin_text_row.append(f"{avg_score:.4f}")
                else:
                    kotlin_text_row.append("N/A")
            writer.writerow(kotlin_text_row)
            
            swift_text_row = ['swift-text']
            for llm in all_llms:
                if llm in swift_results:
                    avg_score = np.mean([r.text_overall for r in swift_results[llm]])
                    swift_text_row.append(f"{avg_score:.4f}")
                else:
                    swift_text_row.append("N/A")
            writer.writerow(swift_text_row)
            
            writer.writerow([])
            writer.writerow([''] + all_llms)
            
            total_pos_row = ['avg-position']
            for llm in all_llms:
                scores = []
                if llm in kotlin_results:
                    scores.extend([r.position_score for r in kotlin_results[llm]])
                if llm in swift_results:
                    scores.extend([r.position_score for r in swift_results[llm]])
                if scores:
                    total_pos_row.append(f"{np.mean(scores):.4f}")
                else:
                    total_pos_row.append("N/A")
            writer.writerow(total_pos_row)
            
            total_size_row = ['avg-size']
            for llm in all_llms:
                scores = []
                if llm in kotlin_results:
                    scores.extend([r.size_score for r in kotlin_results[llm]])
                if llm in swift_results:
                    scores.extend([r.size_score for r in swift_results[llm]])
                if scores:
                    total_size_row.append(f"{np.mean(scores):.4f}")
                else:
                    total_size_row.append("N/A")
            writer.writerow(total_size_row)
            
            total_color_row = ['avg-color']
            for llm in all_llms:
                scores = []
                if llm in kotlin_results:
                    scores.extend([r.color_score for r in kotlin_results[llm]])
                if llm in swift_results:
                    scores.extend([r.color_score for r in swift_results[llm]])
                if scores:
                    total_color_row.append(f"{np.mean(scores):.4f}")
                else:
                    total_color_row.append("N/A")
            writer.writerow(total_color_row)
            
            total_text_row = ['avg-text']
            for llm in all_llms:
                scores = []
                if llm in kotlin_results:
                    scores.extend([r.text_overall for r in kotlin_results[llm]])
                if llm in swift_results:
                    scores.extend([r.text_overall for r in swift_results[llm]])
                if scores:
                    total_text_row.append(f"{np.mean(scores):.4f}")
                else:
                    total_text_row.append("N/A")
            writer.writerow(total_text_row)
            
            total_compile_row = ['avg-compile_rate']
            for llm in all_llms:
                total = 0
                compiled = 0
                if llm in kotlin_results:
                    total += len(kotlin_results[llm])
                    compiled += sum(1 for r in kotlin_results[llm] if r.compiled)
                if llm in swift_results:
                    total += len(swift_results[llm])
                    compiled += sum(1 for r in swift_results[llm] if r.compiled)
                
                if total > 0:
                    total_compile_row.append(f"{compiled/total*100:.1f}%")
                else:
                    total_compile_row.append("N/A")
            writer.writerow(total_compile_row)
        
        print(f"\nCSV summary saved: {output_file}")
        
        self._save_summary_json(kotlin_results, swift_results, all_llms)
        self._save_summary_markdown(kotlin_results, swift_results, all_llms)
        
        return output_file
    
    def _save_summary_json(self, kotlin_results: Dict, swift_results: Dict, all_llms: List[str]):
        """Save JSON format summary."""
        try:
            save_path = self.output_dir / "summary.json"
            
            data = {
                "llms": all_llms,
                "kotlin": {},
                "swift": {},
                "overall": {}
            }
            
            for llm in all_llms:
                if llm in kotlin_results:
                    results = kotlin_results[llm]
                    compiled = sum(1 for r in results if r.compiled)
                    data["kotlin"][llm] = {
                        "total": len(results),
                        "compiled": compiled,
                        "compile_rate": compiled / len(results) if results else 0,
                        "position": float(np.mean([r.position_score for r in results])),
                        "size": float(np.mean([r.size_score for r in results])),
                        "color": float(np.mean([r.color_score for r in results])),
                        "text": float(np.mean([r.text_overall for r in results])),
                    }
            
            for llm in all_llms:
                if llm in swift_results:
                    results = swift_results[llm]
                    compiled = sum(1 for r in results if r.compiled)
                    data["swift"][llm] = {
                        "total": len(results),
                        "compiled": compiled,
                        "compile_rate": compiled / len(results) if results else 0,
                        "position": float(np.mean([r.position_score for r in results])),
                        "size": float(np.mean([r.size_score for r in results])),
                        "color": float(np.mean([r.color_score for r in results])),
                        "text": float(np.mean([r.text_overall for r in results])),
                    }
            
            for llm in all_llms:
                scores_pos, scores_size, scores_color, scores_text = [], [], [], []
                total, compiled = 0, 0
                
                if llm in kotlin_results:
                    results = kotlin_results[llm]
                    scores_pos.extend([r.position_score for r in results])
                    scores_size.extend([r.size_score for r in results])
                    scores_color.extend([r.color_score for r in results])
                    scores_text.extend([r.text_overall for r in results])
                    total += len(results)
                    compiled += sum(1 for r in results if r.compiled)
                
                if llm in swift_results:
                    results = swift_results[llm]
                    scores_pos.extend([r.position_score for r in results])
                    scores_size.extend([r.size_score for r in results])
                    scores_color.extend([r.color_score for r in results])
                    scores_text.extend([r.text_overall for r in results])
                    total += len(results)
                    compiled += sum(1 for r in results if r.compiled)
                
                if total > 0:
                    data["overall"][llm] = {
                        "total": total,
                        "compiled": compiled,
                        "compile_rate": compiled / total,
                        "position": float(np.mean(scores_pos)),
                        "size": float(np.mean(scores_size)),
                        "color": float(np.mean(scores_color)),
                        "text": float(np.mean(scores_text)),
                        "average": float(np.mean([np.mean(scores_pos), np.mean(scores_size), np.mean(scores_color)])),
                    }
            
            with open(save_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
            
            print(f"JSON summary saved: {save_path}")
            
        except Exception as e:
            print(f"Failed to save JSON summary: {e}")
    
    def _save_summary_markdown(self, kotlin_results: Dict, swift_results: Dict, all_llms: List[str]):
        """Save Markdown format report."""
        try:
            save_path = self.output_dir / "summary_report.md"
            
            lines = []
            lines.append("# Evaluation Report\n")
            lines.append(f"**Generated**: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            lines.append("---\n")
            
            lines.append("## Overall Ranking\n")
            lines.append("| Rank | LLM | Compile Rate | Position | Size | Color | Text | Average |\n")
            lines.append("|:----:|:-----|:------------:|:--------:|:----:|:-----:|:----:|:-------:|\n")
            
            rankings = []
            for llm in all_llms:
                scores = []
                if llm in kotlin_results:
                    scores.extend([r.position_score for r in kotlin_results[llm]])
                    scores.extend([r.size_score for r in kotlin_results[llm]])
                    scores.extend([r.color_score for r in kotlin_results[llm]])
                if llm in swift_results:
                    scores.extend([r.position_score for r in swift_results[llm]])
                    scores.extend([r.size_score for r in swift_results[llm]])
                    scores.extend([r.color_score for r in swift_results[llm]])
                
                total, compiled = 0, 0
                if llm in kotlin_results:
                    total += len(kotlin_results[llm])
                    compiled += sum(1 for r in kotlin_results[llm] if r.compiled)
                if llm in swift_results:
                    total += len(swift_results[llm])
                    compiled += sum(1 for r in swift_results[llm] if r.compiled)
                
                avg = np.mean(scores) if scores else 0
                rankings.append((llm, avg, compiled, total))
            
            rankings.sort(key=lambda x: x[1], reverse=True)
            
            for i, (llm, avg, compiled, total) in enumerate(rankings, 1):
                compile_rate = f"{compiled/total*100:.1f}%" if total > 0 else "N/A"
                
                pos_scores, size_scores, color_scores, text_scores = [], [], [], []
                if llm in kotlin_results:
                    pos_scores.extend([r.position_score for r in kotlin_results[llm]])
                    size_scores.extend([r.size_score for r in kotlin_results[llm]])
                    color_scores.extend([r.color_score for r in kotlin_results[llm]])
                    text_scores.extend([r.text_overall for r in kotlin_results[llm]])
                if llm in swift_results:
                    pos_scores.extend([r.position_score for r in swift_results[llm]])
                    size_scores.extend([r.size_score for r in swift_results[llm]])
                    color_scores.extend([r.color_score for r in swift_results[llm]])
                    text_scores.extend([r.text_overall for r in swift_results[llm]])
                
                pos = np.mean(pos_scores) if pos_scores else 0
                size = np.mean(size_scores) if size_scores else 0
                color = np.mean(color_scores) if color_scores else 0
                text = np.mean(text_scores) if text_scores else 0
                
                lines.append(f"| {i} | {llm} | {compile_rate} | {pos:.3f} | {size:.3f} | {color:.3f} | {text:.3f} | {avg:.3f} |\n")
            
            lines.append("\n## Detailed Metrics\n")
            lines.append("### Kotlin\n")
            lines.append("| LLM | Samples | Compiled | Position | Size | Color | Text |\n")
            lines.append("|:-----|:-------:|:--------:|:--------:|:----:|:-----:|:----:|\n")
            
            for llm in all_llms:
                if llm in kotlin_results:
                    results = kotlin_results[llm]
                    compiled = sum(1 for r in results if r.compiled)
                    pos = np.mean([r.position_score for r in results])
                    size = np.mean([r.size_score for r in results])
                    color = np.mean([r.color_score for r in results])
                    text = np.mean([r.text_overall for r in results])
                    lines.append(f"| {llm} | {len(results)} | {compiled} | {pos:.3f} | {size:.3f} | {color:.3f} | {text:.3f} |\n")
            
            lines.append("\n### Swift\n")
            lines.append("| LLM | Samples | Compiled | Position | Size | Color | Text |\n")
            lines.append("|:-----|:-------:|:--------:|:--------:|:----:|:-----:|:----:|\n")
            
            for llm in all_llms:
                if llm in swift_results:
                    results = swift_results[llm]
                    compiled = sum(1 for r in results if r.compiled)
                    pos = np.mean([r.position_score for r in results])
                    size = np.mean([r.size_score for r in results])
                    color = np.mean([r.color_score for r in results])
                    text = np.mean([r.text_overall for r in results])
                    lines.append(f"| {llm} | {len(results)} | {compiled} | {pos:.3f} | {size:.3f} | {color:.3f} | {text:.3f} |\n")
            
            with open(save_path, 'w', encoding='utf-8') as f:
                f.writelines(lines)
            
            print(f"Markdown report saved: {save_path}")
            
        except Exception as e:
            print(f"Failed to save Markdown report: {e}")
    
    def run(self):
        """Run full evaluation pipeline."""
        print("="*60)
        print("Evaluation Pipeline")
        print("="*60)
        print(f"Input:")
        print(f"  Kotlin: {self.gen_dirs['kotlin']}")
        print(f"  Swift: {self.gen_dirs['swift']}")
        print(f"Output: {self.output_dir}")
        print("="*60)
        
        kotlin_results = self.evaluate_language("kotlin")
        self.save_language_results("kotlin", kotlin_results)
        
        swift_results = self.evaluate_language("swift")
        self.save_language_results("swift", swift_results)
        
        self.save_summary(kotlin_results, swift_results)
        
        print("\n" + "="*60)
        print(f"Evaluation complete! Results saved to: {self.output_dir}/")
        print("="*60)
        
        return {
            "kotlin": kotlin_results,
            "swift": swift_results
        }


def main():
    """Main function."""
    import argparse
    
    parser = argparse.ArgumentParser(description='Evaluation Pipeline')
    parser.add_argument('--base-dir', type=str, default='.')
    parser.add_argument('--language', type=str, choices=['kotlin', 'swift', 'all'],
                       default='all')
    parser.add_argument('--kotlin-dir', type=str, default='kt_post')
    parser.add_argument('--swift-dir', type=str, default='swift_post')
    parser.add_argument('--output-dir', type=str, default='evaluation_results')
    
    args = parser.parse_args()
    
    print(f"Configuration:")
    print(f"  Base: {args.base_dir}")
    print(f"  Kotlin input: {args.kotlin_dir}")
    print(f"  Swift input: {args.swift_dir}")
    print(f"  Output: {args.output_dir}")
    print()
    
    pipeline = EvaluationPipeline(
        base_dir=args.base_dir,
        kotlin_gen_dir=args.kotlin_dir,
        swift_gen_dir=args.swift_dir,
        output_dir=args.output_dir
    )
    
    if args.language == 'all':
        pipeline.run()
    else:
        results = pipeline.evaluate_language(args.language)
        pipeline.save_language_results(args.language, results)


if __name__ == '__main__':
    main()
