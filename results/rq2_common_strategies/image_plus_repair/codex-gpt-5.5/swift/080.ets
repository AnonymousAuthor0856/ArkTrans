@Entry
@Component
struct Swift080 {
  build() {
    Column() {
      this.HeaderBar()

      Scroll() {
        Column() {
          Blank().height(12)
          this.ProductImagePlaceholder()
          Blank().height(28)
          this.ProductInfoSection()
          Blank().height(28)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderBar() {
    Row() {
      Text('‹')
        .fontSize(48)
        .fontWeight(FontWeight.Regular)
        .fontColor('#000000')
        .width(56)
        .height(56)
        .textAlign(TextAlign.Center)
        .lineHeight(50)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('♡')
        .fontSize(40)
        .fontWeight(FontWeight.Regular)
        .fontColor('#000000')
        .width(56)
        .height(56)
        .textAlign(TextAlign.Center)
        .lineHeight(54)
    }
    .width('100%')
    .height(68)
    .padding({ left: 20, right: 20, top: 10 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack() {
      Text('🛒')
        .fontSize(72)
        .fontColor('#DEDEDE')
        .opacity(0.55)
    }
    .width('100%')
    .height(240)
    .borderRadius(34)
    .backgroundColor('#F6F6F6')
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Text('Caramel Macchiato')
        .fontSize(29)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .lineHeight(36)
        .width('100%')

      Row() {
        Text('★')
          .fontSize(28)
          .fontColor('#FFC107')
          .height(34)
          .lineHeight(34)

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ left: 6 })

        Text('(230 reviews)')
          .fontSize(15)
          .fontColor('#8E8E93')
          .margin({ left: 8 })
      }
      .height(42)
      .margin({ top: 8 })
      .alignItems(VerticalAlign.Center)

      Text('Description')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 28 })

      Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffe...')
        .fontSize(16)
        .fontColor('#8E8E93')
        .lineHeight(24)
        .margin({ top: 18 })
        .maxLines(4)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionSection() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(15)
          .fontColor('#8E8E93')
          .lineHeight(22)

        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#79543C')
          .lineHeight(34)
      }
      .alignItems(HorizontalAlign.Start)
      .width(118)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .height(56)
        .layoutWeight(1)
        .backgroundColor('#7B563D')
        .borderRadius(16)
    }
    .width('100%')
    .height(100)
    .padding({ left: 24, right: 24, top: 18, bottom: 18 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({ radius: 18, color: '#12000000', offsetX: 0, offsetY: -5 })
  }
}
