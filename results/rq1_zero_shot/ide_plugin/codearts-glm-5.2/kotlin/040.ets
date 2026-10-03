const NAME = 'RetroFilterSearch'
const UI_TYPE = 'Social'
const STYLE_THEME = 'Warm Retro'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#FF7B00',
    secondary: '#FFD166',
    background: '#FFF6E5',
    surface: '#FFFFFF',
    surfaceVariant: '#FFF0C1',
    outline: '#E0C080',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
  }

  static ElevationMapping = {
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.12 },
  }
}

interface ResultItem {
  id: number
  title: string
}

@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' },
  ]
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 150
    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    const cx = w / 2
    const cy = h / 2
    const grad = ctx.createRadialGradient(cx, cy, 0, cx, cy, 80)
    grad.addColorStop(0, AppTokens.Colors.secondary)
    grad.addColorStop(1, AppTokens.Colors.primary)
    ctx.fillStyle = grad
    ctx.beginPath()
    ctx.arc(cx, cy, 80, 0, 2 * Math.PI)
    ctx.fill()

    ctx.fillStyle = AppTokens.Colors.primary
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, 2 * Math.PI)
    ctx.fill()
  }

  build() {
    Column() {
      Text('Retro Filter Search')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      TextInput({ text: this.query, placeholder: 'Search products' })
        .width('100%')
        .height(48)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .backgroundColor(AppTokens.Colors.surface)
        .fontColor(AppTokens.Colors.onSurface)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .placeholderColor('#663E2723')
        .margin({ top: AppTokens.Spacing.md })
        .onChange((value: string) => {
          this.query = value
        })

      Scroll() {
        Row() {
          ForEach(this.filters, (filter: string) => {
            Button(filter)
              .type(ButtonType.Normal)
              .height(36)
              .borderRadius(AppTokens.Shapes.small)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .margin({ right: AppTokens.Spacing.sm })
          }, (filter: string) => filter)
        }
        .height(36)
      }
      .scrollDirection(ScrollDirection.Horizontal)
      .width('100%')
      .margin({ top: AppTokens.Spacing.md })

      Column() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas()
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = event.fingerList[0].localX
                this.knobY = event.fingerList[0].localY
                this.drawCanvas()
              })
          )
      }
      .width('100%')
      .height(180)
      .padding(16)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .margin({ top: AppTokens.Spacing.md })

      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            ResultCard({ item: item })
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .width('100%')
      .layoutWeight(1)
      .columnsGap(AppTokens.Spacing.lg)
      .rowsGap(AppTokens.Spacing.lg)
      .padding({ bottom: 24 })
      .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct ResultCard {
  private item: ResultItem = { id: 0, title: '' }

  build() {
    Column() {
      Column()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      Button('Add')
        .type(ButtonType.Normal)
        .width('100%')
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(AppTokens.TypographyTokens.label.fontSize)
        .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .alignItems(HorizontalAlign.Center)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}