import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// Define App Tokens matching the Kotlin source
interface ColorTokens {
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

interface SpacingTokens {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

class ColorsConfig implements ColorTokens {
  primary: string = '#2563EB';
  secondary: string = '#60A5FA';
  tertiary: string = '#93C5FD';
  background: string = '#F8FAFC';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E2E8F0';
  outline: string = '#CBD5E1';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1E3A8A';
  onTertiary: string = '#1E40AF';
  onBackground: string = '#0F172A';
  onSurface: string = '#0F172A';
}

class SpacingConfig implements SpacingTokens {
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

const AppTokens = {
  Colors: new ColorsConfig(),
  Spacing: new SpacingConfig()
};

@Entry
@Component
struct StockKLinePage {
  @State progress: number = 0.5;
  private canvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D();

  build() {
    Column() {
      // Top Bar Area
      Row() {
        Text('Stock K-Line')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)

      // Main Content Area with Gradient Background
      Column() {
        // Chart Card
        Row() {
          Canvas(this.canvasRenderingContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.1)', offsetY: 4 })
        .padding(AppTokens.Spacing.lg)

        // Market Trend Label
        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Slider
        Slider({ value: this.progress, min: 0, max: 1 })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .showTips(false)
          .onChange((value: number) => {
            this.progress = value;
          })
          .margin({ top: AppTokens.Spacing.md })

        // Linear Progress Indicator
        Row() {
          Row()
            .width(`${this.progress * 100}%`)
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .margin({ top: AppTokens.Spacing.sm })

      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          [0, `${AppTokens.Colors.secondary}26`], // Hex + Alpha for ~0.15 opacity
          [0.5, AppTokens.Colors.background],
          [1, `${AppTokens.Colors.primary}26`]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  drawChart() {
    const ctx = this.canvasRenderingContext;
    if (!ctx) return;

    const width = ctx.width;
    const height = ctx.height;
    
    // Clear canvas
    ctx.clearRect(0, 0, width, height);

    // Configuration
    const step = width / 50;
    let prevY = height / 2;
    
    ctx.beginPath();
    ctx.moveTo(0, prevY);
    ctx.lineWidth = 4;
    ctx.strokeStyle = AppTokens.Colors.primary;
    ctx.lineCap = CanvasLineCap.Round;
    ctx.lineJoin = CanvasLineJoin.Round;

    // Draw Sine Wave
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      // Formula: y = center + sin(angle) * amplitude
      const y = (height / 2) + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
      
      ctx.lineTo(x, y);
      prevY = y;
    }
    
    ctx.stroke();
  }
}