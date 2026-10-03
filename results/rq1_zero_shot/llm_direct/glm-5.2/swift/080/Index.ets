import { Entry, Component } from '@kit.ArkUI';

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
        .margin({ left: 24, right: 24, top: 16 })

      // Content
      Scroll() {
        Column() {
          ProductImagePlaceholder()
            .margin({ top: 24 })

          ProductInfoSection()
            .margin({ top: 32, bottom: 24 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 24, right: 24 })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      // Bottom Actions
      BottomActionSection()
        .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Button() {
        Image($r('sys.symbol.chevron_left'))
          .fontSize(20)
          .fontColor(Color.Black)
          .width(24)
          .height(24)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .backgroundColor(Color.Transparent)

      Blank()

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Blank()

      Button() {
        Image($r('sys.symbol.heart'))
          .fontSize(20)
          .fontColor(Color.Black)
          .width(24)
          .height(24)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .border({ width: 1, color: '#E0E0E0' })
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ProductImagePlaceholder {
  build() {
    Stack() {
      Image($r('sys.symbol.cart'))
        .width(80)
        .height(80)
        .fillColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .borderRadius(32)
    .backgroundColor('#F5F5F5')
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column() {
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
      .alignItems(VerticalAlign.Top)
      .width('100%')

      Row() {
        Image($r('sys.symbol.star_fill'))
          .width(20)
          .height(20)
          .fillColor('#FFC107')

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
      .margin({ top: 24 })

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 24 })

      Row() {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
      .margin({ top: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ColorSelector {
  @Prop color: string = '#000000';
  @Prop isSelected: boolean = false;

  build() {
    Stack() {
      Circle({ width: 32, height: 32 })
        .fill(this.color)

      if (this.isSelected) {
        Circle({ width: 32, height: 32 })
          .stroke(Color.Gray)
          .strokeWidth(2)

        Circle({ width: 10, height: 10 })
          .fill(Color.White)
      }
    }
    .margin({ right: 12 })
  }
}

@Component
struct BottomActionSection {
  build() {
    Row() {
      Button() {
        Text('Add to Cart')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      }
      .layoutWeight(1)
      .height(56)
      .borderRadius(16)
      .backgroundColor(Color.Black)

      Stack() {
        Image($r('sys.symbol.heart_fill'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(56)
      .height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5)
      .margin({ left: 16 })
    }
    .width('100%')
  }
}