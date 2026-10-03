import { router } from '@kit.ArkUI'

interface Pin {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawPins() {
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.context.fillStyle = '#FFECB3'
    this.context.fillRect(0, 0, this.context.width, this.context.height)
    for (const pin of this.pins) {
      this.context.beginPath()
      this.context.arc(pin.x * this.context.width / 700, pin.y * this.context.height / 500, 14, 0, Math.PI * 2)
      this.context.fillStyle = '#FF8C00'
      this.context.fill()
      this.context.closePath()
    }
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .alignSelf(ItemAlign.Start)

        // Live Deals Map Card
        Column({ space: 10 }) {
          Text('Live Deals Map')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .alignSelf(ItemAlign.Start)

          Canvas(this.context)
            .width('100%')
            .height(220)
            .borderRadius(10)
            .backgroundColor('#FFECB3')
            .onReady(() => {
              this.drawPins()
            })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })

        // Buttons Row
        Row({ space: 10 }) {
          Button('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .backgroundColor('#FFC107')
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              const newPin: Pin = {
                x: Math.floor(Math.random() * 450) + 100,
                y: Math.floor(Math.random() * 300) + 150,
                label: 'New'
              }
              this.pins = [...this.pins, newPin]
              this.drawPins()
            })

          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .backgroundColor('#FF8C00')
            .borderRadius(10)
            .height(48)
            .layoutWeight(1)
            .onClick(() => {
              this.pins = []
              this.drawPins()
            })
        }
        .width('100%')

        // Active Groups Card
        Column({ space: 6 }) {
          Text('Active Groups')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8C00')
            .alignSelf(ItemAlign.Start)

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor('#3E2723')

              Circle({ width: 14, height: 14 })
                .fill('#FF8C00')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          })
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
      }
      .padding(16)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1')
  }
}