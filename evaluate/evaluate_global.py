#!/usr/bin/env python3
"""Evaluation pipeline for comparing original and LLM-generated images.

Metrics: 1. Color histogram similarity  2. CLIP semantic similarity
"""

import os
import cv2
import pandas as pd
import numpy as np
from pathlib import Path
from collections import defaultdict
import warnings
warnings.filterwarnings('ignore')

# CLIP imports
import torch
from transformers import CLIPProcessor, CLIPModel
from PIL import Image

# Configuration

ORIGINAL_PATHS = {
    'kotlin': 'suc/kotlin_img',
    'swift': 'suc/swift_img'
}

LLM_PATHS = {
    'kotlin': {
        'deepseek (post)': 'kt_post/deepseek',
        'glm (post)': 'kt_post/glm',
        'gpt (post)': 'kt_post/gpt',
        'kimi-turbo (post)': 'kt_post/kimi-turbo',
        'deepseek (llm)': 'kt_llm/deepseek',
        'gpt (llm)': 'kt_llm/gpt',
        'gpt (a2)': 'kt_ablation/gpt',
        'gpt(nocolor)': 'kt_ablation/gpt_nocolor',
    },
    'swift': {
        'deepseek (post)': 'swift_post/deepseek',
        'glm (post)': 'swift_post/glm',
        'gpt (post)': 'swift_post/gpt',
        'kimi-turbo (post)': 'swift_post/kimi-turbo',
        'deepseek (llm)': 'swift_llm/deepseek',
        'gpt (llm)': 'swift_llm/gpt',
        'gpt (a2)': 'swift_ablation/gpt',
        'gpt(nocolor)': 'swift_ablation/gpt_nocolor',
    }
}

OUTPUT_DIR = 'evaluation_results'

CLIP_MODEL_NAME = "openai/clip-vit-base-patch32"

clip_model = None
clip_processor = None

def init_clip_model():
    """Initialize CLIP model (lazy loading)."""
    global clip_model, clip_processor
    if clip_model is None:
        print("Loading CLIP model...")
        device = "cuda" if torch.cuda.is_available() else "cpu"
        clip_model = CLIPModel.from_pretrained(CLIP_MODEL_NAME).to(device)
        clip_processor = CLIPProcessor.from_pretrained(CLIP_MODEL_NAME)
        clip_model.eval()
        print(f"CLIP model loaded on {device}")
    return clip_model, clip_processor

# Evaluation metrics

def calculate_color_histogram_similarity(img1_path, img2_path):
    """Calculate color histogram similarity between two images."""
    try:
        img1 = cv2.imread(str(img1_path))
        img2 = cv2.imread(str(img2_path))
        
        if img1 is None or img2 is None:
            return 0.0
        
        img1 = cv2.resize(img1, (256, 256))
        img2 = cv2.resize(img2, (256, 256))
        
        hsv1 = cv2.cvtColor(img1, cv2.COLOR_BGR2HSV)
        hsv2 = cv2.cvtColor(img2, cv2.COLOR_BGR2HSV)
        
        h_bins, s_bins = 50, 60
        hist_size = [h_bins, s_bins]
        ranges = [0, 180, 0, 256]
        channels = [0, 1]
        
        hist1 = cv2.calcHist([hsv1], channels, None, hist_size, ranges)
        hist2 = cv2.calcHist([hsv2], channels, None, hist_size, ranges)
        
        cv2.normalize(hist1, hist1, alpha=0, beta=1, norm_type=cv2.NORM_MINMAX)
        cv2.normalize(hist2, hist2, alpha=0, beta=1, norm_type=cv2.NORM_MINMAX)
        
        similarity = cv2.compareHist(hist1, hist2, cv2.HISTCMP_CORREL)
        return max(0.0, min(1.0, similarity))
        
    except Exception as e:
        print(f"Error in color histogram: {e}")
        return 0.0


def calculate_clip_similarity(img1_path, img2_path):
    """Calculate CLIP semantic similarity between two images."""
    try:
        model, processor = init_clip_model()
        device = model.device
        
        img1 = Image.open(img1_path).convert('RGB')
        img2 = Image.open(img2_path).convert('RGB')
        
        inputs1 = processor(images=img1, return_tensors="pt").to(device)
        inputs2 = processor(images=img2, return_tensors="pt").to(device)
        
        with torch.no_grad():
            vision_outputs1 = model.vision_model(**inputs1)
            vision_outputs2 = model.vision_model(**inputs2)
            
            image_embeds1 = vision_outputs1.last_hidden_state[:, 0, :]
            image_embeds2 = vision_outputs2.last_hidden_state[:, 0, :]
            
            image_features1 = model.visual_projection(image_embeds1)
            image_features2 = model.visual_projection(image_embeds2)
        
        image_features1 = image_features1 / image_features1.norm(p=2, dim=-1, keepdim=True)
        image_features2 = image_features2 / image_features2.norm(p=2, dim=-1, keepdim=True)
        
        similarity = (image_features1 @ image_features2.T).item()
        similarity = (similarity + 1) / 2
        
        return max(0.0, min(1.0, similarity))
        
    except Exception as e:
        print(f"Error in CLIP similarity: {e}")
        return 0.0


