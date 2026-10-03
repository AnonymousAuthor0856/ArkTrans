@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  private colors: Color[] = [Color.Black, 0xFF795548, Color.Gray];

  build() {
    Column() {
      // Header Bar
      Row() {
        this.HeaderIcon($r('sys.media.ohos_ic_public_arrow_left'))

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        this.HeaderIcon(this.isFavorite
          ? $r('sys.media.ohos_ic_public_collection')
          : $r('sys.media.ohos_ic_public_collection_n'))
          .onClick(() => {
            this.isFavorite = !this.isFavorite;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Product Image Placeholder
      Row() {
        Image($r('sys.media.ohos_ic_public_shopping_cart'))
          .width(80)
          .height(80)
          .fillColor(0xFFBDBDBD)
      }
      .width('100%')
      .height(300)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(0xFFF5F5F5)
      .borderRadius(32)
      .margin({ top: 24 })

      // Product Info Section
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

        // Rating
        Row() {
          Image($r('sys.media.ohos_ic_public_star_solid'))
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
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        // Colors label
        Text('Colors')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .margin({ top: 24 })

        // Color selectors
        Row() {
          ForEach(this.colors, (item: Color, index: number) => {
            this.ColorSelector(item, this.selectedColorIndex === index)
              .onClick(() => {
                this.selectedColorIndex = index;
              })
          }, (item: Color, index: number) => index.toString())
        }
        .margin({ top: 12 })
      }
      .width('100%')
      .margin({ top: 32 })

      // Spacer
      Blank()

      // Bottom Action Section
      Row() {
        Button('Add to Cart')
          .height(56)
          .layoutWeight(1)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .borderRadius(16)

        Row() {
          Image($r('sys.media.ohos_ic_public_collection'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .width(56)
        .height(56)
        .backgroundColor(0xFFF5F5F5)
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
  }

  @Builder
  HeaderIcon(icon: Resource) {
    Row() {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor(Color.Black)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .border({ width: 1, color: 0xFFE0E0E0 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ColorSelector(color: Color, isSelected: boolean) {
    Row() {
      if (isSelected) {
        Row()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor(Color.White)
      }
    }
    .width(32)
    .height(32)
    .borderRadius(16)
    .backgroundColor(color)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .border(isSelected ? { width: 2, color: 0xFFD3D3D3 } : { width: 0, color: Color.Transparent })
    .margin({ right: 12 })
  }
}
