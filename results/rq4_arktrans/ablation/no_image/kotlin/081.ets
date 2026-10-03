@Entry
@Component
struct Index {
  @State Details: string = 'Details'
  @State ModernLoungeChair: string = 'Modern Lounge Chair'
  @State MinimalistSeries: string = 'Minimalist Series'
  @State PriceText: string = '$1299'
  @State RatingText: string = '4.8'
  @State ReviewsText: string = '(238 Reviews)'
  @State ColorsLabel: string = 'Colors'
  @State AddToCartText: string = 'Add to Cart'

  build() {
    Stack() {
      Column() {
        // HeaderBar
        Row({ space: 0 }) {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid })
          .width(48)
          .height(48)
          .onClick(() => {})

          Text(this.Details)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid })
          .width(48)
          .height(48)
          .onClick(() => {})
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')

        Blank().height(24)

        // ProductImagePlaceholder
        Stack({ alignContent: Alignment.Center }) {
          Image($r('app.media.startIcon'))
            .width(80)
            .height(80)
            .fillColor('#BDBDBD')
        }
        .width('100%')
        .height(300)
        .borderRadius(32)
        .backgroundColor('#F5F5F5')

        Blank().height(32)

        // ProductInfoSection
        Column({ space: 0 }) {
          Row({ space: 0 }) {
            Column({ space: 0 }) {
              Text(this.ModernLoungeChair)
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(32)

              Blank().height(8)

              Text(this.MinimalistSeries)
                .fontSize(16)
                .fontColor(Color.Gray)
            }
            .layoutWeight(1)

            Text(this.PriceText)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .alignItems(VerticalAlign.Top)
          .width('100%')

          Blank().height(24)

          Row({ space: 0 }) {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')

            Blank().width(4)

            Text(this.RatingText)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)

            Blank().width(8)

            Text(this.ReviewsText)
              .fontColor(Color.Gray)
              .fontSize(14)
          }
          .alignItems(VerticalAlign.Center)

          Blank().height(24)

          Text(this.ColorsLabel)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Blank().height(12)

          Row({ space: 12 }) {
            // ColorSelector 1
            Stack({ alignContent: Alignment.Center }) {
              Stack({ alignContent: Alignment.Center }) {
              }
              .width(10)
              .height(10)
              .borderRadius(5)
              .backgroundColor(Color.White)
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(Color.Red) // Placeholder for 'color'

            // ColorSelector 2
            Stack({ alignContent: Alignment.Center }) {
              Stack({ alignContent: Alignment.Center }) {
              }
              .width(10)
              .height(10)
              .borderRadius(5)
              .backgroundColor(Color.White)
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(Color.Blue) // Placeholder for 'color'

            // ColorSelector 3
            Stack({ alignContent: Alignment.Center }) {
              Stack({ alignContent: Alignment.Center }) {
              }
              .width(10)
              .height(10)
              .borderRadius(5)
              .backgroundColor(Color.White)
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(Color.Green) // Placeholder for 'color'
          }
        }
        .width('100%')

        Blank().layoutWeight(1)

        // BottomActionSection
        Row({ space: 16 }) {
          Button() {
            Text(this.AddToCartText)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .height(56)
          .layoutWeight(1)
          .backgroundColor(Color.Black)
          .borderRadius(16)
          .onClick(() => {})

          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(56)
          .height(56)
          .borderRadius(16)
          .backgroundColor('#F5F5F5')
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }
}