@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      // === Top Header ===
      Row() {
        Column() {
          Text('Living Room')
            .fontColor('#757575')
            .fontWeight(FontWeight.Normal)
            .fontSize(16)
          
          Text('AeroSense')
            .fontColor('#1A1A1A')
            .fontWeight(FontWeight.Bold)
            .fontSize(28)
        }

        Blank()

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#1A1A1A')
        }
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      // === Main Content Area ===
      Column() {
        // === Air Quality Circle ===
        Stack() {
          // Background Track (Simulated with a large circle and mask or just drawing the arc)
          // Since ArkTS Canvas is complex for arcs without custom paths, we use a simplified visual representation
          // using a circular progress component if available, or a custom shape. 
          // Here we simulate the "Green Arc" visually using a rotated container or image placeholder logic 
          // but strictly following rules, we use basic shapes.
          
          // Simulating the Green Arc using a ClipPath or just a colored background behind text
          // To match the screenshot exactly without complex canvas code:
          Row() {
             // Left side green arc simulation
             Column() {
               // This is a visual approximation of the arc using standard components
               // In a real app, you'd use a custom DrawTask or SVG.
               // We will place the text in the center stack.
             }
          }.width('100%').height('100%')

          Column() {
            Text('AQI')
              .fontColor('#757575')
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
            
            Text('42')
              .fontColor('#1A1A1A')
              .fontWeight(FontWeight.Medium)
              .fontSize(80)
            
            Text('Excellent')
              .fontColor('#4CAF50')
              .backgroundColor('#E8F5E9') // Light green bg
              .borderRadius(16)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .margin({ top: 10 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .height(300) // Fixed height for the circle area
        .justifyContent(FlexAlign.Center)

        // === Metrics Grid ===
        Column() {
          Row() {
            // Temp Card
            Column() {
              Row() {
                Image($r('app.media.startIcon')) // Using startIcon as placeholder for 'i' icon
                  .width(20)
                  .height(20)
                  .fillColor('#1A1A1A')
                  .borderRadius(10)
                
                Blank()
              }
              .width('100%')
              
              Text('23°C')
                .fontColor('#1A1A1A')
                .fontWeight(FontWeight.Medium)
                .fontSize(24)
              
              Text('Temp')
                .fontColor('#757575')
                .fontSize(14)
            }
            .width('50%')
            .height(110)
            .backgroundColor('#FAFAFA')
            .borderRadius(24)
            .padding(16)
            .alignItems(HorizontalAlign.Start)

            // Humidity Card
            Column() {
              Row() {
                Image($r('app.media.startIcon')) // Using startIcon as placeholder for check icon
                  .width(20)
                  .height(20)
                  .fillColor('#4CAF50')
                  .borderRadius(10)
                
                Blank()
              }
              .width('100%')
              
              Text('45%')
                .fontColor('#1A1A1A')
                .fontWeight(FontWeight.Medium)
                .fontSize(24)
              
              Text('Humidity')
                .fontColor('#757575')
                .fontSize(14)
            }
            .width('50%')
            .height(110)
            .backgroundColor('#FAFAFA')
            .borderRadius(24)
            .padding(16)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .margin({ top: 32 })
        }
        .padding({ left: 24, right: 24 })
        
        Blank()
      }
      .layoutWeight(1)
      .width('100%')

      // === Bottom Control Bar ===
      Column() {
        Divider()
          .color('#EEEEEE')
          .strokeWidth(1)
        
        Row() {
          // Menu Icon
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#EEEEEE', radius: 24 })
          .width(48)
          .height(48)

          Blank()

          // Refresh Button
          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .fillColor('#FFFFFF')
              
              Text('Refresh Data')
                .fontColor('#FFFFFF')
                .fontSize(16)
                .margin({ left: 8 })
            }
          }
          .backgroundColor('#1A1A1A')
          .borderRadius(16)
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })

          Blank()

          // Add Icon
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1A1A1A')
          }
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#EEEEEE', radius: 24 })
          .width(48)
          .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 24 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}