@Entry
@Component
struct MainActivity {
  @Builder
  HeaderBar() {
    Row() {
      Text('‹')
        .fontSize(28)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')

      Text('♡')
        .fontSize(24)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Text('🛒')
      .fontSize(80)
      .fontColor('#BDBDBD')
      .textAlign(TextAlign.Center)
      .width('100%')
      .height(300)
      .lineHeight(300)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)
  }

  @Builder
  ColorSelector(color: string, selected: boolean) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
        .stroke(selected ? '#D3D3D3' : Color.Transparent)
        .strokeWidth(selected ? 2 : 0)
      if (selected) {
        Circle()
          .width(10)
          .height(10)
          .fill('#FFFFFF')
      }
    }
    .width(32)
    .height(32)
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
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#808080')
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row({ space: 4 }) {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')
        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor('#808080')
          .margin({ left: 4 })
      }
      .width('100%')
      .margin({ top: 24 })
      .alignItems(VerticalAlign.Center)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#000000')
        .width('100%')
        .margin({ top: 24, bottom: 12 })

      Row({ space: 12 }) {
        this.ColorSelector('#212121', true)
        this.ColorSelector('#795548', false)
        this.ColorSelector('#9E9E9E', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  BottomActionSection() {
    Row({ space: 16 }) {
      Button('Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .layoutWeight(1)
        .height(56)
        .backgroundColor('#000000')
        .borderRadius(16)

      Text('♥')
        .fontSize(24)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
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
