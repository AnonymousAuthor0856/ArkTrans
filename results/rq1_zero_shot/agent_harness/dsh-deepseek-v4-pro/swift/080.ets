// Translated from SwiftUI (080.swift) to ArkTS / ArkUI

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    FurnitureDetailScreen()
    // .preferredColorScheme(.light)
    // .statusBarHidden(true)
  }
}

@Component
struct FurnitureDetailScreen {
  build() {
    Stack() {
      Column({ space: 0 }) {
        // Header
        HeaderBar()
          .padding({ left: 24, right: 24, top: 16 })

        // Content
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
        }
        .scrollBar(BarState.Off)

        // Bottom Actions (Sticky at bottom)
        BottomActionSection()
          .padding({ left: 24, right: 24, bottom: 24 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Button() {
        Text('←')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {})

      Blank()

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Semibold)
        .fontColor('#000000')

      Blank()

      Button() {
        Text('🤍')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {})
    }
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack() {
      Blank().width('100%').height(300).backgroundColor('#F5F5F5').borderRadius(32)
      Text('🛒')
        .fontSize(80)
        .fontColor('#BDBDBD')
    }
    .height(300)
    .width('100%')
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column({ space: 0 }) {
      Row() {
        Column({ space: 8 }) {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            // lineSpacing(4)

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
      .alignItems(VerticalAlign.Top)

      Blank().height(24)

      Row({ space: 0 }) {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107')

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

      Blank().height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Semibold)
        .fontColor('#000000')

      Blank().height(12)

      Row({ space: 12 }) {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ColorSelector {
  @Prop color: string = ''
  @Prop isSelected: boolean = false

  build() {
    Stack() {
      Blank().width(32).height(32).backgroundColor(this.color).borderRadius(16)

      if (this.isSelected) {
        Blank().width(32).height(32).borderRadius(16).border({ width: 2, color: '#808080' }).opacity(0.5)
        Blank().width(10).height(10).backgroundColor('#FFFFFF').borderRadius(5)
      }
    }
  }
}

@Component
struct BottomActionSection {
  build() {
    Row({ space: 16 }) {
      Button() {
        Text('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .width('100%')
          .height(56)
          .backgroundColor('#000000')
          .borderRadius(16)
      }
      .onClick(() => {})
      .layoutWeight(1)

      Stack() {
        Blank().width(56).height(56).backgroundColor('#F5F5F5').borderRadius(16)
        Text('❤')
          .fontSize(24)
          .fontColor('#000000')
      }
    }
  }
}
