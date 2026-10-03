class AppTokens {
  static readonly Colors = {
    primary: '#FFEF476F',
    secondary: '#FFFFD166',
    tertiary: '#FF06D6A0',
    background: '#FFFFFCF2',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF7EDE2',
    outline: '#FFE5D4B1',
    success: '#FF06D6A0',
    warning: '#FFFFA600',
    error: '#FFD62828',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 16
  }
}

class DrawPoint {
  x: number
  y: number

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}

@Entry
@Component
struct RetroWhiteboard {
  @State points: DrawPoint[] = []
  @State currentColor: string = AppTokens.Colors.primary

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  private circleRadius: number = 10

  private drawCanvas() {
    const ctx = this.canvasContext
    ctx.clearRect(0, 0, 1080, 1920)
    for (let i = 0; i < this.points.length; i++) {
      const point = this.points[i]
      ctx.beginPath()
      ctx.arc(point.x, point.y, this.circleRadius, 0, Math.PI * 2)
      ctx.fillStyle = this.currentColor
      ctx.fill()
    }
  }

  build() {
    Stack() {
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawCanvas()
        })
        .gesture(
          PanGesture({ distance: 0 })
            .onActionUpdate((event: GestureEvent) => {
              const x = event.fingerList[0].localX
              const y = event.fingerList[0].localY
              this.points.push(new DrawPoint(x, y))
              this.drawCanvas()
            })
        )

      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .padding({ top: 12, bottom: 12 })
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)
        Blank()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Blank()
        Row() {
          Button('Red') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .layoutWeight(1)
          .height(44)
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.primary)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary
            this.drawCanvas()
          })

          Button('Yellow') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSecondary)
          .layoutWeight(1)
          .height(44)
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ left: 12 })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary
            this.drawCanvas()
          })

          Button('Green') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onTertiary)
          .layoutWeight(1)
          .height(44)
          .borderRadius(6)
          .backgroundColor(AppTokens.Colors.tertiary)
          .margin({ left: 12 })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary
            this.drawCanvas()
          })
        }
        .width('100%')
        .padding(12)
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Blank()
        Row() {
          Blank()
          Button('Clear') {
          }
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.secondary)
          .onClick(() => {
            this.points = []
            this.drawCanvas()
          })
        }
        .width('100%')
        .padding({ right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}