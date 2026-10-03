class AppTokens {
  static readonly Colors = {
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

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16
  }
}

interface ResultItem {
  id: number
  title: string
}

@Entry
@Component
struct RetroFilterSearchPage {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  @State results: ResultItem[] = Array.from({ length: 6 }, (_, i) => ({ id: i, title: `Result ${i + 1}` }))
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  aboutToAppear(): void {
    this.knobX = 160
    this.knobY = 120
  }

  private drawCanvas(): void {
    const ctx = this.canvasCtx
    const w = this.canvasWidth
    const h = this.canvasHeight

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    const cx = w / 2
    const cy = h / 2
    const radius = 80
    const gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, radius)
    gradient.addColorStop(0, AppTokens.Colors.secondary)
    gradient.addColorStop(1, AppTokens.Colors.primary)
    ctx.fillStyle = gradient
    ctx.beginPath()
    ctx.arc(cx, cy, radius, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = AppTokens.Colors.primary
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fill()
  }

  @Builder
  ResultCard(item: ResultItem) {
    Column() {
      Column() {
      }
      .width(96)
      .height(96)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)

      Text(item.title)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Add')
        .width('100%')
        .height(40)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .margin({ top: AppTokens.Spacing.sm })
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 4
    })
  }

  build() {
    Column() {
      Text('Retro Filter Search')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.md })

      TextInput({ placeholder: 'Search products', text: this.query })
        .width('100%')
        .height(56)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .fontColor(AppTokens.Colors.onSurface)
        .placeholderColor('#3E272366')
        .padding({ left: 16, right: 16 })
        .onChange((value: string) => {
          this.query = value
        })
        .margin({ bottom: AppTokens.Spacing.md })

      Row() {
        ForEach(['Popular', 'New', 'Discount', 'Premium'], (label: string) => {
          Button(label)
            .height(36)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.small)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.label.fontSize)
            .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
            .onClick(() => {})
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: AppTokens.Spacing.md })
      .gap(AppTokens.Spacing.sm)

      Stack() {
        Canvas(this.canvasCtx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.canvasWidth = this.canvasCtx.width
            this.canvasHeight = this.canvasCtx.height
            this.drawCanvas()
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = event.localX
                this.knobY = event.localY
                this.drawCanvas()
              })
          )
      }
      .width('100%')
      .height(180)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .padding(16)
      .margin({ bottom: AppTokens.Spacing.md })

      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            this.ResultCard(item)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.lg)
      .rowsGap(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .padding(AppTokens.Spacing.lg)
  }
}
