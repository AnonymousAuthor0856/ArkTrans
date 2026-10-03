@Entry
@Component
struct Index {
  build() {
    Column() {
      // Header Row
      Row() {
        Text('ZenBreather')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ left: 16 })

        Blank()

        Image($r('app.media.startIcon'))
          .width(32)
          .height(32)
          .fillColor('#808080')
          .margin({ right: 16 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().layoutWeight(1)

      // Main Circle Visualization
      Stack() {
        // Background Circle
        Circle()
          .width(280)
          .height(280)
          .fill('#E0F2F1')
          .borderWidth(2)
          .borderColor('#00796B')

        // Inner Lines (Simulated with rotated columns)
        ForEach([0, 45, 90, 135], (angle: number) => {
          Column() {
            // Line
            Column()
              .width(2)
              .height(120)
              .backgroundColor('#00796B')
              .opacity(0.3)
            
            // Dot at end
            Circle()
              .width(8)
              .height(8)
              .fill('#00796B')
              .margin({ top: -4 })
          }
          .rotate({ angle: angle })
        })

        // Center Text
        Column() {
          Text('Ready')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#00796B')
          
          Text('4s In / 6s Out')
            .fontSize(16)
            .fontColor('#757575')
            .margin({ top: 4 })
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 20 })

      Blank().height(40)

      // Rhythm Selection Section
      Column() {
        Text('Select Rhythm')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .alignSelf(ItemAlign.Start)
          .margin({ left: 16, bottom: 16 })

        Row() {
          // Selected Item (Balance)
          Column() {
            Image($r('app.media.startIcon')) // Using startIcon as a placeholder for checkmark
              .width(24)
              .height(24)
              .fillColor('#00796B')
              .margin({ bottom: 4 })
            
            Text('Balance')
              .fontSize(16)
              .fontColor('#00796B')
          }
          .width(100)
          .height(80)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(20)
          .backgroundColor('#E0F2F1')
          .borderWidth(2)
          .borderColor('#00796B')

          // Unselected Item (Focus)
          Column() {
            Text('Focus')
              .fontSize(16)
              .fontColor('#333333')
          }
          .width(100)
          .height(80)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(20)
          .backgroundColor('#F5F5F5')
          .margin({ left: 10 })
        }
        .justifyContent(FlexAlign.Start)
        .margin({ left: 16 })

      }.margin({ top: 20 })

      Blank().layoutWeight(1)

      // Start Button
      Button() {
        Row() {
          Text('START BREATHING')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .letterSpacing(1)
          
          Image($r('app.media.startIcon')) // Using startIcon as play arrow
            .width(24)
            .height(24)
            .fillColor('#FFFFFF')
            .margin({ left: 10 })
        }
      }
      .width('85%')
      .height(64)
      .backgroundColor('#333333')
      .borderRadius(32)
      .margin({ bottom: 40 })
      
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}