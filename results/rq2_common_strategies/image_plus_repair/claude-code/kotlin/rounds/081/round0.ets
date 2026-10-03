@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  private colors: Color[] = [Color.Black, 0xFF795548, Color.Gray];

  build() {
    Column() {
      this.HeaderBar()

      Column() {
        this.ProductImagePlaceholder()

        Column() {
          this.ProductInfoSection()

          Column()
            .layoutWeight(1)

          this.BottomActionSection()
        }
        .width('100%')
        .margin({ top: 32 })
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
  }

  @Builder
  HeaderBar() {
    Row() {
      CircleIconButton($r('sys.media.ohos_ic_public_arrow_left'))

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      CircleIconButton($r('sys.media.ohos_ic_public_heart_n'))
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CircleIconButton(icon: Resource) {
    Image(icon)
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: 0xFFE0E0E0 })
      .padding(12)
      .fillColor(Color.Black)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack({ alignContent: Alignment.Center }) {
      Image($r('sys.media.ohos_ic_public_shopping_cart'))
        .width(80)
        .height(80)
        .fillColor(0xFFBDBDBD)
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor(0xFFF5F5F5)
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
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Row() {
        Image($r('sys.media.ohos_ic_public_star'))
          .width(20)
          .height(20)
          .fillColor(0xFFFFC107)

        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 4 })

        Text('(238 Reviews)')
          .fontColor(Color.Gray)
          .fontSize(14)
          .margin({ left: 8 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
        .margin({ top: 24 })

      Row() {
        ForEach(this.colors, (color: Color, index: number) => {
          this.ColorSelector(color, index === this.selectedColorIndex)
            .onClick(() => {
              this.selectedColorIndex = index;
            })
        }, (color: Color, index: number) => index.toString())
      }
      .width('100%')
      .margin({ top: 12 })
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
  }

  @Builder
  ColorSelector(color: Color, isSelected: boolean) {
    Stack({ alignContent: Alignment.Center }) {
      if (isSelected) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(color)
    .margin({ right: 12 })
    .border({
      width: isSelected ? 2 : 0,
      color: Color.LightGray
    })
  }

  @Builder
  BottomActionSection() {
    Row() {
      Button('Add to Cart')
        .width(0)
        .height(56)
        .layoutWeight(1)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(Color.Black)
        .borderRadius(16)
        .margin({ right: 16 })
        .onClick(() => {})

      Stack({ alignContent: Alignment.Center }) {
        Image($r('sys.media.ohos_ic_public_heart'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor(0xFFF5F5F5)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
}
