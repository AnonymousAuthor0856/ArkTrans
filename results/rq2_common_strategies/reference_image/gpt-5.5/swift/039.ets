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
  static readonly shadowLevel2: string = '#2E000000'
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
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = 4
}

@Component
struct CustomLinearProgressIndicator {
  @Prop progress: number = 0
  @Prop color: string = AppColors.primary
  @Prop trackColor: string = AppColors.surfaceVariant
  @Prop indicatorHeight: number = 8

  private progressWidth(): string {
    const value: number = Math.max(0, Math.min(1, this.progress))
    return `${value * 100}%`
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.indicatorHeight)
        .backgroundColor(this.trackColor)
        .borderRadius(this.indicatorHeight / 2)

      Row()
        .width(this.progressWidth())
        .height(this.indicatorHeight)
        .backgroundColor(this.color)
        .borderRadius(this.indicatorHeight / 2)
    }
    .width('100%')
    .height(this.indicatorHeight)
  }
}

@Component
struct SurfaceWithCanvas {
  @Link @Watch('handleProgressChange') paymentProgress: number

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private handleProgressChange(): void {
    this.drawWaveAsync()
  }

  private drawWaveAsync(): void {
    setTimeout(() => {
      this.drawWave()
    }, 0)
  }

  private drawWave(): void {
    const width: number = this.context.width
    const height: number = this.context.height

    if (width <= 0 || height <= 0) {
      return
    }

    this.context.clearRect(0, 0, width, height)
    this.context.beginPath()

    const step: number = width / 20
    const initialY: number = height / 2 + Math.sin(this.paymentProgress * Math.PI) * (height / 3)

    this.context.moveTo(0, initialY)

    for (let i = 1; i <= 20; i++) {
      const x: number = i * step
      const y: number = height / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (height / 3)
      this.context.lineTo(x, y)
    }

    this.context.strokeStyle = AppColors.primary
    this.context.lineWidth = 5
    this.context.stroke()
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawWaveAsync()
        })
        .onAreaChange(() => {
          this.drawWaveAsync()
        })
    }
    .width('100%')
    .height(240)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface90)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2Radius,
      color: AppColors.shadowLevel2,
      offsetX: 0,
      offsetY: AppElevation.level2Dy
    })
  }
}

@Entry
@Component
struct InstallmentPlanPage {
  @State private paymentProgress: number = 0.3

  build() {
    Column({ space: 0 }) {
      Stack() {
        Text('Installment Plan')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        SurfaceWithCanvas({ paymentProgress: $paymentProgress })

        Text('Payment Progress')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .textAlign(TextAlign.Center)

        CustomLinearProgressIndicator({
          progress: this.paymentProgress,
          color: AppColors.primary,
          trackColor: AppColors.surfaceVariant,
          indicatorHeight: 8
        })
          .width('100%')

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet,
          direction: Axis.Horizontal,
          reverse: false
        })
          .width('100%')
          .height(40)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .blockColor(AppColors.secondary)
          .trackThickness(4)
          .onChange((value: number) => {
            this.paymentProgress = value
          })

        Button('Reset Progress', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(48)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
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
        angle: 180,
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