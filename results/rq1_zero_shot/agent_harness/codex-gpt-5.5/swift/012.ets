@Entry
@Component
struct ContentView {
  @State private displayedCoordinates: string = '(200, 400)';

  @Builder
  MapSurface() {
    Stack({ alignContent: Alignment.Center }) {
      Rect()
        .width('100%')
        .height(400)
        .fill('#F7FBFF')
        .radius(24)
      Circle()
        .width(360)
        .height(360)
        .fill('#3393C5FD')
      Circle()
        .width(240)
        .height(240)
        .fill('#4D93C5FD')
      Stack() {
        Circle()
          .width(24)
          .height(24)
          .fill('#4D60A5FA')
        Circle()
          .width(8)
          .height(8)
          .fill('#60A5FA')
      }
      .width(24)
      .height(24)
      .position({ x: 120, y: 200 })
      Rect()
        .width('100%')
        .height(400)
        .fill(Color.Transparent)
        .stroke('#D1D5DB')
        .strokeWidth(1)
        .radius(24)
    }
    .width('100%')
    .height(400)
    .padding({ left: 16, right: 16 })
  }

  @Builder
  SavedMarkerRow() {
    Row() {
      Circle()
        .width(8)
        .height(8)
        .fill('#60A5FA')
      Text('Saved Marker')
        .fontSize(14)
        .fontColor('#111827')
        .margin({ left: 8 })
      Blank()
    }
    .width('100%')
  }

  build() {
    Column() {
      Text('Favorite Spots Map')
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#111827')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 10, bottom: 10 })
        .backgroundColor('#F9FAFB')

      Stack() {
        Rect()
          .width('100%')
          .height('100%')
          .fill('#F9FAFB')
        Column() {
          Blank()
          this.MapSurface()
          Column() {
            Text('Spot Coordinates: ' + this.displayedCoordinates)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
            Button('Save Marker')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#60A5FA')
              .width('100%')
              .height(48)
              .borderRadius(16)
              .margin({ top: 16 })

            Column() {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#111827')
                .width('100%')
              this.SavedMarkerRow()
                .margin({ top: 12 })
              this.SavedMarkerRow()
                .margin({ top: 8 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 24 })
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
    .backgroundColor('#F9FAFB')
  }
}
