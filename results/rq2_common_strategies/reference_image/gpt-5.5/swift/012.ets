@Entry
@Component
struct ContentView {
  @State private markerX: number = 120
  @State private markerY: number = 200
  @State private displayedCoordinates: string = '(200, 400)'

  build() {
    Column() {
      Column() {
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#F9FAFB')

      Stack() {
        Column() {
          Blank()
            .layoutWeight(1)

          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(360)
              .height(360)
              .fill('rgba(147, 197, 253, 0.20)')

            Circle()
              .width(240)
              .height(240)
              .fill('rgba(147, 197, 253, 0.30)')

            Circle()
              .width(24)
              .height(24)
              .fill('rgba(255, 255, 255, 0.0)')
              .stroke('rgba(96, 165, 250, 0.30)')
              .strokeWidth(1)
              .position({ x: this.markerX - 12, y: this.markerY - 12 })

            Circle()
              .width(8)
              .height(8)
              .fill('#60A5FA')
              .position({ x: this.markerX - 4, y: this.markerY - 4 })
          }
          .width('100%')
          .height(400)
          .backgroundColor('#F8FBFF')
          .borderRadius(24)
          .border({
            width: 1,
            color: '#D1D5DB'
          })
          .clip(true)
          .margin({ left: 16, right: 16 })

          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Button({ type: ButtonType.Normal, stateEffect: true }) {
              Text('Save Marker')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .width('100%')
            .height(48)
            .backgroundColor('#60A5FA')
            .borderRadius(16)
            .onClick(() => {
            })

            Column({ space: 12 }) {
              Text('Saved Markers')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#111827')

              Column({ space: 8 }) {
                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')

                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#111827')
                    .margin({ left: 12 })

                  Blank()
                    .layoutWeight(1)
                }
                .width('100%')

                Row() {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')

                  Text('Saved Marker')
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#111827')
                    .margin({ left: 12 })

                  Blank()
                    .layoutWeight(1)
                }
                .width('100%')
              }
              .width('100%')
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding({ top: 8 })
          }
          .width('100%')
          .padding({
            left: 16,
            right: 16,
            top: 0,
            bottom: 24
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}