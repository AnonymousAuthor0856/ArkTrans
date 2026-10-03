// File 032 - Transfer Wizard (Finance)
const Colors = {
  primary: '#FFA500',
  secondary: '#FFC300',
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
  @State markerX: number = 200
  @State markerY: number = 400
  @State progress: number = 0.4
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawCircle() {
    const c = this.context
    const w = c.width
    const h = c.height
    c.clearRect(0, 0, w, h)
    c.beginPath()
    c.arc(w / 2, h / 2, 260, 0, Math.PI * 2)
    c.fillStyle = Colors.surfaceVariant
    c.fill()
    c.beginPath()
    c.arc(this.markerX, this.markerY, 20, 0, Math.PI * 2)
    c.fillStyle = Colors.primary
    c.fill()
  }

  build() {
    Column() {
      Row() {
        Text('Transfer Wizard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Stack({ alignContent: Alignment.Bottom }) {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => { this.drawCircle() })
        Column({ space: Spacing.lg }) {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
            .width('80%')
            .height(8)
            .color(Colors.primary)
            .backgroundColor(Colors.surfaceVariant)
          Row({ space: Spacing.md }) {
            Button('+', { type: ButtonType.Circle })
              .width(48)
              .height(48)
              .backgroundColor(Colors.primary)
              .fontColor(Colors.onPrimary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1)
              })
            Button('-', { type: ButtonType.Circle })
              .width(48)
              .height(48)
              .backgroundColor(Colors.secondary)
              .fontColor(Colors.onSecondary)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0)
              })
          }
        }
        .width('100%')
        .padding({ bottom: Spacing.xxl })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [['#33FFC300', 0.0], ['#FFFBF2', 0.5], ['#33FFA500', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
