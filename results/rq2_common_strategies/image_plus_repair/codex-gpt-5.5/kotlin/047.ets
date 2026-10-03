interface Pin {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RootScreen {
  @State private pins: Pin[] = [
    { x: 150, y: 250, label: 'Group A' },
    { x: 350, y: 420, label: 'Group B' },
    { x: 520, y: 310, label: 'Group C' }
  ]

  private readonly primary: string = '#FF8C00'
  private readonly secondary: string = '#FFC107'
  private readonly pageBackground: string = '#FFF8E1'
  private readonly surface: string = '#FFFFFF'
  private readonly surfaceVariant: string = '#FFECB3'
  private readonly textColor: string = '#3E2723'

  private addGroup(): void {
    const x: number = Math.floor(Math.random() * 450) + 100
    const y: number = Math.floor(Math.random() * 300) + 150
    this.pins = [...this.pins, { x: x, y: y, label: 'New' }]
  }

  @Builder
  private DealPin(pin: Pin) {
    Circle()
      .width(14)
      .height(14)
      .fill(this.primary)
      .position({
        x: pin.x / 2 + 1,
        y: pin.y / 2 + 1
      })
  }

  @Builder
  private ActiveGroup(pin: Pin) {
    Row() {
      Text(pin.label)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.textColor)

      Circle()
        .width(14)
        .height(14)
        .fill(this.primary)
    }
    .width('100%')
    .height(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column({ space: 16 }) {
      Text('Retro Group Buy')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .lineHeight(34)

      Column({ space: 10 }) {
        Text('Live Deals Map')
          .width('100%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor)
          .lineHeight(24)

        Stack() {
          ForEach(this.pins, (pin: Pin) => {
            this.DealPin(pin)
          }, (pin: Pin, index: number) => `${pin.label}-${index}-${pin.x}-${pin.y}`)
        }
        .width('100%')
        .height(220)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(10)
        .clip(true)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.surface)
      .borderRadius(16)
      .shadow({
        radius: 8,
        color: '#26000000',
        offsetX: 0,
        offsetY: 4
      })

      Blank()
        .height(6)

      Row({ space: 10 }) {
        Button('Add Group')
          .layoutWeight(1)
          .height(48)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor)
          .backgroundColor(this.secondary)
          .borderRadius(10)
          .stateEffect(false)
          .onClick(() => {
            this.addGroup()
          })

        Button('Clear')
          .layoutWeight(1)
          .height(48)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor)
          .backgroundColor(this.primary)
          .borderRadius(10)
          .stateEffect(false)
          .onClick(() => {
            this.pins = []
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Column({ space: 6 }) {
        Text('Active Groups')
          .width('100%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)
          .lineHeight(24)

        ForEach(this.pins, (pin: Pin) => {
          this.ActiveGroup(pin)
        }, (pin: Pin, index: number) => `${pin.label}-${index}`)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.surface)
      .borderRadius(16)
      .shadow({
        radius: 4,
        color: '#1A000000',
        offsetX: 0,
        offsetY: 2
      })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(this.pageBackground)
  }
}
