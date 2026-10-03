@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header Section
        Row() {
          Column() {
            Text('Living Room')
              .fontSize(16)
              .fontColor('#8E8E93')
              .fontWeight(FontWeight.Regular)
            
            Text('AeroSense')
              .fontSize(42)
              .fontColor('#1C1C1E')
              .fontWeight(FontWeight.Bold)
              .margin({ top: 4 })
          }
          
          Blank()
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(28)
              .height(28)
              .fillColor('#1C1C1E')
          }
          .width(50)
          .height(50)
          .backgroundColor('#F2F2F7')
          .borderRadius(25)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 40 })

        // Main AQI Card
        Stack({ alignContent: Alignment.Center }) {
          // Background Circle (Simulated Canvas)
          Circle()
            .width(220)
            .height(220)
            .fill('#F9F9FA')
          
          // Green Arc (Simulated Canvas)
          Circle()
            .width(220)
            .height(220)
            .fill('#5CB85C')
            .clip(true)
            .offset({ x: -20, y: -20 })
            .scale({ x: 0.8, y: 0.8 })
            .rotate({ angle: 45 })

          Column({ space: 8 }) {
            Text('AQI')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8E8E93')
              .letterSpacing(2)
            
            Text('42')
              .fontSize(80)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1C1C1E')
              .lineHeight(80)
            
            Text('Excellent')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#5CB85C')
              .backgroundColor('#5CB85C1A') // Hex opacity for green
              .borderRadius(16)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          }
        }
        .width('100%')
        .height(300)
        .alignItems(HorizontalAlign.Center)

        // Metrics Grid
        Column({ space: 16 }) {
          Row({ space: 16 }) {
            // Temp Card
            Column({ space: 0 }) {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#1C1C1E')
                  .borderRadius(12)
                
                Blank()
              }
              
              Blank()
              
              Column({ space: 4 }) {
                Text('23°C')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1C1E')
                
                Text('Temp')
                  .fontSize(12)
                  .fontColor('#8E8E93')
              }
            }
            .width('100%')
            .height(110)
            .padding(16)
            .backgroundColor('#F9F9FA')
            .borderRadius(24)

            // Humidity Card
            Column({ space: 0 }) {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#5CB85C')
                  .borderRadius(12)
                
                Blank()
              }
              
              Blank()
              
              Column({ space: 4 }) {
                Text('45%')
                  .fontSize(24)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1C1E')
                
                Text('Humidity')
                  .fontSize(12)
                  .fontColor('#8E8E93')
              }
            }
            .width('100%')
            .height(110)
            .padding(16)
            .backgroundColor('#F9F9FA')
            .borderRadius(24)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          // Bottom Cards Row (Partially visible in screenshot)
          Row({ space: 16 }) {
             // CO2 Card
             Column({ space: 0 }) {
               Row() {
                 Image($r('app.media.startIcon'))
                   .width(24)
                   .height(24)
                   .fillColor('#5CB85C')
                   .borderRadius(12)
                 
                 Blank()
               }
               
               Blank()
               
               Column({ space: 4 }) {
                 Text('12')
                   .fontSize(24)
                   .fontWeight(FontWeight.Medium)
                   .fontColor('#1C1C1E')
                 
                 Text('CO2')
                   .fontSize(12)
                   .fontColor('#8E8E93')
               }
             }
             .width('100%')
             .height(110)
             .padding(16)
             .backgroundColor('#F9F9FA')
             .borderRadius(24)

             // Warning Card
             Column({ space: 0 }) {
               Row() {
                 Image($r('app.media.startIcon'))
                   .width(24)
                   .height(24)
                   .fillColor('#FF9500')
                   .borderRadius(12)
                 
                 Blank()
               }
               
               Blank()
               
               Column({ space: 4 }) {
                 Text('850')
                   .fontSize(24)
                   .fontWeight(FontWeight.Medium)
                   .fontColor('#1C1C1E')
                 
                 Text('VOCs')
                   .fontSize(12)
                   .fontColor('#8E8E93')
               }
             }
             .width('100%')
             .height(110)
             .padding(16)
             .backgroundColor('#F9F9FA')
             .borderRadius(24)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .margin({ top: 32 })

        // Analysis Card
        Column({ space: 12 }) {
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1C1C1E')
            
            Blank().width(12)
            
            Text('Room Analysis')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1C1C1E')
          }
          
          Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
            .fontSize(14)
            .fontColor('#8E8E93')
            .lineHeight(22)
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .border({ width: 1, color: '#E5E5EA' })
        .margin({ top: 16, left: 24, right: 24 })
        
        Blank()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
      
      // Bottom Navigation Bar
      Row({ space: 16 }) {
        Button() {
           Image($r('app.media.startIcon'))
             .width(24)
             .height(24)
             .fillColor('#1C1C1E')
        }
        .width(56)
        .height(56)
        .backgroundColor('#FFFFFF')
        .borderRadius(28)
        .border({ width: 1, color: '#E5E5EA' })

        Button() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
            
            Blank().width(8)
            
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
        }
        .layoutWeight(1)
        .height(56)
        .backgroundColor('#1C1C1E')
        .borderRadius(20)

        Button() {
           Image($r('app.media.startIcon'))
             .width(24)
             .height(24)
             .fillColor('#1C1C1E')
        }
        .width(56)
        .height(56)
        .backgroundColor('#FFFFFF')
        .borderRadius(28)
        .border({ width: 1, color: '#E5E5EA' })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 40 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -60 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}