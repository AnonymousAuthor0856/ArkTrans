const NAME = '055*ProductDetail*en'
const UI_TYPE = 'ECommerce'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#111111',
    secondary: '#333333',
    tertiary: '#777777',
    background: '#FFFFFF',
    surface: '#F9F9F9',
    surfaceVariant: '#E5E5E5',
    outline: '#CCCCCC',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111111',
    onBackground: '#111111',
    onSurface: '#111111',
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
    large: 14,
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.12 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.15 },
  }
}

interface Marker {
  x: number
  y: number
  label: string
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    { x: 120, y: 200, label: 'Store A' },
    { x: 360, y: 400, label: 'Store B' },
  ]
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  aboutToAppear() {
    this.drawCanvas()
  }

  drawCanvas() {
    const ctx = this.canvasContext
    const w = 320
    const h = 210
    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.primary
    for (const marker of this.markers) {
      ctx.beginPath()
      ctx.arc(marker.x, marker.y, 14, 0, 2 * Math.PI)
      ctx.fill()
    }
  }

  build() {
    Column() {
      Text('Product Detail')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Column() {
        Column()
          .width('100%')
          .height(160)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)

        Text('Monochrome Bag')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })

        Text('A minimalist and timeless design piece.')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.tertiary)

        Text('$79.00')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ top: AppTokens.Spacing.sm })

        Button('Add to Cart')
          .type(ButtonType.Normal)
          .width('100%')
          .height(48)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .margin({ top: AppTokens.Spacing.md })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
      .margin({ top: AppTokens.Spacing.lg })

      Column() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas()
          })
      }
      .width('100%')
      .height(240)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .margin({ top: AppTokens.Spacing.lg })

      Row() {
        Button('Add Marker')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(44)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .onClick(() => {
            const newX = Math.floor(Math.random() * 400) + 100
            const newY = Math.floor(Math.random() * 300) + 150
            this.markers.push({ x: newX, y: newY, label: 'New' })
            this.drawCanvas()
          })

        Button('Clear')
          .type(ButtonType.Normal)
          .layoutWeight(1)
          .height(44)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .margin({ left: AppTokens.Spacing.md })
          .onClick(() => {
            this.markers = []
            this.drawCanvas()
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}