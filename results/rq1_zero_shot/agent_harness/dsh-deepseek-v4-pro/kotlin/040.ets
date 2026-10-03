// File 040 - Retro Filter Search
interface ResultItem {
  id: number
  title: string
}

const Colors = {
  primary: '#FF7B00',
  secondary: '#FFD166',
  background: '#FFF6E5',
  surface: '#FFFFFF',
  surfaceVariant: '#FFF0C1',
  outline: '#E0C080',
  onPrimary: '#FFFFFF',
  onSecondary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723'
}

const Spacing = {
  sm: 8,
  md: 12,
  lg: 16
}

@Entry
@Component
struct Index {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  @State results: ResultItem[] = []
  private chips: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    for (let i = 0; i < 6; i++) {
      this.results.push({ id: i, title: 'Result ' + (i + 1) })
    }
  }

  private drawFilterCanvas() {
    const c = this.context
    const w = c.width
    const h = c.height
    c.clearRect(0, 0, w, h)
    c.fillStyle = Colors.surfaceVariant
    c.fillRect(0, 0, w, h)
    const grad = c.createRadialGradient(w / 2, h / 2, 0, w / 2, h / 2, 80)
    grad.addColorStop(0, Colors.secondary)
    grad.addColorStop(1, Colors.primary)
    c.beginPath()
    c.arc(w / 2, h / 2, 80, 0, Math.PI * 2)
    c.fillStyle = grad
    c.fill()
    c.beginPath()
    c.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    c.fillStyle = Colors.primary
    c.fill()
  }

  build() {
    Column({ space: Spacing.md }) {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)

      TextInput({ placeholder: 'Search products', text: this.query })
        .width('100%')
        .height(56)
        .backgroundColor(Colors.surface)
        .borderRadius(10)
        .fontColor(Colors.onSurface)
        .placeholderColor('#663E2723')
        .onChange((value: string) => { this.query = value })

      Row({ space: Spacing.sm }) {
        ForEach(this.chips, (chip: string) => {
          Button(chip, { type: ButtonType.Normal })
            .height(36)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(12)
            .borderRadius(6)
            .padding({ left: 12, right: 12 })
            .onClick(() => {})
        }, (chip: string) => chip)
      }
      .width('100%')

      Column() {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => { this.drawFilterCanvas() })
          .onTouch((event: TouchEvent) => {
            if (event.touches.length > 0) {
              this.knobX = event.touches[0].x
              this.knobY = event.touches[0].y
              this.drawFilterCanvas()
            }
          })
      }
      .width('100%')
      .height(180)
      .backgroundColor(Colors.surface)
      .borderRadius(14)
      .padding(16)

      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          Column() {
            Column({ space: Spacing.sm }) {
              Stack() {}
                .width(96)
                .height(96)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(10)
              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Button('Add', { type: ButtonType.Normal })
                .width('100%')
                .backgroundColor(Colors.primary)
                .fontColor(Colors.onPrimary)
                .fontSize(12)
                .borderRadius(10)
                .onClick(() => {})
            }
            .width('100%')
            .padding(Spacing.lg)
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .backgroundColor(Colors.surface)
          .borderRadius(14)
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(Spacing.lg)
      .rowsGap(Spacing.lg)
      .layoutWeight(1)
      .padding({ bottom: 24 })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .padding(Spacing.lg)
    .backgroundColor(Colors.background)
  }
}
