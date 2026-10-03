@Entry
@Component
struct Index {
  @State pins: Pin[] = [
    new Pin(150, 250, "Group A"),
    new Pin(350, 420, "Group B"),
    new Pin(520, 310, "Group C")
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')

        Column() {
          Column({ space: 10 }) {
            Text('Live Deals Map')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#3E2723')

            Stack({ alignContent: Alignment.Center }) {
              Canvas().width('100%').height('100%')
            }
            .width('100%')
            .height(220)
            .backgroundColor('#FFECB3')
            .borderRadius(8)
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Blank().height(16)

        Row({ space: 0 }) {
          Button() {
            Text('Add Group')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#D7CCC8')
          .fontColor('#3E2723')
          .borderRadius(8)

          Blank().width(16)

          Button() {
            Text('Clear')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
          }
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#FF8C00')
          .fontColor('#FFFFFF')
          .borderRadius(8)
          .onClick(() => {
            this.pins = []
          })
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')

        Column() {
          Column({ space: 6 }) {
            Text('Active Groups')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF8C00')

            ForEach(this.pins, (pin: Pin) => {
              Row({ space: 0 }) {
                Text(pin.label)
                  .fontSize(16)
                  .fontColor('#3E2723')
                
                Stack({ alignContent: Alignment.Center }) {
                }
                .width(14)
                .height(14)
                .backgroundColor('#FF8C00')
                .borderRadius(7)
              }
              .alignItems(VerticalAlign.Center)
              .width('100%')
            })
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1')
  }
}

class Pin {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}