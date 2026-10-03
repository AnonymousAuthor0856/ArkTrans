const NAME = '061*GroupBuy*en'
const UI_TYPE = 'ECommerce'
const STYLE_THEME = 'Retro Flat'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#FF8C00',
    secondary: '#FFC107',
    tertiary: '#FFE082',
    background: '#FFF8E1',
    surface: '#FFFFFF',
    surfaceVariant: '#FFECB3',
    outline: '#D7CCC8',
    success: '#4CAF50',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#3E2723',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  }

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 },
  }
}

interface Pin {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    { x: 150, y: 130, label: 'Group A' },
    { x: 350, y: 200, label: 'Group B' },
    { x: 520, y: 160, label: 'Group C' },
  ]
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 200
    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.primary
    for (const pin of this.pins) {
      ctx.beginPath()
      ctx.arc(pin.x, pin.y, 14, 0, 2 * Math.PI)
      ctx.fill()
    }
  }

  build() {
    Column() {
      Text('Retro Group Buy')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Column() {
        Text('Live Deals Map')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(220)
        .padding(8)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
      .margin({ top: AppTokens.Spacing.lg })

      Row() {
        Button('Add Group')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .onClick(() => {
            const newX = Math.floor(Math.random() * 450) + 100
            const newY = Math.floor(Math.random() * 300) + 150
            this.pins.push({ x: newX, y: newY, label: 'New' })
            this.drawCanvas()
          })

        Button('Clear')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            this.pins = []
            this.drawCanvas()
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.lg })

      Column() {
        Text('Active Groups')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)

        ForEach(this.pins, (pin: Pin, index: number) => {
          Row() {
            Text(pin.label)
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            Column()
              .width(14)
              .height(14)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(7)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: AppTokens.Spacing.sm })
        }, (pin: Pin, index: number) => index.toString())
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
      .margin({ top: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}
