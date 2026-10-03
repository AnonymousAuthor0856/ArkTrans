@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      // Header Bar
      Row() {
        Button() {
          Text('<')
            .fontSize(18)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid })

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Button() {
          Text('♡')
            .fontSize(18)
            .fontColor(Color.Black)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', style: BorderStyle.Solid })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Spacer
      Blank().height(24)

      // Product Image Placeholder
      Stack({ alignContent: Alignment.Center }) {
        Column()
          .width('100%')
          .height(300)
          .borderRadius(32)
          .backgroundColor('#F5F5F5')

        Text('🛒')
          .fontSize(80)
          .fontColor('#BDBDBD')
      }
      .width('100%')
      .height(300)

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
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Blank().height(12)

        // Color Selectors
        Row({ space: 12 }) {
          // Color 1 - Dark (selected)
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(32)
              .height(32)
              .fill('#212121')
              .stroke('#BDBDBD')
              .strokeWidth(2)

            Circle()
              .width(10)
              .height(10)
              .fill(Color.White)
          }
          .width(32)
          .height(32)

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
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .backgroundColor(Color.Black)
          .borderRadius(16)

        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(56)
            .height(56)
            .borderRadius(16)
            .backgroundColor('#F5F5F5')

          Text('♥')
            .fontSize(22)
            .fontColor(Color.Black)
        }
        .width(56)
        .height(56)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}