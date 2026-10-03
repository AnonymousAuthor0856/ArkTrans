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
struct InvoiceScannerPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvas: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State private scanning: boolean = false
  @State private markers: Marker[] = [
    new Marker(108, 181, 'A1'),
    new Marker(288, 381, 'B2'),
    new Marker(508, 581, 'C3')
  ]

  private drawInvoiceArea(): void {
    const width: number = 584
    const height: number = 728
    this.canvas.clearRect(0, 0, width, height)

    this.canvas.fillStyle = '#FBFDFF'
    this.canvas.fillRect(0, 0, width, height)

    this.canvas.fillStyle = '#E0F2FE'
    this.canvas.beginPath()
    this.canvas.arc(width / 2, height / 2, 244, 0, Math.PI * 2)
    this.canvas.fill()

    this.canvas.fillStyle = '#06B6D4'
    for (let i = 0; i < this.markers.length; i++) {
      const marker: Marker = this.markers[i]
      this.canvas.beginPath()
      this.canvas.arc(marker.x, marker.y, 12, 0, Math.PI * 2)
      this.canvas.fill()
    }
  }

  private addMarker(): void {
    if (!this.scanning) {
      return
    }
    const x: number = 80 + Math.random() * 500
    const y: number = 150 + Math.random() * 500
    this.markers = this.markers.concat([new Marker(x, y, `N${this.markers.length + 1}`)])
  }

  build() {
    Column() {
      Text('Invoice Scanner')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0F172A')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 34, bottom: 66 })

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.canvas)
            .width(584)
            .height(728)
            .onReady(() => {
              this.drawInvoiceArea()
            })
            .onAreaChange(() => {
              this.drawInvoiceArea()
            })
        }
        .width('100%')
        .height('100%')
      }
      .width('91.1%')
      .height(800)
      .padding(36)
      .backgroundColor('rgba(255,255,255,0.90)')
      .borderRadius(32)
      .shadow({
        radius: 18,
        color: 'rgba(15, 23, 42, 0.22)',
        offsetX: 0,
        offsetY: 8
      })

      Row() {
        Text('Scanning Active')
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')

        Toggle({ type: ToggleType.Switch, isOn: this.scanning })
          .selectedColor('#3B82F6')
          .switchPointColor(this.scanning ? '#FFFFFF' : '#7DD3FC')
          .onChange((isOn: boolean) => {
            this.scanning = isOn
          })
          .width(104)
          .height(58)
      }
      .width('91.1%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 64 })

      Button('Add Marker')
        .width('91.1%')
        .height(96)
        .fontSize(34)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#06B6D4')
        .borderRadius(24)
        .margin({ top: 50 })
        .onClick(() => {
          this.addMarker()
          this.drawInvoiceArea()
        })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        ['#EAF7FF', 0.00],
        ['#BFDBFE', 0.18],
        ['#F0F9FF', 0.55],
        ['#B6F0FA', 1.00]
      ]
    })
  }
}
