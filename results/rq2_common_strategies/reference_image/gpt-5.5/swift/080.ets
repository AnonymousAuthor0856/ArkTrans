@Entry
@Component
struct FurnitureApp {
  build() {
    Column() {
      FurnitureDetailScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      HeaderBar()
        .padding({
          left: 24,
          right: 24,
          top: 16
        })

      Scroll() {
        Column() {
          ProductImagePlaceholder()
            .margin({ top: 24 })

          ProductInfoSection()
            .margin({ top: 28, bottom: 24 })
        }
        .width('100%')
        .padding({
          left: 24,
          right: 24
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Text('←')
          .fontSize(36)
          .fontColor('#000000')
          .fontWeight(FontWeight.Regular)
      }
      .width(48)
      .height(48)

      Blank()

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Text('♡')
          .fontSize(40)
          .fontColor('#000000')
          .fontWeight(FontWeight.Regular)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .height(48)
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('🛒')
        .fontSize(72)
        .fontColor('#DADADA')
        .opacity(0.55)
    }
    .width('100%')
    .height(240)
    .backgroundColor('#F5F5F5')
    .borderRadius(32)
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column() {
      Text('Caramel Macchiato')
        .width('100%')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .lineHeight(36)

      Row({ space: 8 }) {
        Text('★')
          .fontSize(26)
          .fontColor('#FFC107')
          .fontWeight(FontWeight.Bold)

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text('(230 reviews)')
          .fontSize(15)
          .fontColor('#8F8F95')
      }
      .width('100%')
      .height(36)
      .margin({ top: 8 })

      Text('Description')
        .fontSize(19)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ top: 26 })

      Text('A Caramel Macchiato is a coffee drink that\ncontains espresso, steamed milk, vanilla syrup\nand caramel drizzle. It is a sweet and creamy\nbeverage that balances the rich flavor of coffe...')
        .fontSize(15)
        .fontColor('#8F8F95')
        .lineHeight(24)
        .margin({ top: 16 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomActionSection {
  build() {
    Column() {
      Divider()
        .width('100%')
        .height(1)
        .color('#F0F0F0')

      Row() {
        Column() {
          Text('Price')
            .fontSize(15)
            .fontColor('#8F8F95')

          Text('$ 4.50')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#7A563D')
            .margin({ top: 6 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Stack({ alignContent: Alignment.Center }) {
          Text('Add to Cart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(200)
        .height(56)
        .backgroundColor('#7A563D')
        .borderRadius(16)
        .onClick(() => {
        })
      }
      .width('100%')
      .height(104)
      .padding({
        left: 24,
        right: 24,
        top: 22,
        bottom: 24
      })
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }
}