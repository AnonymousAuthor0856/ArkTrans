class AppTokens {
  static readonly Colors = {
    primary: '#FFFF8C00',
    secondary: '#FFFFC107',
    tertiary: '#FFFFE082',
    background: '#FFFFF8E1',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFFECB3',
    outline: '#FFD7CCC8',
    success: '#FF4CAF50',
    warning: '#FFFFB300',
    error: '#FFE53935',
    onPrimary: '#FF3E2723',
    onSecondary: '#FF3E2723',
    onBackground: '#FF3E2723',
    onSurface: '#FF3E2723',
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
    large: 16,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
  }
}

class Pin {
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
  @State pins: Pin[] = [
    new Pin(80, 60, 'Group A'),
    new Pin(180, 120, 'Group B'),
    new Pin(260, 80, 'Group C'),
  ]
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w = 296
    const h = 204
    ctx.clearRect(0, 0, w, h)
    for (let i = 0; i < this.pins.length; i++) {
      const p = this.pins[i]
      ctx.fillStyle = AppTokens.Colors.primary
      ctx.beginPath()
      ctx.arc(p.x, p.y, 14, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  build() {
    Stack() {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')

        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Deals Map')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Stack() {
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
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 6, color: '#263E2723', offsetY: 4 })

        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              const x = 100 + Math.floor(Math.random() * 450)
              const y = 150 + Math.floor(Math.random() * 300)
              this.pins.push(new Pin(x, y, 'New'))
              this.drawCanvas()
            })

          Button('Clear')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.pins = []
              this.drawCanvas()
            })
        }
        .width('100%')

        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1)

              Circle({ width: 14, height: 14 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
          })
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 2, color: '#1A3E2723', offsetY: 2 })
      }
      .padding(AppTokens.Spacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}