@Entry
@Component
struct ProductDetailsPage {
  @State isFavorite: boolean = false;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // ---------- Header ----------
        Row() {
          Button() {
            Text('←')
              .fontSize(26)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF1A1A1A')
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.White)
          .borderWidth(1)
          .borderColor('#FFE5E5E5')
          .width(52)
          .height(52)

          Blank()

          Text('Details')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF1A1A1A')

          Blank()

          Button() {
            Text(this.isFavorite ? '♥' : '♡')
              .fontSize(24)
              .fontColor('#FF1A1A1A')
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.White)
          .borderWidth(1)
          .borderColor('#FFE5E5E5')
          .width(52)
          .height(52)
          .onClick(() => {
            this.isFavorite = !this.isFavorite;
          })
        }
        .width('100%')
        .height(64)
        .padding({ left: 20, right: 20, top: 8, bottom: 8 })

        // ---------- Scrollable content ----------
        Scroll() {
          Column() {
            // Product image placeholder
            Stack({ alignContent: Alignment.Center }) {
              Stack() {
                Path({ commands: 'M12 20 L44 20 L66 106 L132 106 L150 44 L52 44' })
                  .width(160)
                  .height(160)
                  .stroke('#FFC9C9C9')
                  .strokeWidth(9)
                  .strokeLineCap(LineCapStyle.Round)
                  .strokeLineJoin(LineJoinStyle.Round)
                  .fillOpacity(0)

                Circle()
                  .width(18)
                  .height(18)
                  .fill('#FFC9C9C9')
                  .position({ x: 58, y: 127 })

                Circle()
                  .width(18)
                  .height(18)
                  .fill('#FFC9C9C9')
                  .position({ x: 112, y: 127 })
              }
              .width(160)
              .height(160)
            }
            .width('100%')
            .aspectRatio(1)
            .backgroundColor('#FFF4F4F4')
            .borderRadius(32)

            // Title + price
            Row() {
              Text('Modern Lounge Chair')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF1A1A1A')
                .lineHeight(32)
                .maxLines(2)
                .layoutWeight(1)

              Text('$1299')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF1A1A1A')
                .margin({ left: 12 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ top: 28 })

            // Series name
            Text('Minimalist Series')
              .fontSize(17)
              .fontColor('#FF8A8A8A')
              .width('100%')
              .margin({ top: 6 })

            // Rating
            Row() {
              Text('★')
                .fontSize(20)
                .fontColor('#FFFFC107')

              Text('4.8')
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF1A1A1A')
                .margin({ left: 6 })

              Text('(238 Reviews)')
                .fontSize(16)
                .fontColor('#FF8A8A8A')
                .margin({ left: 10 })
            }
            .width('100%')
            .margin({ top: 18 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24, bottom: 120 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // ---------- Bottom action bar ----------
      Row() {
        Button('Add to Cart')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .backgroundColor('#FF111111')
          .height(56)
          .layoutWeight(1)
          .borderRadius(16)

        Button() {
          Text('♥')
            .fontSize(24)
            .fontColor('#FF111111')
        }
        .type(ButtonType.Normal)
        .backgroundColor('#FFF4F4F4')
        .borderRadius(16)
        .width(56)
        .height(56)
        .margin({ left: 14 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 14, bottom: 24 })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}