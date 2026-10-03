@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  @Builder
  SizeOption(label: string) {
    Stack() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSize === label ? '#6F4E37' : '#000000')
    }
    .width(100)
    .height(48)
    .borderRadius(12)
    .border({ width: 1, color: this.selectedSize === label ? '#6F4E37' : '#E0E0E0' })
    .backgroundColor(this.selectedSize === label ? '#FFF4E0' : '#FFFFFF')
    .onClick(() => {
      this.selectedSize = label;
    })
  }

  build() {
    Column() {
      Row() {
        Button() {
          Text('←')
            .fontSize(24)
            .fontColor('#000000')
        }
        .type(ButtonType.Circle)
        .backgroundColor('#FFFFFF')
        .width(40)
        .height(40)
        .onClick(() => {
        })

        Blank()

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Blank()

        Button() {
          Text(this.isFavorite ? '♥' : '♡')
            .fontSize(22)
            .fontColor(this.isFavorite ? '#FF0000' : '#000000')
        }
        .type(ButtonType.Circle)
        .backgroundColor('#FFFFFF')
        .width(40)
        .height(40)
        .onClick(() => {
          this.isFavorite = !this.isFavorite;
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          Blank().height(16)

          Stack() {
            Text('🛒')
              .fontSize(80)
              .fontColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')

          Blank().height(24)

          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(8)

          Row() {
            Text('★')
              .fontSize(20)
              .fontColor('#FFC107')
            Blank().width(4)
            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Blank().width(4)
            Text('(230 reviews)')
              .fontSize(14)
              .fontColor('#808080')
          }
          .alignItems(VerticalAlign.Center)

          Blank().height(24)

          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(12)

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .fontColor('#808080')
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Blank().height(24)

          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Blank().height(16)

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
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.TopStart)

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
        .alignItems(HorizontalAlign.Start)

        Button() {
          Text('Add to Cart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(200)
        .height(56)
        .borderRadius(16)
        .backgroundColor('#6F4E37')
        .onClick(() => {
        })
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 16, color: '#1A000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
