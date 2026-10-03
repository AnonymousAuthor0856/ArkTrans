@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false
  @State selectedSize: string = 'M'
  private sizes: string[] = ['S', 'M', 'L']

  @Builder
  SizeOptionBuilder(label: string) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedSize === label ? '#6F4E37' : '#000000')
      .width(100)
      .height(48)
      .backgroundColor(this.selectedSize === label ? '#FFF4E0' : '#FFFFFF')
      .borderRadius(12)
      .borderWidth(1)
      .borderColor(this.selectedSize === label ? '#6F4E37' : '#E0E0E0')
      .textAlign(TextAlign.Center)
      .onClick(() => {
        this.selectedSize = label
      })
  }

  build() {
    Column() {
      Row() {
        Text('←')
          .fontSize(22)
          .fontColor('#000000')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text(this.isFavorite ? '♥' : '♡')
          .fontSize(22)
          .fontColor(this.isFavorite ? '#FF0000' : '#000000')
          .width(40)
          .height(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.isFavorite = !this.isFavorite
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          Column() {
            Text('🛒')
              .fontSize(64)
              .fontColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .backgroundColor('#F5F5F5')
          .borderRadius(32)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 16 })

          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 24 })

          Row() {
            Text('★')
              .fontSize(18)
              .fontColor('#FFC107')
            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ left: 4 })
            Text('(230 reviews)')
              .fontSize(14)
              .fontColor('#888888')
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 24 })

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .fontColor('#888888')
            .lineHeight(22)
            .margin({ top: 12 })

          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 24 })

          Row() {
            ForEach(this.sizes, (size: string) => {
              this.SizeOptionBuilder(size)
            }, (size: string) => size)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 16, bottom: 100 })
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Column() {
          Text('Price')
            .fontSize(14)
            .fontColor('#888888')
          Text('$ 4.50')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#6F4E37')
        }
        .alignItems(HorizontalAlign.Start)

        Button('Add to Cart') {
          Text('Add to Cart')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
          .type(ButtonType.Normal)
          .backgroundColor('#6F4E37')
          .borderRadius(16)
          .width(200)
          .height(56)
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}