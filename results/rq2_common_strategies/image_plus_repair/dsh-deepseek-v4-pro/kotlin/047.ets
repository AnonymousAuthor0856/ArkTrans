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
struct RootScreen {
  private primary: string = '#FF8C00'
  private secondary: string = '#FFC107'
  private bgColor: string = '#FFF8E1'
  private surface: string = '#FFFFFF'
  private surfaceVariant: string = '#FFECB3'
  private onPrimary: string = '#3E2723'
  private onSecondary: string = '#3E2723'
  private onBackground: string = '#3E2723'
  private onSurface: string = '#3E2723'

  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMap(): void {
    this.context.clearRect(0, 0, this.context.width, this.context.height)
    this.context.fillStyle = this.surfaceVariant
    this.context.fillRect(0, 0, this.context.width, this.context.height)
    for (let i = 0; i < this.pins.length; i++) {
      const pin: Pin = this.pins[i]
      this.context.fillStyle = this.primary
      this.context.beginPath()
      this.context.arc(pin.x, pin.y, 14, 0, 2 * Math.PI)
      this.context.fill()
    }
  }

  private addGroup(): void {
    const newX: number = 100 + Math.floor(Math.random() * 450)
    const newY: number = 150 + Math.floor(Math.random() * 300)
    this.pins.push(new Pin(newX, newY, 'New'))
    this.pins = this.pins.slice()
    this.drawMap()
  }

  private clearPins(): void {
    this.pins = []
    this.drawMap()
  }

  build() {
    Column({ space: 16 }) {
      Text('Retro Group Buy')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onBackground)

      Column({ space: 10 }) {
        Text('Live Deals Map')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.onSurface)
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawMap()
            })
        }
        .width('100%')
        .height(220)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(10)
        .padding(8)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.surface)
      .borderRadius(16)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.15)', offsetX: 0, offsetY: 4 })

      Blank()
        .height(6)

      Row({ space: 10 }) {
        Button() {
          Text('Add Group')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSecondary)
        }
        .backgroundColor(this.secondary)
        .borderRadius(10)
        .layoutWeight(1)
        .height(48)
        .onClick(() => {
          this.addGroup()
        })

        Button() {
          Text('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimary)
        }
        .backgroundColor(this.primary)
        .borderRadius(10)
        .layoutWeight(1)
        .height(48)
        .onClick(() => {
          this.clearPins()
        })
      }
      .width('100%')

      Column({ space: 6 }) {
        Text('Active Groups')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.primary)

        ForEach(this.pins, (pin: Pin) => {
          Row() {
            Text(pin.label)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(this.onSurface)
            Circle({ width: 14, height: 14 })
              .fill(this.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }, (pin: Pin, index: number) => index.toString())
      }
      .width('100%')
      .padding(16)
      .backgroundColor(this.surface)
      .borderRadius(16)
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
    .padding(16)
  }
}
