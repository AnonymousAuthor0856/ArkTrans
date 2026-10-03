// File 038 - Invoice Scanner (Finance)
interface Marker {
  x: number
  y: number
  label: string
}

const Colors = {
  primary: '#06B6D4',
  secondary: '#3B82F6',
  tertiary: '#8B5CF6',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#BAE6FD',
  success: '#22C55E',
  warning: '#FACC15',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#0F172A'
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
  @State scanning: boolean = false
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ]
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawScanner() {
    const c = this.context
    const w = c.width
    const h = c.height
    c.clearRect(0, 0, w, h)
    const cx = w / 2
    const cy = h / 2
    const radius = Math.min(w, h) / 2.5
    c.beginPath()
    c.arc(cx, cy, radius, 0, Math.PI * 2)
    c.fillStyle = Colors.surfaceVariant
    c.fill()
    for (const m of this.markers) {
      c.beginPath()
      c.arc(m.x, m.y, 12, 0, Math.PI * 2)
      c.fillStyle = Colors.primary
      c.fill()
    }
  }

  build() {
    Column() {
      Row() {
        Text('Invoice Scanner')
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
            .onReady(() => { this.drawScanner() })
        }
        .width('100%')
        .height(400)
        .backgroundColor('#E6FFFFFF')
        .borderRadius(20)
        .padding(Spacing.md)

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Blank().layoutWeight(1)
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(Colors.secondary)
            .onChange((isOn: boolean) => { this.scanning = isOn })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Button('Add Marker', { type: ButtonType.Normal })
          .width('100%')
          .height(48)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(18)
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              this.markers.push({
                x: 80 + Math.floor(Math.random() * 500),
                y: 150 + Math.floor(Math.random() * 500),
                label: 'N' + (this.markers.length + 1)
              })
              this.drawScanner()
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [['#4D3B82F6', 0.0], ['#F0F9FF', 0.5], ['#4D06B6D4', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
