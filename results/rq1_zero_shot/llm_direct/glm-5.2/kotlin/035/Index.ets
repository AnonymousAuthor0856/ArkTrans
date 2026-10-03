// 046StockKLineen.ets
// Finance | Modern Blue | en | 720x1280

class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF60A5FA',
    tertiary: '#FF93C5FD',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E3A8A',
    onTertiary: '#FF1E40AF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A'
  };
  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };
  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 16
  };
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };
  static readonly Elevation = {
    level1: 2,
    level2: 6
  };
}

@Entry
@Component
struct RootScreen {
  @State private progress: number = 0.5;

  private points: Point[] = [];

  private generatePoints(width: number, height: number) {
    this.points = [];
    const step = width / 50;
    let prevY = height / 2;
    for (let i = 0; i <= 50; i++) {
      const x = i * step;
      const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
      this.points.push(new Point(x, y));
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .padding({ horizontal: AppTokens.Spacing.lg })

      // Content
      Scroll() {
        Column() {
          // Chart Surface
          Column() {
            Canvas(this.generatePoints.bind(this))
              .width('100%')
              .height(220)
              .padding(AppTokens.Spacing.lg)
              .onReady(() => {})
          }
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: AppTokens.Elevation.level2, color: '#1E000000', offsetX: 0, offsetY: 4 })

          Text('Market Trend')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: AppTokens.Spacing.lg })

          // Slider
          Row() {
            Slider({ value: this.progress, min: 0, max: 1, step: 0.01, style: SliderStyle.OutSet })
              .layoutWeight(1)
              .blockColor(AppTokens.Colors.primary)
              .selectedColor(AppTokens.Colors.secondary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .onChange((value: number) => {
                this.progress = value;
              })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })

          // Linear Progress Indicator
          Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(8)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .margin({ top: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.secondary, 0.0],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.primary, 1.0]
          ]
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

class Point {
  x: number = 0;
  y: number = 0;
  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}