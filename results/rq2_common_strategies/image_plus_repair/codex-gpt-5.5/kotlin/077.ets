@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private readonly accent: string = '#EFB495'
  private readonly pageBackground: string = '#F5F5F7'
  private readonly heroBackground: string = '#E8E8E8'
  private readonly darkText: string = '#333333'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          this.buildHero()
          this.buildDetails()
        }
        .width('100%')
        .padding({ bottom: 112 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      this.buildBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBackground)
  }

  @Builder
  buildHero() {
    Stack({ alignContent: Alignment.Center }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('⌂')
          .fontSize(84)
          .fontColor(this.accent)
          .fontWeight(FontWeight.Bold)
      }
      .width(200)
      .height(200)
      .borderRadius(100)
      .backgroundColor(Color.White)
      .shadow({
        radius: 20,
        color: '#45000000',
        offsetX: 0,
        offsetY: 10
      })

      Row() {
        this.buildRoundIcon('←', () => {
          // Navigation is intentionally local to this standalone screen.
        })

        Blank()
          .layoutWeight(1)

        this.buildRoundIcon(this.isFavorite ? '♥' : '♡', () => {
          this.isFavorite = !this.isFavorite
        }, this.isFavorite ? '#E53935' : Color.Black)
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 48 })
      .align(Alignment.Top)
    }
    .width('100%')
    .height(400)
    .borderRadius({
      bottomLeft: 40,
      bottomRight: 40
    })
    .backgroundColor(this.heroBackground)
  }

  @Builder
  buildRoundIcon(icon: string, action: () => void, tint: ResourceColor = Color.Black) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text(icon)
        .fontSize(icon === '←' ? 38 : 36)
        .fontColor(tint)
        .fontWeight(FontWeight.Normal)
    }
    .width(84)
    .height(84)
    .backgroundColor(Color.White)
    .onClick(action)
  }

  @Builder
  buildDetails() {
    Column() {
      Row() {
        Column() {
          Text('Modern Lounge')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.darkText)
            .maxLines(1)

          Text('Armchair')
            .fontSize(20)
            .fontColor('#888888')
            .margin({ top: -2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Row() {
          Text('★')
            .fontSize(27)
            .fontColor('#FFC107')
          Text('4.8')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text('Description')
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 62 })

      Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
        .width('100%')
        .fontSize(14)
        .lineHeight(22)
        .fontColor('#888888')
        .margin({ top: 8 })

      Row() {
        Column() {
          Text('Color')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Row() {
            this.buildColorDot(0, this.accent, 0)
            this.buildColorDot(1, '#8D6E63', 12)
            this.buildColorDot(2, '#5D4037', 12)
          }
          .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Column() {
          Text('Quantity')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Row() {
            Text('-')
              .fontSize(20)
              .fontColor(Color.Black)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .onClick(() => {
                if (this.quantity > 1) {
                  this.quantity--
                }
              })

            Text(this.quantity.toString())
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .padding({ left: 8, right: 8 })

            Text('+')
              .fontSize(24)
              .fontColor(Color.Black)
              .padding({ left: 8, right: 8, top: 1, bottom: 1 })
              .onClick(() => {
                this.quantity++
              })
          }
          .height(42)
          .borderRadius(12)
          .backgroundColor(Color.White)
          .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .margin({ top: 24 })
    }
    .width('100%')
    .padding({ left: 48, right: 48, top: 50 })
  }

  @Builder
  buildColorDot(index: number, color: string, marginLeft: number) {
    Stack()
      .width(30)
      .height(30)
      .margin({ left: marginLeft })
      .borderRadius(15)
      .backgroundColor(color)
      .border({
        width: this.selectedColorIndex === index ? 2 : 0,
        color: Color.Black,
        radius: 15
      })
      .onClick(() => {
        this.selectedColorIndex = index
      })
  }

  @Builder
  buildBottomBar() {
    Row() {
      Column() {
        Text('Total Price')
          .fontSize(14)
          .fontColor('#888888')
        Text(`$${245 * this.quantity}`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button({ type: ButtonType.Normal }) {
        Row() {
          Text('🛒')
            .fontSize(25)
            .fontColor(Color.White)
          Text('Add to Cart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ left: 12 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(320)
      .height(102)
      .borderRadius(28)
      .backgroundColor(this.darkText)
      .onClick(() => {})
    }
    .width('100%')
    .height(170)
    .padding({ left: 48, right: 48 })
    .backgroundColor(Color.White)
    .borderRadius({
      topLeft: 24,
      topRight: 24
    })
    .shadow({
      radius: 16,
      color: '#26000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}
