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
}

class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private results: ResultItem[] = []
  private chips: string[] = ['Popular', 'New', 'Discount', 'Premium']

  aboutToAppear(): void {
    for (let i: number = 0; i < 6; i++) {
      this.results.push(new ResultItem(i, 'Result ' + (i + 1).toString()))
    }
  }

  private draw(): void {
    const w: number = this.context.width
    const h: number = this.context.height
    this.context.clearRect(0, 0, w, h)
    this.context.fillStyle = AppColors.surfaceVariant
    this.context.fillRect(0, 0, w, h)
    const gradient: CanvasGradient = this.context.createRadialGradient(w / 2, h / 2, 0, w / 2, h / 2, 80)
    gradient.addColorStop(0, AppColors.secondary)
    gradient.addColorStop(1, AppColors.primary)
    this.context.fillStyle = gradient
    this.context.beginPath()
    this.context.arc(w / 2, h / 2, 80, 0, Math.PI * 2)
    this.context.fill()
    this.context.fillStyle = AppColors.primary
    this.context.beginPath()
    this.context.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    this.context.fill()
  }

  build() {
    Scroll() {
      Column({ space: 12 }) {
        Text('Retro Filter Search')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        TextInput({ placeholder: 'Search products', text: this.query })
          .placeholderColor('rgba(62,39,35,0.4)')
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surface)
          .borderRadius(10)
          .height(48)
          .width('100%')
          .onChange((value: string) => {
            this.query = value
          })

        Row({ space: 8 }) {
          ForEach(this.chips, (chip: string) => {
            Button() {
              Text(chip)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSecondary)
            }
            .height(36)
            .backgroundColor(AppColors.secondary)
            .borderRadius(6)
            .onClick(() => {})
          }, (chip: string) => chip)
        }
        .width('100%')

        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.draw()
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Down || event.type === TouchType.Move) {
                if (event.touches.length > 0) {
                  this.knobX = event.touches[0].x
                  this.knobY = event.touches[0].y
                  this.draw()
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
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              Column({ space: 8 }) {
                Column()
                  .width(96)
                  .height(96)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(10)

                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)

                Button() {
                  Text('Add')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onPrimary)
                }
                .width('100%')
                .backgroundColor(AppColors.primary)
                .borderRadius(10)
                .onClick(() => {})
              }
              .width('100%')
              .padding(16)
              .alignItems(HorizontalAlign.Center)
            }
            .backgroundColor(AppColors.surface)
            .borderRadius(14)
          }, (item: ResultItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
      }
      .width('100%')
      .padding(16)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
