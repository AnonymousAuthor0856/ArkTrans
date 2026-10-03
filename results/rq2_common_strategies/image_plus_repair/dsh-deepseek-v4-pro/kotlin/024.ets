class Point {
  x: number
  y: number
  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}

const COLOR_PRIMARY = '#EF476F'
const COLOR_SECONDARY = '#FFD166'
const COLOR_TERTIARY = '#06D6A0'
const COLOR_BACKGROUND = '#FFFCF2'
const COLOR_SURFACE = '#FFFFFF'
const COLOR_ON_PRIMARY = '#FFFFFF'
const COLOR_ON_SECONDARY = '#1E1E1E'
const COLOR_ON_TERTIARY = '#1E1E1E'
const COLOR_ON_SURFACE = '#1E1E1E'

const RADIUS_SMALL = 6
const SPACING_MD = 12
const SPACING_LG = 16

@Entry
@Component
struct WhiteboardPage {
  @State color: string = COLOR_PRIMARY
  private points: Point[] = []
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private redraw(): void {
    const ctx = this.context
    ctx.clearRect(0, 0, ctx.width, ctx.height)
    ctx.fillStyle = this.color
    for (let i = 0; i < this.points.length; i++) {
      const p = this.points[i]
      ctx.beginPath()
      ctx.arc(p.x, p.y, 10, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  private addPoint(x: number, y: number): void {
    this.points.push(new Point(x, y))
    this.redraw()
  }

  private changeColor(newColor: string): void {
    this.color = newColor
    this.redraw()
  }

  private clearPoints(): void {
    this.points = []
    this.redraw()
  }

  private handleTouch(event: TouchEvent): void {
    if (event.touches.length > 0) {
      const t = event.touches[0]
      this.addPoint(t.x, t.y)
    }
  }

  build() {
    Column() {
      Row() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_SURFACE)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      Stack() {
        Stack() {
          Canvas(this.context)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.redraw()
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(COLOR_BACKGROUND)
        .onTouch((event: TouchEvent) => {
          this.handleTouch(event)
        })

        Button('Clear')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(COLOR_SECONDARY)
          .fontColor(COLOR_ON_SECONDARY)
          .fontSize(12)
          .align(Alignment.BottomEnd)
          .margin({ right: SPACING_LG, bottom: SPACING_LG })
          .onClick(() => {
            this.clearPoints()
          })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Button('Red')
          .backgroundColor(COLOR_PRIMARY)
          .fontColor(COLOR_ON_PRIMARY)
          .borderRadius(RADIUS_SMALL)
          .onClick(() => {
            this.changeColor(COLOR_PRIMARY)
          })
        Button('Yellow')
          .backgroundColor(COLOR_SECONDARY)
          .fontColor(COLOR_ON_SECONDARY)
          .borderRadius(RADIUS_SMALL)
          .onClick(() => {
            this.changeColor(COLOR_SECONDARY)
          })
        Button('Green')
          .backgroundColor(COLOR_TERTIARY)
          .fontColor(COLOR_ON_TERTIARY)
          .borderRadius(RADIUS_SMALL)
          .onClick(() => {
            this.changeColor(COLOR_TERTIARY)
          })
      }
      .width('100%')
      .padding(SPACING_MD)
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(COLOR_SURFACE)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}
