interface MindNode {
  x: number
  y: number
}

class AppTokens {
  static Colors = class {
    static readonly primary: string = '#00FFFF'
    static readonly secondary: string = '#00FF88'
    static readonly tertiary: string = '#BB86FC'
    static readonly background: string = '#0D0D0D'
    static readonly surface: string = '#1C1C1C'
    static readonly surfaceVariant: string = '#2E2E2E'
    static readonly outline: string = '#3F3F3F'
    static readonly success: string = '#00FFAA'
    static readonly warning: string = '#FFC107'
    static readonly error: string = '#FF1744'
    static readonly onPrimary: string = '#000000'
    static readonly onSecondary: string = '#000000'
    static readonly onTertiary: string = '#000000'
    static readonly onBackground: string = '#FFFFFF'
    static readonly onSurface: string = '#FFFFFF'
  }

  static TypographyTokens = class {
    static readonly display: number = 28
    static readonly title: number = 18
    static readonly body: number = 14
    static readonly label: number = 12
  }

  static Spacing = class {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
  }

  static ElevationMapping = class {
    static readonly level1 = {
      elevation: 2,
      radius: 4,
      dy: 2,
      opacity: 0.12
    }

    static readonly level2 = {
      elevation: 6,
      radius: 8,
      dy: 4,
      opacity: 0.18
    }
  }
}

@Entry
@Component
struct MindMapApp {
  @State private nodes: MindNode[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]

  @State private currentColor: string = AppTokens.Colors.primary

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  private rgbaBlack(opacity: number): string {
    return `rgba(0, 0, 0, ${opacity})`
  }

  private drawMindMap(): void {
    if (this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }

    this.context.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    this.context.lineWidth = 6
    this.context.strokeStyle = this.currentColor
    this.context.fillStyle = this.currentColor
    this.context.lineCap = 'round'
    this.context.lineJoin = 'round'

    for (let i = 1; i < this.nodes.length; i++) {
      const start: MindNode = this.nodes[i - 1]
      const end: MindNode = this.nodes[i]

      this.context.beginPath()
      this.context.moveTo(start.x, start.y)
      this.context.lineTo(end.x, end.y)
      this.context.stroke()
    }

    for (let i = 0; i < this.nodes.length; i++) {
      const node: MindNode = this.nodes[i]

      this.context.beginPath()
      this.context.arc(node.x, node.y, 20, 0, Math.PI * 2)
      this.context.fill()
    }
  }

  private appendNode(x: number, y: number): void {
    this.nodes.push({ x, y })
    this.drawMindMap()
  }

  private changeColor(color: string): void {
    this.currentColor = color
    this.drawMindMap()
  }

  private appendRandomNode(): void {
    const randomX: number = 100 + Math.random() * 500
    const randomY: number = 200 + Math.random() * 600
    this.appendNode(randomX, randomY)
  }

  @Builder
  private ColorButton(title: string, backgroundColor: string, textColor: string) {
    Button({ type: ButtonType.Capsule, stateEffect: false }) {
      Text(title)
        .fontSize(AppTokens.TypographyTokens.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(textColor)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
    }
    .backgroundColor(backgroundColor)
    .borderRadius(15)
    .onClick(() => {
      this.changeColor(backgroundColor)
    })
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawMindMap()
        })
        .onAreaChange((oldArea: Area, newArea: Area) => {
          this.canvasWidth = Number(newArea.width)
          this.canvasHeight = Number(newArea.height)
          this.drawMindMap()
        })
        .gesture(
          PanGesture({ fingers: 1, distance: 0 })
            .onActionStart((event: GestureEvent) => {
              this.appendNode(event.offsetX, event.offsetY)
            })
            .onActionUpdate((event: GestureEvent) => {
              this.appendNode(event.offsetX, event.offsetY)
            })
        )

      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.TypographyTokens.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .padding({
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
          .width('100%')
          .backgroundColor(AppTokens.Colors.background)

        Blank()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)

      Column() {
        Blank()

        Row({ space: AppTokens.Spacing.md }) {
          this.ColorButton('Cyan', AppTokens.Colors.primary, AppTokens.Colors.onPrimary)
          this.ColorButton('Green', AppTokens.Colors.secondary, AppTokens.Colors.onSecondary)
          this.ColorButton('Purple', AppTokens.Colors.tertiary, AppTokens.Colors.onTertiary)
        }
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.radius,
          color: this.rgbaBlack(AppTokens.ElevationMapping.level1.opacity),
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)

      Column() {
        Blank()

        Row() {
          Blank()

          Button({ type: ButtonType.Circle, stateEffect: false }) {
            Text('+')
              .fontSize(AppTokens.TypographyTokens.title)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.secondary)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: this.rgbaBlack(AppTokens.ElevationMapping.level2.opacity),
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })
          .margin(AppTokens.Spacing.lg)
          .onClick(() => {
            this.appendRandomNode()
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}