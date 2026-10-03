const Colors = {
  primary: '#6F4E37',
  secondary: '#D2B48C',
  background: '#FFFFFF',
  surface: '#FFFFFF',
  onSurface: '#000000'
};

const sizeOptions: string[] = ['S', 'M', 'L'];

@Entry
@Component
struct Index {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  @Builder
  sizeOption(label: string) {
    Stack() {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSize === label ? Colors.primary : '#000000')
    }
    .width(100)
    .height(48)
    .backgroundColor(this.selectedSize === label ? '#FFF4E0' : '#FFFFFF')
    .border({ width: 1, color: this.selectedSize === label ? Colors.primary : '#E0E0E0' })
    .borderRadius(12)
    .onClick(() => {
      this.selectedSize = label;
    })
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text('←')
            .fontSize(22)
            .fontColor('#000000')
        }
        .width(40)
        .height(40)
        .onClick(() => {
        })

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Stack() {
          Text(this.isFavorite ? '♥' : '♡')
            .fontSize(22)
            .fontColor(this.isFavorite ? '#FF0000' : '#000000')
        }
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
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
              .fontColor('#000000')
            Blank().width(4)
            Text('(230 reviews)')
              .fontColor('#808080')
              .fontSize(14)
          }
          .alignItems(VerticalAlign.Center)

          Blank().height(24)

          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Blank().height(12)
          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontColor('#808080')
            .fontSize(15)
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
            ForEach(sizeOptions, (label: string) => {
              this.sizeOption(label)
            }, (label: string) => label)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(100)
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)

      Row() {
        Column() {
          Text('Price')
            .fontColor('#808080')
            .fontSize(14)
          Text('$ 4.50')
            .fontColor(Colors.primary)
            .fontWeight(FontWeight.Bold)
            .fontSize(24)
        }
        Button('Add to Cart')
          .width(200)
          .height(56)
          .backgroundColor(Colors.primary)
          .fontColor('#FFFFFF')
          .borderRadius(16)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 16, color: '#33000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
