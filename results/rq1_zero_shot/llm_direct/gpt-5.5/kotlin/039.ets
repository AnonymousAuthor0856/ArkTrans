const NAME: string = '051*InstallmentPlan*en'
const UI_TYPE: string = 'Finance'
const STYLE_THEME: string = 'Warm Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const AppTokens = {
  Colors: {
    primary: '#FFA500',
    secondary: '#FFC107',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surface90: 'rgba(255, 255, 255, 0.9)',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E',
    secondary25: 'rgba(255, 193, 7, 0.25)',
    primary25: 'rgba(255, 165, 0, 0.25)'
  },
  TypographyTokens: {
    displaySize: 28,
    titleSize: 18,
    bodySize: 14,
    labelSize: 12
  },
  Shapes: {
    small: 6,
    medium: 12,
    large: 20
  },
  Spacing: {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  ElevationMapping: {
    level1: {
      elevation: 2,
      radius: 4,
      dy: 2,
      opacity: 0.12
    },
    level2: {
      elevation: 6,
      radius: 8,
      dy: 4,
      opacity: 0.18
    }
  }
}

@Entry
@Component
struct InstallmentPlanPage {
  @State private paymentProgress: number = 0.3

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private progressWidth(): string {
    const value = Math.max(0, Math.min(100, this.paymentProgress * 100))
    return `${value}%`
  }

  private drawInstallmentWave(): void {
    const w = this.context.width
    const h = this.context.height

    if (w <= 0 || h <= 0) {
      return
    }

    this.context.clearRect(0, 0, w, h)
    this.context.beginPath()
    this.context.strokeStyle = AppTokens.Colors.primary
    this.context.lineWidth = 5
    this.context.lineCap = 'round'
    this.context.lineJoin = 'round'

    const step = w / 20
    let prevY = h / 2

    for (let i = 0; i <= 20; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)

      this.context.moveTo(x - step, prevY)
      this.context.lineTo(x, y)

      prevY = y
    }

    this.context.stroke()
  }

  build() {
    Column() {
      Row() {
        Text('Installment Plan')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawInstallmentWave()
            })
            .onAreaChange(() => {
              this.drawInstallmentWave()
            })
        }
        .width('100%')
        .height(240)
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface90)
        .borderRadius(AppTokens.Shapes.large)
        .clip(true)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text('Payment Progress')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Stack({ alignContent: Alignment.CenterStart }) {
          Row() {
          }
          .width('100%')
          .height(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(4)

          Row() {
          }
          .width(this.progressWidth())
          .height(8)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(4)
        }
        .width('100%')
        .height(8)

        Slider({
          value: this.paymentProgress,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.secondary)
          .selectedColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .showTips(false)
          .onChange((value: number) => {
            this.paymentProgress = value
            this.drawInstallmentWave()
          })

        Button() {
          Text('Reset Progress')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
        }
        .width('100%')
        .height(48)
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          this.paymentProgress = 0
          this.drawInstallmentWave()
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary25, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.primary25, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}