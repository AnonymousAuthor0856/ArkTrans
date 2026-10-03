// FurnitureApp.ets
import router from '@ohos.router';

@Entry
@Component
struct FurnitureApp {
  build() {
    Column() {
      FurnitureDetailScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      // Header
      HeaderBar()
        .padding({ left: 24, right: 24, top: 16 })

      // Content
      Scroll() {
        Column() {
          Blank().height(24)

          ProductImagePlaceholder()

          Blank().height(32)

          ProductInfoSection()

          Blank().height(24)
        }
        .padding({ left: 24, right: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      // Bottom Actions (Sticky at bottom)
      BottomActionSection()
        .padding({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
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
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .backgroundColor(Color.Transparent)

      Blank()

      // Title
      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
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
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height(300)
        .borderRadius(32)
        .backgroundColor('#F5F5F5')

      // Cart Icon Placeholder
      Text('🛒')
        .fontSize(80)
        .fontColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column() {
      // Title and Price
      Row() {
        Column() {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .lineHeight(32)

          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(Color.Gray)
            .margin({ top: 8 })
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

      Blank().height(24)

      // Rating
      Row() {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 4 })

        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(Color.Gray)
          .margin({ left: 8 })
      }

      Blank().height(24)

      // Colors
      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Blank().height(12)

      // Color Selectors
      Row({ space: 12 }) {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ColorSelector {
  private color: ResourceColor = Color.Black;
  private isSelected: boolean = false;

  build() {
    Stack() {
      Column()
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor(this.color)

      if (this.isSelected) {
        // Outer Ring
        Column()
          .width(32)
          .height(32)
          .borderRadius(16)
          .border({ width: 2, color: '#80808080' }) // Semi-transparent gray

        // Inner Dot
        Column()
          .width(10)
          .height(10)
          .borderRadius(5)
          .backgroundColor(Color.White)
      }
    }
    .width(32)
    .height(32)
  }
}

@Component
struct BottomActionSection {
  build() {
    Row({ space: 16 }) {
      // Add to Cart Button
      Button() {
        Text('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .layoutWeight(1)
      .height(56)
      .backgroundColor(Color.Black)
      .borderRadius(16)

      // Favorite Icon Box
      Stack() {
        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
  }
}