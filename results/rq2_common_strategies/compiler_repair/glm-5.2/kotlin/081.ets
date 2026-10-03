// Index.ets
@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      Column() {
        // HeaderBar
        Row() {
          // Back Button
          Button() {
            Image($r('sys.media.ohos_ic_back'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0' })
          .backgroundColor('#FFFFFF')
          .padding(0)

          Text('Details')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')

          // Favorite Border Button
          Button() {
            Image($r('sys.media.ohos_ic_public_favor'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0' })
          .backgroundColor('#FFFFFF')
          .padding(0)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(24)

        // ProductImagePlaceholder
        Row() {
          Image($r('sys.media.ohos_ic_public_shopping_cart'))
            .width(80)
            .height(80)
            .fillColor('#BDBDBD')
        }
        .width('100%')
        .height(300)
        .borderRadius(32)
        .backgroundColor('#F5F5F5')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        // ProductInfoSection
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
                .fontColor('#808080')
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
            Image($r('sys.media.ohos_ic_public_star_filled'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')
            Blank().width(4)
            Text('4.8')
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Blank().width(8)
            Text('(238 Reviews)')
              .fontColor('#808080')
              .fontSize(14)
          }
          .alignItems(VerticalAlign.Center)

          Blank().height(24)

          Text('Colors')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')

          Blank().height(12)

          Row() {
            // ColorSelector 1 (Selected)
            Stack() {
              Row()
                .width(10)
                .height(10)
                .borderRadius(5)
                .backgroundColor('#FFFFFF')
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor('#212121')
            .border({ width: 2, color: '#D3D3D3' })

            Blank().width(12)

            // ColorSelector 2
            Row()
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#795548')

            Blank().width(12)

            // ColorSelector 3
            Row()
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#9E9E9E')
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        Blank().layoutWeight(1)

        // BottomActionSection
        Row() {
          Button('Add to Cart')
            .height(56)
            .layoutWeight(1)
            .backgroundColor('#000000')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .borderRadius(16)

          Blank().width(16)

          Row() {
            Image($r('sys.media.ohos_ic_public_favor_filled'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .width(56)
          .height(56)
          .borderRadius(16)
          .backgroundColor('#F5F5F5')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}