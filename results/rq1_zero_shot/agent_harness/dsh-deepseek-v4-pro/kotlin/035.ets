// File 035 - Stock K-Line (Finance)
const Colors = {
  primary: '#2563EB',
  secondary: '#60A5FA',
  tertiary: '#93C5FD',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#CBD5E1',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E3A8A',
  onTertiary: '#1E40AF',
  onBackground: '#0F172A',
  onSurface: '#0F172A'
}

const Spacing = {
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
  xxl: 28
}

@Entry
@Component
struct Index {
  @State progress: number = 0.5
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart() {
    const c = this.context
    const w = c.width
    const h = c.height
    const step = w / 50
    let prevY = h / 2
    c.clearRect(0, 0, w, h)
    c.beginPath()
    for (let i = 0; i <= 50; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 8 + this.progress * Math.PI) * (h / 3)
      c.moveTo(x - step, prevY)
      c.lineTo(x, y)
      prevY = y
    }
    c.strokeStyle = Colors.primary
    c.lineWidth = 4
    c.stroke()
  }

  build() {
    Column() {
      Row() {
        Text('Stock K-Line')
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
        .height(260)
        .backgroundColor(Colors.surface)
        .borderRadius(16)
        .padding(Spacing.lg)

        Text('Market Trend')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Slider({ value: this.progress, min: 0, max: 1 })
          .selectedColor(Colors.secondary)
          .trackColor(Colors.surfaceVariant)
          .blockColor(Colors.primary)
          .onChange((value: number) => {
            this.progress = value
            this.drawChart()
          })

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#2660A5FA', 0.0], ['#F8FAFC', 0.5], ['#262563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
