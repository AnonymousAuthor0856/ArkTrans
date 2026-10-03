@Entry
@Component
struct ContentView {
  @State markerX: number = 120
  @State markerY: number = 200
  @State displayedCoordinates: string = "(200, 400)"

  build() {
    Column() {
      // Top App Bar
      Column() {
        Text("Favorite Spots Map")
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#111827')
      }
      .width('100%')
      .padding({ top: 10, bottom: 10 })
      .backgroundColor('#F9FAFB')

      // Main content
      Scroll() {
        Column({ space: 0 }) {
          // Map container
          Stack() {
            // Radial gradient background simulation
            Column()
              .width('100%')
              .height(400)
              .borderRadius(24)
              .backgroundColor('#EFF6FF')

            // Inner circle (radius ~120)
            Column()
              .width(240)
              .height(240)
              .borderRadius(120)
              .backgroundColor('rgba(147, 197, 253, 0.3)')

            // Outer circle (radius ~180)
            Column()
              .width(360)
              .height(360)
              .borderRadius(180)
              .backgroundColor('rgba(147, 197, 253, 0.2)')

            // Marker outer ring
            Column()
              .width(24)
              .height(24)
              .borderRadius(12)
              .border({ width: 1, color: 'rgba(96, 165, 250, 0.3)' })
              .backgroundColor('transparent')
              .position({ x: this.markerX - 12, y: this.markerY - 12 })

            // Marker dot
            Column()
              .width(8)
              .height(8)
              .borderRadius(4)
              .backgroundColor('#60A5FA')
              .position({ x: this.markerX - 4, y: this.markerY - 4 })
          }
          .width('100%')
          .height(400)
          .borderRadius(24)
          .border({ width: 1, color: '#D1D5DB' })
          .clip(true)
          .margin({ left: 16, right: 16 })

          // Bottom controls
          Column({ space: 16 }) {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')

            Button("Save Marker")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .width('100%')
              .height(48)
              .backgroundColor('#60A5FA')
              .borderRadius(16)
              .onClick(() => {
                // Save marker action
              })

            // Saved markers list
            Column({ space: 12 }) {
              Text("Saved Markers")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#111827')
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: 8 }) {
                Row({ space: 8 }) {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111827')
                  Blank()
                }
                .width('100%')

                Row({ space: 8 }) {
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#111827')
                  Blank()
                }
                .width('100%')
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 8 })
          }
          .padding({ left: 16, right: 16, top: 16, bottom: 24 })
          .width('100%')
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F9FAFB')
  }
}