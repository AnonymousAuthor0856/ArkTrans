@Entry
@Component
struct ContentView {
  @State markerX: number = 120
  @State markerY: number = 200

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top App Bar
        Text('Favorite Spots Map')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 10, bottom: 10 })
          .backgroundColor('#F9FAFB')

        // Map area
        Stack() {
          // Background circles
          Image('')
            .width(240)
            .height(240)
            .borderRadius(120)
            .backgroundColor('#93C5FD')
            .opacity(0.3)
            .position({ x: '50%', y: '50%' }) // center

          Image('')
            .width(360)
            .height(360)
            .borderRadius(180)
            .backgroundColor('#93C5FD')
            .opacity(0.2)
            .position({ x: '50%', y: '50%' })

          // Marker outer ring
          Image('')
            .width(24)
            .height(24)
            .borderRadius(12)
            .backgroundColor('#60A5FA')
            .opacity(0.3)
            .margin({ left: this.markerX - 12, top: this.markerY - 12 })

          // Marker dot
          Image('')
            .width(8)
            .height(8)
            .borderRadius(4)
            .backgroundColor('#60A5FA')
            .margin({ left: this.markerX - 4, top: this.markerY - 4 })
        }
        .width('100%')
        .height(400)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .border({ width: 1, color: '#D1D5DB' })
        .padding({ left: 16, right: 16 })

        // Bottom controls
        Column({ space: 16 }) {
          Text('Spot Coordinates: (' + this.markerX.toString() + ', ' + this.markerY.toString() + ')')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')

          Button({ type: ButtonType.Normal }) {
            Text('Save Marker')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .width('100%')
              .height(48)
          }
          .width('100%')
          .height(48)
          .backgroundColor('#60A5FA')
          .borderRadius(16)

          // Saved markers section
          Column({ space: 12 }) {
            Text('Saved Markers')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Column({ space: 8 }) {
              Row({ space: 8 }) {
                Image('')
                  .width(8)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor('#60A5FA')
                Text('Saved Marker')
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .fontColor('#111827')
                Blank()
              }
              Row({ space: 8 }) {
                Image('')
                  .width(8)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor('#60A5FA')
                Text('Saved Marker')
                  .fontSize(14)
                  .fontWeight(FontWeight.Regular)
                  .fontColor('#111827')
                Blank()
              }
            }
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ top: 8 })
        }
        .width('100%')
        .padding({ left: 16, right: 16, bottom: 24 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}