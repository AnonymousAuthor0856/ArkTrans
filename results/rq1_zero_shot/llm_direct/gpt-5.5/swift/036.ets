class TypographySpec {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppTokenColors {
  readonly primary: ResourceColor = 'rgba(255, 168, 168, 1)';
  readonly secondary: ResourceColor = 'rgba(255, 225, 168, 1)';
  readonly tertiary: ResourceColor = 'rgba(168, 255, 225, 1)';
  readonly background: ResourceColor = 'rgba(255, 252, 245, 1)';
  readonly surface: ResourceColor = 'rgba(255, 255, 255, 1)';
  readonly surfaceVariant: ResourceColor = 'rgba(247, 247, 247, 1)';
  readonly outline: ResourceColor = 'rgba(226, 226, 226, 1)';
  readonly success: ResourceColor = 'rgba(34, 197, 94, 1)';
  readonly warning: ResourceColor = 'rgba(245, 158, 11, 1)';
  readonly error: ResourceColor = 'rgba(239, 68, 68, 1)';
  readonly onPrimary: ResourceColor = 'rgba(30, 30, 30, 1)';
  readonly onSecondary: ResourceColor = 'rgba(30, 30, 30, 1)';
  readonly onTertiary: ResourceColor = 'rgba(30, 30, 30, 1)';
  readonly onBackground: ResourceColor = 'rgba(30, 30, 30, 1)';
  readonly onSurface: ResourceColor = 'rgba(30, 30, 30, 1)';
  readonly secondary30: ResourceColor = 'rgba(255, 225, 168, 0.3)';
  readonly tertiary30: ResourceColor = 'rgba(168, 255, 225, 0.3)';
}

class AppTypographyTokens {
  readonly display: TypographySpec = new TypographySpec(28, FontWeight.Bold);
  readonly title: TypographySpec = new TypographySpec(18, FontWeight.Medium);
  readonly body: TypographySpec = new TypographySpec(14, FontWeight.Regular);
  readonly label: TypographySpec = new TypographySpec(12, FontWeight.Medium);
}

class AppShapes {
  readonly small: number = 6;
  readonly medium: number = 12;
  readonly large: number = 20;
}

class AppSpacing {
  readonly sm: number = 8;
  readonly md: number = 12;
  readonly lg: number = 16;
  readonly xl: number = 24;
  readonly xxl: number = 32;
}

class AppElevationMapping {
  readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

class AppTokens {
  static readonly Colors: AppTokenColors = new AppTokenColors();
  static readonly TypographyTokens: AppTypographyTokens = new AppTypographyTokens();
  static readonly Shapes: AppShapes = new AppShapes();
  static readonly Spacing: AppSpacing = new AppSpacing();
  static readonly ElevationMapping: AppElevationMapping = new AppElevationMapping();
}

@Component
struct FilterChipView {
  text: string = '';
  isSelected: boolean = false;
  action: () => void = () => {
  };

  build() {
    Text(this.text)
      .fontSize(AppTokens.TypographyTokens.label.size)
      .fontWeight(AppTokens.TypographyTokens.label.weight)
      .fontColor(AppTokens.Colors.onPrimary)
      .padding({
        left: AppTokens.Spacing.md,
        right: AppTokens.Spacing.md,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .onClick(() => {
        this.action();
      })
  }
}

@Component
struct LinearProgressIndicatorView {
  progress: number = 0;

  private normalizedProgress(): number {
    return Math.max(0, Math.min(1, this.progress));
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(4)

      Row()
        .width(`${this.normalizedProgress() * 100}%`)
        .height(8)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
    .clip(true)
  }
}

@Component
struct CustomSwitchView {
  @Link isOn: boolean;
  checkedThumbColor: ResourceColor = AppTokens.Colors.secondary;
  uncheckedThumbColor: ResourceColor = AppTokens.Colors.outline;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width(27)
        .height(27)
        .borderRadius(13.5)
        .backgroundColor(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .shadow({
          radius: 2,
          color: 'rgba(0, 0, 0, 0.1)',
          offsetX: 0,
          offsetY: 1
        })
        .translate({ x: this.isOn ? 10 : -10 })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
    }
    .width(51)
    .height(31)
    .borderRadius(15.5)
    .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}

@Component
struct WaveChartCanvas {
  @Prop progress: number = 0.6;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawChart(): void {
    const w: number = Number(this.context.width);
    const h: number = Number(this.context.height);

    if (w <= 0 || h <= 0) {
      return;
    }

    const step: number = w / 30;
    const initialPrevY: number = h / 2;

    this.context.clearRect(0, 0, w, h);
    this.context.beginPath();
    this.context.lineWidth = 5;
    this.context.strokeStyle = 'rgba(255, 168, 168, 1)';
    this.context.moveTo(-step, initialPrevY);

    for (let i = 0; i <= 30; i++) {
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      this.context.lineTo(x, y);
    }

    this.context.stroke();
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawChart();
      })
      .onAreaChange(() => {
        this.drawChart();
      })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6;
  @State isAutoUpdate: boolean = true;

  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA'];

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Crypto Market')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.background)

        Column({ space: AppTokens.Spacing.lg }) {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.chips, (chipText: string) => {
              FilterChipView({
                text: chipText,
                isSelected: this.selectedChip === chipText,
                action: () => {
                  this.selectedChip = chipText;
                }
              })
            }, (chipText: string) => chipText)
          }

          Stack() {
            WaveChartCanvas({ progress: this.progress })
              .width('100%')
              .height('100%')
              .padding(AppTokens.Spacing.lg)
          }
          .width('100%')
          .height(260)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          Text('Price Variation')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.primary)

          LinearProgressIndicatorView({ progress: this.progress })
            .width('100%')
            .height(8)

          Row() {
            Text('Auto Update')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            CustomSwitchView({
              isOn: $isAutoUpdate,
              checkedThumbColor: AppTokens.Colors.secondary,
              uncheckedThumbColor: AppTokens.Colors.outline
            })
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppTokens.Colors.secondary30, 0.0],
            [AppTokens.Colors.background, 0.5],
            [AppTokens.Colors.tertiary30, 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}