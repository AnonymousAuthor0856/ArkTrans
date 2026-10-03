@Entry
@Component
struct Index {
  @State private isFavorite: boolean = false
  @State private selectedSize: string = 'M'

  @Builder
  private TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Row() {
        Text('←')
          .fontSize(38)
          .fontColor(Color.Black)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .onClick(() => {
          })

        Text(this.isFavorite ? '♥' : '♡')
          .fontSize(this.isFavorite ? 36 : 46)
          .fontColor(this.isFavorite ? Color.Red : Color.Black)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.isFavorite = !this.isFavorite
          })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 28, right: 28 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(104)
    .padding({ top: 24 })
    .backgroundColor(Color.White)
  }

  @Builder
  private SizeOption(label: string, isSelected: boolean) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#6F4E37' : Color.Black)
    }
    .width(100)
    .height(48)
    .border({
      width: 1,
      color: isSelected ? '#6F4E37' : '#E0E0E0',
      radius: 12
    })
    .borderRadius(12)
    .backgroundColor(isSelected ? '#FFF4E0' : Color.White)
    .onClick(() => {
      this.selectedSize = label
    })
  }

  @Builder
  private BottomBarAction() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor('#8A8A8A')

        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('Add to Cart')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .type(ButtonType.Normal)
      .width(200)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#6F4E37')
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({
      radius: 16,
      color: '#16000000',
      offsetX: 0,
      offsetY: -4
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column() {
            Blank()
              .height(16)

            Stack({ alignContent: Alignment.Center }) {
              Text('🛒')
                .fontSize(78)
                .fontColor('#E0E0E0')
                .opacity(0.8)
            }
            .width('100%')
            .height(240)
            .borderRadius(32)
            .backgroundColor('#F5F5F5')

            Blank()
              .height(24)

            Text('Caramel Macchiato')
              .width('100%')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Blank()
              .height(8)

            Row() {
              Text('★')
                .fontSize(24)
                .fontColor('#FFC107')
                .width(24)
                .height(24)
                .textAlign(TextAlign.Center)

              Blank()
                .width(4)

              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)

              Blank()
                .width(4)

              Text('(230 reviews)')
                .fontSize(14)
                .fontColor('#8A8A8A')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Blank()
              .height(24)

            Text('Description')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Blank()
              .height(12)

            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
              .width('100%')
              .fontSize(15)
              .fontColor('#8A8A8A')
              .lineHeight(22)
              .maxLines(4)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Blank()
              .height(24)

            Text('Size')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Blank()
              .height(16)

            Row() {
              this.SizeOption('S', this.selectedSize === 'S')
              this.SizeOption('M', this.selectedSize === 'M')
              this.SizeOption('L', this.selectedSize === 'L')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Blank()
              .height(120)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}