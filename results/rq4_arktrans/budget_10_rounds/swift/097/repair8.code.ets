@Entry
@Component
struct Index {
  @State isEcoModeActive: boolean = true

  build() {
    Stack() {
      Column({ space: 16 }) {
        // === Header Section (Simulated based on screenshot) ===
        Row() {
          Button() {
            Image($r('app.media.startIcon')) // Placeholder for down arrow
              .width(24).height(24).fillColor(Color.Black)
          }
          .backgroundColor('#F5F5F7').borderRadius(30).width(60).height(60)

          Blank()

          // Toggle Switch Simulation
          Row() {
            Circle().width(50).height(30).fillColor(Color.Black)
            Circle().width(30).height(30).fillColor(Color.White).margin({ left: -15 })
          }.width(50).height(30)

          Blank()

          Button() {
            Image($r('app.media.startIcon')) // Placeholder for up arrow
              .width(24).height(24).fillColor(Color.Black)
          }
          .backgroundColor('#F5F5F7').borderRadius(30).width(60).height(60)
        }.width('100%').padding({ left: 24, right: 24 })

        // === Quick Actions Section ===
        Column({ space: 16 }) {
          Text('QUICK ACTIONS')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8E8E93')
            .margin({ left: 24 })

          // Row 1
          Row({ space: 16 }) {
            // Card 1: Fan Speed
            Column({ space: 8 }) {
              Image($r('app.media.startIcon')) // Placeholder icon
                .width(24).height(24).fillColor(Color.Black)
              
              Blank()
              
              Column({ space: 4 }) {
                Text('Fan Speed')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000')
                
                Text('Auto')
                  .fontSize(14)
                  .fontColor('#8E8E93')
              }
            }
            .width('100%')
            .height(120)
            .padding(16)
            .backgroundColor('#F5F5F7')
            .borderRadius(24)

            // Card 2: Eco Mode (Active State)
            Column({ space: 8 }) {
              Image($r('app.media.startIcon')) // Placeholder icon
                .width(24).height(24).fillColor(Color.White)
              
              Blank()
              
              Column({ space: 4 }) {
                Text('Eco Mode')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FFF')
                
                Text('On')
                  .fontSize(14)
                  .fontColor('#A1A1A6')
              }
            }
            .width('100%')
            .height(120)
            .padding(16)
            .backgroundColor('#1C1C1E')
            .borderRadius(24)
          }.width('100%').padding({ left: 24, right: 24 })

          // Row 2
          Row({ space: 16 }) {
            // Card 3: Timer
            Column({ space: 8 }) {
              Image($r('app.media.startIcon')) // Placeholder icon
                .width(24).height(24).fillColor(Color.Black)
              
              Blank()
              
              Column({ space: 4 }) {
                Text('Timer')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000')
                
                Text('Off')
                  .fontSize(14)
                  .fontColor('#8E8E93')
              }
            }
            .width('100%')
            .height(120)
            .padding(16)
            .backgroundColor('#F5F5F7')
            .borderRadius(24)

            // Card 4: Home
            Column({ space: 8 }) {
              Image($r('app.media.startIcon')) // Placeholder icon
                .width(24).height(24).fillColor(Color.Black)
              
              Blank()
              
              Column({ space: 4 }) {
                Text('Home')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000')
                
                Text('Living Room')
                  .fontSize(14)
                  .fontColor('#8E8E93')
              }
            }
            .width('100%')
            .height(120)
            .padding(16)
            .backgroundColor('#F5F5F7')
            .borderRadius(24)
          }.width('100%').padding({ left: 24, right: 24 })
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF')
  }
}