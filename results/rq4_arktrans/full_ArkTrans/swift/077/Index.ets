@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Top Navigation Bar
        Row() {
          // Back Button
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .fillColor('#1C1B1F')
          }
          .width(48)
          .height(48)
          .backgroundColor(Color.White)
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)

          Blank()

          // Favorite Button
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .fillColor('#1C1B1F')
          }
          .width(48)
          .height(48)
          .backgroundColor(Color.White)
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 56, bottom: 16 })

        // Main Content Area
        Column() {
          // Product Image Container (The large rounded rectangle with the circle inside)
          Column() {
            // The floating white circle with the house icon
            Row() {
              Image($r('app.media.startIcon'))
                .width(120)
                .height(120)
                .objectFit(ImageFit.Contain)
                .fillColor('#EAAA93')
            }
            .width(240)
            .height(240)
            .backgroundColor(Color.White)
            .borderRadius(120)
            .shadow({ radius: 24, color: '#20000000', offsetY: 10 })
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#EAEAEA')
          .borderRadius({ topLeft: 40, topRight: 40 })
          .justifyContent(FlexAlign.Center)

          // Details Section
          Column() {
            // Title and Rating Row
            Row() {
              Text('Modern Lounge')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#1C1B1F')
                .maxLines(1)
              
              Blank()

              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#FFD700')
                
                Text('4.8')
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1C1B1F')
                  .margin({ left: 4 })
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            Text('Armchair')
              .fontSize(24)
              .fontColor('#757575')
              .margin({ top: 4 })

            // Description Section
            Column() {
              Text('Description')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1C1B1F')
                .margin({ top: 24 })

              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium')
                .fontSize(16)
                .fontColor('#757575')
                .lineHeight(24)
                .margin({ top: 8 })
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 24, bottom: 100 }) // Bottom padding to account for fixed footer
        }
        .layoutWeight(1)
        .backgroundColor('#F5F5F7')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // Fixed Bottom Footer
      Row() {
        Column() {
          Text('Total Price')
            .fontSize(16)
            .fontColor('#757575')
          
          Text('$245')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1C1B1F')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // Add to Cart Button
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.White)
          
          Text('Add to Cart')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
        .width(200)
        .height(56)
        .backgroundColor('#333333')
        .borderRadius(28)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 32, top: 16 })
      .backgroundColor(Color.White)
      .shadow({ radius: 20, color: '#10000000', offsetY: -5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}