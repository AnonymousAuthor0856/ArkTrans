class MindNode {
  x: number
  y: number
  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}

const PRIMARY = '#00FFFF'
const SECONDARY = '#00FF88'
const TERTIARY = '#BB86FC'
const BACKGROUND = '#0D0D0D'
const SURFACE_VARIANT = '#2E2E2E'
const ON_PRIMARY = '#000000'
const ON_SECONDARY = '#000000'
const ON_TERTIARY = '#000000'

@Entry
@Component
struct NeonMindMap {
  @State currentColor: string = PRIMARY
  @State nodes: MindNode[] = [new MindNode(200, 400), new MindNode(500, 700), new MindNode(350, 250)]
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  addNode(x: number, y: number) {
    this.nodes = this.nodes.concat([new MindNode(x, y)])
    this.redraw()
  }

  redraw() {
    const w = this.context.width
    const h = this.context.height
    this.context.clearRect(0, 0, w, h)
    this.context.strokeStyle = this.currentColor
    this.context.lineWidth = 6
    for (let i = 1; i < this.nodes.length; i++) {
      this.context.beginPath()
      this.context.moveTo(this.nodes[i - 1].x, this.nodes[i - 1].y)
      this.context.lineTo(this.nodes[i].x, this.nodes[i].y)
      this.context.stroke()
    }
    this.context.fillStyle = this.currentColor
    for (let i = 0; i < this.nodes.length; i++) {
      this.context.beginPath()
      this.context.arc(this.nodes[i].x, this.nodes[i].y, 20, 0, Math.PI * 2)
      this.context.fill()
    }
  }

  build() {
    Column() {
      Stack() {
        Text('Neon Mind Map')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
      }
      .width('100%')
      .height(64)
      .backgroundColor(BACKGROUND)

      Stack({ alignContent: Alignment.BottomEnd }) {
        Canvas(this.context)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.redraw()
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                const t = event.touches[0]
                this.addNode(t.x, t.y)
              }
            }
          })

        Button('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(SECONDARY)
          .fontColor(ON_SECONDARY)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .margin(16)
          .onClick(() => {
            const rx = 100 + Math.floor(Math.random() * 501)
            const ry = 200 + Math.floor(Math.random() * 601)
            this.addNode(rx, ry)
          })
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        Button('Cyan')
          .backgroundColor(PRIMARY)
          .fontColor(ON_PRIMARY)
          .fontSize(14)
          .borderRadius(20)
          .onClick(() => {
            this.currentColor = PRIMARY
            this.redraw()
          })
        Button('Green')
          .backgroundColor(SECONDARY)
          .fontColor(ON_SECONDARY)
          .fontSize(14)
          .borderRadius(20)
          .onClick(() => {
            this.currentColor = SECONDARY
            this.redraw()
          })
        Button('Purple')
          .backgroundColor(TERTIARY)
          .fontColor(ON_TERTIARY)
          .fontSize(14)
          .borderRadius(20)
          .onClick(() => {
            this.currentColor = TERTIARY
            this.redraw()
          })
      }
      .width('100%')
      .padding(12)
      .justifyContent(FlexAlign.SpaceEvenly)
      .backgroundColor(SURFACE_VARIANT)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
