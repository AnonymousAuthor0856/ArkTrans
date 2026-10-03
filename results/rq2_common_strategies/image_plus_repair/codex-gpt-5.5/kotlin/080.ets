@Entry
@Component
struct MainPage {
  @State private isFavorite: boolean = false
  @State private selectedSize: string = 'M'

  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column() {
          Blank()
            .height(16)

          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width('100%')
              .height(240)
              .borderRadius(32)
              .backgroundColor('#F5F5F5')

            Text('🛒')
              .fontSize(70)
              .fontColor('#DEDEDE')
              .opacity(0.95)
          }
          .width('100%')
          .height(240)

          Blank()
            .height(24)

          Text('Caramel Macchiato')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')

          Row() {
            Text('★')
              .fontSize(25)
              .fontColor('#FFC107')

            Text('4.8')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 8 })

            Text('(230 reviews)')
              .fontSize(14)
              .fontColor('#8E8E8E')
              .margin({ left: 4 })
          }
          .width('100%')
          .height(32)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 8 })

          Blank()
            .height(24)

          Text('Description')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#202124')
            .width('100%')

          Blank()
            .height(12)

          Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
            .fontSize(15)
            .lineHeight(22)
            .fontColor('#8E8E8E')
            .width('100%')
            .maxLines(4)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Blank()
            .height(24)

          Text('Size')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#202124')
            .width('100%')

          Blank()
            .height(16)

          Row() {
            this.sizeOption('S')
            this.sizeOption('M')
            this.sizeOption('L')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank()
            .height(100)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  topBar() {
    Row() {
      Text('‹')
        .fontSize(50)
        .fontWeight(FontWeight.Lighter)
        .fontColor(Color.Black)
        .width(56)
        .height(64)
        .textAlign(TextAlign.Center)
        .onClick(() => {
        })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text(this.isFavorite ? '♥' : '♡')
        .fontSize(42)
        .fontColor(this.isFavorite ? '#E53935' : Color.Black)
        .width(56)
        .height(64)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  sizeOption(label: string) {
    Text(label)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.selectedSize === label ? '#6F4E37' : Color.Black)
      .width(100)
      .height(48)
      .textAlign(TextAlign.Center)
      .padding({ top: 12 })
      .border({
        width: 1,
        color: this.selectedSize === label ? '#6F4E37' : '#E0E0E0',
        radius: 12
      })
      .backgroundColor(this.selectedSize === label ? '#FFF4E0' : Color.White)
      .onClick(() => {
        this.selectedSize = label
      })
  }

  @Builder
  bottomBar() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor('#8E8E8E')
          .width('100%')

        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
          .width('100%')
          .margin({ top: 4 })
      }
      .width(150)
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart', { type: ButtonType.Capsule })
        .width(200)
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor('#6F4E37')
        .borderRadius(16)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(104)
    .padding({ left: 24, right: 24, top: 16, bottom: 16 })
    .backgroundColor('#F7F5F3')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}
