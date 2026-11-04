class FurnColors {
  static background: string = '#F5F5F7'
  static heroBg: string = '#E8E8E8'
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static darkText: string = '#333333'
  static gray: string = '#808080'
  static gold: string = '#FFC107'
  static colorOne: string = '#EFB495'
  static colorTwo: string = '#8D6E63'
  static colorThree: string = '#5D4037'
  static red: string = '#E53935'
}

@Entry
@Component
struct Index {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private swatches: string[] = [FurnColors.colorOne, FurnColors.colorTwo, FurnColors.colorThree]

  @Builder
  TopImageSection() {
    Stack() {
      Rect()
        .width('100%')
        .height(400)
        .fill(FurnColors.heroBg)
        .radius(40)

      Stack() {
        Circle()
          .width(200)
          .height(200)
          .fill(FurnColors.white)
          .shadow({ radius: 20, color: '#33000000', offsetY: 10 })
        Text('Home')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(FurnColors.colorOne)
      }
      .width(200)
      .height(200)

      Column() {
        Row() {
          Button('<')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(FurnColors.black)
            .width(42)
            .height(42)
            .backgroundColor(FurnColors.white)
            .borderRadius(21)

          Blank()
            .layoutWeight(1)

          Button(this.isFavorite ? '♥' : '♡')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isFavorite ? FurnColors.red : FurnColors.black)
            .width(42)
            .height(42)
            .backgroundColor(FurnColors.white)
            .borderRadius(21)
            .onClick(() => {
              this.isFavorite = !this.isFavorite
            })
        }
        .width('100%')
        .padding(24)

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height(400)
    }
    .width('100%')
    .height(400)
  }

  @Builder
  ColorSwatch(color: string, index: number) {
    Stack() {
      Circle()
        .width(30)
        .height(30)
        .fill(color)
      if (this.selectedColorIndex === index) {
        Circle()
          .width(30)
          .height(30)
          .fill('#00000000')
          .stroke(FurnColors.black)
          .strokeWidth(2)
      }
    }
    .width(30)
    .height(30)
    .onClick(() => {
      this.selectedColorIndex = index
    })
  }

  @Builder
  QuantitySelector() {
    Row() {
      Text('-')
        .fontSize(20)
        .fontColor(FurnColors.black)
        .width(40)
        .height(32)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          if (this.quantity > 1) {
            this.quantity -= 1
          }
        })

      Text(this.quantity.toString())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(FurnColors.black)
        .width(24)
        .textAlign(TextAlign.Center)

      Text('+')
        .fontSize(16)
        .fontColor(FurnColors.black)
        .width(40)
        .height(32)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.quantity += 1
        })
    }
    .height(32)
    .backgroundColor(FurnColors.white)
    .borderRadius(12)
  }

  @Builder
  ContentSection() {
    Column() {
      Row() {
        Text('Modern Lounge')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(FurnColors.darkText)
        Blank()
          .layoutWeight(1)
        Row({ space: 4 }) {
          Text('*')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(FurnColors.gold)
          Text('4.8')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(FurnColors.black)
        }
      }
      .width('100%')

      Text('Armchair')
        .fontSize(20)
        .fontWeight(FontWeight.Lighter)
        .fontColor(FurnColors.gray)
        .width('100%')
        .margin({ top: -4 })

      Blank()
        .height(24)

      Text('Description')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(FurnColors.black)
        .width('100%')

      Blank()
        .height(8)

      Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
        .fontSize(14)
        .fontColor(FurnColors.gray)
        .lineHeight(22)
        .width('100%')

      Blank()
        .height(24)

      Row() {
        Column({ space: 8 }) {
          Text('Color')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(FurnColors.black)
          Row({ space: 12 }) {
            ForEach(this.swatches, (color: string, index?: number) => {
              this.ColorSwatch(color, index ? index : 0)
            })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Column({ space: 8 }) {
          Text('Quantity')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(FurnColors.black)
          this.QuantitySelector()
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')

      Blank()
        .height(100)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Total Price')
          .fontSize(14)
          .fontColor(FurnColors.gray)
        Text('$' + (245 * this.quantity).toString())
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(FurnColors.black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Cart  Add to Cart')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(FurnColors.white)
        .width(160)
        .height(50)
        .backgroundColor(FurnColors.darkText)
        .borderRadius(16)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(FurnColors.white)
    .borderRadius(24)
    .shadow({ radius: 16, color: '#1A000000', offsetY: -4 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.TopImageSection()
          this.ContentSection()
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      Column() {
        Blank()
          .layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(FurnColors.background)
  }
}
