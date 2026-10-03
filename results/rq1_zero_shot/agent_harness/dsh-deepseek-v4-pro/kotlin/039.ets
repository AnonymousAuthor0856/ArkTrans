// File 039 - Installment Plan (Finance)
const Colors = {
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
}

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State paymentProgress: number = 0.3
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart() {
    const c = this.context
    const w = c.width
    const h = c.height
    const step = w / 20
    let prevY = h / 2
    c.clearRect(0, 0, w, h)
    c.beginPath()
    for (let i = 0; i <= 20; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 5 + this.paymentProgress * Math.PI) * (h / 3)
      c.moveTo(x - step, prevY)
      c.lineTo(x, y)
      prevY = y
    }
    c.strokeStyle = Colors.primary
    c.lineWidth = 5
    c.stroke()
  }

  build() {
    Column() {
      Row() {
        Text('Installment Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column({ space: Spacing.lg }) {
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => { this.drawChart() })
        }
        .width('100%')
        .height(240)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(20)
        .padding(Spacing.lg)

        Text('Payment Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Progress({ value: this.paymentProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)

        Slider({ value: this.paymentProgress, min: 0, max: 1 })
          .selectedColor(Colors.primary)
          .trackColor(Colors.surfaceVariant)
          .blockColor(Colors.secondary)
          .onChange((value: number) => {
            this.paymentProgress = value
            this.drawChart()
          })

        Button('Reset Progress', { type: ButtonType.Normal })
          .width('100%')
          .height(48)
          .backgroundColor(Colors.tertiary)
          .fontColor(Colors.onTertiary)
          .fontSize(18)
          .borderRadius(12)
          .onClick(() => {
            this.paymentProgress = 0
            this.drawChart()
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#40FFC107', 0.0], ['#FFFBF2', 0.5], ['#40FFA500', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
