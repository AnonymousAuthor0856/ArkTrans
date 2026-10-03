@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Header Row
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .backgroundColor(Color.White)
          .borderRadius(50)
          .border({ width: 1, color: '#E0E0E0' })
          .width(48)
          .height(48)

          Text('Details')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .backgroundColor(Color.White)
          .borderRadius(50)
          .border({ width: 1, color: '#E0E0E0' })
          .width(48)
          .height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })

        Scroll() {
          Column() {
            // Product Image Placeholder
            Column() {
              Image($r('app.media.startIcon'))
                .width(120)
                .height(120)
                .fillColor('#CCCCCC')
            }
            .width('100%')
            .height(300)
            .backgroundColor('#F5F5F5')
            .borderRadius(32)
            .margin({ top: 16, left: 24, right: 24 })

            // Title and Price Row
            Row() {
              Column() {
                Text('Modern Lounge Chair')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
                  .lineHeight(36)
                
                Text('Minimalist Series')
                  .fontSize(16)
                  .fontColor('#999999')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Text('$1299')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 24 })

            // Rating Row
            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor('#FFC107')
              
              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ left: 4 })

              Text('(238 Reviews)')
                .fontSize(14)
                .fontColor('#999999')
                .margin({ left: 4 })
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 16 })
            
            Blank().height(20)
          }
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // Bottom Action Bar
      Row() {
        Button('Add to Cart')
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(16)
          .height(56)
          .layoutWeight(1)
          .margin({ right: 16 })

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .width(56)
        .height(56)
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24, top: 16 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -80 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}