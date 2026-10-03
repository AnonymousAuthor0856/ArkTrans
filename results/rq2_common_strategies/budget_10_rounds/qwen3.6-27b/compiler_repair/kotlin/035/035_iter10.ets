import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

// Color Constants
interface ColorConstants {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const COLORS: ColorConstants = {
  primary: '#2563EB',
  secondary: '#60A5FA',
  tertiary: '#93C5FD',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E3A8A',
  onTertiary: '#1E40AF',
  onBackground: '#0F172A',
  onSurface: '#0F172A'
};

// Spacing Constants (vp)
interface SpacingConstants {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

const SPACING: SpacingConstants = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
  xxl: 28
};

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private context: common.UIAbilityContext | undefined = AppStorage.get('appContext') as common.UIAbilityContext;

  aboutToAppear() {
    // Hide system bars if context is available
    if (this.context) {
      try {
        const windowClass = window.getWindowSync(this.context);
        windowClass.setWindowSystemBarEnable([window.SystemBarType.STATUS_BAR], false);
        windowClass.setWindowLayoutFullScreen(true);
      } catch (e) {
        console.error('Failed to set full screen', e);
      }
    }
  }

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text("Stock K-Line")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLORS.background)

      // Main Content Area
      Column() {
        // Chart Card
        Row() {
          Canvas({
            drawImage: this.drawChart.bind(this)
          })
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(260)
        .borderRadius(16)
        .backgroundColor(COLORS.surface)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 4 })
        .padding(SPACING.lg)

        // Title
        Text("Market Trend")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.primary)
          .margin({ top: SPACING.md })

        // Slider
        Slider({ value: this.progress, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .trackColor(COLORS.surfaceVariant)
          .selectedColor(COLORS.secondary)
          .blockColor(COLORS.primary)
          .margin({ top: SPACING.sm })

        // Progress Indicator
        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(COLORS.primary)
          .backgroundColor(COLORS.surfaceVariant)
          .margin({ top: SPACING.sm })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SPACING.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [COLORS.secondary, 0.15],
          [COLORS.background, 0.5],
          [COLORS.primary, 0.15]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  drawChart(context: CanvasRenderingContext2D, size: Size) {
    const width = size.width;
    const height = size.height;
    const step = width / 50;
    
    context.beginPath();
    context.lineWidth = 4;
    context.strokeStyle = COLORS.primary;
    context.lineCap = 'round';
    context.lineJoin = 'round';

    let prevY = height / 2;
    
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      // Calculate Y based on sine wave and progress
      // Note: ArkTS Math.sin takes radians. PI is Math.PI.
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
      
      if (i === 0) {
        context.moveTo(x, y);
      } else {
        context.lineTo(x, y);
      }
      prevY = y;
    }
    
    context.stroke();
  }
}