import { curves } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF2563EB';
  static readonly secondary: string = '#FF60A5FA';
  static readonly tertiary: string = '#FF93C5FD';
  static readonly background: string = '#FFF8FAFC';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE2E8F0';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF1E3A8A';
  static readonly onTertiary: string = '#FF1E40AF';
  static readonly onBackground: string = '#FF0F172A';
  static readonly onSurface: string = '#FF0F172A';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

// MARK: - KLineCanvas Component
@Component
struct KLineCanvas {
  @Prop progress: number = 0.5;

  build() {
    Canvas(new RenderingContextSettings(true))
      .width('100%')
      .height('100%')
      .onReady((context: CanvasRenderingContext2D) => {
        this.drawKLine(context);
      })
  }

  drawKLine(context: CanvasRenderingContext2D): void {
    const width = context.width;
    const height = context.height;
    const step = width / 50.0;

    context.clearRect(0, 0, width, height);
    context.beginPath();
    context.strokeStyle = AppColors.primary;
    context.lineWidth = 4;
    context.lineJoin = 'round';
    context.lineCap = 'round';

    const startY = height / 2.0 + Math.sin(0 * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
    context.moveTo(0, startY);

    for (let i = 1; i <= 50; i++) {
      const x = i * step;
      const y = height / 2.0 + Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0);
      context.lineTo(x, y);
    }

    context.stroke();
  }
}

// MARK: - CustomProgressBar Component
@Component
struct CustomProgressBar {
  @Prop progress: number = 0.5;
  tintColor: string = AppColors.primary;
  trackColor: string = AppColors.surfaceVariant;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track background
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.trackColor)

      // Progress fill
      Row()
        .width(`${this.progress * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.tintColor)
    }
    .width('100%')
    .height(8)
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State progress: number = 0.5;
  private canvasContext: CanvasRenderingContext2D | null = null;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Stack() {
        Text('Stock K-Line')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Column({ space: AppSpacing.lg }) {
        // Chart Surface Card
        Stack() {
          // Shadow and background card
          Column()
            .width('100%')
            .height(260)
            .borderRadius(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .shadow({
              radius: ElevationMapping.level2.radius,
              color: `rgba(15, 23, 42, ${ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: ElevationMapping.level2.dy
            })

          // Canvas for K-Line chart
          Canvas(this.context)
            .width('100%')
            .height(260)
            .borderRadius(AppSpacing.large)
            .padding(AppSpacing.lg)
            .onReady(() => {
              this.drawChart();
            })
        }
        .width('100%')
        .height(260)
        .borderRadius(AppShapes.large)
        .clip(true)

        // Market Trend Label
        Text('Market Trend')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Slider Control
        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .blockColor(AppColors.primary)
          .onChange((value: number) => {
            this.progress = value;
            this.drawChart();
          })

        // Linear Progress Indicator
        CustomProgressBar({
          progress: this.progress,
          tintColor: AppColors.primary,
          trackColor: AppColors.surfaceVariant
        })
          .width('100%')
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [`${AppColors.secondary}26`, 0.0],
          [AppColors.background, 0.5],
          [`${AppColors.primary}26`, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  drawChart(): void {
    const width = this.context.width;
    const height = this.context.height;

    if (width === 0 || height === 0) {
      return;
    }

    const paddingValue = AppSpacing.lg;
    const drawWidth = width - paddingValue * 2;
    const drawHeight = height - paddingValue * 2;
    const step = drawWidth / 50.0;

    this.context.clearRect(0, 0, width, height);
    this.context.beginPath();
    this.context.strokeStyle = AppColors.primary;
    this.context.lineWidth = 4;
    this.context.lineJoin = 'round';
    this.context.lineCap = 'round';

    const startY = paddingValue + drawHeight / 2.0 +
      Math.sin(0 * Math.PI / 8.0 + this.progress * Math.PI) * (drawHeight / 3.0);
    this.context.moveTo(paddingValue, startY);

    for (let i = 1; i <= 50; i++) {
      const x = paddingValue + i * step;
      const y = paddingValue + drawHeight / 2.0 +
        Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (drawHeight / 3.0);
      this.context.lineTo(x, y);
    }

    this.context.stroke();
  }
}