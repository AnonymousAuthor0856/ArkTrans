class FurnColors {
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static imageBg: string = '#F5F5F5'
  static border: string = '#E0E0E0'
  static iconGray: string = '#BDBDBD'
  static gray: string = '#808080'
  static amber: string = '#FFC107'
  static swatchBlack: string = '#212121'
  static swatchBrown: string = '#795548'
  static swatchGray: string = '#9E9E9E'
}

@Entry
@Component
struct Index {
  @Builder
  CircleButton(label: string) {
    Button(label)
      .fontSize(18)
      .fontColor(FurnColors.black)
      .width(48)
      .height(48)
      .backgroundColor('#00000000')
      .border({ width: 1, color: FurnColors.border, radius: 24 })
  }

  @Builder
  HeaderBar() {
    Row() {
      this.CircleButton('<')

      Blank()
        .layoutWeight(1)

      Text('Details')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(FurnColors.black)

      Blank()
        .layoutWeight(1)

      this.CircleButton('♡')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ProductImagePlaceholder() {
    Stack() {
      Text('Cart')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(FurnColors.iconGray)
    }
    .width('100%')
    .height(300)
    .backgroundColor(FurnColors.imageBg)
    .borderRadius(32)
  }

  @Builder
  ColorSelector(color: string, selected: boolean) {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(color)
      if (selected) {
        Circle()
          .width(32)
          .height(32)
          .fill('#00000000')
          .stroke('#809E9E9E')
          .strokeWidth(2)
        Circle()
          .width(10)
          .height(10)
          .fill(FurnColors.white)
      }
    }
    .width(32)
    .height(32)
  }

  @Builder
  ProductInfoSection() {
    Column() {
      Row() {
        Column({ space: 8 }) {
          Text('Modern Lounge\nChair')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(FurnColors.black)
            .lineHeight(32)
          Text('Minimalist Series')
            .fontSize(16)
            .fontColor(FurnColors.gray)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Text('$1299')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(FurnColors.black)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Blank()
        .height(24)

      Row() {
        Text('*')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(FurnColors.amber)
        Blank()
          .width(4)
        Text('4.8')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(FurnColors.black)
        Blank()
          .width(8)
        Text('(238 Reviews)')
          .fontSize(14)
          .fontColor(FurnColors.gray)
      }
      .width('100%')

      Blank()
        .height(24)

      Text('Colors')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(FurnColors.black)
        .width('100%')

      Blank()
        .height(12)

      Row({ space: 12 }) {
        this.ColorSelector(FurnColors.swatchBlack, true)
        this.ColorSelector(FurnColors.swatchBrown, false)
        this.ColorSelector(FurnColors.swatchGray, false)
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomActionSection() {
    Row({ space: 16 }) {
      Button('Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(FurnColors.white)
        .height(56)
        .layoutWeight(1)
        .backgroundColor(FurnColors.black)
        .borderRadius(16)

      Stack() {
        Text('♥')
          .fontSize(22)
          .fontColor(FurnColors.black)
      }
      .width(56)
      .height(56)
      .backgroundColor(FurnColors.imageBg)
      .borderRadius(16)
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column() {
        Column() {
          this.HeaderBar()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column() {
            Blank()
              .height(24)
            this.ProductImagePlaceholder()
            Blank()
              .height(32)
            this.ProductInfoSection()
            Blank()
              .height(24)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Column() {
          this.BottomActionSection()
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(FurnColors.white)
  }
}
