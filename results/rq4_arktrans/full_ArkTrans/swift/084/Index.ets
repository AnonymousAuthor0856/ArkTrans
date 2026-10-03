@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row({ space: 24 }) {
          Column({ space: 4 }) {
            Text('V60 Guide')
              .fontColor('#000000')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
            
            Text('Ethiopia Yirgacheffe')
              .fontColor('#8E8E93')
              .fontSize(16)
          }
          
          Blank()
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .backgroundColor(Color.Transparent)
        }
        .padding({ top: 30, bottom: 30, left: 24, right: 24 })

        Blank()

        Column({ space: 10 }) {
          Text('00:45')
            .fontColor('#000000')
            .fontSize(90)
            .fontWeight(FontWeight.Regular)
            .lineHeight(90)
            .letterSpacing(-2)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .width('100%')
          
          Text('Target: 300g')
            .fontColor('#8E8E93')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
        }

        Blank()

        Row({ space: 30 }) {
          // Ratio Item
          Column({ space: 12 }) {
            Stack() {
              Circle()
                .width(64)
                .height(64)
                .borderWidth(1.5)
                .borderColor('#D1D1D6')
              
              // Using startIcon as a placeholder for the plus icon to satisfy compilation rules
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#8E8E93')
            }
            
            Column({ space: 4 }) {
              Text('1:15')
                .fontColor('#000000')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              
              Text('Ratio')
                .fontColor('#8E8E93')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
            }
          }
          .width(80)
          .alignItems(HorizontalAlign.Center)

          // Beans Item
          Column({ space: 12 }) {
            Stack() {
              Circle()
                .width(64)
                .height(64)
                .borderWidth(1.5)
                .borderColor('#D1D1D6')
              
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#8E8E93')
            }
            
            Column({ space: 4 }) {
              Text('20g')
                .fontColor('#000000')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              
              Text('Beans')
                .fontColor('#8E8E93')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
            }
          }
          .width(80)
          .alignItems(HorizontalAlign.Center)

          // Temp Item
          Column({ space: 12 }) {
            Stack() {
              Circle()
                .width(64)
                .height(64)
                .borderWidth(1.5)
                .borderColor('#D1D1D6')
              
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .fillColor('#8E8E93')
            }
            
            Column({ space: 4 }) {
              Text('93°C')
                .fontColor('#000000')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Center)
              
              Text('Temp')
                .fontColor('#8E8E93')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .textAlign(TextAlign.Center)
            }
          }
          .width(80)
          .alignItems(HorizontalAlign.Center)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .padding({ left: 30, right: 30 })

        Blank()

        Column({ space: 15 }) {
          Text('Brewing Steps')
            .fontColor('#000000')
            .fontSize(19)
            .fontWeight(FontWeight.Bold)
            .padding({ left: 24, right: 24 })
            .alignSelf(ItemAlign.Start)

          Row({ space: 16 }) {
            // Checkmark Icon
            Image($r('app.media.startIcon'))
              .width(28)
              .height(28)
              .fillColor('#FFFFFF')
              .backgroundColor('#000000')
              .borderRadius(14)
            
            // Step Card
            Rect()
              .width('100%')
              .height(52)
              .backgroundColor('#F2F2F7')
              .borderRadius(10)
          }
          .padding({ left: 24, right: 24 })
        }

        Blank()

        Button() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#FFFFFF')
            
            Text('Start Brewing')
              .fontColor('#FFFFFF')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#000000')
        .borderRadius(28)
        .margin({ left: 24, right: 24, bottom: 30 })
        
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}