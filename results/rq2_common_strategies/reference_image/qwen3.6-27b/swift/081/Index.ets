@Entry
@Component
struct ProductDetailsPage {
  @State isFavorite: boolean = false

  build() {
    Column() {
      // Header
      Row() {
        Button() {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
        .width(48)
        .height(48)

        Text("Details")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 16 })

        Blank()

        Button() {
          Image(this.isFavorite ? $r('app.media.ic_heart_filled') : $r('app.media.ic_heart_outline'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ top: 48, bottom: 16 })

      // Product Image Placeholder
      Column() {
        Image($r('app.media.ic_cart_placeholder'))
          .width(60)
          .height(60)
          .objectFit(ImageFit.Contain)
      }
      .width('90%')
      .aspectRatio(1)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 24 })

      // Product Info
      Column() {
        Row() {
          Text("Modern Lounge Chair")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text("$1299")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Bottom)

        Text("Minimalist Series")
          .fontSize(16)
          .fontColor('#757575')
          .margin({ top: 8 })

        Row() {
          Image($r('app.media.ic_star'))
            .width(20)
            .height(20)
          
          Text("4.8")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .margin({ left: 4 })

          Text("(238 Reviews)")
            .fontSize(14)
            .fontColor('#757575')
            .margin({ left: 4 })
        }
        .margin({ top: 16 })
      }
      .width('100%')
      .padding({ left: 15, right: 15 })
      .layoutWeight(1)

      // Bottom Action Bar
      Row() {
        Button("Add to Cart") {
          // Add to cart action
        }
        .width('80%')
        .height(56)
        .backgroundColor(Color.Black)
        .fontColor(Color.White)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .borderRadius(16)

        Button() {
          Image(this.isFavorite ? $r('app.media.ic_heart_filled') : $r('app.media.ic_heart_outline'))
            .width(28)
            .height(28)
            .fillColor(Color.Black)
        }
        .onClick(() => {
          this.isFavorite = !this.isFavorite
        })
        .width(56)
        .height(56)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .margin({ left: 12 })
      }
      .width('100%')
      .padding({ left: 15, right: 15, bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}