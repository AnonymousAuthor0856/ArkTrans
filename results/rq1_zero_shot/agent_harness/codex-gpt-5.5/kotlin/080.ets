@Entry
@Component
struct MainActivity {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  @Builder
  TopBar() {
    Row() {
      Text('‹')
        .fontSize(28)
        .fontColor('#000000')
        .width(44)
        .textAlign(TextAlign.Center)
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
      Text(this.isFavorite ? '♥' : '♡')
        .fontSize(24)
        .fontColor(this.isFavorite ? '#FF0000' : '#000000')
        .width(44)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SizeOption(label: string) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedSize === label ? '#6F4E37' : '#000000')
      .textAlign(TextAlign.Center)
      .width(100)
      .height(48)
      .lineHeight(48)
      .backgroundColor(this.selectedSize === label ? '#FFF4E0' : '#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: this.selectedSize === label ? '#6F4E37' : '#E0E0E0' })
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
          .fontColor('#808080')
        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#FFFFFF')
        .width(200)
        .height(56)
        .backgroundColor('#6F4E37')
        .borderRadius(16)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 16, color: '#33000000', offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          Blank().height(16)

          Text('🛒')
            .fontSize(80)
            .fontColor('#E0E0E0')
            .textAlign(TextAlign.Center)
            .width('100%')
            .height(240)
            .lineHeight(240)
            .backgroundColor('#F5F5F5')
            .borderRadius(32)

          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .margin({ top: 24 })

          Row({ space: 4 }) {
            Text('★')
              .fontSize(20)
              .fontColor('#FFC107')
            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('(230 reviews)')
              .fontSize(14)
              .fontColor('#808080')
          }
          .width('100%')
          .margin({ top: 8 })
          .alignItems(VerticalAlign.Center)

          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
            .width('100%')
            .margin({ top: 24, bottom: 12 })

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .fontColor('#808080')
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')

          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#000000')
            .width('100%')
            .margin({ top: 24, bottom: 16 })

          Row() {
            this.SizeOption('S')
            this.SizeOption('M')
            this.SizeOption('L')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(100)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
