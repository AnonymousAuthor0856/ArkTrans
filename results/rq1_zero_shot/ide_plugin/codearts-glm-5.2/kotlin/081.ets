@Entry
@Component
struct FurnitureDetailScreen {
  private colors: string[] = ['#212121', '#795548', '#9E9E9E']

  @Builder
  ColorSelectorBuilder(color: string, isSelected: boolean) {
    Stack() {
      if (isSelected) {
        Column() {}
          .width(10)
          .height(10)
          .backgroundColor('#FFFFFF')
          .borderRadius(5)
      }
    }
    .width(32)
    .height(32)
    .backgroundColor(color)
    .borderRadius(16)
    .borderWidth(isSelected ? 2 : 0)
    .borderColor(isSelected ? '#AAAAAA' : '#00000000')
    .alignContent(Alignment.Center)
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text('←')
            .fontSize(22)
            .fontColor('#000000')
        }
        .width(48)
        .height(48)
        .borderWidth(1)
        .borderColor('#E0E0E0')
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Column() {
          Text('♡')
            .fontSize(22)
            .fontColor('#000000')
        }
        .width(48)
        .height(48)
        .borderWidth(1)
        .borderColor('#E0E0E0')
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('🛒')
          .fontSize(64)
          .fontColor('#BDBDBD')
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 24 })

      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .lineHeight(32)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#888888')
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)
      .margin({ top: 32 })

      Row() {
        Text('★')
          .fontSize(18)
          .fontColor('#FFC107')
        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ left: 4 })
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .margin({ top: 24 })

      Row() {
        ForEach(this.colors, (color: string, index: number) => {
          this.ColorSelectorBuilder(color, index === 0)
        }, (color: string) => color)
      }
      .margin({ top: 12 })

      Row() {
        Button('Add to Cart') {
          Text('Add to Cart')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
          .type(ButtonType.Normal)
          .backgroundColor('#000000')
          .borderRadius(16)
          .layoutWeight(1)
          .height(56)

        Column() {
          Text('♥')
            .fontSize(24)
            .fontColor('#000000')
        }
        .width(56)
        .height(56)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ left: 16 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 32 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}