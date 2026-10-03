@Entry
@Component
struct FurnitureDetailScreen {
  @State selectedColorIndex: number = 0

  build() {
    Column() {
      // HeaderBar
      Row() {
        // Back Button
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.Black)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .borderRadius(24)
        .border({ width: 1, color: Color.Gray })

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        // Favorite Button
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.Black)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .borderRadius(24)
        .border({ width: 1, color: Color.Gray })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(24)

      // ProductImagePlaceholder
      Column() {
        Image($r('app.media.startIcon'))
          .width(80)
          .height(80)
          .objectFit(ImageFit.Contain)
          .fillColor('#BDBDBD')
      }
      .width('100%')
      .height(300)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)

      Blank().height(32)

      // ProductInfoSection
      Column() {
        // Title and Price Row
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
          .layoutWeight(1)

          Text('$1299')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width('100%')

        Blank().height(24)

        // Rating Row
        Row() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
            .fillColor('#FFC107')
          
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

        // Colors Label
        Text('Colors')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Blank().height(12)

        // Color Selectors
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
          this.ColorSelector('#212121', 0)
          this.ColorSelector('#795548', 1)
          this.ColorSelector('#9E9E9E', 2)
        }
        .gap(12)
      }
      .width('100%')

      Blank().layoutWeight(1)

      // BottomActionSection
      Row() {
        Button('Add to Cart')
          .height(56)
          .layoutWeight(1)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .borderRadius(16)
          .fontWeight(FontWeight.Bold)
          .fontSize(16)

        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor(Color.Black)
        }
        .width(56)
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
      }
      .width('100%')
      .margin({ left: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  ColorSelector(colorHex: string, index: number) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(colorHex)
      
      if (this.selectedColorIndex === index) {
        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .onClick(() => {
      this.selectedColorIndex = index
    })
  }
}