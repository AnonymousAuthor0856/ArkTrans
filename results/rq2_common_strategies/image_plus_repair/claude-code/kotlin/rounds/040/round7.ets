class ColorTokens {
  primary: string = '#FF7B00'
  secondary: string = '#FFD166'
  background: string = '#FFF6E5'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#FFF0C1'
  outline: string = '#E0C080'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#3E2723'
  onBackground: string = '#3E2723'
  onSurface: string = '#3E2723'
}

class TypographyStyle {
  fontSize: number
  fontWeight: FontWeight

  constructor(fontSize: number, fontWeight: FontWeight) {
    this.fontSize = fontSize
    this.fontWeight = fontWeight
  }
}

class TypographyTokens {
  display: TypographyStyle = new TypographyStyle(28, FontWeight.Bold)
  headline: TypographyStyle = new TypographyStyle(20, FontWeight.Bold)
  title: TypographyStyle = new TypographyStyle(16, FontWeight.Medium)
  body: TypographyStyle = new TypographyStyle(14, FontWeight.Normal)
  label: TypographyStyle = new TypographyStyle(12, FontWeight.Medium)
}

class ShapeTokens {
  small: number = 6
  medium: number = 10
  large: number = 14
}

class SpacingTokens {
  sm: number = 8
  md: number = 12
  lg: number = 16
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens()
  static readonly Typography: TypographyTokens = new TypographyTokens()
  static readonly Shapes: ShapeTokens = new ShapeTokens()
  static readonly Spacing: SpacingTokens = new SpacingTokens()
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
struct RetroFilterSearchPage {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  @State results: ResultItem[] = []
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  aboutToAppear(): void {
    const items: ResultItem[] = []
    for (let i: number = 0; i < 6; i++) {
      items.push(new ResultItem(i, 'Result ' + String(i + 1)))
    }
    this.results = items
    this.knobX = 160
    this.knobY = 120
  }

  private drawCanvas(): void {
    const ctx: CanvasRenderingContext2D = this.canvasCtx
    const w: number = this.canvasWidth
    const h: number = this.canvasHeight

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    const cx: number = w / 2
    const cy: number = h / 2
    const radius: number = 80
    const gradient: CanvasGradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, radius)
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
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Add')
        .width('100%')
        .height(40)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
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
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
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
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .margin({ right: AppTokens.Spacing.sm })
            .onClick(() => {})
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: AppTokens.Spacing.md })

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
              .onActionStart((event: GestureEvent) => {
                const finger: FingerInfo = event.fingerList[0]
                this.startKnobX = finger.localX
                this.startKnobY = finger.localY
              })
              .onActionUpdate((event: GestureEvent) => {
                const finger: FingerInfo = event.fingerList[0]
                this.knobX = finger.localX
                this.knobY = finger.localY
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
