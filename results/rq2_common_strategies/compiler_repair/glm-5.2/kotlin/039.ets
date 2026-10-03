// 051*InstallmentPlan*en
// UI_TYPE: Finance
// STYLE_THEME: Warm Gradient
// LANG: en
// BASELINE_SIZE: 720x1280

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface TextStyleSpec {
  fontSize: number;
  fontWeight: number;
}

interface LinearGradientStop {
  color: ResourceColor;
}

class AppTokens {
  static Colors: Record<string, ResourceColor> = {
    primary: '#FFA500',
    secondary: '#FFC107',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static Typography: Record<string, TextStyleSpec> = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Shapes: Record<string, number> = {
    small: 6,
    medium: 12,
    large: 20
  };

  static Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Installment Plan')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })

      // Content Area
      Column() {
        // Chart Surface
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(240)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
        .padding(AppTokens.Spacing.lg)

        Text('Payment Progress')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.lg })

        // Linear Progress Indicator
        Row() {
          Column()
            .width(`${this.paymentProgress * 100}%`)
            .height(8)
            .backgroundColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .height(8)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(4)

        // Slider
        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .width('100%')
          .onChange((value: number) => {
            this.paymentProgress = value;
          })

        // Reset Button
        Button('Reset Progress')
          .width('100%')
          .height(48)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .onClick(() => {
            this.paymentProgress = 0;
          })
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary, 1.0]
        ]
      })
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawChart() {
    const ctx = this.context;
    const w = ctx.width;
    const h = ctx.height;
    const step = w / 20;
    let prevY = h / 2;

    ctx.strokeStyle = AppTokens.Colors.primary as string;
    ctx.lineWidth = 5;
    ctx.beginPath();

    for (let i = 0; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      
      if (i === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
      prevY = y;
    }
    ctx.stroke();
  }
}