@Entry
@Component
struct FurnitureDetailPage {
  @Builder
  HeaderBar() {
    Row() {
      Stack() {
        Text('←')
          .fontSize(24)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
      .alignContent(Alignment.Center)
      .onClick(() => {})

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')

      Stack() {
        Text('♡')
          .fontSize(24)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
      .alignContent(Alignment.Center)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack() {
      Text('🛒')
        .fontSize(80)
        .fontColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
    .alignContent(Alignment.Center)
  }

  @Builder
  ColorSelector(color: string, isSelected: boolean) {
    Stack() {
      if (isSelected) {
        Stack() {}
        .width(10)
        .height(10)
        .borderRadius(5)
        .backgroundColor('#FFFFFF')
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(color)
    .border({ width: isSelected ? 2 : 0, color: '#CCCCCC', radius: 16 })
    .alignContent(Alignment.Center)
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .lineHeight(32)
          Blank().height(8)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#888888')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Blank().height(24)

      Row() {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')
        Blank().width(4)
        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Blank().width(8)
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor('#888888')
      }
      .alignItems(VerticalAlign.Center)

      Blank().height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')

      Blank().height(12)

      Row() {
        this.ColorSelector('#212121', true)
        Blank().width(12)
        this.ColorSelector('#795548', false)
        Blank().width(12)
        this.ColorSelector('#9E9E9E', false)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionSection() {
    Row() {
      Button() {
        Text('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
      }
      .height(56)
      .layoutWeight(1)
      .borderRadius(16)
      .backgroundColor('#000000')
      .onClick(() => {})

      Blank().width(16)

      Stack() {
        Text('♥')
          .fontSize(24)
          .fontColor('#000000')
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .alignContent(Alignment.Center)
    }
    .width('100%')
  }

  build() {
    Column() {
      this.HeaderBar()
      Blank().height(24)
      this.ProductImagePlaceholder()
      Blank().height(32)
      this.ProductInfoSection()
      Blank().layoutWeight(1)
      this.BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}
