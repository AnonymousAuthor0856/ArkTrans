// index.ets
// ArkTS conversion of the Kotlin Compose CoffeeDetailScreen (HarmonyOS / ArkUI)

@Entry
@Component
struct CoffeeDetailPage {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  @Builder
  TopBar() {
    Row() {
      SymbolGlyph($r('sys.symbol.arrow_left'))
        .fontSize(24)
        .fontColor([Color.Black])
        .onClick(() => {
          // back navigation
        })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      SymbolGlyph(this.isFavorite ? $r('sys.symbol.heart_fill') : $r('sys.symbol.heart'))
        .fontSize(24)
        .fontColor([this.isFavorite ? Color.Red : Color.Black])
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  @Builder
  SizeOption(label: string, isSelected: boolean) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#6F4E37' : Color.Black)
      .textAlign(TextAlign.Center)
      .width(100)
      .height(48)
      .borderRadius(12)
      .borderWidth(isSelected ? 1 : 1)
      .borderColor(isSelected ? '#6F4E37' : '#E0E0E0')
      .backgroundColor(isSelected ? '#FFF4E0' : Color.White)
      .onClick(() => {
        this.selectedSize = label;
      })
  }

  @Builder
  BottomBarAction() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor(Color.Gray)

        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.White)
        .backgroundColor('#6F4E37')
        .borderRadius(16)
        .width(200)
        .height(56)
        .onClick(() => {
          // add to cart
        })
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({ radius: 24, color: 'rgba(0, 0, 0, 0.10)', offsetX: 0, offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          // ---- Hero image placeholder ----
          Stack() {
            SymbolGlyph($r('sys.symbol.cart'))
              .fontSize(80)
              .fontColor(['#E0E0E0'])
          }
          .width('100%')
          .height(240)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')
          .margin({ top: 16 })

          // ---- Title + rating ----
          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .margin({ top: 24 })

          Row() {
            SymbolGlyph($r('sys.symbol.star_fill'))
              .fontSize(20)
              .fontColor(['#FFC107'])

            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 4 })

            Text('(230 reviews)')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ left: 4 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          // ---- Description ----
          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
            .width('100%')
            .margin({ top: 24 })

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .fontColor(Color.Gray)
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .margin({ top: 12 })

          // ---- Size selector ----
          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
            .width('100%')
            .margin({ top: 24 })

          Row() {
            this.SizeOption('S', this.selectedSize === 'S')
            this.SizeOption('M', this.selectedSize === 'M')
            this.SizeOption('L', this.selectedSize === 'L')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 16, bottom: 100 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}