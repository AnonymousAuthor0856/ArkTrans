@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Column() {
          Blank().height(48)
          Text('MATCHA RITUAL')
            .fontColor('#999999')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(4)
            .fontSize(14)
            .textAlign(TextAlign.Center)
          
          Blank().height(8)
          
          Text('Ceremonial Grade')
            .fontColor('#000000')
            .fontWeight(FontWeight.Lighter)
            .fontSize(28)
            .textAlign(TextAlign.Center)
        }

        Column() {
          // Canvas: Matcha Bowl Illustration
          Column() {
            // Steam lines
            Row() {
              Column().width(3).height(24).borderRadius(2).backgroundColor('#CCCCCC')
              Column().width(3).height(32).borderRadius(2).backgroundColor('#CCCCCC').margin({ left: 12, right: 12 })
              Column().width(3).height(24).borderRadius(2).backgroundColor('#CCCCCC')
            }.justifyContent(FlexAlign.Center)

            // Bowl Body
            Column() {
              // Green Tea Surface
              Capsule()
                .width(160)
                .height(40)
                .backgroundColor('#8CB369')
                .position({ y: -15 })
              
              // Dark Bowl Base
              Circle()
                .width(180)
                .height(180)
                .backgroundColor('#333333')
                .clip(true)
                .position({ y: 30 })
            }
            .width(180)
            .height(120)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(160)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Blank().height(40)

          // Stats Row
          Row() {
            Blank()
            
            Column() {
              Text('TEMP')
                .fontColor('#999999')
                .opacity(0.5)
                .fontWeight(FontWeight.Bold)
                .fontSize(10)
                .textAlign(TextAlign.Center)
              
              Blank().height(4)
              
              Text('80°C')
                .fontColor('#000000')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
                .textAlign(TextAlign.Center)
            }

            Blank()

            Column() {
              Text('WATER')
                .fontColor('#999999')
                .opacity(0.5)
                .fontWeight(FontWeight.Bold)
                .fontSize(10)
                .textAlign(TextAlign.Center)
              
              Blank().height(4)
              
              Text('70ml')
                .fontColor('#000000')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
                .textAlign(TextAlign.Center)
            }

            Blank()

            Column() {
              Text('BAMBOO')
                .fontColor('#999999')
                .opacity(0.5)
                .fontWeight(FontWeight.Bold)
                .fontSize(10)
                .textAlign(TextAlign.Center)
              
              Blank().height(4)
              
              Text('Whisk')
                .fontColor('#000000')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
                .textAlign(TextAlign.Center)
            }

            Blank()
          }.width('100%')
        }.layoutWeight(1)

        Column() {
          // Step 1
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill('#F5F5F5')
              
              Text('01')
                .fontColor('#000000')
                .fontWeight(FontWeight.Bold)
                .fontSize(12)
            }
            
            Blank().width(16)
            
            Text('Sift 2g of matcha powder.')
              .fontColor('#4D4D4D')
              .fontSize(14)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          Blank().height(12)

          // Step 2
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill('#F5F5F5')
              
              Text('02')
                .fontColor('#000000')
                .fontWeight(FontWeight.Bold)
                .fontSize(12)
            }
            
            Blank().width(16)
            
            Text("Add hot water. Whisk in 'M' shape.")
              .fontColor('#4D4D4D')
              .fontSize(14)
              .layoutWeight(1)
          }
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          Blank().height(32)

          Button() {
            Row() {
              // Play Icon Triangle
              Path()
                .commands('M 0 0 L 12 8 L 0 16 Z')
                .fill('#FFFFFF')
                .width(12)
                .height(16)
                .margin({ right: 8 })
                
              Text('START TIMER')
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
                .fontSize(16)
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F')
          .borderRadius(28)
          .type(ButtonType.Capsule)

          Blank().height(24)
        }.width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }
}