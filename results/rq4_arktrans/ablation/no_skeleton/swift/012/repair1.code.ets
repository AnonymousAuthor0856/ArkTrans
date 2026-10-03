@Entry
@Component
struct ContentView {
  @State markerPosition: { x: number, y: number } = { x: 120, y: 200 }
  @State displayedCoordinates: string = "(200, 400)"

  build() {
    Column() {
      // Top App Bar
      Text("Favorite Spots Map")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF111827')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .backgroundColor('#FFF9FAFB')

      // Main Content Area
      Stack() {
        // Background Gradient (Simulated with solid color for ArkTS compatibility as LinearGradient on Stack is complex)
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#FFF9FAFB')

        Column() {
          // Map Container
          Stack() {
            // Radial Gradient Background Simulation
            Circle()
              .fill(Color.White)
              .opacity(0.8)
              .width(360)
              .height(360)
            
            Circle()
              .fill('#FFEFF6FF')
              .opacity(0.6)
              .width(240)
              .height(240)

            // Border
            Rect()
              .width('100%')
              .height('100%')
              .borderWidth(1)
              .borderColor('#FFD1D5DB')
              .borderRadius(24)

            // Drawing Circles and Markers using Shapes in a Stack
            // Inner Circle (radius 120 -> width/height 240)
            Circle()
              .fill('#FF93C5FD')
              .opacity(0.3)
              .width(240)
              .height(240)

            // Outer Circle (radius 180 -> width/height 360)
            Circle()
              .fill('#FF93C5FD')
              .opacity(0.2)
              .width(360)
              .height(360)

            // Marker Group - Positioned relative to center based on SwiftUI logic
            // SwiftUI: center is size/2. Marker is at (120, 200). 
            // Assuming map size approx 400x400. Center (200, 200). 
            // Offset X: 120 - 200 = -80. Offset Y: 200 - 200 = 0.
            Stack() {
              // Marker Outer Ring (radius 12 -> width/height 24)
              Circle()
                .width(24)
                .height(24)
                .fill('transparent')
                .borderWidth(1)
                .borderColor('#FF60A5FA')
                .borderOpacity(0.3)

              // Marker Solid Dot (radius 4 -> width/height 8)
              Circle()
                .width(8)
                .height(8)
                .fill('#FF60A5FA')
            }
            .position({ x: '50%', y: '50%' })
            .translate({ x: -80, y: 0 }) // Adjusting position to match SwiftUI coordinates relative to center

          }
          .width('100%')
          .height(400)
          .clipShape(RoundedRectangle({ radius: 24 }))
          .margin({ left: 16, right: 16 })

          // Bottom Control Area
          Column() {
            Text(`Spot Coordinates: ${this.displayedCoordinates}`)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF111827')
              .margin({ top: 16, bottom: 16 })

            Button("Save Marker")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .width('100%')
              .height(48)
              .backgroundColor('#FF60A5FA')
              .borderRadius(16)
              .onClick(() => {
                // Save action
              })

            Column() {
              Text("Saved Markers")
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF111827')
                .alignSelf(ItemAlign.Start)
                .margin({ top: 16, bottom: 12 })

              Column() {
                Row() {
                  Circle()
                    .fill('#FF60A5FA')
                    .width(8)
                    .height(8)
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                    .margin({ left: 8 })
                  Blank()
                }
                .width('100%')
                .margin({ bottom: 8 })

                Row() {
                  Circle()
                    .fill('#FF60A5FA')
                    .width(8)
                    .height(8)
                  Text("Saved Marker")
                    .fontSize(14)
                    .fontWeight(FontWeight.Regular)
                    .fontColor('#FF111827')
                    .margin({ left: 8 })
                  Blank()
                }
                .width('100%')
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 24 })
          
          Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center })
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9FAFB')
  }
}