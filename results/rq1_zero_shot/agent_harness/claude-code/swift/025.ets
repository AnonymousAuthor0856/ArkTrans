import prompt from '@ohos.promptAction'

class AppTokens {
  static Colors = class {
    static readonly primary: string = '#FF00FFFF'
    static readonly secondary: string = '#FF00FF88'
    static readonly tertiary: string = '#FFBB86FC'
    static readonly background: string = '#FF0D0D0D'
    static readonly surface: string = '#FF1C1C1C'
    static readonly surfaceVariant: string = '#FF2E2E2E'
    static readonly outline: string = '#FF3F3F3F'
    static readonly success: string = '#FF00FFAA'
    static readonly warning: string = '#FFFFC107'
    static readonly error: string = '#FFFF1744'
    static readonly onPrimary: string = '#FF000000'
    static readonly onSecondary: string = '#FF000000'
    static readonly onTertiary: string = '#FF000000'
    static readonly onBackground: string = '#FFFFFFFF'
    static readonly onSurface: string = '#FFFFFFFF'
  }

  static TypographyTokens = class {
    static readonly display: { size: number; weight: FontWeight } = { size: 28, weight: FontWeight.Bold }
    static readonly title: { size: number; weight: FontWeight } = { size: 18, weight: FontWeight.Medium }
    static readonly body: { size: number; weight: FontWeight } = { size: 14, weight: FontWeight.Normal }
    static readonly label: { size: number; weight: FontWeight } = { size: 12, weight: FontWeight.Medium }
  }

  static Spacing = class {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
  }

  static ShadowSpec = class {
    elevation: number = 0
    radius: number = 0
    dy: number = 0
    opacity: number = 0
    constructor(elevation: number, radius: number, dy: number, opacity: number) {
      this.elevation = elevation
      this.radius = radius
      this.dy = dy
      this.opacity = opacity
    }
  }

  static ElevationMapping = class {
    static readonly level1: AppTokens.ShadowSpec = new AppTokens.ShadowSpec(2, 4, 2, 0.12)
    static readonly level2: AppTokens.ShadowSpec = new AppTokens.ShadowSpec(6, 8, 4, 0.18)
  }
}

interface NodePoint {
  x: number
  y: number
}

@Entry
@Component
struct RootScreen {
  @State nodes: NodePoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State currentColor: string = AppTokens.Colors.primary

  private onTouch(event: TouchEvent): void {
    if (event.type === TouchType.Down || event.type === TouchType.Move) {
      const touch = event.touches[0]
      this.nodes.push({ x: touch.x, y: touch.y })
    }
  }

  private addRandomNode(): void {
    const randomX = 100 + Math.random() * 500
    const randomY = 200 + Math.random() * 600
    this.nodes.push({ x: randomX, y: randomY })
  }

  build() {
    Stack() {
      // Canvas for drawing nodes and lines
      Canvas(this.drawNodeCanvas.bind(this))
        .width('100%')
        .height('100%')
        .onTouch((event: TouchEvent) => this.onTouch(event))

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .backgroundColor(AppTokens.Colors.background)
        Spacer()
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Spacer()
        Row() {
          Button('Cyan')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(15)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary
            })

          Button('Green')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(15)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary
            })

          Button('Purple')
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(15)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary
            })
        }
        .justifyContent(FlexAlign.Center)
        .space(AppTokens.Spacing.md)
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Column() {
        Spacer()
        Row() {
          Spacer()
          Button('+')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(56)
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(28)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.dy
            })
            .onClick(() => {
              this.addRandomNode()
            })
            .margin(AppTokens.Spacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  private drawNodeCanvas(canvas: CanvasRenderingContext2D): void {
    // Draw connecting lines
    canvas.strokeStyle = this.currentColor
    canvas.lineWidth = 6
    canvas.beginPath()
    if (this.nodes.length > 0) {
      canvas.moveTo(this.nodes[0].x, this.nodes[0].y)
      for (let i = 1; i < this.nodes.length; i++) {
        canvas.lineTo(this.nodes[i].x, this.nodes[i].y)
      }
    }
    canvas.stroke()

    // Draw nodes
    canvas.fillStyle = this.currentColor
    for (const node of this.nodes) {
      canvas.beginPath()
      canvas.arc(node.x, node.y, 20, 0, Math.PI * 2)
      canvas.fill()
    }
  }
}
