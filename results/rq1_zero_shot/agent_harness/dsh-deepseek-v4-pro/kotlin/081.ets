@Entry
@Component
struct Index {
  build() {
    Column() {
      HeaderBar()
      Blank().height(24)
      ProductImagePlaceholder()
      Blank().height(32)
      ProductInfoSection()
      Blank().layoutWeight(1)
      BottomActionSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderBar {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('←').fontSize(20).fontColor('#000000')
      }
      .width(48).height(48)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0', radius: 24 })

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Button({ type: ButtonType.Circle }) {
        Text('♡').fontSize(20).fontColor('#000000')
      }
      .width(48).height(48)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0', radius: 24 })
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
      Text('🛒').fontSize(80).fontColor('#BDBDBD')
    }
    .width('100%')
    .height(300)
    .backgroundColor('#F5F5F5')
    .borderRadius(32)
    .alignContent(Alignment.Center)
  }
}

@Component
struct ProductInfoSection {
  build() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge Chair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .lineHeight(32)
          Blank().height(8)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor('#888888')
        }
        .layoutWeight(1)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Blank().height(24)

      Row() {
        Text('★').fontSize(20).fontColor('#FFC107')
        Blank().width(4)
        Text('4.8')
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Blank().width(8)
        Text('(238 Reviews)')
          .fontColor('#888888')
          .fontSize(14)
      }
      .alignItems(VerticalAlign.Center)

      Blank().height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Blank().height(12)

      Row() {
        ColorSelector({ color: '#212121', isSelected: true })
        ColorSelector({ color: '#795548', isSelected: false })
        ColorSelector({ color: '#9E9E9E', isSelected: false })
      }
      .space(12)
    }
    .width('100%')
  }
}

@Component
struct ColorSelector {
  @Prop color: string = '#000000'
  @Prop isSelected: boolean = false

  build() {
    Stack() {
      if (this.isSelected) {
        Stack() {}
          .width(10).height(10)
          .borderRadius(5)
          .backgroundColor('#FFFFFF')
      }
    }
    .width(32).height(32)
    .borderRadius(16)
    .backgroundColor(this.color)
    .border({ width: this.isSelected ? 2 : 0, color: '#CCCCCC', radius: 16 })
    .alignContent(Alignment.Center)
  }
}

@Component
struct BottomActionSection {
  build() {
    Row() {
      Button('Add to Cart')
        .height(56)
        .layoutWeight(1)
        .backgroundColor('#000000')
        .fontColor('#FFFFFF')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .borderRadius(16)

      Stack() {
        Text('♥').fontSize(24).fontColor('#000000')
      }
      .width(56).height(56)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .space(16)
  }
}
