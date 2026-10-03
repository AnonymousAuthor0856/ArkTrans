@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      // Header
      Row() {
        Button() {
          // Back action
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .border({ theme => theme.colorCompBorder })
        .backgroundColor(Color.Transparent)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .type(ButtonType.Normal)
        .borderRadius(24)
        .borderWidth(1)
        .borderColor('#E0E0E0')
        .backgroundColor('#FFFFFF')
        .backgroundImage($r('sys.media.ohos_ic_back'))
        .backgroundImageSize({ width: 20, height: 20 })

        Blank()

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')

        Blank()

        Button() {
          // Favorite action
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .borderWidth(1)
        .borderColor('#E0E0E0')
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .type(ButtonType.Normal)
        .backgroundImage($r('sys.media.ohos_ic_heart'))
        .backgroundImageSize({ width: 20, height: 20 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16 })

      // Content
      Scroll() {
        Column({ space: 0 }) {
          // Product Image Placeholder
          Column() {
            Image($r('sys.media.ohos_ic_cart'))
              .width(80)
              .height(80)
              .fillColor('#BDBDBD')
          }
          .width('100%')
          .height(300)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Blank().height(32)

          // Product Info Section
          Column({ space: 0 }) {
            Row() {
              Column({ space: 8 }) {
                Text('Modern Lounge\nChair')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .lineHeight(32)

                Text('Minimalist Series')
                  .fontSize(16)
                  .fontColor('#808080')
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Text('$1299')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            Blank().height(24)

            Row({ space: 0 }) {
              Image($r('sys.media.ohos_ic_star_filled'))
                .width(20)
                .height(20)
                .fillColor('#FFC107')

              Blank().width(4)

              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')

              Blank().width(8)

              Text('(238 Reviews)')
                .fontSize(14)
                .fontColor('#808080')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Blank().height(24)

            Text('Colors')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')

            Blank().height(12)

            Row({ space: 12 }) {
              // Color 1 - Selected
              Stack() {
                Circle()
                  .width(32)
                  .height(32)
                  .fill('#212121')

                Circle()
                  .width(32)
                  .height(32)
                  .fill(Color.Transparent)
                  .stroke('#808080')
                  .strokeWidth(2)

                Circle()
                  .width(10)
                  .height(10)
                  .fill('#FFFFFF')
              }
              .width(32)
              .height(32)

              // Color 2
              Circle()
                .width(32)
                .height(32)
                .fill('#795548')

              // Color 3
              Circle()
                .width(32)
                .height(32)
                .fill('#9E9E9E')
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          Blank().height(24)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      // Bottom Action Section
      Row({ space: 16 }) {
        Button('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .layoutWeight(1)
          .height(56)
          .borderRadius(16)
          .backgroundColor('#000000')
          .type(ButtonType.Normal)

        Stack() {
          Column()
            .width(56)
            .height(56)
            .borderRadius(16)
            .backgroundColor('#F5F5F5')

          Image($r('sys.media.ohos_ic_heart_filled'))
            .width(24)
            .height(24)
            .fillColor('#000000')
        }
        .width(56)
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}