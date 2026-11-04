@Entry
@Component
struct Index {
  build() {
    Column() {
      this.HeaderBar()
      this.ProductImagePlaceholder()
      this.ProductInfoSection()
      Blank()
      this.BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderBar() {
    Row() {
      Button('‹')
        .fontSize(30)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .width(48)
        .height(48)
        .padding(0)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Button('♡')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack() {
      Text('▣')
        .fontSize(82)
        .fontColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
    .margin({ top: 24 })
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row() {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')
        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 4 })
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })

      Text('Colors')
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 24 })

      Row() {
        this.ColorSelector('#212121', true)
        this.ColorSelector('#795548', false)
        this.ColorSelector('#9E9E9E', false)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 12 })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  ColorSelector(color: string, selected: boolean) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
        .border({ width: selected ? 2 : 0, color: '#D3D3D3' })
      if (selected) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .margin({ right: 12 })
  }

  @Builder
  BottomActionSection() {
    Row() {
      Button('Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .height(56)
        .layoutWeight(1)
        .borderRadius(16)
        .backgroundColor(Color.Black)

      Stack() {
        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .margin({ left: 16 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}
