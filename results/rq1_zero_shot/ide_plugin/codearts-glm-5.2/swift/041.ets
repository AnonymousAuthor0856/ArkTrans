class AppTokens {
  static readonly Colors = {
    primary: '#FF111111',
    secondary: '#FF333333',
    tertiary: '#FF777777',
    background: '#FFFFFFFF',
    surface: '#FFF9F9F9',
    surfaceVariant: '#FFE5E5E5',
    outline: '#FFCCCCCC',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111111',
    onBackground: '#FF111111',
    onSurface: '#FF111111',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }
  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
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

@Entry
@Component
struct RootScreen {
  @State markers: Marker[] = [
    new Marker(120, 200, 'Store A'),
    new Marker(360, 400, 'Store B'),
  ]
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w = 328
    const h = 240 - AppTokens.Spacing.lg * 2
    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)
    for (let i = 0; i < this.markers.length; i++) {
      const m = this.markers[i]
      ctx.fillStyle = AppTokens.Colors.primary
      ctx.beginPath()
      ctx.arc(m.x, m.y, 14, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Text('Product Detail')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .margin({ bottom: AppTokens.Spacing.lg })

        Column() {
          Column()
            .width('100%')
            .height(160)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)

          Text('Monochrome Bag')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.md })

          Text('A minimalist and timeless design piece.')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.tertiary)
            .margin({ top: AppTokens.Spacing.sm })

          Text('$79.00')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: AppTokens.Spacing.sm })

          Button('Add to Cart')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ top: AppTokens.Spacing.md })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
        .margin({ bottom: AppTokens.Spacing.lg })

        Stack() {
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
        .margin({ bottom: AppTokens.Spacing.lg })

        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Marker')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              const x = 100 + Math.floor(Math.random() * 401)
              const y = 150 + Math.floor(Math.random() * 301)
              this.markers.push(new Marker(x, y, 'New'))
              this.drawCanvas()
            })

          Button('Clear')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onTertiary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.markers = []
              this.drawCanvas()
            })
        }
        .width('100%')
      }
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}