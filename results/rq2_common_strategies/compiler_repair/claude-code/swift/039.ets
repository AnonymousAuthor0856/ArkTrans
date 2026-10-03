// AppTokens - unified UI design tokens
class AppColors {
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

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: number = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: number = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: number = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: number = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;

  constructor(radius: number, dy: number, opacity: number) {
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(8, 4, 0.18);
}

// Custom linear progress indicator
@Component
struct CustomLinearProgressIndicator {
  @Prop progress: number = 0;
  @Prop color: string = AppColors.primary;
  @Prop trackColor: string = AppColors.surfaceVariant;
  @Prop barHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Rect()
        .width('100%')
        .height(this.barHeight)
        .fill(this.trackColor)
        .borderRadius(this.barHeight / 2)

      // Progress bar
      Rect()
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .fill(this.color)
        .borderRadius(this.barHeight / 2)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

// Surface with Canvas drawing (sine wave)
@Component
struct SurfaceWithCanvas {
  @Link paymentProgress: number;
  @State canvasWidth: number = 0;
  @State canvasHeight: number = 0;

  build() {
    Stack() {
      // Surface background with shadow
      Stack() {
        Canvas(this.onCanvasDraw.bind(this))
          .width('100%')
          .height('100%')
          .padding(AppSpacing.lg)
          .onAreaChange((oldValue: Area, newValue: Area) => {
            this.canvasWidth = newValue.width as number;
            this.canvasHeight = newValue.height as number;
          })
      }
      .width('100%')
      .height(240)
      .backgroundColor(AppColors.surface)
      .opacity(0.9)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: AppElevation.level2.radius,
        color: `rgba(0, 0, 0, ${AppElevation.level2.opacity})`,
        offsetY: AppElevation.level2.dy,
        offsetX: 0
      })
    }
    .width('100%')
  }

  onCanvasDraw(cts: CanvasRenderingContext2D) {
    const w = this.canvasWidth - AppSpacing.lg * 2;
    const h = this.canvasHeight - AppSpacing.lg * 2;
    if (w <= 0 || h <= 0) {
      return;
    }
    const step: number = w / 20;

    cts.beginPath();
    cts.strokeStyle = AppColors.primary;
    cts.lineWidth = 5;

    const initialY = h / 2 + Math.sin(0 * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
    cts.moveTo(0, initialY);

    for (let i = 1; i <= 20; i++) {
      const x = i * step;
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3);
      cts.lineTo(x, y);
    }
    cts.stroke();
  }
}

// Root screen component
@Entry
@Component
struct RootScreen {
  @State paymentProgress: number = 0.3;

  build() {
    Column() {
      // Top bar (CenterAlignedTopAppBar)
      Text('Installment Plan')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.background)

      // Main content area
      Column() {
        SurfaceWithCanvas({ paymentProgress: $paymentProgress })

        Text('Payment Progress')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppColors.primary,
          trackColor: AppColors.surfaceVariant,
          barHeight: 8
        })
        .width('100%')

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .blockColor(AppColors.secondary)
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.paymentProgress = value;
          })

        Button('Reset Progress')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onTertiary)
          .width('100%')
          .height(48)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            this.paymentProgress = 0.0;
          })
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
      .background(this.contentGradient())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private contentGradient() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppColors.secondary, 0],
            [AppColors.background, 0.5],
            [AppColors.primary, 1]
          ]
        })
        .opacity(0.25)
    }
    .width('100%')
    .height('100%')
  }
}
