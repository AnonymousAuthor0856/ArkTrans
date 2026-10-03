const NAME: string = '051*InstallmentPlan*en'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Warm Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly PRIMARY: string = '#FFA500'
  static readonly SECONDARY: string = '#FFC107'
  static readonly TERTIARY: string = '#FFE066'
  static readonly BACKGROUND: string = '#FFFBF2'
  static readonly SURFACE: string = '#FFFFFF'
  static readonly SURFACE_VARIANT: string = '#FFEED6'
  static readonly OUTLINE: string = '#F1C27D'
  static readonly SUCCESS: string = '#22C55E'
  static readonly WARNING: string = '#F59E0B'
  static readonly ERROR: string = '#EF4444'
  static readonly ON_PRIMARY: string = '#FFFFFF'
  static readonly ON_SECONDARY: string = '#1E1E1E'
  static readonly ON_TERTIARY: string = '#1E1E1E'
  static readonly ON_BACKGROUND: string = '#1E1E1E'
  static readonly ON_SURFACE: string = '#1E1E1E'
}

class AppSpacing {
  static readonly SM: number = 8
  static readonly MD: number = 12
  static readonly LG: number = 16
  static readonly XL: number = 24
  static readonly XXL: number = 32
}

@Entry
@Component
struct Index {
  @State private paymentProgress: number = 0.3

  private readonly chartSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private readonly chartContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.chartSettings)
  private chartWidth: number = 0
  private chartHeight: number = 0

  private toNumber(value: Length): number {
    if (typeof value === 'number') {
      return value
    }
    if (typeof value === 'string') {
      const parsed: number = Number.parseFloat(value)
      return parsed === parsed ? parsed : 0
    }
    return 0
  }

  private drawChart(): void {
    if (this.chartWidth <= 0 || this.chartHeight <= 0) {
      return
    }

    const ctx: CanvasRenderingContext2D = this.chartContext
    const width: number = this.chartWidth
    const height: number = this.chartHeight
    const step: number = width / 20

    ctx.clearRect(0, 0, width, height)
    ctx.beginPath()
    ctx.strokeStyle = AppColors.PRIMARY
    ctx.lineWidth = 5

    let prevY: number = height / 2

    for (let i: number = 0; i <= 20; i++) {
      const x: number = i * step
      const y: number = height / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (height / 3)

      if (i === 0) {
        ctx.moveTo(x - step, prevY)
      } else {
        ctx.moveTo(x - step, prevY)
      }

      ctx.lineTo(x, y)
      prevY = y
    }

    ctx.stroke()
  }

  build() {
    Column() {
      Text('Installment Plan')
        .width('100%')
        .height(64)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.ON_SURFACE)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.BACKGROUND)

      Column({ space: AppSpacing.LG }) {
        Column() {
          Canvas(this.chartContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawChart()
            })
            .onAreaChange((oldArea: Area, newArea: Area) => {
              this.chartWidth = this.toNumber(newArea.width)
              this.chartHeight = this.toNumber(newArea.height)
              this.drawChart()
            })
        }
        .width('100%')
        .height(240)
        .padding(AppSpacing.LG)
        .borderRadius(20)
        .backgroundColor('rgba(255, 255, 255, 0.90)')
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: 4
        })

        Text('Payment Progress')
          .width('100%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.PRIMARY)
          .textAlign(TextAlign.Center)

        Progress({
          value: this.paymentProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .color(AppColors.PRIMARY)
          .backgroundColor(AppColors.SURFACE_VARIANT)
          .borderRadius(4)

        Slider({
          value: this.paymentProgress * 100,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet,
          direction: Axis.Horizontal,
          reverse: false
        })
          .width('100%')
          .blockColor(AppColors.SECONDARY)
          .selectedColor(AppColors.PRIMARY)
          .trackColor(AppColors.SURFACE_VARIANT)
          .showTips(false)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.paymentProgress = value / 100
            this.drawChart()
          })

        Button('Reset Progress', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(48)
          .borderRadius(12)
          .backgroundColor(AppColors.TERTIARY)
          .fontColor(AppColors.ON_TERTIARY)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.paymentProgress = 0
            this.drawChart()
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: AppSpacing.LG,
        right: AppSpacing.LG,
        top: AppSpacing.LG,
        bottom: AppSpacing.LG
      })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['rgba(255, 193, 7, 0.25)', 0.0],
          [AppColors.BACKGROUND, 0.5],
          ['rgba(255, 165, 0, 0.25)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BACKGROUND)
  }
}