// File 036 - Crypto Market (Finance)
const Colors = {
  primary: '#FFA8A8',
  secondary: '#FFE1A8',
  tertiary: '#A8FFE1',
  background: '#FFFCF5',
  surface: '#FFFFFF',
  surfaceVariant: '#F7F7F7',
  outline: '#E2E2E2',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#1E1E1E',
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
  @State selectedChip: string = 'BTC'
  @State progress: number = 0.6
  @State isAutoUpdate: boolean = true
  private chips: string[] = ['BTC', 'ETH', 'SOL', 'ADA']
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawChart() {
    const c = this.context
    const w = c.width
    const h = c.height
    const step = w / 30
    let prevY = h / 2
    c.clearRect(0, 0, w, h)
    c.beginPath()
    for (let i = 0; i <= 30; i++) {
      const x = i * step
      const y = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3)
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
        Text('Crypto Market')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column({ space: Spacing.lg }) {
        Row({ space: Spacing.md }) {
          ForEach(this.chips, (chip: string) => {
            Button(chip, { type: ButtonType.Normal })
              .backgroundColor(this.selectedChip === chip ? Colors.primary : Colors.surfaceVariant)
              .fontColor(Colors.onPrimary)
              .fontSize(14)
              .borderRadius(20)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .onClick(() => { this.selectedChip = chip })
          }, (chip: string) => chip)
        }

        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => { this.drawChart() })
        }
        .width('100%')
        .height(260)
        .backgroundColor(Colors.surface)
        .borderRadius(20)
        .padding(Spacing.lg)

        Text('Price Variation')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)

        Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)

        Row() {
          Text('Auto Update')
            .fontSize(14)
            .fontColor(Colors.onSurface)
          Blank().layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.isAutoUpdate })
            .selectedColor(Colors.secondary)
            .onChange((isOn: boolean) => { this.isAutoUpdate = isOn })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#4DFFE1A8', 0.0], ['#FFFCF5', 0.5], ['#4DA8FFE1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