def evaluate_single_pair(original_path, generated_path):
    """Evaluate a pair of images and return scores."""
    color_score = calculate_color_histogram_similarity(original_path, generated_path)
    clip_score = calculate_clip_similarity(original_path, generated_path)
    
    return {
        'color_score': color_score,
        'clip_score': clip_score
    }

# Evaluation logic

def get_all_original_images(direction):
    """Get list of all original image filenames."""
    original_dir = ORIGINAL_PATHS[direction]
    if not os.path.exists(original_dir):
        return []
    
    images = [f for f in os.listdir(original_dir) if f.endswith('.png')]
    return sorted(images)


def evaluate_direction(direction):
    """Evaluate all images for a direction (kotlin/swift)."""
    print(f"\n{'='*70}")
    print(f"Evaluating: {direction.upper()}")
    print(f"{'='*70}")
    
    original_dir = ORIGINAL_PATHS[direction]
    llm_paths = LLM_PATHS[direction]
    
    original_images = get_all_original_images(direction)
    print(f"Total images: {len(original_images)}")
    
    results = []
    
    for llm_name, llm_dir in llm_paths.items():
        print(f"\nEvaluating: {llm_name} ...")
        
        llm_results = {
            'llm_name': llm_name,
            'direction': direction,
            'total_images': len(original_images),
            'compiled_count': 0,
            'failed_count': 0,
            'color_scores': [],
            'clip_scores': [],
            'details': []
        }
        
        if not os.path.exists(llm_dir):
            print(f"  Warning: directory not found {llm_dir}")
            continue
        
        for img_name in original_images:
            original_path = os.path.join(original_dir, img_name)
            generated_path = os.path.join(llm_dir, img_name)
            
            if os.path.exists(generated_path):
                scores = evaluate_single_pair(original_path, generated_path)
                llm_results['compiled_count'] += 1
                llm_results['color_scores'].append(scores['color_score'])
                llm_results['clip_scores'].append(scores['clip_score'])
                llm_results['details'].append({
                    'image_id': img_name.replace('.png', ''),
                    'compiled': True,
                    'color_score': scores['color_score'],
                    'clip_score': scores['clip_score']
                })
            else:
                llm_results['failed_count'] += 1
                llm_results['color_scores'].append(0.0)
                llm_results['clip_scores'].append(0.0)
                llm_results['details'].append({
                    'image_id': img_name.replace('.png', ''),
                    'compiled': False,
                    'color_score': 0.0,
                    'clip_score': 0.0
                })
        
        if llm_results['color_scores']:
            llm_results['avg_color_score'] = np.mean(llm_results['color_scores'])
            llm_results['avg_clip_score'] = np.mean(llm_results['clip_scores'])
            llm_results['max_color_score'] = np.max(llm_results['color_scores'])
            llm_results['max_clip_score'] = np.max(llm_results['clip_scores'])
            llm_results['min_color_score'] = np.min(llm_results['color_scores'])
            llm_results['min_clip_score'] = np.min(llm_results['clip_scores'])
            llm_results['std_color_score'] = np.std(llm_results['color_scores'])
            llm_results['std_clip_score'] = np.std(llm_results['clip_scores'])
        else:
            for key in ['avg', 'max', 'min', 'std']:
                llm_results[f'{key}_color_score'] = 0.0
                llm_results[f'{key}_clip_score'] = 0.0
        
        llm_results['compile_rate'] = llm_results['compiled_count'] / llm_results['total_images'] * 100
        
        print(f"  Compile rate: {llm_results['compile_rate']:.1f}%")
        print(f"  Avg color: {llm_results['avg_color_score']:.4f}")
        print(f"  Avg CLIP: {llm_results['avg_clip_score']:.4f}")
        
        results.append(llm_results)
    
    return results


