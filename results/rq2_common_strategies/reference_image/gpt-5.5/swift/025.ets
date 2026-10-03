interface MindPoint {
  x: number
  y: number
}

class AppTokens {
  static readonly COLOR_PRIMARY: string = '#00FFFF'
  static readonly COLOR_SECONDARY: string = '#00FF88'
  static readonly COLOR_TERTIARY: string = '#BB86FC'
  static readonly COLOR_BACKGROUND: string = '#0D0D0D'
  static readonly COLOR_SURFACE: string = '#1C1C1C'
  static readonly COLOR_SURFACE_VARIANT: string = '#2E2E2E'
  static readonly COLOR_OUTLINE: string = '#3F3F3F'
  static readonly COLOR_SUCCESS: string = '#00FFAA'
  static readonly COLOR_WARNING: string = '#FFC107'
  static readonly COLOR_ERROR: string = '#FF1744'
  static readonly COLOR_ON_PRIMARY: string = '#000000'
  static readonly COLOR_ON_SECONDARY: string = '#000000'
  static readonly COLOR_ON_TERTIARY: string = '#000000'
  static readonly COLOR_ON_BACKGROUND: string = '#FFFFFF'
  static readonly COLOR_ON_SURFACE: string = '#FFFFFF'

  static readonly FONT_DISPLAY: number = 28
  static readonly FONT_TITLE: number = 18
  static readonly FONT_BODY: number = 14
  static readonly FONT_LABEL: number = 12

  static readonly SPACING_SM: number = 8
  static readonly SPACING_MD: number = 12
  static readonly SPACING_LG: number = 16
  static readonly SPACING_XL: number = 24

  static readonly ELEVATION_LEVEL1_RADIUS: number = 4
  static readonly ELEVATION_LEVEL1_DY: number = 2
  static readonly ELEVATION_LEVEL1_OPACITY_COLOR: string = 'rgba(0, 0, 0, 0.12)'

  static readonly ELEVATION_LEVEL2_RADIUS: number = 8
  static readonly ELEVATION_LEVEL2_DY: number = 4
  static readonly ELEVATION_LEVEL2_OPACITY_COLOR: string = 'rgba(0, 0, 0, 0.18)'
}

@Entry
@Component
struct RootScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private nodes: MindPoint[] = [
    { x: 200, y: 400 },
    { x: 500, y: 700 },
    { x: 350, y: 250 }
  ]
  private currentColor: string = AppTokens.COLOR_PRIMARY
  private canvasReady: boolean = false

  private drawMindMap(): void {
    if (!this.canvasReady) {
      return
    }

    this.context.clearRect(0, 0, 10000, 10000)

    this.context.lineWidth = 6
    this.context.strokeStyle = this.currentColor
    this.context.fillStyle = this.currentColor

    for (let i = 1; i < this.nodes.length; i++) {
      const start: MindPoint = this.nodes[i - 1]
      const end: MindPoint = this.nodes[i]

      this.context.beginPath()
      this.context.moveTo(start.x, start.y)
      this.context.lineTo(end.x, end.y)
      this.context.stroke()
    }

    for (let i = 0; i < this.nodes.length; i++) {
      const node: MindPoint = this.nodes[i]

      this.context.beginPath()
      this.context.arc(node.x, node.y, 20, 0, Math.PI * 2)
      this.context.fill()
    }
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.canvasReady = true
          this.drawMindMap()
        })
        .onAreaChange(() => {
          this.drawMindMap()
        })
        .onTouch((event: TouchEvent) => {
          if ((event.type === TouchType.Down || event.type === TouchType.Move) && event.touches.length > 0) {
            this.nodes.push({
              x: event.touches[0].x,
              y: event.touches[0].y
            })
            this.drawMindMap()
          }
        })

      Column() {
        Text('Neon Mind Map')
          .fontSize(AppTokens.FONT_DISPLAY)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.COLOR_PRIMARY)
          .padding({
            top: AppTokens.SPACING_LG,
            bottom: AppTokens.SPACING_LG
          })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.COLOR_BACKGROUND)

        Blank()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()

        Row() {
          Row() {
            Text('Cyan')
              .fontSize(AppTokens.FONT_BODY)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.COLOR_ON_PRIMARY)
          }
          .padding({
            left: AppTokens.SPACING_LG,
            right: AppTokens.SPACING_LG,
            top: AppTokens.SPACING_SM,
            bottom: AppTokens.SPACING_SM
          })
          .backgroundColor(AppTokens.COLOR_PRIMARY)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppTokens.COLOR_PRIMARY
            this.drawMindMap()
          })

          Row() {
            Text('Green')
              .fontSize(AppTokens.FONT_BODY)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.COLOR_ON_SECONDARY)
          }
          .padding({
            left: AppTokens.SPACING_LG,
            right: AppTokens.SPACING_LG,
            top: AppTokens.SPACING_SM,
            bottom: AppTokens.SPACING_SM
          })
          .backgroundColor(AppTokens.COLOR_SECONDARY)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppTokens.COLOR_SECONDARY
            this.drawMindMap()
          })

          Row() {
            Text('Purple')
              .fontSize(AppTokens.FONT_BODY)
              .fontWeight(FontWeight.Regular)
              .fontColor(AppTokens.COLOR_ON_TERTIARY)
          }
          .padding({
            left: AppTokens.SPACING_LG,
            right: AppTokens.SPACING_LG,
            top: AppTokens.SPACING_SM,
            bottom: AppTokens.SPACING_SM
          })
          .backgroundColor(AppTokens.COLOR_TERTIARY)
          .borderRadius(15)
          .onClick(() => {
            this.currentColor = AppTokens.COLOR_TERTIARY
            this.drawMindMap()
          })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding(AppTokens.SPACING_MD)
        .backgroundColor(AppTokens.COLOR_SURFACE_VARIANT)
        .shadow({
          radius: AppTokens.ELEVATION_LEVEL1_RADIUS,
          color: AppTokens.ELEVATION_LEVEL1_OPACITY_COLOR,
          offsetX: 0,
          offsetY: AppTokens.ELEVATION_LEVEL1_DY
        })
        .gap(AppTokens.SPACING_MD)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()

        Row() {
          Blank()

          Stack() {
            Text('+')
              .fontSize(AppTokens.FONT_TITLE)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.COLOR_ON_SECONDARY)
          }
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.COLOR_SECONDARY)
          .borderRadius(28)
          .shadow({
            radius: AppTokens.ELEVATION_LEVEL2_RADIUS,
            color: AppTokens.ELEVATION_LEVEL2_OPACITY_COLOR,
            offsetX: 0,
            offsetY: AppTokens.ELEVATION_LEVEL2_DY
          })
          .margin(AppTokens.SPACING_LG)
          .onClick(() => {
            const randomX: number = Math.random() * 500 + 100
            const randomY: number = Math.random() * 600 + 200
            this.nodes.push({ x: randomX, y: randomY })
            this.drawMindMap()
          })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.COLOR_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}