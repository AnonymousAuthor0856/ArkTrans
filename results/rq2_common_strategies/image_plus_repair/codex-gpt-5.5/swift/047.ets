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
struct GroupBuyApp {
  @State private pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private readonly bgColor: string = '#FFF8E1'
  private readonly surfaceColorValue: string = '#FFFFFF'
  private readonly surfaceVariantColorValue: string = '#FFECB3'
  private readonly primaryColorValue: string = '#FF8C00'
  private readonly secondaryColorValue: string = '#FFC107'
  private readonly onSurfaceColorValue: string = '#3E2723'

  private addGroup(): void {
    const randomX: number = Math.floor(Math.random() * 450) + 100
    const randomY: number = Math.floor(Math.random() * 300) + 150
    this.pins.push(new Pin(randomX, randomY, 'New'))
  }

  private clearGroups(): void {
    this.pins = []
  }

  @Builder
  private mapContent() {
    Stack() {
      ForEach(this.pins, (pin: Pin) => {
        Circle()
          .width(28)
          .height(28)
          .fill(this.primaryColorValue)
          .position({
            x: pin.x - 14,
            y: pin.y - 14
          })
      }, (pin: Pin) => `${pin.label}-${pin.x}-${pin.y}`)
    }
    .width('100%')
    .height(220)
    .backgroundColor(this.surfaceVariantColorValue)
    .borderRadius(10)
    .clip(true)
  }

  @Builder
  private activeGroups() {
    Column() {
      Text('Active Groups')
        .fontSize(18)
        .fontColor(this.primaryColorValue)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .margin({ bottom: 6 })

      ForEach(this.pins, (pin: Pin) => {
        Row() {
          Text(pin.label)
            .fontSize(14)
            .fontColor(this.onSurfaceColorValue)

          Blank()

          Circle()
            .width(14)
            .height(14)
            .fill(this.primaryColorValue)
        }
        .width('100%')
        .height(23)
      }, (pin: Pin) => `${pin.label}-row-${pin.x}-${pin.y}`)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(this.surfaceColorValue)
    .borderRadius(16)
    .shadow({
      radius: 2,
      color: '#193E2723',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontColor(this.onSurfaceColorValue)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 16 })

      Column() {
        Text('Live Deals Map')
          .fontSize(18)
          .fontColor(this.onSurfaceColorValue)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .margin({ bottom: 10 })

        this.mapContent()
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .width('100%')
      .backgroundColor(this.surfaceColorValue)
      .borderRadius(16)
      .shadow({
        radius: 6,
        color: '#263E2723',
        offsetX: 0,
        offsetY: 4
      })

      Row() {
        Button('Add Group', { type: ButtonType.Normal })
          .layoutWeight(1)
          .height(48)
          .fontSize(12)
          .fontColor(this.onSurfaceColorValue)
          .backgroundColor(this.secondaryColorValue)
          .borderRadius(10)
          .margin({ right: 10 })
          .onClick(() => this.addGroup())

        Button('Clear', { type: ButtonType.Normal })
          .layoutWeight(1)
          .height(48)
          .fontSize(12)
          .fontColor(this.onSurfaceColorValue)
          .backgroundColor(this.primaryColorValue)
          .borderRadius(10)
          .onClick(() => this.clearGroups())
      }
      .width('100%')
      .margin({ top: 24, bottom: 16 })

      this.activeGroups()

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(this.bgColor)
  }
}
