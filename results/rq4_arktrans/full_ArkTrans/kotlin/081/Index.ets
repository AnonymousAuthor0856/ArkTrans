@Entry
@Component
struct Index {
  @State Details: string = "Details"
  @State ModernLoungeChair: string = "Modern Lounge Chair"
  @State MinimalistSeries: string = "Minimalist Series"
  @State Price: string = "$1299"
  @State Rating: string = "4.8"
  @State Reviews: string = "(238 Reviews)"
  @State ColorsLabel: string = "Colors"
  @State AddToCart: string = "Add to Cart"

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
          .border({ width: 1, color: '#E0E0E0' })
          .width(48)
          .height(48)

          Text(this.Details)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0' })
          .width(48)
          .height(48)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

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
        .backgroundColor('#F5F5F5')
        .borderRadius(32)

        Blank().height(32)

        // ProductInfoSection
        Column({ space: 0 }) {
          // Title and Price
          Row({ space: 0 }) {
            Column({ space: 8 }) {
              Text(this.ModernLoungeChair)
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(32)
              
              Text(this.MinimalistSeries)
                .fontSize(16)
                .fontColor(Color.Gray)
            }
            .layoutWeight(1)

            Text(this.Price)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          Blank().height(24)

          // Rating
          Row({ space: 4 }) {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor('#FFC107')
            
            Text(this.Rating)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            
            Blank().width(4)
            
            Text(this.Reviews)
              .fontColor(Color.Gray)
              .fontSize(14)
          }
          .alignItems(VerticalAlign.Center)

          Blank().height(24)

          // Colors
          Text(this.ColorsLabel)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)

          Blank().height(12)

          // Color Selectors
          Row({ space: 12 }) {
            // Selector 1 (Selected)
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 10, height: 10 }).fill(Color.White)
            }
            .width(32)
            .height(32)
            .clip(true)
            .backgroundColor(Color.Black)
            .border({ width: 2, color: '#D3D3D3' })

            // Selector 2
            Stack({ alignContent: Alignment.Center }) {
              // Empty for unselected
            }
            .width(32)
            .height(32)
            .clip(true)
            .backgroundColor(Color.Gray)

            // Selector 3
            Stack({ alignContent: Alignment.Center }) {
              // Empty for unselected
            }
            .width(32)
            .height(32)
            .clip(true)
            .backgroundColor('#A0A0A0')
          }
        }
        .width('100%')

        Blank().layoutWeight(1)

        // BottomActionSection
        Row({ space: 16 }) {
          Button(this.AddToCart) {
            Text(this.AddToCart)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
          .height(56)
          .layoutWeight(1)
          .backgroundColor(Color.Black)
          .borderRadius(16)

          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(56)
          .height(56)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
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