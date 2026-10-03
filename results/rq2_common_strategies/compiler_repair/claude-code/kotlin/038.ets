@Entry
@Component
struct InvoiceScannerPage {
  @State scanning: boolean = false
  @State markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .margin({ top: 48, bottom: 16 })

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.context)
          .width('100%')
          .height(400)
          .onReady(() => {
            this.drawCanvas()
          })
      }
      .width('100%')
      .height(400)
      .backgroundColor('rgba(255, 255, 255, 0.9)')
      .borderRadius(20)
      .shadow({
        radius: 8,
        color: 'rgba(0, 0, 0, 0.18)',
        offsetY: 4
      })

      Row() {
        Text('Scanning Active')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')

        Toggle({ type: ToggleType.Switch, isOn: this.scanning })
          .selectedColor('#3B82F6')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.scanning = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 16 })

      Button('Add Marker')
        .width('100%')
        .height(48)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#06B6D4')
        .borderRadius(12)
        .margin({ top: 16 })
        .onClick(() => {
          if (this.scanning) {
            let x: number = Math.floor(Math.random() * 500) + 80
            let y: number = Math.floor(Math.random() * 500) + 150
            this.markers.push(new Marker(x, y, 'N' + (this.markers.length + 1)))
            this.drawCanvas()
          }
        })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['rgba(59, 130, 246, 0.3)', 0.0],
        ['#F0F9FF', 0.5],
        ['rgba(6, 182, 212, 0.3)', 1.0]
      ]
    })
  }

  private drawCanvas(): void {
    let ctx = this.context
    let w = ctx.width
    let h = ctx.height
    let centerX = w / 2
    let centerY = h / 2
    let radius = Math.min(w, h) / 2.5

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    ctx.fillStyle = '#E0F2FE'
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.fill()

    for (let i = 0; i < this.markers.length; i++) {
      let m = this.markers[i]
      ctx.beginPath()
      ctx.fillStyle = '#06B6D4'
      ctx.arc(m.x, m.y, 12, 0, Math.PI * 2)
      ctx.fill()
    }
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
