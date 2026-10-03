@Entry
@Component
struct FurnitureApp {
  build() {
    FurnitureDetailScreen()
  }
}

@Component
struct FurnitureDetailScreen {
  build() {
    Stack() {
      Column() {
        HeaderBar()
          .padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column() {
            Blank()
              .height(24)

            ProductImagePlaceholder()

            Blank()
              .height(32)

            ProductInfoSection()

            Blank()
              .height(24)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        BottomActionSection()
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Stack() {
        Text('‹')
          .fontSize(32)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Normal)
          .margin({ bottom: 4 })
      }
      .width(48)
      .height(48)
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 24
      })
      .onClick(() => {
      })

      Blank()
        .layoutWeight(1)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Blank()
        .layoutWeight(1)

      Stack() {
        Text('♡')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .border({
        width: 1,
        color: '#E0E0E0',
        radius: 24
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .height(48)
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

      Text('🛒')
        .fontSize(72)
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
          .layoutWeight(1)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Blank()
        .height(24)

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
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)

      Blank()
        .height(12)

      Row() {
        ColorSelector({ colorValue: '#212121', isSelected: true })

        ColorSelector({ colorValue: '#795548', isSelected: false })
          .margin({ left: 12 })

        ColorSelector({ colorValue: '#9E9E9E', isSelected: false })
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ColorSelector {
  colorValue: ResourceColor = '#212121'
  isSelected: boolean = false

  build() {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(this.colorValue)

      if (this.isSelected) {
        Circle()
          .width(32)
          .height(32)
          .fill(Color.Transparent)
          .stroke('#80808080')
          .strokeWidth(2)

        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
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
      .backgroundColor(Color.Black)
      .borderRadius(16)
      .onClick(() => {
      })

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
      .margin({ left: 16 })
    }
    .width('100%')
    .height(56)
    .alignItems(VerticalAlign.Center)
  }
}