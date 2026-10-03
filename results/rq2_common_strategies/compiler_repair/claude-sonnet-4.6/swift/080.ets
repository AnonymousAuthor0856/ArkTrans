@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      // Header
      HeaderBar()
        .margin({ left: 24, right: 24, top: 16 })

      // Scrollable Content
      Scroll() {
        Column({ space: 0 }) {
          Blank().height(24)

          ProductImagePlaceholder()

          Blank().height(32)

          ProductInfoSection()

          Blank().height(24)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')

      // Bottom Actions
      BottomActionSection()
        .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      // Back Button
      Button() {
        Text('←')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .borderWidth(1)
      .borderColor('#E0E0E0')
      .borderRadius(24)
      .type(ButtonType.Normal)

      Blank()

      Text('Details')
        .fontSize(18)
        .fontWeight(600)
        .fontColor(Color.Black)

      Blank()

      // Heart Button
      Button() {
        Text('♡')
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .borderWidth(1)
      .borderColor('#E0E0E0')
      .borderRadius(24)
      .type(ButtonType.Normal)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height(300)
        .backgroundColor('#F5F5F5')
        .borderRadius(32)

      Column() {
        Text('🛒')
          .fontSize(80)
          .fontColor('#BDBDBD')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(300)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column({ space: 0 }) {
      // Title and Price Row
      Row() {
        Column({ space: 8 }) {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(34)

          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(24)

      // Rating Row
      Row({ space: 0 }) {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')

        Blank().width(4)

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Blank().width(8)

        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .alignItems(VerticalAlign.Center)

      Blank().height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(600)
        .fontColor(Color.Black)

      Blank().height(12)

      Row({ space: 12 }) {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ColorSelector {
  color: string = '#000000'
  isSelected: boolean = false

  build() {
    Stack() {
      Circle()
        .fill(this.color)
        .width(32)
        .height(32)

      if (this.isSelected) {
        Circle()
          .fill(Color.Transparent)
          .width(40)
          .height(40)
          .stroke('#AAAAAA')
          .strokeWidth(2)

        Circle()
          .fill(Color.White)
          .width(10)
          .height(10)
      }
    }
    .width(40)
    .height(40)
    .alignContent(Alignment.Center)
  }
}

@Component
struct BottomActionSection {
  build() {
    Row({ space: 16 }) {
      Button('Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .height(56)
        .layoutWeight(1)
        .backgroundColor(Color.Black)
        .borderRadius(16)
        .type(ButtonType.Normal)

      Stack() {
        Column()
          .width(56)
          .height(56)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)

        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}