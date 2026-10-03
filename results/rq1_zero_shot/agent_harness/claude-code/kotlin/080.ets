@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Back button
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .margin({ left: 12, right: 12 })
          .onClick(() => {})

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 48 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)

      // Scrollable content
      Scroll() {
        Column() {
          // Image placeholder
          Stack() {
            Image($r('sys.media.ohos_ic_public_shopping_cart'))
              .width(80)
              .height(80)
              .fillColor('#FFE0E0E0')
          }
          .width('100%')
          .height(240)
          .backgroundColor('#FFF5F5F5')
          .borderRadius(32)
          .margin({ top: 16 })

          // Title
          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 24 })

          // Rating row
          Row() {
            Image($r('sys.media.ohos_ic_public_star_full'))
              .width(20)
              .height(20)
              .fillColor('#FFFFC107')

            Text('4.8')
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
              .margin({ left: 4 })

            Text('(230 reviews)')
              .fontColor(Color.Gray)
              .fontSize(14)
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          // Description
          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .margin({ top: 24 })

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontColor(Color.Gray)
            .fontSize(15)
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 12 })

          // Size selection
          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .margin({ top: 24 })

          Row() {
            this.SizeOption('S', this.selectedSize === 'S')
              .onClick(() => { this.selectedSize = 'S' })
            this.SizeOption('M', this.selectedSize === 'M')
              .onClick(() => { this.selectedSize = 'M' })
            this.SizeOption('L', this.selectedSize === 'L')
              .onClick(() => { this.selectedSize = 'L' })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 100 })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(Color.White)

      // Bottom Bar Action
      Row() {
        Column() {
          Text('Price')
            .fontColor(Color.Gray)
            .fontSize(14)

          Text('$ 4.50')
            .fontColor('#FF6F4E37')
            .fontWeight(FontWeight.Bold)
            .fontSize(24)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Add to Cart')
          .width(200)
          .height(56)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .backgroundColor('#FF6F4E37')
          .borderRadius(16)
          .onClick(() => {})
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .shadow({
        radius: 16,
        color: '#1A000000',
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SizeOption(label: string, isSelected: boolean) {
    Stack() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#FF6F4E37' : Color.Black)
    }
    .width(100)
    .height(48)
    .border({
      width: 1,
      color: isSelected ? '#FF6F4E37' : '#FFE0E0E0',
      radius: 12
    })
    .backgroundColor(isSelected ? '#FFFFF4E0' : Color.White)
    .borderRadius(12)
  }
}
