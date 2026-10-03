@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Text('Metro Planner')
          .fontColor('#00FFFF')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Map Visualization Area
        Column() {
          // Simulating the map line graph with a custom layout
          Row() {
            // Point 1 (Top Left)
            Column() {
              Circle().width(36).height(36).fill('#00FFFF')
              Circle().width(14).height(14).fill('#0A0A1A').margin({ top: -18 })
            }
            .position({ x: 0, y: 0 })

            // Line 1-2
            Rect().width(10).height(120).fill('#00D4FF')
              .position({ x: 15, y: 18 })
              .rotate({ angle: 45 })

            // Point 2 (Bottom Left-ish)
            Column() {
              Circle().width(36).height(36).fill('#00FFFF')
              Circle().width(14).height(14).fill('#0A0A1A').margin({ top: -18 })
            }
            .position({ x: 70, y: 120 })

            // Line 2-3
            Rect().width(10).height(120).fill('#00D4FF')
              .position({ x: 85, y: 102 })
              .rotate({ angle: -45 })

            // Point 3 (Top Middle)
            Column() {
              Circle().width(36).height(36).fill('#00FFFF')
              Circle().width(14).height(14).fill('#0A0A1A').margin({ top: -18 })
            }
            .position({ x: 140, y: 0 })

            // Line 3-4
            Rect().width(10).height(120).fill('#00D4FF')
              .position({ x: 155, y: 18 })
              .rotate({ angle: 45 })

            // Point 4 (Bottom Middle)
            Column() {
              Circle().width(36).height(36).fill('#00FFFF')
              Circle().width(14).height(14).fill('#0A0A1A').margin({ top: -18 })
            }
            .position({ x: 210, y: 120 })

             // Line 4-5
            Rect().width(10).height(120).fill('#00D4FF')
              .position({ x: 225, y: 102 })
              .rotate({ angle: -45 })

            // Point 5 (Top Right)
            Column() {
              Circle().width(36).height(36).fill('#00FFFF')
              Circle().width(14).height(14).fill('#0A0A1A').margin({ top: -18 })
            }
            .position({ x: 280, y: 0 })

            // Line 5-6
            Rect().width(10).height(120).fill('#00D4FF')
              .position({ x: 295, y: 18 })
              .rotate({ angle: 45 })

            // Point 6 (Bottom Right)
            Column() {
              Circle().width(36).height(36).fill('#00FFFF')
              Circle().width(14).height(14).fill('#0A0A1A').margin({ top: -18 })
            }
            .position({ x: 350, y: 120 })
          }
          .width('100%')
          .height(260)
          .justifyContent(FlexAlign.Center)
        }
        .backgroundColor('#1E1E4A')
        .borderRadius(24)
        .padding(16)
        .margin({ top: 20 })

        // Next Departures Card
        Column() {
          Text('Next Departures')
            .fontColor('#00B4FF')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 12 })

          Column({ space: 12 }) {
            this.DepartureRow('08:45 • Line 1')
            this.DepartureRow('09:10 • Line 2')
            this.DepartureRow('09:30 • Line 3')
          }
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#12122E')
        .borderRadius(24)
        .shadow({ radius: 10, color: '#000000', offsetX: 0, offsetY: 4 })
        .margin({ top: 20 })

        Blank()

        // Floating Action Button
        Button() {
          Text('+')
            .fontColor('#0A0A1A')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
        }
        .width(64)
        .height(64)
        .backgroundColor('#00FFFF')
        .borderRadius(32)
        .margin({ right: 24, bottom: 24 })
        .alignSelf(ItemAlign.End)
      }
      .width('100%')
      .height('100%')
      .padding({ left: 20, right: 20, top: 50 })
      .backgroundColor('#0A0A1A')

      // Bottom Navigation Bar
      Row() {
        Text('Routes')
          .fontColor('#00B4FF')
          .fontSize(16)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Text('Planner')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Tickets')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(60)
      .backgroundColor('#12122E')
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DepartureRow(text: string) {
    Row() {
      Text(text)
        .fontColor('#FFFFFF')
        .fontSize(16)
      
      Blank()
      
      Text('On Time')
        .fontColor('#00FFAA')
        .fontSize(14)
    }
    .width('100%')
  }
}