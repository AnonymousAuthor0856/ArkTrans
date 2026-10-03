@Entry
@Component
struct CoffeeDetailScreen {
  @State isFavorite: boolean = false
  @State selectedSize: string = 'M'

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('←')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .padding({ left: 16 })
          .onClick(() => {})

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text(this.isFavorite ? '♥' : '♡')
          .fontSize(22)
          .fontColor(this.isFavorite ? Color.Red : Color.Black)
          .padding({ right: 16 })
          .onClick(() => {
            this.isFavorite = !this.isFavorite
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(Color.White)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Image Placeholder
          Stack() {
            Text('🛒')
              .fontSize(60)
              .fontColor('#E0E0E0')
          }
          .width('100%')
          .height(240)
          .backgroundColor('#F5F5F5')
          .borderRadius(32)
          .alignContent(Alignment.Center)

          // Title
          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 24 })
            .width('100%')

          // Rating Row
          Row() {
            Text('★')
              .fontSize(20)
              .fontColor('#FFC107')
            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .margin({ left: 4 })
            Text('(230 reviews)')
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ left: 4 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          // Description Section
          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 24 })
            .width('100%')

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .fontColor(Color.Gray)
            .lineHeight(22)
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ top: 12 })
            .width('100%')

          // Size Section
          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 24 })
            .width('100%')

          Row() {
            this.SizeOption('S')
            this.SizeOption('M')
            this.SizeOption('L')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 16 })

          // Bottom spacer
          Column()
            .height(100)
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
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
        .alignItems(HorizontalAlign.Start)

        Button('Add to Cart')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .backgroundColor('#6F4E37')
          .borderRadius(16)
          .width(200)
          .height(56)
          .onClick(() => {})
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.White)
      .shadow({ radius: 16, color: '#22000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SizeOption(label: string) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedSize === label ? '#6F4E37' : Color.Black)
      .width(100)
      .height(48)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.selectedSize === label ? '#FFF4E0' : Color.White)
      .border({
        width: 1,
        color: this.selectedSize === label ? '#6F4E37' : '#E0E0E0',
        radius: 12
      })
      .onClick(() => {
        this.selectedSize = label
      })
  }
}