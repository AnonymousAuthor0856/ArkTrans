import hilog from '@ohos.hilog';
import promptAction from '@ohos.promptAction';

// MARK: - AppTokens
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

  static Spacing = class {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
  }
}

// MARK: - Mind Node model
interface MindNode {
  x: number
  y: number
}

// MARK: - RootScreen Component
@Entry
@Component
struct MindMapPage {
  @State nodes: MindNode[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State currentColor: string = AppTokens.Colors.primary
  private nodeRadius: number = 20
  private strokeWidth: number = 6

  build() {
    Stack() {
      // Background
      Rect()
        .fill(AppTokens.Colors.background)
        .width('100%')
        .height('100%')

      // Canvas for drawing nodes and connections
      Canvas(this.getCanvasSettings())
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawMindMap()
        })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down || event.type === TouchType.Move) {
            const touch = event.touches[0]
            this.nodes.push({ x: touch.x, y: touch.y })
          }
        })

      // Top Bar
      Column() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        Blank()
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      Column() {
        Blank()

        Row({ space: AppTokens.Spacing.md }) {
          // Cyan button
          Button('Cyan')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(15)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.primary
            })

          // Green button
          Button('Green')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(15)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.secondary
            })

          // Purple button
          Button('Purple')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppTokens.Colors.onTertiary)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(15)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
              top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
            .onClick(() => {
              this.currentColor = AppTokens.Colors.tertiary
            })
        }
        .padding(AppTokens.Spacing.md)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.12)',
          offsetX: 0,
          offsetY: 2
        })
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Column() {
        Blank()

        Row() {
          Blank()

          Button('+')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .width(56)
            .height(56)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(28)
            .shadow({
              radius: 8,
              color: 'rgba(0, 0, 0, 0.18)',
              offsetX: 0,
              offsetY: 4
            })
            .margin(AppTokens.Spacing.lg)
            .onClick(() => {
              const randomX = 100 + Math.random() * 500
              const randomY = 200 + Math.random() * 600
              this.nodes.push({ x: randomX, y: randomY })
            })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .onUpdate(() => {
      this.drawMindMap()
    })
  }

  private settings: CanvasRenderingContext2D | null = null

  getCanvasSettings(): CanvasRenderingContext2D {
    if (!this.settings) {
      this.settings = new CanvasRenderingContext2D()
    }
    return this.settings!
  }

  drawMindMap() {
    const ctx = this.settings
    if (!ctx) {
      return
    }

    ctx.clearRect(0, 0, 1000, 2000)

    // Draw connecting lines
    ctx.strokeStyle = this.currentColor
    ctx.lineWidth = this.strokeWidth
    ctx.lineCap = 'round'

    for (let i = 1; i < this.nodes.length; i++) {
      const start = this.nodes[i - 1]
      const end = this.nodes[i]
      ctx.beginPath()
      ctx.moveTo(start.x, start.y)
      ctx.lineTo(end.x, end.y)
      ctx.stroke()
    }

    // Draw nodes
    ctx.fillStyle = this.currentColor
    for (const node of this.nodes) {
      ctx.beginPath()
      ctx.arc(node.x, node.y, this.nodeRadius, 0, Math.PI * 2)
      ctx.fill()
    }
  }
}
