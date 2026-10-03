class AppColors {
  static readonly primary: string = '#2563EB'
  static readonly secondary: string = '#60A5FA'
  static readonly tertiary: string = '#93C5FD'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#1E3A8A'
  static readonly onTertiary: string = '#1E40AF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
  static readonly secondaryAlpha15: string = 'rgba(96, 165, 250, 0.15)'
  static readonly primaryAlpha15: string = 'rgba(37, 99, 235, 0.15)'
  static readonly shadowLevel2: string = 'rgba(15, 23, 42, 0.18)'
}

class AppTypography {
  static readonly display: number = 28
  static readonly title: number = 18
  static readonly body: number = 14
  static readonly label: number = 12
}

class AppShapes {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 16
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

@Component
struct KLineChartCard {
  @Prop @Watch('onProgressChanged') progress: number = 0.5

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  onProgressChanged(): void {
    this.drawChart()
  }

  private drawChart(): void {
    const width: number = this.context.width
    const height: number = this.context.height

    if (width <= 0 || height <= 0) {
      return
    }

    this.context.clearRect(0, 0, width, height)

    const step: number = width / 50.0
    const startY: number = height / 2.0

    this.context.beginPath()
    this.context.moveTo(0, startY)

    for (let i = 0; i <= 50; i++) {
      const x: number = i * step
      const y: number = height / 2.0 +
        Math.sin(i * Math.PI / 8.0 + this.progress * Math.PI) * (height / 3.0)
      this.context.lineTo(x, y)
    }

    this.context.strokeStyle = AppColors.primary
    this.context.lineWidth = 4
    this.context.lineCap = 'round'
    this.context.lineJoin = 'round'
    this.context.stroke()
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawChart()
        })
        .onAreaChange(() => {
          this.drawChart()
        })
    }
    .width('100%')
    .height(260)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 8,
      color: AppColors.shadowLevel2,
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct LinearProgressBar {
  @Prop progress: number = 0.5

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(4)

      Row()
        .width(`${this.progress * 100}%`)
        .height(8)
        .backgroundColor(AppColors.primary)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

@Entry
@Component
struct StockKLineApp {
  @State private progress: number = 0.5

  build() {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('Stock K-Line')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        KLineChartCard({ progress: this.progress })

        Text('Market Trend')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.001,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(44)
          .selectedColor(AppColors.primary)
          .trackColor(AppColors.outline)
          .blockColor(AppColors.surface)
          .showTips(false)
          .showSteps(false)
          .onChange((value: number) => {
            this.progress = value
          })

        LinearProgressBar({ progress: this.progress })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.secondaryAlpha15, 0.0],
          [AppColors.background, 0.5],
          [AppColors.primaryAlpha15, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}