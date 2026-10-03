@Entry
@Component
struct FurnitureDetailScreen {
  @State private isFavorite: boolean = false;
  @State private selectedColorIndex: number = 0;
  @State private quantity: number = 1;
  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];

  @Builder
  private TopImageSection() {
    Stack() {
      Rect()
        .width('100%')
        .height(400)
        .fill('#E8E8E8')
        .radius({ bottomLeft: 40, bottomRight: 40 })

      Stack() {
        Circle()
          .width(200)
          .height(200)
          .fill(Color.White)
          .shadow({ radius: 20, color: '#00000033', offsetX: 0, offsetY: 10 })
        Text('⌂')
          .fontSize(92)
          .fontColor('#EFB495')
      }
      .width(200)
      .height(200)

      Column() {
        Row() {
          Button('←')
            .width(42)
            .height(42)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .backgroundColor(Color.White)
            .borderRadius(21)
          Blank()
          Button(this.isFavorite ? '♥' : '♡')
            .width(42)
            .height(42)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isFavorite ? Color.Red : Color.Black)
            .backgroundColor(Color.White)
            .borderRadius(21)
            .onClick(() => {
              this.isFavorite = !this.isFavorite;
            })
        }
        .padding(24)
        .width('100%')
        Blank()
      }
      .height(400)
      .width('100%')
    }
    .width('100%')
    .height(400)
  }

  @Builder
  private ColorDot(color: string, index: number) {
    Stack() {
      Circle()
        .width(30)
        .height(30)
        .fill(color)
      if (this.selectedColorIndex === index) {
        Circle()
          .width(30)
          .height(30)
          .fill(Color.Transparent)
          .stroke(Color.Black)
          .strokeWidth(2)
      }
    }
    .width(30)
    .height(30)
    .onClick(() => {
      this.selectedColorIndex = index;
    })
  }

  @Builder
  private QuantitySelector() {
    Row({ space: 0 }) {
      Text('-')
        .fontSize(20)
        .fontColor(Color.Black)
        .width(40)
        .height(32)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          if (this.quantity > 1) {
            this.quantity -= 1;
          }
        })
      Text(this.quantity.toString())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .constraintSize({ minWidth: 20 })
        .textAlign(TextAlign.Center)
      Text('+')
        .fontSize(16)
        .fontColor(Color.Black)
        .width(40)
        .height(32)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.quantity += 1;
        })
    }
    .backgroundColor(Color.White)
    .borderRadius(12)
  }

  @Builder
  private ContentSection() {
    Column({ space: 0 }) {
      Row() {
        Text('Modern Lounge')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
        Blank()
        Row({ space: 4 }) {
          Text('★')
            .fontSize(20)
            .fontColor('#FFC107')
          Text('4.8')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
      }
      .width('100%')

      Text('Armchair')
        .fontSize(20)
        .fontWeight(FontWeight.Lighter)
        .fontColor('#808080')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: -4 })

      Blank().height(24)

      Text('Description')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Start)

      Blank().height(8)

      Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
        .fontSize(14)
        .fontColor('#808080')
        .lineHeight(22)
        .width('100%')

      Blank().height(24)

      Row() {
        Column({ space: 8 }) {
          Text('Color')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
          Row({ space: 12 }) {
            ForEach(this.colors, (color: string, index: number) => {
              this.ColorDot(color, index)
            })
          }
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Column({ space: 8 }) {
          Text('Quantity')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(Color.Black)
          this.QuantitySelector()
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Blank().height(100)
    }
    .padding(24)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private BottomSurface() {
    Row() {
      Column({ space: 2 }) {
        Text('Total Price')
          .fontSize(14)
          .fontColor('#808080')
        Text(`$${245 * this.quantity}`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button('🛒  Add to Cart')
        .width(160)
        .height(50)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .backgroundColor('#333333')
        .borderRadius(16)
    }
    .padding(24)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 16, color: '#0000001A', offsetX: 0, offsetY: -4 })
  }

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column({ space: 0 }) {
            this.TopImageSection()
            this.ContentSection()
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomSurface()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
