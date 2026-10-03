// Index.ets

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface TextStyleSpec {
  fontSize: number;
  weight: number;
}

class AppTokens {
  static Colors = {
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
  static Typography: Record<string, TextStyleSpec> = {
    display: { fontSize: 28, weight: FontWeight.Bold },
    title: { fontSize: 18, weight: FontWeight.Medium },
    body: { fontSize: 14, weight: FontWeight.Normal },
    label: { fontSize: 12, weight: FontWeight.Medium }
  };
  static Shapes = {
    small: 4,
    medium: 8,
    large: 16
  };
  static Spacing = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  };
  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content Area
      Column() {
        // Canvas Card
        Column() {
          Canvas(this)
            .width('100%')
            .height('100%')
            .onReady((ctx: CanvasRenderingContext2D) => {
              const width = ctx.canvas.width;
              const height = ctx.canvas.height;
              const step = width / 50;
              let prevY = height / 2;
              ctx.beginPath();
              ctx.strokeStyle = AppTokens.Colors.primary;
              ctx.lineWidth = 4;
              for (let i = 0; i <= 50; i++) {
                const x = i * step;
                const y = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3);
                ctx.moveTo(x - step, prevY);
                ctx.lineTo(x, y);
                prevY = y;
              }
              ctx.stroke();
            })
        }
        .width('100%')
        .height(260)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        });

        Text('Market Trend')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg });

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01
        })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .selectedColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .onChange((value: number) => {
            this.progress = value;
          });

        // Linear Progress Indicator
        Row() {
          Column()
            .width(`${this.progress * 100}%`)
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(4);
        }
        .width('100%')
        .height(8)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(4)
        .margin({ top: AppTokens.Spacing.lg });
      }
      .layoutWeight(1)
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.15],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 0.15]
        ]
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}