const NAME: string = '046StockKLineen'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
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

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18)
}

@Entry
@Component
struct StockKLinePage {
  @State private progress: number = 0.5

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart(): void {
    const width: number = this.canvasContext.width
    const height: number = this.canvasContext.height

    if (width <= 0 || height <= 0) {
      return
    }

    this.canvasContext.clearRect(0, 0, width, height)

    const step: number = width / 50
    let prevY: number = height / 2

    this.canvasContext.lineWidth = 4
    this.canvasContext.strokeStyle = AppColors.primary
    this.canvasContext.lineCap = 'round'
    this.canvasContext.lineJoin = 'round'

    for (let i: number = 0; i <= 50; i++) {
      const x: number = i * step
      const y: number = height / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (height / 3)

      this.canvasContext.beginPath()
      this.canvasContext.moveTo(x - step, prevY)
      this.canvasContext.lineTo(x, y)
      this.canvasContext.stroke()

      prevY = y
    }
  }

  private updateProgress(value: number): void {
    this.progress = value
    setTimeout(() => {
      this.drawChart()
    }, 0)
  }

  build() {
    Column() {
      Row() {
        Text('Stock K-Line')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
            .onAreaChange(() => {
              setTimeout(() => {
                this.drawChart()
              }, 0)
            })
        }
        .width('100%')
        .height(260)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevation.level2.radius,
          color: 'rgba(15, 23, 42, 0.18)',
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })

        Text('Market Trend')
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Slider({
          value: this.progress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppColors.primary)
          .selectedColor(AppColors.secondary)
          .trackColor(AppColors.surfaceVariant)
          .onChange((value: number) => {
            this.updateProgress(value)
          })

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
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
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