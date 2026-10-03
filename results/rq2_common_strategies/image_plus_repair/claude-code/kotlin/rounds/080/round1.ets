@Entry
@Component
struct CoffeeDetailPage {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            // Product image placeholder
            Stack({ alignContent: Alignment.Center }) {
              Image($r('sys.media.ohos_ic_public_add'))
                .width(80)
                .height(80)
                .fillColor('#E0E0E0')
                .objectFit(ImageFit.Contain)
            }
            .width('100%')
            .height(240)
            .backgroundColor('#F5F5F5')
            .borderRadius(32)
            .margin({ top: 16 })

            // Title
            Text('Caramel Macchiato')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width('100%')
              .margin({ top: 24 })

            // Rating
            Row() {
              Image($r('sys.media.ohos_ic_public_arrow_right'))
                .width(20)
                .height(20)
                .fillColor('#FFC107')
                .objectFit(ImageFit.Contain)
              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .margin({ left: 4 })
              Text('(230 reviews)')
                .fontSize(14)
                .fontColor('#999999')
                .margin({ left: 4 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin({ top: 8 })

            // Description
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width('100%')
              .margin({ top: 24 })

            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
              .fontSize(15)
              .fontColor('#999999')
              .width('100%')
              .lineHeight(22)
              .maxLines(4)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 12 })

            // Size
            Text('Size')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .width('100%')
              .margin({ top: 24 })

            Row() {
              this.SizeOption('S', this.selectedSize === 'S', () => { this.selectedSize = 'S'; })
              this.SizeOption('M', this.selectedSize === 'M', () => { this.selectedSize = 'M'; })
              this.SizeOption('L', this.selectedSize === 'L', () => { this.selectedSize = 'L'; })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 16 })

            // Bottom spacer
            Blank()
              .height(120)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')

      // Bottom bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Row() {
        Image($r('sys.media.ohos_ic_public_arrow_left'))
          .width(24)
          .height(24)
          .fillColor('#000000')
          .objectFit(ImageFit.Contain)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .padding({ left: 8 })

      Row() {
        if (this.isFavorite) {
          Image($r('sys.media.ohos_ic_public_heart_like'))
            .width(24)
            .height(24)
            .fillColor('#FF0000')
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              this.isFavorite = false;
            })
        } else {
          Image($r('sys.media.ohos_ic_public_heart_white'))
            .width(24)
            .height(24)
            .fillColor('#000000')
            .objectFit(ImageFit.Contain)
            .onClick(() => {
              this.isFavorite = true;
            })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 16 })
    }
    .width('100%')
    .height(56)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SizeOption(label: string, isSelected: boolean, onClick: () => void) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#6F4E37' : '#000000')
    }
    .width(100)
    .height(48)
    .backgroundColor(isSelected ? '#FFF4E0' : '#FFFFFF')
    .border({
      width: 1,
      color: isSelected ? '#6F4E37' : '#E0E0E0',
      radius: 12
    })
    .borderRadius(12)
    .onClick(() => onClick())
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor('#999999')
        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#6F4E37')
        .borderRadius(16)
        .width(200)
        .height(56)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .shadow({
      radius: 16,
      color: '#1A000000',
      offsetY: -2
    })
  }
}
