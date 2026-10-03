@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Column() {
          Text('Favorite Spots Map')
            .fontColor('#111827')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .backgroundColor('#F9FAFB')

        Stack() {
          // Background Gradient
          Column()
            .width('100%')
            .height('100%')
            .linearGradient({
              angle: 135,
              colors: [
                ['#FFFFFF', 0.6],
                ['#EFF6FF', 0.5],
                ['#FFFFFF', 0.7]
              ]
            })

          Column() {
            Blank()

            // Map Area
            Stack() {
              // Radial Gradient Background for Map
              Column()
                .width('100%')
                .height('100%')
                .radialGradient({
                  center: [0.5, 0.5],
                  radius: 1,
                  colors: [
                    ['#FFFFFF', 0.8],
                    ['#EFF6FF', 0.6]
                  ]
                })

              // Border
              Rect()
                .width('100%')
                .height('100%')
                .borderWidth(1)
                .borderColor('#D1D5DB')
                .borderRadius(24)

              // Canvas Content (Simulated with Shapes based on screenshot)
              Stack() {
                // Outer Ring
                Circle()
                  .width(300)
                  .height(300)
                  .fill('#BFDBFE')
                  .opacity(0.3)
                
                // Inner Ring
                Circle()
                  .width(200)
                  .height(200)
                  .fill('#BFDBFE')
                  .opacity(0.6)

                // Center Marker
                Stack() {
                  Circle()
                    .width(24)
                    .height(24)
                    .fill('#BFDBFE')
                    .opacity(0.5)
                  
                  Circle()
                    .width(8)
                    .height(8)
                    .fill('#60A5FA')
                }.offset({ x: -40, y: -20 })
              }
            }
            .width('100%')
            .height(400)
            .clip(true)
            .borderRadius(24)

            // Bottom Controls
            Column() {
              Text('Spot Coordinates: (200, 400)')
                .fontColor('#111827')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)

              Button() {
                Text('Save Marker')
                  .fontColor('#FFFFFF')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .height(48)
              .backgroundColor('#60A5FA')
              .borderRadius(16)
              .margin({ top: 16 })

              Column() {
                Text('Saved Markers')
                  .fontColor('#111827')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.Start)
                  .width('100%')

                Column() {
                  Row() {
                    Circle()
                      .width(8)
                      .height(8)
                      .fill('#60A5FA')
                    
                    Text('Saved Marker')
                      .fontColor('#111827')
                      .fontSize(14)
                      .fontWeight(FontWeight.Regular)
                      .margin({ left: 8 })
                    
                    Blank()
                  }
                  .width('100%')
                  .margin({ bottom: 8 })

                  Row() {
                    Circle()
                      .width(8)
                      .height(8)
                      .fill('#60A5FA')
                    
                    Text('Saved Marker')
                      .fontColor('#111827')
                      .fontSize(14)
                      .fontWeight(FontWeight.Regular)
                      .margin({ left: 8 })
                    
                    Blank()
                  }
                  .width('100%')
                }
                .margin({ top: 8 })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .margin({ top: 16 })
            }
            .width('100%')
            .padding({ left: 16, right: 16, bottom: 24 })
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')
    }
    .width('100%')
    .height('100%')
  }
}