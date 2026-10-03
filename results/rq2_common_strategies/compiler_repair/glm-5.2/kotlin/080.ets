// Index.ets
@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedSize: string = 'M';

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r('sys.media.ohos_ic_back'))
          .width(24)
          .height(24)
          .fillColor('#000000')
          .margin({ left: 16 })
          .onClick(() => {})
        
        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        
        Image(this.isFavorite ? $r('sys.media.ohos_ic_public_thumbs_up') : $r('sys.media.ohos_ic_public_thumbs_up'))
          .width(24)
          .height(24)
          .fillColor(this.isFavorite ? '#FF0000' : '#000000')
          .margin({ right: 16 })
          .onClick(() => {
            this.isFavorite = !this.isFavorite;
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFF')

      // Scrollable Content
      Scroll() {
        Column() {
          // Image Placeholder
          Row() {
            Image($r('sys.media.ohos_ic_public_search'))
              .width(80)
              .height(80)
              .fillColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16 })

          // Title and Rating
          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ top: 24, bottom: 8 })
            .width('100%')

          Row() {
            Image($r('sys.media.ohos_ic_public_search'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')
            
            Text('4.8')
              .fontWeight(FontWeight.Bold)
              .fontSize(16)
              .fontColor('#000000')
              .margin({ left: 4 })

            Text('(230 reviews)')
              .fontColor('#808080')
              .fontSize(14)
              .margin({ left: 4 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // Description
          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 24, bottom: 12 })
            .width('100%')

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontColor('#808080')
            .fontSize(15)
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')

          // Size Selection
          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .margin({ top: 24, bottom: 16 })
            .width('100%')

          Row() {
            this.SizeOption('S', this.selectedSize === 'S')
            this.SizeOption('M', this.selectedSize === 'M')
            this.SizeOption('L', this.selectedSize === 'L')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(100)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Bar
      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder SizeOption(label: string, isSelected: boolean) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#6F4E37' : '#000000')
      .width(100)
      .height(48)
      .textAlign(TextAlign.Center)
      .borderRadius(12)
      .backgroundColor(isSelected ? '#FFF4E0' : '#FFFFFF')
      .border({ width: 1, color: isSelected ? '#6F4E37' : '#E0E0E0', radius: 12 })
      .onClick(() => {
        this.selectedSize = label;
      })
  }

  @Builder BottomBarAction() {
    Row() {
      Column() {
        Text('Price')
          .fontColor('#808080')
          .fontSize(14)
        
        Text('$ 4.50')
          .fontColor('#6F4E37')
          .fontWeight(FontWeight.Bold)
          .fontSize(24)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#6F4E37')
        .width(200)
        .height(56)
        .borderRadius(16)
        .onClick(() => {})
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 16, color: 'rgba(0,0,0,0.1)', offsetY: -4 })
  }
}