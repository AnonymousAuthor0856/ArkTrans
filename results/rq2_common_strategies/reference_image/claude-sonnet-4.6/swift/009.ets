```typescript
import { display } from '@kit.ArkUI';

/**
 * 视频容器高度占屏幕高度的比例（0.48~0.55 均可按需微调）
 * 标定稿为 720×1280，视频面固定 300vp，比例仅作上限约束参考。
 */
const VIDEO_SURFACE_RATIO: number = 0.50;

/* ------------------------- 配色 ------------------------- */
const COLOR_PRIMARY: string = '#1E3A8A';          // 深蓝（主色）
const COLOR_BACKGROUND: string = '#0F172A';       // 背景
const COLOR_SURFACE: string = '#1E293B';          // 深色块
const COLOR_SURFACE_VARIANT: string = '#334155';  // 次级深色块
const COLOR_OUTLINE: string = '#475569';          // 轮廓描边
const COLOR_ON_SURFACE: string = '#E2E8F0';       // 文本
const COLOR_CHIP: string = '#E8DEF8';             // 浅紫色按钮底

const COLOR_TITLE: string = '#E2E8F0';            // 顶部标题
const COLOR_MOVIE_TITLE: string = '#E0E8F0';      // 片名
const COLOR_TIME: string = '#A3AAB5';             // 时间文本
const COLOR_CHIP_TEXT: string = '#1D192B';        // 浅紫按钮文字
const COLOR_FULLSCREEN_TEXT: string = '#47434E';  // Fullscreen 文字

@Entry
@Component
struct VideoPlayerRoot {
  @State screenW: number = 360;
  @State screenH: number = 780;

  aboutTo