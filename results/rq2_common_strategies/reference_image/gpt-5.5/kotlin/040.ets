interface ResultItem {
  id: number
  title: string
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
  static readonly placeholder: string = '#663E2723'
  static readonly shadow: string = '#33000000'
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
}

@Component
struct FilterChip {
  @Prop label: string = ''
  @Prop chipWidth: number = 80

  build() {
    Button(this.label, { type: ButtonType.Normal })
      .width(this.chipWidth)
      .height(36)
      .borderRadius(6)
      .backgroundColor(AppColors.secondary)
      .fontColor(AppColors.onSecondary)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .padding({ left: 8, right: 8 })
  }
}

@Component
struct ResultCard {
  @Prop title: string = ''

  build() {
    Column({ space: AppSpacing.sm }) {
      Blank()
        .width(96)
        .height(96)
        .borderRadius(10)
        .backgroundColor(AppColors.surfaceVariant)

      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')

      Button('Add', { type: ButtonType.Normal })
        .width('100%')
        .height(48)
        .borderRadius(10)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(212)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(14)
    .shadow({
      radius: 8,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Entry
@Component
struct Index {
  @State query: string = ''
  @State knobX: number = 137
  @State knobY: number = 62

  private canvasContext: CanvasRenderingContext2D =
    new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' }
  ]

  private drawFilterCanvas(): void {
    this.canvasContext.clearRect(0, 0, 1000, 1000)

    this.canvasContext.fillStyle = AppColors.surfaceVariant
    this.canvasContext.fillRect(0, 0, 1000, 1000)

    const cx: number = 148
    const cy: number = 74
    const radius: number = 80

    let gradient: CanvasGradient = this.canvasContext.createRadialGradient(cx, cy, 0, cx, cy, radius)
    gradient.addColorStop(0, AppColors.secondary)
    gradient.addColorStop(1, AppColors.primary)

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = gradient
    this.canvasContext.arc(cx, cy, radius, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = AppColors.primary
    this.canvasContext.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    this.canvasContext.fill()
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Retro Filter Search')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)

      Column() {
        TextInput({ text: this.query, placeholder: 'Search products' })
          .width('100%')
          .height(55)
          .backgroundColor(AppColors.surface)
          .borderRadius(10)
          .fontSize(20)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.placeholder)
          .caretColor(AppColors.primary)
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
          .onChange((value: string) => {
            this.query = value
          })

        Divider()
          .height(1)
          .color(AppColors.outline)
      }
      .width('100%')
      .height(56)
      .borderRadius(10)
      .clip(true)
      .backgroundColor(AppColors.surface)

      Row({ space: AppSpacing.sm }) {
        FilterChip({ label: 'Popular', chipWidth: 89 })
        FilterChip({ label: 'New', chipWidth: 72 })
        FilterChip({ label: 'Discount', chipWidth: 96 })
        FilterChip({ label: 'Premium', chipWidth: 96 })
      }
      .width('100%')
      .height(48)
      .clip(true)
      .alignItems(VerticalAlign.Center)

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawFilterCanvas()
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                this.knobX = event.touches[0].x
                this.knobY = event.touches[0].y
                this.drawFilterCanvas()
              }
            }
          })
      }
      .width('100%')
      .height(180)
      .padding(AppSpacing.lg)
      .borderRadius(14)
      .clip(true)
      .backgroundColor(AppColors.surface)

      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            ResultCard({ title: item.title })
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .padding({ bottom: 24 })
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
  }
}