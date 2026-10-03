class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

class AppColors {
  static readonly primary: string = '#FF7B00'
  static readonly secondary: string = '#FFD166'
  static readonly background: string = '#FFF6E5'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFF0C1'
  static readonly outline: string = '#E0C080'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
  static readonly placeholder: string = '#B6AAA6'
}

@Entry
@Component
struct RootScreen {
  @State private query: string = ''
  @State private knobX: number = 160
  @State private knobY: number = 120
  @State private canvasWidth: number = 0
  @State private canvasHeight: number = 0

  private readonly contextSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private readonly canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.contextSettings)
  private readonly categories: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private readonly items: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ]

  private toNumber(value: string | number): number {
    if (typeof value === 'number') {
      return value
    }
    const parsed = Number.parseFloat(value)
    return Number.isNaN(parsed) ? 0 : parsed
  }

  private drawFilter(): void {
    const width = this.canvasWidth > 0 ? this.canvasWidth : 296
    const height = this.canvasHeight > 0 ? this.canvasHeight : 148
    const centerX = width / 2
    const centerY = height / 2

    this.canvasContext.clearRect(0, 0, width, height)
    this.canvasContext.fillStyle = AppColors.surfaceVariant
    this.canvasContext.fillRect(0, 0, width, height)

    const gradient = this.canvasContext.createRadialGradient(centerX, centerY, 0, centerX, centerY, 80)
    gradient.addColorStop(0, AppColors.secondary)
    gradient.addColorStop(1, AppColors.primary)
    this.canvasContext.fillStyle = gradient
    this.canvasContext.beginPath()
    this.canvasContext.arc(centerX, centerY, 80, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.canvasContext.fillStyle = AppColors.primary
    this.canvasContext.beginPath()
    this.canvasContext.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    this.canvasContext.fill()
  }

  @Builder
  private CategoryButton(label: string, index: number) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .height(36)
      .width(index === 0 ? 89 : index === 1 ? 72 : index === 2 ? 96 : 95)
      .borderRadius(6)
      .backgroundColor(AppColors.secondary)
      .fontColor(AppColors.onSecondary)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .padding({ left: 10, right: 10 })
  }

  @Builder
  private ResultCard(item: ResultItem) {
    Column({ space: 8 }) {
      Blank()
        .width(96)
        .height(96)
        .borderRadius(10)
        .backgroundColor(AppColors.surfaceVariant)

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Button('Add', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(40)
        .borderRadius(10)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.18)',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column({ space: 12 }) {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')

      Column() {
        TextInput({ text: this.query, placeholder: 'Search products' })
          .width('100%')
          .height(56)
          .fontSize(16)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.placeholder)
          .caretColor(AppColors.primary)
          .backgroundColor(AppColors.surface)
          .borderRadius(10)
          .padding({ left: 16, right: 16 })
          .onChange((value: string) => {
            this.query = value
          })

        Divider()
          .height(1)
          .color(AppColors.outline)
      }
      .width('100%')

      Row({ space: 8 }) {
        ForEach(this.categories, (label: string, index: number) => {
          this.CategoryButton(label, index)
        }, (label: string) => label)
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center)
      .clip(true)

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawFilter()
          })
          .onAreaChange((_oldArea: Area, newArea: Area) => {
            this.canvasWidth = this.toNumber(newArea.width as string | number)
            this.canvasHeight = this.toNumber(newArea.height as string | number)
            this.knobX = this.canvasWidth / 2 - 22
            this.knobY = this.canvasHeight / 2 - 28
            this.drawFilter()
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                this.knobX = event.touches[0].x
                this.knobY = event.touches[0].y
                this.drawFilter()
              }
            }
          })
      }
      .width('100%')
      .height(180)
      .padding(16)
      .backgroundColor(AppColors.surface)
      .borderRadius(14)

      Grid() {
        ForEach(this.items, (item: ResultItem) => {
          GridItem() {
            this.ResultCard(item)
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .layoutWeight(1)
      .padding({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor(AppColors.background)
  }
}
