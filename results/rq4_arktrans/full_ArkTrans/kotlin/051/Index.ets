@Entry
@Component
struct Index {
  @State departures: string[] = ["08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3"]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Text('Metro Planner')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')

        // Canvas Area (Simulated with Stack and Shapes to match screenshot)
        Stack() {
          // Background for the graph area
          Rect().width('100%').height('100%').fill('#1E1E3F')
          
          // The Graph Line (Simplified visual representation using a path or shapes)
          // Since we cannot draw complex paths easily without custom drawing, 
          // we use a simplified visual structure matching the skeleton's intent.
          // In a real app, this would be a custom DrawingContext component.
          // Here we represent the "Canvas" block from the skeleton.
        }
        .width('100%')
        .height(260)
        .borderRadius(24)
        .padding(16)

        // Card Component
        Column() {
          Column({ space: 6 }) {
            Text('Next Departures')
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
              .fontColor('#00B4FF')

            ForEach(this.departures, (item: string) => {
              Row() {
                Text(item)
                  .fontSize(16)
                  .fontColor('#FFFFFF')
                
                Blank()
                
                Text('On Time')
                  .fontSize(14)
                  .fontColor('#00FFAA')
              }.width('100%')
            }, (item: string) => item)
          }
          .width('100%')
          .padding(16)
        }
        .width('100%')
        .backgroundColor('#141436')
        .borderRadius(24)
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 4 })

        Blank().height(10)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0A0A1A', 0], ['#141436', 0.5], ['#0A0A1A', 1]]
      })

      // Floating Action Button
      Button() {
        Text('+')
          .fontSize(32)
          .fontColor('#0A0A1A')
          .fontWeight(FontWeight.Bold)
      }
      .width(56)
      .height(56)
      .backgroundColor('#00FFFF')
      .borderRadius(28)
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 24, bottom: 80 })
      .alignSelf(ItemAlign.End)

      // Bottom Navigation Bar
      Row() {
        Text('Routes')
          .fontSize(16)
          .fontColor('#00B4FF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Text('Planner')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Text('Tickets')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          
        Text('Profile')
          .fontSize(16)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(80)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#141436')
      .position({ x: 0, y: 'auto' })
      .alignSelf(ItemAlign.Stretch)
    }
    .width('100%')
    .height('100%')
  }
}