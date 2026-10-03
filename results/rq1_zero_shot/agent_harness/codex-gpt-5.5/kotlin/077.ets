@Entry
@Component
struct MainActivity {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];

  private increaseQuantity(): void {
    this.quantity++;
  }

  private decreaseQuantity(): void {
    if (this.quantity > 1) {
      this.quantity--;
    }
  }

  @Builder
  IconButton(label: string, color: string = '#000000') {
    Text(label)
      .fontSize(20)
      .fontColor(color)
      .textAlign(TextAlign.Center)
      .width(42)
      .height(42)
      .lineHeight(42)
      .backgroundColor('#FFFFFF')
      .borderRadius(21)
  }

  @Builder
  ColorSwatch(color: string, index: number) {
    Circle()
      .width(30)
      .height(30)
      .fill(color)
      .stroke(this.selectedColorIndex === index ? '#000000' : Color.Transparent)
      .strokeWidth(this.selectedColorIndex === index ? 2 : 0)
      .onClick(() => {
        this.selectedColorIndex = index;
      })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Total Price')
          .fontSize(14)
          .fontColor('#808080')
        Text(`$${245 * this.quantity}`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('🛒  Add to Cart')
        .fontSize(14)
        .fontColor('#FFFFFF')
        .width(160)
        .height(50)
        .backgroundColor('#333333')
        .borderRadius(16)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 16, color: '#33000000', offsetY: -4 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Stack() {
            Column() {
              Text('⌂')
                .fontSize(100)
                .fontColor('#EFB495')
                .textAlign(TextAlign.Center)
                .width(200)
                .height(200)
                .lineHeight(200)
                .backgroundColor('#FFFFFF')
                .borderRadius(100)
                .shadow({ radius: 20, color: '#33000000', offsetY: 8 })
            }
            .width('100%')
            .height(400)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor('#E8E8E8')
            .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            Row() {
              this.IconButton('‹')
              Text(this.isFavorite ? '♥' : '♡')
                .fontSize(22)
                .fontColor(this.isFavorite ? '#FF0000' : '#000000')
                .textAlign(TextAlign.Center)
                .width(42)
                .height(42)
                .lineHeight(42)
                .backgroundColor('#FFFFFF')
                .borderRadius(21)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
            }
            .width('100%')
            .padding(24)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(400)

          Column() {
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .layoutWeight(1)
              Row({ space: 4 }) {
                Text('★')
                  .fontSize(20)
                  .fontColor('#FFC107')
                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Light)
              .fontColor('#808080')
              .width('100%')
              .margin({ top: -4 })

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#000000')
              .width('100%')
              .margin({ top: 24, bottom: 8 })

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#808080')
              .lineHeight(22)
              .width('100%')

            Row() {
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor('#000000')
                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    this.ColorSwatch(color, index)
                  })
                }
                .margin({ top: 8 })
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor('#000000')
                Row() {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                    .onClick(() => { this.decreaseQuantity(); })
                  Text(`${this.quantity}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                  Text('+')
                    .fontSize(20)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                    .onClick(() => { this.increaseQuantity(); })
                }
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ top: 8 })
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .alignItems(VerticalAlign.Center)
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .margin({ top: 24 })
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(24)

          Blank().height(80)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
