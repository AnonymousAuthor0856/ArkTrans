class BoardPoint {
  x: number = 0
  y: number = 0

  constructor(x: number, y: number) {
    this.x = x
    this.y = y
  }
}

const PRIMARY_COLOR: string = '#EF476F'
const SECONDARY_COLOR: string = '#FFD166'
const TERTIARY_COLOR: string = '#06D6A0'
const BACKGROUND_COLOR: string = '#FFFCF2'
const SURFACE_COLOR: string = '#FFFFFF'
const ON_PRIMARY_COLOR: string = '#FFFFFF'
const ON_SECONDARY_COLOR: string = '#1E1E1E'
const ON_TERTIARY_COLOR: string = '#1E1E1E'
const ON_SURFACE_COLOR: string = '#1E1E1E'

@Entry
@Component
struct Index {
  @State private points: BoardPoint[] = []
  @State private currentColor: string = PRIMARY_COLOR

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawBoard(): void {
    this.canvasContext.clearRect(0, 0, 10000, 10000)
    this.canvasContext.fillStyle = this.currentColor

    for (let i = 0; i < this.points.length; i++) {
      this.canvasContext.beginPath()
      this.canvasContext.arc(this.points[i].x, this.points[i].y, 10, 0, Math.PI * 2)
      this.canvasContext.fill()
    }
  }

  private addPoint(x: number, y: number): void {
    const nextPoints: BoardPoint[] = this.points.slice()
    nextPoints.push(new BoardPoint(x, y))
    this.points = nextPoints
    this.drawBoard()
  }

  private clearBoard(): void {
    this.points = []
    this.drawBoard()
  }

  private selectColor(color: string): void {
    this.currentColor = color
    this.drawBoard()
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Retro Whiteboard')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE_COLOR)
        }
        .width('100%')
        .height(128)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(BACKGROUND_COLOR)

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .backgroundColor(BACKGROUND_COLOR)
            .onReady(() => {
              this.drawBoard()
            })
            .onTouch((event: TouchEvent) => {
              if ((event.type === TouchType.Down || event.type === TouchType.Move) &&
                event.touches.length > 0) {
                this.addPoint(event.touches[0].x, event.touches[0].y)
              }
            })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(BACKGROUND_COLOR)

        Row() {
          Button('Red')
            .width(148)
            .height(80)
            .borderRadius(10)
            .backgroundColor(PRIMARY_COLOR)
            .fontColor(ON_PRIMARY_COLOR)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.selectColor(PRIMARY_COLOR)
            })

          Button('Yellow')
            .width(180)
            .height(80)
            .borderRadius(10)
            .backgroundColor(SECONDARY_COLOR)
            .fontColor(ON_SECONDARY_COLOR)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.selectColor(SECONDARY_COLOR)
            })

          Button('Green')
            .width(172)
            .height(80)
            .borderRadius(10)
            .backgroundColor(TERTIARY_COLOR)
            .fontColor(ON_TERTIARY_COLOR)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.selectColor(TERTIARY_COLOR)
            })
        }
        .width('100%')
        .height(144)
        .padding({ left: 12, right: 12, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(SURFACE_COLOR)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND_COLOR)

      Button('Clear')
        .width(112)
        .height(112)
        .borderRadius(56)
        .backgroundColor(SECONDARY_COLOR)
        .fontColor(ON_SECONDARY_COLOR)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .shadow({
          radius: 16,
          color: '#33000000',
          offsetX: 0,
          offsetY: 6
        })
        .align(Alignment.BottomEnd)
        .margin({ right: 32, bottom: 176 })
        .onClick(() => {
          this.clearBoard()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}