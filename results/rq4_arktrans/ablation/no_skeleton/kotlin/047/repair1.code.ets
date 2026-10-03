import { canvas, drawing } from '@kit.ArkGraphics'

interface Pin {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RetroGroupBuy {
  @State pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ]

  build() {
    Column() {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .margin({ bottom: 16 })

      // Live Deals Map Card
      Column() {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#3E2723')
          .margin({ bottom: 10 })

        Canvas(this.ctx).width('100%').height(220).borderRadius(10).backgroundColor('#FFECB3')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: '#26000000', offsetY: 4 })

      Blank().height(6)

      // Buttons Row
      Row() {
        Button('Add Group')
          .type(ButtonType.Normal)
          .backgroundColor('#FFC107')
          .fontColor('#3E2723')
          .borderRadius(10)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.pins.push({
              x: Math.random() * 450 + 50,
              y: Math.random() * 300 + 100,
              label: `New ${this.pins.length + 1}`
            })
          })

        Blank().width(10)

        Button('Clear')
          .type(ButtonType.Normal)
          .backgroundColor('#FF8C00')
          .fontColor('#3E2723')
          .borderRadius(10)
          .height(48)
          .layoutWeight(1)
          .onClick(() => {
            this.pins = []
          })
      }
      .width('100%')

      // Active Groups Card
      Column() {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF8C00')
          .margin({ bottom: 6 })

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(14)
              .fontColor('#3E2723')
              .layoutWeight(1)

            Circle({ width: 14, height: 14 })
              .fill('#FF8C00')
          }
          .width('100%')
          .margin({ bottom: 6 })
        })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFF')
      .borderRadius(16)
      .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFF8E1')
  }

  private ctx: drawing.DrawingContext = new drawing.DrawingContext()

  aboutToAppear() {
    this.ctx.onDrawRect((canvasObj: canvas.Canvas, rect: drawing.Rect) => {
      const paint = new drawing.Paint()
      paint.setColor(drawing.Color.parseColorSync('#FFECB3'))
      canvasObj.drawRoundRect(rect, 10, 10, paint)

      for (const pin of this.pins) {
        const circlePaint = new drawing.Paint()
        circlePaint.setColor(drawing.Color.parseColorSync('#FF8C00'))
        canvasObj.drawCircle(pin.x, pin.y, 14, circlePaint)
      }
    })
  }
}