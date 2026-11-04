@Entry
@Component
struct Index {
  @State displayedCoordinates: string = '(200, 400)'

  private cBg: string = '#F9FAFB'
  private cText: string = '#111827'
  private cMapTint: string = '#EFF6FF'
  private cLine: string = '#D1D5DB'
  private cBlue: string = '#60A5FA'
  private cRing: string = '#93C5FD'

  @Builder
  SavedMarkerRow() {
    Row() {
      Circle()
        .width(8)
        .height(8)
        .fill(this.cBlue)
        .margin({ right: 8 })
      Text('Saved Marker')
        .fontSize(14)
        .fontColor(this.cText)
      Blank()
    }
    .width('100%')
    .height(24)
  }

  @Builder
  MapPanel() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width('100%')
        .height(400)
        .radius(24)
        .fill(this.cMapTint)
      Circle()
        .width(360)
        .height(360)
        .fill('#3393C5FD')
      Circle()
        .width(240)
        .height(240)
        .fill('#4D93C5FD')
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(24)
          .height(24)
          .fill('#4D60A5FA')
        Circle()
          .width(8)
          .height(8)
          .fill(this.cBlue)
      }
      .width(24)
      .height(24)
      .translate({ x: -80, y: 0 })
      Rect()
        .width('100%')
        .height(400)
        .radius(24)
        .fill(Color.Transparent)
        .stroke(this.cLine)
    }
    .width('100%')
    .height(400)
    .padding({ left: 16, right: 16 })
  }

  build() {
    Column() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cText)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .backgroundColor(this.cBg)

      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#F7FBFF')
        Column() {
          Blank().layoutWeight(1)
          this.MapPanel()

          Column() {
            Text('Spot Coordinates: ' + this.displayedCoordinates)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cText)
              .textAlign(TextAlign.Center)
              .width('100%')
              .margin({ bottom: 16 })

            Button('Save Marker')
              .width('100%')
              .height(48)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .backgroundColor(this.cBlue)
              .borderRadius(16)
              .margin({ bottom: 16 })

            Column() {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.cText)
                .width('100%')
                .margin({ bottom: 12 })
              this.SavedMarkerRow()
              this.SavedMarkerRow()
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 24 })
        }
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBg)
  }
}
