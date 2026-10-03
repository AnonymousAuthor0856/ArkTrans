@Entry
@Component
struct FurnitureDetailScreen {
  @State selectedColorIndex: number = 0;
  private colors: ResourceColor[] = [Color.Black, 0xFF795548, Color.Gray];

  build() {
    Column() {
      this.HeaderBar()

      this.ProductImagePlaceholder()

      Column() {
        this.ProductInfoSection()

        Column()
          .layoutWeight(1)

        this.BottomActionSection()
      }
      .width('100%')
      .layoutWeight(1)
      .margin({ top: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
  }

  @Builder
  HeaderBar() {
    Row() {
      this.CircleIconButton('←', false)

      Text('Details')
        .fontSize(18)
        .fontWeight(600)
        .fontColor(Color.Black)

      this.CircleIconButton('♡', false)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CircleIconButton(label: string, isFilled: boolean) {
    Text(label)
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: 0xFFE0E0E0 })
      .fontSize(22)
      .fontColor(Color.Black)
      .textAlign(TextAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack({ alignContent: Alignment.Center }) {
      Text('🛒')
        .fontSize(80)
        .fontColor(0xFFBDBDBD)
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor(0xFFF5F5F5)
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
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Row() {
        Text('★')
          .fontSize(20)
          .fontColor(0xFFFFC107)

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
        .fontWeight(600)
        .fontColor(Color.Black)
        .margin({ top: 24 })

      Row() {
        ForEach(this.colors, (color: ResourceColor, index: number) => {
          Stack({ alignContent: Alignment.Center }) {
            if (index === this.selectedColorIndex) {
              Column()
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
          .margin({ right: 12 })
          .border({
            width: index === this.selectedColorIndex ? 2 : 0,
            color: 0xFFD3D3D3
          })
          .onClick(() => {
            this.selectedColorIndex = index;
          })
        }, (_: ResourceColor, index: number) => index.toString())
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
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
        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor(0xFFF5F5F5)
    }
    .width('100%')
  }
}
