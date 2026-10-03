import { router } from '@kit.ArkUI'

interface MarkerData {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RootScreen {
  @State markers: MarkerData[] = [
    { x: 120, y: 200, label: 'A1' },
    { x: 300, y: 400, label: 'B2' },
    { x: 520, y: 600, label: 'C3' }
  ]
  @State scanning: boolean = false

  private canvasWidth: number = 0
  private canvasHeight: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawCanvas() {
    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)
    const cx = this.canvasWidth / 2
    const cy = this.canvasHeight / 2
    const radius = Math.min(this.canvasWidth, this.canvasHeight) / 2.5

    this.context.beginPath()
    this.context.arc(cx, cy, radius, 0, Math.PI * 2)
    this.context.fillStyle = '#E0F2FE'
    this.context.fill()

    for (const m of this.markers) {
      this.context.beginPath()
      this.context.arc(m.x, m.y, 12, 0, Math.PI * 2)
      this.context.fillStyle = '#06B6D4'
      this.context.fill()
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Invoice Scanner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      // Main content with gradient background
      Column({ space: 16 }) {
        // Canvas card
        Column() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.canvasWidth = this.context.width
              this.canvasHeight = this.context.height
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(400)
        .borderRadius(20)
        .backgroundColor('#E6FFFFFF')
        .shadow({ radius: 8, color: '#1F000000', offsetX: 0, offsetY: 4 })
        .clip(true)

        // Scanning Active row
        Row() {
          Text('Scanning Active')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0F172A')

          Toggle({ type: ToggleType.Switch, isOn: this.scanning })
            .selectedColor('#3B82F6')
            .switchPointColor('#BAE6FD')
            .onChange((isOn: boolean) => {
              this.scanning = isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Add Marker button
        Button('Add Marker')
          .width('100%')
          .height(48)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#06B6D4')
          .borderRadius(12)
          .onClick(() => {
            if (this.scanning) {
              const newMarker: MarkerData = {
                x: Math.floor(Math.random() * (580 - 80) + 80),
                y: Math.floor(Math.random() * (650 - 150) + 150),
                label: `N${this.markers.length + 1}`
              }
              this.markers = [...this.markers, newMarker]
              this.drawCanvas()
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          ['#F0F9FF', 0.5],
          ['#4D06B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}