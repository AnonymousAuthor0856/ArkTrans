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

@Entry
@Component
struct Index {
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private newPin(): Pin {
    const index = this.pins.length + 1
    const x = 100 + ((index * 79) % 450)
    const y = 150 + ((index * 67) % 300)
    return new Pin(x, y, 'New')
  }

  @Builder
  MapCard() {
    Column() {
      Text('Live Deals Map')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .width('100%')

      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .radius(10)
          .fill('#FFECB3')

        ForEach(this.pins, (pin: Pin) => {
          Circle()
            .width(28)
            .height(28)
            .fill('#FF8C00')
            .translate({ x: pin.x / 2 - 150, y: pin.y / 2 - 110 })
        }, (pin: Pin, index: number) => `${pin.label}${index}`)
      }
      .width('100%')
      .height(220)
      .backgroundColor('#FFECB3')
      .borderRadius(10)
      .margin({ top: 10 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#263E2723', offsetY: 4 })
  }

  @Builder
  ActiveGroupsCard() {
    Column() {
      Text('Active Groups')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FF8C00')
        .width('100%')

      ForEach(this.pins, (pin: Pin) => {
        Row() {
          Text(pin.label)
            .fontSize(14)
            .fontColor('#3E2723')
            .layoutWeight(1)
          Circle()
            .width(14)
            .height(14)
            .fill('#FF8C00')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 6 })
      }, (pin: Pin, index: number) => `${pin.label}${index}`)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1A3E2723', offsetY: 2 })
  }

  build() {
    Stack() {
      Column() {
        Text('Retro Group Buy')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#3E2723')
          .width('100%')

        Column() {
          this.MapCard()
        }
        .margin({ top: 16 })

        Row() {
          Button('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .height(48)
            .layoutWeight(1)
            .backgroundColor('#FFC107')
            .borderRadius(10)
            .onClick(() => {
              this.pins = [...this.pins, this.newPin()]
            })

          Blank().width(10)

          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#3E2723')
            .height(48)
            .layoutWeight(1)
            .backgroundColor('#FF8C00')
            .borderRadius(10)
            .onClick(() => {
              this.pins = []
            })
        }
        .width('100%')
        .margin({ top: 6 })

        Column() {
          this.ActiveGroupsCard()
        }
        .margin({ top: 16 })

        Blank()
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
