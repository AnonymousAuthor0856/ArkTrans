@Entry
@Component
struct Index {
  @State progress: number = 0.45

  build() {
    Stack() {
      Column() {
        // Header Row
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .padding({ left: 8 })
          
          Blank()
          
          Text('Charging Progress')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
          
          Blank()
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#F59E0B')
          }
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')

        // Main Content Area
        Column() {
          // Battery Graphic & Percentage
          Column() {
            Stack() {
              // Battery Body
              Rect()
                .width(50)
                .height(90)
                .borderRadius(8)
                .fill('#3B82F6')
              
              // Battery Cap
              Rect()
                .width(20)
                .height(10)
                .borderRadius(3)
                .fill('#3B82F6')
                .position({ x: 15, y: -50 })

              // Lightning Icon (Simulated with text for simplicity as per constraints)
              Text('⚡')
                .fontSize(40)
                .fontColor('#FFFFFF')
            }
            
            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor('#111827')
              .margin({ top: 20 })
          }
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 24 })

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Background Track
            Capsule()
              .width('100%')
              .height(12)
              .fill('#FFFFFF')
              .border({ width: 1, color: '#D4D4D8' })

            // Foreground Fill
            Capsule()
              .width(`${this.progress * 100}%`)
              .height(10)
              .fill('#3B82F6')
          }
          .width('100%')
          .margin({ top: 24 })

          // Action Button
          Button('Simulate Charge')
            .width('80%')
            .height(48)
            .backgroundColor('#22C55E')
            .borderRadius(24)
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 32 })
            .onClick(() => {
              if (this.progress < 1.0) {
                this.progress += 0.1
                if (this.progress > 1.0) {
                  this.progress = 1.0
                }
              } else {
                this.progress = 0.0
              }
            })

          // Status Text
          Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.progress < 1.0 ? '#3B82F6' : '#22C55E')
            .margin({ top: 24 })

          Blank()
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#F5F5F5')
      }
    }
    .width('100%')
    .height('100%')
  }
}