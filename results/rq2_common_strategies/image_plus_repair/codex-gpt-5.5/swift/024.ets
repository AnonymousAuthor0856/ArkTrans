interface DrawPoint {
  x: number
  y: number
}

@Entry
@Component
struct RetroWhiteboardApp {
  @State private points: DrawPoint[] = []
  @State private currentColor: string = '#EF476F'

  private readonly canvasBackground: string = '#FFFCF2'
  private readonly surfaceColor: string = '#FFFFFF'
  private readonly redColor: string = '#EF476F'
  private readonly yellowColor: string = '#FFD166'
  private readonly greenColor: string = '#06D6A0'
  private readonly inkColor: string = '#1E1E1E'

  private addPoint(event: TouchEvent): void {
    if (event.type !== TouchType.Down && event.type !== TouchType.Move) {
      return
    }
    const touch = event.touches[0]
    if (touch === undefined) {
      return
    }
    this.points = this.points.concat([{ x: touch.x, y: touch.y }])
  }

  private selectColor(color: string): void {
    this.currentColor = color
  }

  private clearCanvas(): void {
    this.points = []
  }

  build() {
    Stack() {
      Column() {
        ForEach(this.points, (point: DrawPoint) => {
          Circle()
            .width(20)
            .height(20)
            .fill(this.currentColor)
            .position({ x: point.x - 10, y: point.y - 10 })
        }, (point: DrawPoint, index: number) => `${index}-${point.x}-${point.y}`)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.canvasBackground)
      .onTouch((event: TouchEvent) => this.addPoint(event))

      Column() {
        Text('Retro Whiteboard')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.inkColor)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 12, bottom: 12 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .align(Alignment.Top)

      Row() {
        Button('Red')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .backgroundColor(this.redColor)
          .borderRadius(6)
          .height(44)
          .layoutWeight(1)
          .onClick(() => this.selectColor(this.redColor))

        Button('Yellow')
          .fontSize(14)
          .fontColor(this.inkColor)
          .backgroundColor(this.yellowColor)
          .borderRadius(6)
          .height(44)
          .layoutWeight(1)
          .onClick(() => this.selectColor(this.yellowColor))

        Button('Green')
          .fontSize(14)
          .fontColor(this.inkColor)
          .backgroundColor(this.greenColor)
          .borderRadius(6)
          .height(44)
          .layoutWeight(1)
          .onClick(() => this.selectColor(this.greenColor))
      }
      .width('100%')
      .height(68)
      .padding({ left: 64, right: 64, top: 12, bottom: 12 })
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(this.surfaceColor)
      .shadow({
        radius: 2,
        color: '#1F000000',
        offsetX: 0,
        offsetY: 2
      })
      .align(Alignment.Bottom)

      Button('Clear')
        .fontSize(12)
        .fontColor(this.inkColor)
        .backgroundColor(this.yellowColor)
        .width(56)
        .height(56)
        .borderRadius(28)
        .shadow({
          radius: 2,
          color: '#1F000000',
          offsetX: 0,
          offsetY: 2
        })
        .align(Alignment.BottomEnd)
        .margin({ right: 24, bottom: 24 })
        .onClick(() => this.clearCanvas())
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.canvasBackground)
    .clip(true)
  }
}