def create_detail_csv(results, direction):
    """Create detailed results CSV."""
    rows = []
    all_image_ids = sorted(set(d['image_id'] for r in results for d in r['details']))
    
    for img_id in all_image_ids:
        row = {'image_id': img_id}
        
        for r in results:
            llm_name = r['llm_name']
            detail = next((d for d in r['details'] if d['image_id'] == img_id), None)
            if detail:
                row[f'{llm_name}_compiled'] = 'yes' if detail['compiled'] else 'no'
                row[f'{llm_name}_color'] = f"{detail['color_score']:.4f}" if detail['compiled'] else '0.0000'
                row[f'{llm_name}_clip'] = f"{detail['clip_score']:.4f}" if detail['compiled'] else '0.0000'
            else:
                row[f'{llm_name}_compiled'] = 'no'
                row[f'{llm_name}_color'] = '0.0000'
                row[f'{llm_name}_clip'] = '0.0000'
        
        rows.append(row)
    
    df = pd.DataFrame(rows)
    return df


def create_summary_csv(all_results):
    """Create summary results CSV."""
    rows = []
    
    for direction, results in all_results.items():
        for r in results:
            rows.append({
                'direction': direction.upper(),
                'llm': r['llm_name'],
                'total': r['total_images'],
                'compiled': r['compiled_count'],
                'failed': r['failed_count'],
                'compile_rate_pct': f"{r['compile_rate']:.2f}",
                'color_avg': f"{r['avg_color_score']:.4f}",
                'color_max': f"{r['max_color_score']:.4f}",
                'color_min': f"{r['min_color_score']:.4f}",
                'clip_avg': f"{r['avg_clip_score']:.4f}",
                'clip_max': f"{r['max_clip_score']:.4f}",
                'clip_min': f"{r['min_clip_score']:.4f}",
            })
    
    df = pd.DataFrame(rows)
    return df


def create_pivot_summaries(all_results):
    """Create pivot table summaries."""
    data = []
    
    for direction, results in all_results.items():
        for r in results:
            data.append({
                'direction': direction,
                'llm': r['llm_name'],
                'avg_color_score': r['avg_color_score'],
                'avg_clip_score': r['avg_clip_score'],
                'compile_rate': r['compile_rate']
            })
    
    df = pd.DataFrame(data)
    
    pivot_color = df.pivot(index='direction', columns='llm', values='avg_color_score')
    pivot_clip = df.pivot(index='direction', columns='llm', values='avg_clip_score')
    pivot_compile = df.pivot(index='direction', columns='llm', values='compile_rate')
    
    return pivot_color, pivot_clip, pivot_compile


# Main function

def main():
    print("="*70)
    print("Image Evaluation Pipeline - Color Histogram + CLIP")
    print("="*70)
    
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    all_results = {}
    
    kotlin_results = evaluate_direction('kotlin')
    all_results['kotlin'] = kotlin_results
    
    swift_results = evaluate_direction('swift')
    all_results['swift'] = swift_results
    
    print(f"\n{'='*70}")
    print("Generating result tables...")
    print(f"{'='*70}")
    
    for direction, results in all_results.items():
        df_detail = create_detail_csv(results, direction)
        output_path = os.path.join(OUTPUT_DIR, f'{direction}_detail_results.csv')
        df_detail.to_csv(output_path, index=False, encoding='utf-8-sig')
        print(f"Saved: {output_path}")
    
    df_summary = create_summary_csv(all_results)
    summary_path = os.path.join(OUTPUT_DIR, 'summary_results.csv')
    df_summary.to_csv(summary_path, index=False, encoding='utf-8-sig')
    print(f"Saved: {summary_path}")
    
    pivot_color, pivot_clip, pivot_compile = create_pivot_summaries(all_results)
    
    pivot_color_path = os.path.join(OUTPUT_DIR, 'pivot_color_histogram.csv')
    pivot_color.to_csv(pivot_color_path, encoding='utf-8-sig')
    print(f"Saved: {pivot_color_path}")
    
    pivot_clip_path = os.path.join(OUTPUT_DIR, 'pivot_clip_score.csv')
    pivot_clip.to_csv(pivot_clip_path, encoding='utf-8-sig')
    print(f"Saved: {pivot_clip_path}")
    
    pivot_compile_path = os.path.join(OUTPUT_DIR, 'pivot_compile_rate.csv')
    pivot_compile.to_csv(pivot_compile_path, encoding='utf-8-sig')
    print(f"Saved: {pivot_compile_path}")
    
    print(f"\n{'='*70}")
    print("Summary - Color Histogram Average")
    print(f"{'='*70}")
    print(pivot_color.to_string())
    
    print(f"\n{'='*70}")
    print("Summary - CLIP Semantic Similarity Average")
    print(f"{'='*70}")
    print(pivot_clip.to_string())
    
    print(f"\n{'='*70}")
    print("Summary - Compile Rate (%)")
    print(f"{'='*70}")
    print(pivot_compile.to_string())
    
    print(f"\n{'='*70}")
    print("Evaluation complete! Results saved to 'evaluation_results/'")
    print(f"{'='*70}")


if __name__ == '__main__':
    main()
