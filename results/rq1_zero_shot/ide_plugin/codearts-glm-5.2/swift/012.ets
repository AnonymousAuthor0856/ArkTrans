class AppTokens {
  static readonly Colors = {
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    primary: '#FF60A5FA',
    primaryLight: '#FF93C5FD',
    text: '#FF111827',
    outline: '#FFD1D5DB',
    primaryLight30: '#4D93C5FD',
    primaryLight20: '#3393C5FD',
    primary30: '#4D60A5FA'
  }
}

@Entry
@Component
struct FavoriteSpotsMap {
  @State markerPositionX: number = 120
  @State markerPositionY: number = 200
  @State displayedCoordinates: string = '(200, 400)'

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w: number = 328
    const h: number = 400
    const centerX = w / 2
    const centerY = h / 2

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    ctx.arc(centerX, centerY, 180, 0, Math.PI * 2)
    ctx.fillStyle = '#3393C5FD'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(centerX, centerY, 120, 0, Math.PI * 2)
    ctx.fillStyle = '#4D93C5FD'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(this.markerPositionX, this.markerPositionY, 12, 0, Math.PI * 2)
    ctx.strokeStyle = '#4D60A5FA'
    ctx.lineWidth = 1
    ctx.stroke()

    ctx.beginPath()
    ctx.arc(this.markerPositionX, this.markerPositionY, 4, 0, Math.PI * 2)
    ctx.fillStyle = '#FF60A5FA'
    ctx.fill()
  }

  build() {
    Column() {
      Row() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppTokens.Colors.text)
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column() {
          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height(400)
              .onReady(() => {
                this.drawCanvas()
              })
          }
          .width('100%')
          .height(400)
          .borderRadius(24)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .padding({ left: 16, right: 16 })

          Column() {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.text)

            Button('Save Marker') {
            }
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFFFF')
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(16)
            .margin({ top: 16 })

            Column() {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.Semibold)
                .fontColor(AppTokens.Colors.text)
                .margin({ bottom: 12 })

              Row() {
                Row()
                  .width(8)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(AppTokens.Colors.primary)
                Text('Saved Marker')
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.text)
                  .margin({ left: 8 })
                Blank()
              }
              .width('100%')
              .margin({ bottom: 8 })

              Row() {
                Row()
                  .width(8)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(AppTokens.Colors.primary)
                Text('Saved Marker')
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.text)
                  .margin({ left: 8 })
                Blank()
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 8 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 24 })
          .margin({ top: 16 })
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}