class AppTokens {
  static readonly Colors = {
    primary: '#FF06B6D4',
    secondary: '#FF3B82F6',
    tertiary: '#FF8B5CF6',
    background: '#FFF0F9FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE0F2FE',
    outline: '#FFBAE6FD',
    success: '#FF22C55E',
    warning: '#FFFACC15',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
    surface90: '#E6FFFFFF'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 12,
    large: 20
  }
}

class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct InvoiceScanner {
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]
  @State scanning: boolean = false

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 320
    const h: number = 376
    const centerX = w / 2
    const centerY = h / 2
    const minDim = Math.min(w, h)

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    ctx.arc(centerX, centerY, minDim / 2.5, 0, Math.PI * 2)
    ctx.fillStyle = '#FFE0F2FE'
    ctx.fill()

    for (let i = 0; i < this.markers.length; i++) {
      const marker = this.markers[i]
      ctx.beginPath()
      ctx.arc(marker.x, marker.y, 12, 0, Math.PI * 2)
      ctx.fillStyle = '#FF06B6D4'
      ctx.fill()
    }
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(12)
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(20)
        .backgroundColor(AppTokens.Colors.surface90)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor(AppTokens.Colors.secondary)
            .onChange((value: boolean) => {
              this.scanning = value
            })
        }
        .width('100%')
        .margin({ top: 16 })

        Button('Add Marker') {
        }
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(48)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.primary)
        .margin({ top: 16 })
        .onClick(() => {
          if (this.scanning) {
            const x = 80 + Math.random() * 500
            const y = 150 + Math.random() * 500
            const label = `N${this.markers.length + 1}`
            this.markers.push(new Marker(x, y, label))
            this.drawCanvas()
          }
        })
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}