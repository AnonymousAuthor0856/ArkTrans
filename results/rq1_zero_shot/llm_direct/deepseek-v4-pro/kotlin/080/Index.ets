@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false
  @State selectedSize: string = 'M'

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Image($r('sys.media.ohos_ic_back'))
            .width(24)
            .height(24)
        }
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Button({ type: ButtonType.Circle }) {
          Image(this.isFavorite ? $r('sys.media.ohos_ic_heart_filled') : $r('sys.media.ohos_ic_heart'))
            .width(24)
            .height(24)
            .fillColor(this.isFavorite ? Color.Red : Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 8, right: 8 })
      .backgroundColor(Color.White)

      // Main Content
      Scroll() {
        Column() {
          // Image placeholder
          Column() {
            Image($r('sys.media.ohos_ic_cart'))
              .width(80)
              .height(80)
              .fillColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .margin({ top: 16 })

          // Title
          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 24 })

          // Rating Row
          Row() {
            Image($r('sys.media.ohos_ic_star'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')

            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 4 })

            Text('(230 reviews)')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ left: 4 })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          // Description
          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 24 })

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .fontColor(Color.Gray)
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 12 })

          // Size
          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 24 })

          Row() {
            this.SizeOption('S', this.selectedSize === 'S', () => { this.selectedSize = 'S' })
            this.SizeOption('M', this.selectedSize === 'M', () => { this.selectedSize = 'M' })
            this.SizeOption('L', this.selectedSize === 'L', () => { this.selectedSize = 'L' })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 16 })

          // Bottom spacing
          Blank()
            .height(100)
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
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

        Blank()
          .layoutWeight(1)

        Button('Add to Cart') {
          // Add to cart action
        }
        .width(200)
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .backgroundColor('#6F4E37')
        .fontColor(Color.White)
        .borderRadius(16)
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .shadow({ radius: 16, color: '#1A000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SizeOption(label: string, isSelected: boolean, onClick: () => void) {
    Text(label)
      .width(100)
      .height(48)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? '#6F4E37' : Color.Black)
      .backgroundColor(isSelected ? '#FFF4E0' : Color.White)
      .borderRadius(12)
      .border({
        width: 1,
        color: isSelected ? '#6F4E37' : '#E0E0E0'
      })
      .textAlign(TextAlign.Center)
      .onClick(() => {
        onClick()
      })
  }
}