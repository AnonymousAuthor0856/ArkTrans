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

const PRIMARY: string = '#FF8C00'
const SECONDARY: string = '#FFC107'
const BACKGROUND: string = '#FFF8E1'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#FFECB3'
const ON_PRIMARY: string = '#3E2723'
const ON_SECONDARY: string = '#3E2723'
const ON_BACKGROUND: string = '#3E2723'
const ON_SURFACE: string = '#3E2723'

const SPACE_SM: number = 6
const SPACE_MD: number = 10
const SPACE_LG: number = 16

@Entry
@Component
struct Index {
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private pinLeft(pin: Pin): number {
    return 8 + pin.x / 2 - 7
  }

  private pinTop(pin: Pin): number {
    return 8 + pin.y / 2 - 7
  }

  private randomInt(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min)) + min
  }

  build() {
    Column({ space: SPACE_LG }) {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_BACKGROUND)
        .width('100%')

      Column({ space: SPACE_MD }) {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
          .width('100%')

        Stack() {
          ForEach(this.pins, (pin: Pin) => {
            Circle()
              .width(14)
              .height(14)
              .fill(PRIMARY)
              .position({
                x: this.pinLeft(pin),
                y: this.pinTop(pin)
              })
          })
        }
        .width('100%')
        .height(220)
        .backgroundColor(SURFACE_VARIANT)
        .borderRadius(10)
        .clip(true)
      }
      .width('100%')
      .padding(SPACE_LG)
      .backgroundColor(SURFACE)
      .borderRadius(16)
      .shadow({
        radius: 8,
        color: '#26000000',
        offsetX: 0,
        offsetY: 4
      })

      Blank()
        .height(SPACE_SM)

      Row({ space: SPACE_MD }) {
        Button('Add Group', { type: ButtonType.Normal, stateEffect: true })
          .height(48)
          .layoutWeight(1)
          .borderRadius(10)
          .backgroundColor(SECONDARY)
          .fontColor(ON_SECONDARY)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            const x: number = this.randomInt(100, 550)
            const y: number = this.randomInt(150, 450)
            this.pins = [...this.pins, new Pin(x, y, 'New')]
          })

        Button('Clear', { type: ButtonType.Normal, stateEffect: true })
          .height(48)
          .layoutWeight(1)
          .borderRadius(10)
          .backgroundColor(PRIMARY)
          .fontColor(ON_PRIMARY)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.pins = []
          })
      }
      .width('100%')

      Column({ space: SPACE_SM }) {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY)
          .width('100%')

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(ON_SURFACE)

            Circle()
              .width(14)
              .height(14)
              .fill(PRIMARY)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        })
      }
      .width('100%')
      .padding(SPACE_LG)
      .backgroundColor(SURFACE)
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
    .padding(SPACE_LG)
    .backgroundColor(BACKGROUND)
  }
}