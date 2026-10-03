import { Color, FontSize, FontWeight, PixelMap, Point, Rect, RenderContext, StrokeCap, TextAlign, TextOverflow } from '@kit.ArkGraphics'
import { BusinessError } from '@kit.BasicServicesKit'
import { common, UIAbility, Want } from '@kit.AbilityKit'
import { window } from '@kit.ArkUI'

// --- Constants & Tokens ---
const NAME = "026MindMapen"
const UI_TYPE = "Productivity"
const STYLE_THEME = "Dark Neon"
const LANG = "en"
const BASELINE_SIZE = "720x1280"

interface ColorToken {
  value: Color
}

interface TypographyToken {
  fontSize: number
  fontWeight: FontWeight
}

class AppTokens {
  static Colors: Record<string, Color> = {
    primary: new Color(0x00FFFF),
    secondary: new Color(0x00FF88),
    tertiary: new Color(0xBB86FC),
    background: new Color(0x0D0D0D),
    surface: new Color(0x1C1C1C),
    surfaceVariant: new Color(0x2E2E2E),
    outline: new Color(0x3F3F3F),
    success: new Color(0x00FFAA),
    warning: new Color(0xFFC107),
    error: new Color(0xFF1744),
    onPrimary: new Color(0x000000),
    onSecondary: new Color(0x000000),
    onTertiary: new Color(0x000000),
    onBackground: new Color(0xFFFFFFFF),
    onSurface: new Color(0xFFFFFFFF)
  }

  static TypographyTokens: Record<string, TypographyToken> = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

// --- Main Ability Entry ---
@Entry
@Component
struct RootScreen {
  @State nodes: Point[] = [new Point(200, 400), new Point(500, 700), new Point(350, 250)]
  @State currentColor: Color = AppTokens.Colors.primary
  private renderContext?: RenderContext

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Neon Mind Map")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .textAlign(TextAlign.Center)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      // Canvas Area
      Stack() {
        Canvas(this.getContext())
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.background)
          .onReady((event: CanvasRenderingContext2DEvent) => {
            this.renderContext = event.renderContext
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                if (this.renderContext) {
                  const x = event.offsetX
                  const y = event.offsetY
                  this.nodes.push(new Point(x, y))
                  this.drawCanvas()
                }
              })
          )
        
        // Floating Action Button
        Button("+", { type: ButtonType.Circle })
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .position({ x: '90%', y: '85%' })
          .onClick(() => {
            const randomX = Math.random() * 500 + 100
            const randomY = Math.random() * 600 + 200
            this.nodes.push(new Point(randomX, randomY))
            this.drawCanvas()
          })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Row() {
        Button("Cyan")
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .margin({ right: AppTokens.Spacing.sm })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary
            this.drawCanvas()
          })

        Button("Green")
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .margin({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary
            this.drawCanvas()
          })

        Button("Purple")
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .margin({ left: AppTokens.Spacing.sm })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary
            this.drawCanvas()
          })
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .padding(AppTokens.Spacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .onAppear(() => {
      this.drawCanvas()
    })
  }

  drawCanvas() {
    if (!this.renderContext) return
    
    const ctx = this.renderContext
    ctx.clearRect(0, 0, 10000, 10000) // Clear canvas
    
    // Draw Lines
    for (let i = 1; i < this.nodes.length; i++) {
      ctx.beginPath()
      ctx.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y)
      ctx.lineTo(this.nodes[i].x, this.nodes[i].y)
      ctx.strokeStyle = this.currentColor.toString()
      ctx.lineWidth = 6
      ctx.lineCap = StrokeCap.Round
      ctx.stroke()
    }

    // Draw Nodes
    this.nodes.forEach(node => {
      ctx.beginPath()
      ctx.arc(node.x, node.y, 20, 0, 2 * Math.PI)
      ctx.fillStyle = this.currentColor.toString()
      ctx.fill()
    })
  }
}