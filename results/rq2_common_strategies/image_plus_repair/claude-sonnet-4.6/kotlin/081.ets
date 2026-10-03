@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      // Header Bar
      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('←')
            .fontSize(18)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Button({ type: ButtonType.Circle }) {
          Text('♡')
            .fontSize(18)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Spacer
      Blank().height(24)

      // Product Image Placeholder
      Stack() {
        Text('🛒')
          .fontSize(60)
          .fontColor('#BDBDBD')
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)
      .alignContent(Alignment.Center)

      // Spacer
      Blank().height(32)

      // Product Info Section
      Column() {
        Row() {
          Column() {
            Text('Modern Lounge Chair')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .lineHeight(32)
            Blank().height(8)
            Text('Minimalist Series')
              .fontSize(16)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('$1299')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Top)

        Blank().height(24)

        // Rating Row
        Row() {
          Text('★')
            .fontSize(20)
            .fontColor('#FFC107')
          Blank().width(4)
          Text('4.8')
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Blank().width(8)
          Text('(238 Reviews)')
            .fontColor(Color.Gray)
            .fontSize(14)
        }
        .alignItems(VerticalAlign.Center)

        Blank().height(24)

        Text('Colors')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Blank().height(12)

        // Color Selectors
        Row({ space: 12 }) {
          // Color 1 - Dark (selected)
          Stack() {
            Circle()
              .width(32)
              .height(32)
              .fill('#212121')
            Circle()
              .width(10)
              .height(10)
              .fill(Color.White)
          }
          .width(32)
          .height(32)
          .border({ width: 2, color: '#D3D3D3', radius: 16 })

          // Color 2 - Brown
          Circle()
            .width(32)
            .height(32)
            .fill('#795548')

          // Color 3 - Gray
          Circle()
            .width(32)
            .height(32)
            .fill('#9E9E9E')
        }
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      // Bottom Action Section
      Row({ space: 16 }) {
        Button('Add to Cart')
          .height(56)
          .layoutWeight(1)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .borderRadius(16)

        Stack() {
          Text('♥')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(56)
        .height(56)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .alignContent(Alignment.Center)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}