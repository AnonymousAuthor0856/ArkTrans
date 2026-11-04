class SizeChoice {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

@Entry
@Component
struct Index {
  @State isFavorite: boolean = false
  @State selectedSize: string = 'M'

  private sizes: SizeChoice[] = [
    new SizeChoice('S'),
    new SizeChoice('M'),
    new SizeChoice('L')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            Stack() {
              Text('☕')
                .fontSize(82)
                .fontColor('#E0E0E0')
            }
            .width('100%')
            .height(240)
            .borderRadius(32)
            .backgroundColor('#F5F5F5')
            .margin({ top: 16 })

            Text('Caramel Macchiato')
              .width('100%')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })

            Row() {
              Text('★')
                .fontSize(20)
                .fontColor('#FFC107')
              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ left: 4 })
              Text('(230 reviews)')
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({ left: 4 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin({ top: 8 })

            Text('Description')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })
            Text('A Caramel Macchiato is a coffee drink that contains espresso, steamed milk, vanilla syrup and caramel drizzle. It is a sweet and creamy beverage that balances the rich flavor of coffee.')
              .width('100%')
              .fontSize(15)
              .fontColor(Color.Gray)
              .lineHeight(22)
              .maxLines(4)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({ top: 12 })

            Text('Size')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })
            Row() {
              ForEach(this.sizes, (size: SizeChoice) => {
                this.SizeOption(size.label)
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 16, bottom: 116 })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      this.BottomBarAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Button('‹')
        .fontSize(30)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(56)
        .padding(0)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Button(this.isFavorite ? '♥' : '♡')
        .fontSize(24)
        .fontColor(this.isFavorite ? Color.Red : Color.Black)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(56)
        .padding(0)
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 8, right: 8 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
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
      .border({ width: 1, color: this.selectedSize === label ? '#6F4E37' : '#E0E0E0', radius: 12 })
      .backgroundColor(this.selectedSize === label ? '#FFF4E0' : Color.White)
      .onClick(() => {
        this.selectedSize = label
      })
  }

  @Builder
  BottomBarAction() {
    Row() {
      Column() {
        Text('Price')
          .fontSize(14)
          .fontColor(Color.Gray)
        Text('$ 4.50')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#6F4E37')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Add to Cart')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width(200)
        .height(56)
        .borderRadius(16)
        .backgroundColor('#6F4E37')
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({ radius: 16, color: 'rgba(0,0,0,0.14)', offsetY: -4 })
  }
}
