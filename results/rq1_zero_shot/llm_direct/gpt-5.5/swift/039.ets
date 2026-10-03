class AppColors {
  static readonly primary: string = '#FFA500'
  static readonly secondary: string = '#FFC107'
  static readonly tertiary: string = '#FFE066'
  static readonly background: string = '#FFFBF2'
  static readonly surface: string = '#FFFFFF'
  static readonly surface90: string = '#E6FFFFFF'
  static readonly surfaceVariant: string = '#FFEED6'
  static readonly outline: string = '#F1C27D'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E1E1E'
  static readonly onTertiary: string = '#1E1E1E'
  static readonly onBackground: string = '#1E1E1E'
  static readonly onSurface: string = '#1E1E1E'
  static readonly secondary25: string = '#40FFC107'
  static readonly primary25: string = '#40FFA500'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 12
  static readonly large: number = 20
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
}

class AppElevation {
  static readonly level1Radius: number = 4
  static readonly level1Dy: number = 2
  static readonly level1Opacity: number = 0.12
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = 4
  static readonly level2Opacity: number = 0.18
}

function clamp01(value: number): number {
  return Math.max(0, Math.min(1, value))
}

@Component
struct CustomLinearProgressIndicator {
  progress: number = 0
  color: ResourceColor = AppColors.primary
  trackColor: ResourceColor = AppColors.surfaceVariant
  heightValue: number = 8

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Blank()
        .width('100%')
        .height(this.heightValue)
        .backgroundColor(this.trackColor)
        .borderRadius(this.heightValue / 2)

      Blank()
        .width(`${clamp01(this.progress) * 100}%`)
        .height(this.heightValue)
        .backgroundColor(this.color)
        .borderRadius(this.heightValue / 2)
    }
    .width('100%')
    .height(this.heightValue)
  }
}

@Component
struct CustomSlider {
  @Link value: number

  activeTrackColor: ResourceColor = AppColors.primary
  inactiveTrackColor: ResourceColor = AppColors.surfaceVariant
  thumbColor: ResourceColor = AppColors.secondary

  build() {
    Slider({
      value: this.value,
      min: 0,
      max: 1,
      step: 0.01,
      style: SliderStyle.OutSet
    })
      .width('100%')
      .selectedColor(this.activeTrackColor)
      .trackColor(this.inactiveTrackColor)
      .blockColor(this.thumbColor)
      .onChange((value: number) => {
        this.value = value
      })
  }
}

@Component
struct SurfaceWithCanvas {
  @Link @Watch('onProgressChanged') paymentProgress: number

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  onProgressChanged() {
    setTimeout(() => {
      this.drawWave()
    }, 0)
  }

  drawWave() {
    const ctx = this.canvasContext
    const w = Number(ctx.width)
    const h = Number(ctx.height)

    if (w <= 0 || h <= 0) {
      return
    }

    const padding = AppSpacing.lg
    const drawWidth = w - padding * 2
    const drawHeight = h - padding * 2
    const step = drawWidth / 20
    const centerY = padding + drawHeight / 2
    const amplitude = drawHeight / 3

    ctx.clearRect(0, 0, w, h)
    ctx.beginPath()

    const initialY = centerY + Math.sin(this.paymentProgress * Math.PI) * amplitude
    ctx.moveTo(padding, initialY)

    for (let i = 1; i <= 20; i++) {
      const x = padding + i * step
      const y = centerY + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * amplitude
      ctx.lineTo(x, y)
    }

    ctx.strokeStyle = AppColors.primary
    ctx.lineWidth = 5
    ctx.lineCap = 'round'
    ctx.lineJoin = 'round'
    ctx.stroke()
  }

  build() {
    Stack() {
      Blank()
        .width('100%')
        .height(240)
        .backgroundColor(AppColors.surface90)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevation.level2Radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppElevation.level2Dy
        })

      Canvas(this.canvasContext)
        .width('100%')
        .height(240)
        .onReady(() => {
          this.drawWave()
        })
        .onAreaChange(() => {
          this.drawWave()
        })
    }
    .width('100%')
    .height(240)
  }
}

@Entry
@Component
struct RootScreen {
  @State private paymentProgress: number = 0.3

  build() {
    Column({ space: 0 }) {
      Text('Installment Plan')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        SurfaceWithCanvas({ paymentProgress: $paymentProgress })

        Text('Payment Progress')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppColors.primary,
          trackColor: AppColors.surfaceVariant,
          heightValue: 8
        })
          .width('100%')

        CustomSlider({
          value: $paymentProgress,
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: AppColors.surfaceVariant,
          thumbColor: AppColors.secondary
        })
          .width('100%')

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Reset Progress')
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
        }
        .width('100%')
        .height(48)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          this.paymentProgress = 0
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondary25, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primary25, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}