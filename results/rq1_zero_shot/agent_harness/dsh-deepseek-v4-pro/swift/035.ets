// 035.ets - translated from 035.swift (Stock K-Line)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#60A5FA';
  static readonly tertiary: string = '#93C5FD';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E3A8A';
  static readonly onTertiary: string = '#1E40AF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
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
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

class AppTokensSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { elevation: 6, radius: 8, dy: 4, opacity: 0.18 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State progress: number = 0.5;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  progressPercent(): string {
    return (this.progress * 100).toString() + '%';
  }

  drawCanvas() {
    const width = this.ctx.width;
    const height = this.ctx.height;
    const step = width / 50.0;
    this.ctx.strokeStyle = AppTokens.Colors.primary;
    this.ctx.lineWidth = 4;
    this.ctx.beginPath();
    this.ctx.moveTo(0, height / 2.0);
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
      this.ctx.lineTo(x, y);
    }
    this.ctx.stroke();
  }

  build() {
    Column({ space: 0 }) {
      // 顶部栏
      Stack() {
        Column()
          .width('100%')
          .height(56)
          .backgroundColor(AppTokens.Colors.background)
        Text('Stock K-Line')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)

      // 主内容区域
      Column({ space: AppTokens.Spacing.lg }) {
        // 图表 Surface
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(15,23,42,0.18)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })

          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .onReady(() => {
              this.drawCanvas();
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(AppTokens.Shapes.large)

        Text('Market Trend')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)

        // Slider
        Slider({ value: this.progress, min: 0, max: 1, step: 0.01, style: SliderStyle.OutSet })
          .selectedColor(AppTokens.Colors.primary)
          .width('100%')
          .height(44)
          .onChange((value: number) => {
            this.progress = value;
            this.drawCanvas();
          })

        // LinearProgressIndicator
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
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [['rgba(96,165,250,0.15)', 0.0], [AppTokens.Colors.background, 0.5], ['rgba(37,99,235,0.15)', 1.0]]
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
