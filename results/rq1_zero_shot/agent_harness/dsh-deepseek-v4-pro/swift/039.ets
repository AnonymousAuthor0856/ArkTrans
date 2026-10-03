// 039.ets - translated from 039.swift (Installment Plan)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#FFA500';
  static readonly secondary: string = '#FFC107';
  static readonly tertiary: string = '#FFE066';
  static readonly background: string = '#FFFBF2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFEED6';
  static readonly outline: string = '#F1C27D';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppTokensSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

interface ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { radius: 8, dy: 4, opacity: 0.18 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - SurfaceWithCanvas

@Component
struct SurfaceWithCanvas {
  @Prop paymentProgress: number;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    const step = w / 20;
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 5;
    this.ctx.beginPath();
    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    this.ctx.moveTo(0, initialY);
    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      this.ctx.lineTo(x, y);
    }
    this.ctx.stroke();
  }

  build() {
    Stack() {
      // Surface 背景和阴影
      Column()
        .width('100%')
        .height(240)
        .backgroundColor('rgba(255,255,255,0.9)')
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.18)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })

      // Canvas 绘图区域
      Canvas(this.ctx)
        .width('100%')
        .height(240)
        .padding(AppTokens.Spacing.lg)
        .onReady(() => {
          this.drawCanvas();
        })
    }
    .width('100%')
    .height(240)
  }
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  progressPercent(): string {
    return (this.paymentProgress * 100).toString() + '%';
  }

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Text('Installment Plan')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(64)
        .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Column({ space: AppTokens.Spacing.lg }) {
        SurfaceWithCanvas({ paymentProgress: this.paymentProgress })

        Text('Payment Progress')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        // CustomLinearProgressIndicator
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4)
          Row()
            .width(this.progressPercent())
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4)
        }
        .width('100%')
        .height(8)

        // CustomSlider
        Slider({ value: this.paymentProgress, min: 0, max: 1, step: 0.01, style: SliderStyle.OutSet })
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .blockColor(AppTokens.Colors.secondary)
          .width('100%')
          .onChange((value: number) => {
            this.paymentProgress = value;
          })

        // Reset Progress Button
        Button('Reset Progress')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.paymentProgress = 0.0;
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['rgba(255,193,7,0.25)', 0.0], [AppTokens.Colors.background, 0.5], ['rgba(255,165,0,0.25)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
