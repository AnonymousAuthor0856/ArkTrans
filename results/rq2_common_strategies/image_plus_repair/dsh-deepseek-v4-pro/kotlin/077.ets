@Entry
@Component
struct FurnitureDetailPage {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;
  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];

  build() {
    Column() {
      Scroll() {
        Column() {
          // Header image area
          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            // Centered circular badge with home icon
            Column() {
              Text('⌂')
                .fontSize(90)
                .fontColor('#EFB495')
            }
            .width(200)
            .height(200)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(Color.White)
            .borderRadius(100)
            .shadow({ radius: 20, color: '#1A000000', offsetX: 0, offsetY: 0 })

            // Top action bar
            Row() {
              Stack() {
                Text('←')
                  .fontSize(20)
                  .fontColor('#000000')
              }
              .width(42)
              .height(42)
              .alignContent(Alignment.Center)
              .backgroundColor(Color.White)
              .borderRadius(21)
              .onClick(() => {})

              Stack() {
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(22)
                  .fontColor(this.isFavorite ? '#FF0000' : '#000000')
              }
              .width(42)
              .height(42)
              .alignContent(Alignment.Center)
              .backgroundColor(Color.White)
              .borderRadius(21)
              .onClick(() => {
                this.isFavorite = !this.isFavorite;
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: 24, right: 24, top: 24 })
            .position({ x: 0, y: 0 })
          }
          .width('100%')
          .height(400)

          // Content column
          Column() {
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              Row() {
                Text('★')
                  .fontSize(20)
                  .fontColor('#FFC107')
                Text('4.8')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .fontColor('#000000')
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#808080')
              .offset({ y: -4 })

            Blank().height(24)

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')

            Blank().height(8)

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#808080')
              .lineHeight(22)

            Blank().height(24)

            Row() {
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Blank().height(8)

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Column()
                      .width(30)
                      .height(30)
                      .borderRadius(15)
                      .backgroundColor(color)
                      .border({
                        width: this.selectedColorIndex === index ? 2 : 0,
                        color: this.selectedColorIndex === index ? '#000000' : '#00000000'
                      })
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                  }, (color: string, index: number) => color + index.toString())
                }
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Blank().height(8)

                Row() {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity--;
                      }
                    })
                  Text(this.quantity.toString())
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                  Text('+')
                    .fontSize(20)
                    .fontColor('#000000')
                    .onClick(() => {
                      this.quantity++;
                    })
                }
                .alignItems(VerticalAlign.Center)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(24)
        }
        .padding({ bottom: 80 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollable(ScrollDirection.Vertical)

      // Bottom bar
      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontColor('#808080')
              .fontSize(14)
            Text('$' + (245 * this.quantity).toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Button() {
            Row() {
              Text('🛒')
                .fontSize(20)
              Text('Add to Cart')
                .fontSize(16)
                .fontColor(Color.White)
                .margin({ left: 8 })
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .height(50)
          .width(160)
          .backgroundColor('#333333')
          .borderRadius(16)
          .onClick(() => {})
        }
        .padding(24)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#33000000', offsetX: 0, offsetY: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
