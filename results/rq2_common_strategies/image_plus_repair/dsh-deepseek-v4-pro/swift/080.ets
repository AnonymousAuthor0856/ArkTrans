// import SwiftUI

@Entry
@Component
struct FurnitureApp {
  build() {
    // WindowGroup {
    //   ContentView()
    // }
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
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
    Column({ space: 0 }) {
      // Header
      HeaderBar()
        .padding({ left: 24, right: 24 })
        .padding({ top: 16 })

      // Content
      Scroll() {
        Column({ space: 0 }) {
          Blank().height(24)

          ProductImagePlaceholder()

          Blank().height(32)

          ProductInfoSection()

          // Spacer to push content up if needed, but in scrollview it just adds padding
          Blank().height(24)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 24, right: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)

      // Bottom Actions (Sticky at bottom)
      BottomActionSection()
        .padding({ left: 24, right: 24 })
        .padding({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White) // Color.white.ignoresSafeArea()
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Button() {
        Text('←')
          .fontSize(20)
          .fontColor(Color.Black)
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
      }

      Blank()

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Blank()

      Button() {
        Text('♡')
          .fontSize(20)
          .fontColor(Color.Black)
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
      }
    }
    .width('100%')
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack() {
      Text('🛒')
        .fontSize(80)
        .fontColor('#BDBDBD') // #BDBDBD
    }
    .width('100%')
    .height(300)
    .backgroundColor('#F5F5F5') // #F5F5F5
    .borderRadius(32)
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
            .fontColor(Color.Black)
            .lineHeight(32) // Adjusting line spacing to approx 32.sp line height

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

      Blank().height(24)

      Row({ space: 0 }) {
        Text('★')
          .fontSize(20)
          .fontColor('#FFC107') // #FFC107

        Blank().width(4)

        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold) // Default usually matches body
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
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)

      Blank().height(12)

      Row({ space: 12 }) {
        ColorSelector({ color: '#212121', isSelected: true }) // #212121
        ColorSelector({ color: '#795548', isSelected: false }) // #795548
        ColorSelector({ color: '#9E9E9E', isSelected: false }) // #9E9E9E
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ColorSelector {
  @Prop color: string = '#000000'
  @Prop isSelected: boolean = false

  build() {
    Stack() {
      Circle()
        .fill(this.color)
        .width(32)
        .height(32)

      if (this.isSelected) {
        Circle()
          .width(32)
          .height(32)
          .fill(Color.Transparent)
          .stroke(Color.Gray)
          .strokeWidth(2)
          .opacity(0.5) // LightGray approx

        Circle()
          .fill(Color.White)
          .width(10)
          .height(10)
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
          .fontColor(Color.White)
      }
      .layoutWeight(1)
      .height(56)
      .backgroundColor(Color.Black)
      .borderRadius(16)

      Stack() {
        Text('♥')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .backgroundColor('#F5F5F5') // #F5F5F5
      .borderRadius(16)
    }
    .width('100%')
  }
}
