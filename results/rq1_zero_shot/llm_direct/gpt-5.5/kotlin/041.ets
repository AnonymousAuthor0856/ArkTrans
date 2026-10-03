const NAME: string = '055*ProductDetail*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

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
    onSurface: '#111111'
  }

  static TypographyTokens = {
    display: {
      fontSize: 28,
      fontWeight: FontWeight.Bold
    },
    title: {
      fontSize: 18,
      fontWeight: FontWeight.Medium
    },
    body: {
      fontSize: 14,
      fontWeight: FontWeight.Normal
    },
    label: {
      fontSize: 12,
      fontWeight: FontWeight.Medium
    }
  }

  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static ElevationMapping = {
    level1: new ShadowSpec(2, 4, 2, 0.1),
    level2: new ShadowSpec(4, 8, 4, 0.12),
    level3: new ShadowSpec(8, 12, 6, 0.15)
  }
}

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B')
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMap(): void {
    this.canvasContext.clearRect(0, 0, 1000, 1000)
    this.canvasContext.fillStyle = AppTokens.Colors.surfaceVariant
    this.canvasContext.fillRect(0, 0, 1000, 1000)

    this.markers.forEach((marker: Marker) => {
      this.canvasContext.beginPath()
      this.canvasContext.fillStyle = AppTokens.Colors.primary
      this.canvasContext.arc(marker.x, marker.y, 14, 0, Math.PI * 2)
      this.canvasContext.fill()
    })
  }

  @Builder
  ProductCard() {
    Column({ space: AppTokens.Spacing.md }) {
      Blank()
        .width('100%')
        .height(160)
        .backgroundColor(AppTokens.Colors.surfaceVariant)

      Text('Monochrome Bag')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Text('A minimalist and timeless design piece.')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.tertiary)

      Text('$79.00')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.primary)

      Button('Add to Cart')
        .width('100%')
        .height(48)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Product Detail')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')

      this.ProductCard()

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawMap()
          })
      }
      .width('100%')
      .height(240)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)

      Row() {
        Button('Add Marker')
          .height(44)
          .layoutWeight(1)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            const marker = new Marker(
              Math.floor(Math.random() * 400) + 100,
              Math.floor(Math.random() * 300) + 150,
              'New'
            )
            this.markers = [...this.markers, marker]
            setTimeout(() => {
              this.drawMap()
            }, 0)
          })

        Blank()
          .width(AppTokens.Spacing.md)

        Button('Clear')
          .height(44)
          .layoutWeight(1)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
            this.markers = []
            setTimeout(() => {
              this.drawMap()
            }, 0)
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
  }
}