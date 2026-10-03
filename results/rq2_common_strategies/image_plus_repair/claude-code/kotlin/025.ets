@Entry
@Component
struct NeonMindMap {
  @State nodes: Array<Point> = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  @State currentColor: string = AppTokens.Colors.primary
  @State selectedIndex: number = -1

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear(): void {
    this.drawMindMap()
  }

  aboutToUpdate(): void {
    this.drawMindMap()
  }

  drawMindMap(): void {
    const ctx = this.context
    ctx.clearRect(0, 0, 720, 1280)
    ctx.strokeStyle = this.currentColor
    ctx.lineWidth = 6
    ctx.lineCap = 'round'
    ctx.shadowColor = this.currentColor
    ctx.shadowBlur = 8

    ctx.beginPath()
    for (let i = 0; i < this.nodes.length; i++) {
      if (i === 0) {
        ctx.moveTo(this.nodes[i].x, this.nodes[i].y)
      } else {
        ctx.lineTo(this.nodes[i].x, this.nodes[i].y)
      }
    }
    ctx.stroke()

    ctx.shadowBlur = 12
    for (let i = 0; i < this.nodes.length; i++) {
      ctx.fillStyle = this.currentColor
      ctx.beginPath()
      ctx.arc(this.nodes[i].x, this.nodes[i].y, 20, 0, Math.PI * 2)
      ctx.fill()
    }
    ctx.shadowBlur = 0
  }

  build() {
    Stack() {
      Column() {
        Text('Neon Mind Map')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 48, bottom: 16 })

        Canvas(this.context)
          .width('100%')
          .layoutWeight(1)
          .onReady(() => {
            this.drawMindMap()
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              const x = event.touches[0].x
              const y = event.touches[0].y
              let hit = -1
              for (let i = 0; i < this.nodes.length; i++) {
                const dx = this.nodes[i].x - x
                const dy = this.nodes[i].y - y
                if (Math.sqrt(dx * dx + dy * dy) < 30) {
                  hit = i
                  break
                }
              }
              if (hit >= 0) {
                this.selectedIndex = hit
              } else {
                this.nodes.push({ x: x, y: y })
              }
            } else if (event.type === TouchType.Move && this.selectedIndex >= 0) {
              this.nodes[this.selectedIndex].x = event.touches[0].x
              this.nodes[this.selectedIndex].y = event.touches[0].y
            } else if (event.type === TouchType.Up) {
              this.selectedIndex = -1
            }
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Stack() {
        Text('+')
          .fontSize(48)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
      }
      .width(88)
      .height(88)
      .borderRadius(44)
      .backgroundColor(AppTokens.Colors.secondary)
      .shadow({
        radius: 12,
        color: AppTokens.Colors.secondary,
        offsetX: 0,
        offsetY: 4
      })
      .position({ x: 560, y: 920 })
      .onClick(() => {
        const newX = 100 + Math.random() * 500
        const newY = 200 + Math.random() * 600
        this.nodes.push({ x: newX, y: newY })
      })

      Row() {
        Button('Cyan')
          .fontSize(32)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(40)
          .height(72)
          .layoutWeight(1)
          .margin({ right: 12 })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary
          })

        Button('Green')
          .fontSize(32)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(40)
          .height(72)
          .layoutWeight(1)
          .margin({ right: 12 })
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary
          })

        Button('Purple')
          .fontSize(32)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(40)
          .height(72)
          .layoutWeight(1)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary
          })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 32 })
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

interface Point {
  x: number
  y: number
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#00FFFF'
    export const secondary: string = '#00FF88'
    export const tertiary: string = '#BB86FC'
    export const background: string = '#0D0D0D'
    export const surface: string = '#1C1C1C'
    export const surfaceVariant: string = '#2E2E2E'
    export const outline: string = '#3F3F3F'
    export const success: string = '#00FFAA'
    export const warning: string = '#FFC107'
    export const error: string = '#FF1744'
    export const onPrimary: string = '#000000'
    export const onSecondary: string = '#000000'
    export const onTertiary: string = '#000000'
    export const onBackground: string = '#FFFFFF'
    export const onSurface: string = '#FFFFFF'
  }
}
