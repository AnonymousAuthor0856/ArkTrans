class AppTokens {
  static readonly Colors = {
    primary: '#FF00FFFF',
    secondary: '#FF00FF88',
    tertiary: '#FFBB86FC',
    background: '#FF0D0D0D',
    surface: '#FF1C1C1C',
    surfaceVariant: '#FF2E2E2E',
    outline: '#FF3F3F3F',
    success: '#FF00FFAA',
    warning: '#FFFFC107',
    error: '#FFFF1744',
    onPrimary: '#FF000000',
    onSecondary: '#FF000000',
    onTertiary: '#FF000000',
    onBackground: '#FFFFFFFF',
    onSurface: '#FFFFFFFF'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

class MapNode {
  x: number
  y: number

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}

@Entry
@Component
struct NeonMindMap {
  @State nodes: MapNode[] = [
    new MapNode(200, 400),
    new MapNode(500, 700),
    new MapNode(350, 250)
  ]
  @State currentColor: string = AppTokens.Colors.primary

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    ctx.clearRect(0, 0, 1080, 1920)

    ctx.strokeStyle = this.currentColor
    ctx.lineWidth = 6
    for (let i = 1; i < this.nodes.length; i++) {
      const start = this.nodes[i - 1]
      const end = this.nodes[i]
      ctx.beginPath()
      ctx.moveTo(start.x, start.y)
      ctx.lineTo(end.x, end.y)
      ctx.stroke()
    }

    ctx.fillStyle = this.currentColor
    for (let i = 0; i < this.nodes.length; i++) {
      const node = this.nodes[i]
      ctx.beginPath()
      ctx.arc(node.x, node.y, 20, 0, Math.PI * 2)
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
              this.nodes.push(new MapNode(x, y))
              this.drawCanvas()
            })
        )

      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
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
          Button('Cyan') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(15)
          .backgroundColor(AppTokens.Colors.primary)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary
            this.drawCanvas()
          })

          Button('Green') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSecondary)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(15)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ left: 12 })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary
            this.drawCanvas()
          })

          Button('Purple') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .borderRadius(15)
          .backgroundColor(AppTokens.Colors.tertiary)
          .margin({ left: 12 })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary
            this.drawCanvas()
          })
        }
        .width('100%')
        .padding(12)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      Column() {
        Blank()
        Row() {
          Blank()
          Button('+') {
          }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(AppTokens.Colors.secondary)
          .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
          .onClick(() => {
            const randomX = 100 + Math.random() * 500
            const randomY = 200 + Math.random() * 600
            this.nodes.push(new MapNode(randomX, randomY))
            this.drawCanvas()
          })
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}