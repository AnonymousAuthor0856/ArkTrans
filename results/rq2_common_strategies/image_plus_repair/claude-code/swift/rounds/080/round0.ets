@Entry
@Component
struct CoffeeDetailPage {
  build() {
    Stack() {
      Column() {
        // Header Bar
        Row() {
          // Back button
          Circle()
            .fill(Color.White)
            .stroke('#E0E0E0', 1)
            .width(48)
            .height(48)
            .overlay(
              Image($r('sys.media.ohos_ic_public_arrow_left'))
                .width(20)
                .height(20)
                .fillColor(Color.Black)
            )

          Text('Details')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          // Heart button
          Circle()
            .fill(Color.White)
            .stroke('#E0E0E0', 1)
            .width(48)
            .height(48)
            .overlay(
              Image($r('sys.media.ohos_ic_public_heart'))
                .width(20)
                .height(20)
                .fillColor(Color.Black)
            )
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column() {
            // Product Image Placeholder
            Stack() {
              RoundRect()
                .fill('#F5F5F5')
                .cornerRadius(32)
                .width('100%')
                .height(300)

              Image($r('sys.media.ohos_ic_public_shopping_cart'))
                .width(80)
                .height(80)
                .fillColor('#BDBDBD')
            }
            .width('100%')
            .margin({ top: 24 })

            // Product Title
            Text('Caramel Macchiato')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .width('100%')
              .margin({ top: 32 })

            // Rating Row
            Row() {
              Image($r('sys.media.ohos_ic_public_star_full'))
                .width(20)
                .height(20)
                .fillColor('#FFC107')

              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ left: 4 })

              Text('(230 reviews)')
                .fontSize(16)
                .fontColor('#9E9E9E')
                .margin({ left: 8 })
            }
            .width('100%')
            .margin({ top: 12 })

            // Description Section
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color.Black)
              .width('100%')
              .margin({ top: 24 })

            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee with the sweetness of caramel.')
              .fontSize(16)
              .fontColor('#9E9E9E')
              .width('100%')
              .margin({ top: 12 })
              .lineHeight(28)

            Blank()
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // Bottom Action Section
        Row() {
          Column() {
            Text('Price')
              .fontSize(16)
              .fontColor('#9E9E9E')

            Text('$ 4.50')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#795548')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Button('Add to Cart')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor('#795548')
            .borderRadius(28)
            .height(56)
            .layoutWeight(1)
            .margin({ left: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24, top: 16 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }
}
