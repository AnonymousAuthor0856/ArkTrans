const colorOptions: string[] = ['#EFB495', '#8D6E63', '#5D4037'];

@Entry
@Component
struct Index {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  build() {
    Column() {
      Scroll() {
        Column() {
          Stack() {
            Stack() {
              Text('⌂')
                .fontSize(50)
                .fontColor('#EFB495')
            }
            .width(200)
            .height(200)
            .borderRadius(100)
            .backgroundColor('#FFFFFF')
            .shadow({ radius: 20, color: '#33000000', offsetY: 0 })

            Row() {
              Stack() {
                Text('←')
                  .fontSize(20)
                  .fontColor('#000000')
              }
              .width(42)
              .height(42)
              .borderRadius(21)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
              })

              Stack() {
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(20)
                  .fontColor(this.isFavorite ? '#FF0000' : '#000000')
              }
              .width(42)
              .height(42)
              .borderRadius(21)
              .backgroundColor('#FFFFFF')
              .onClick(() => {
                this.isFavorite = !this.isFavorite;
              })
            }
            .width('100%')
            .padding(24)
            .justifyContent(FlexAlign.SpaceBetween)
            .position({ x: 0, y: 0 })
          }
          .width('100%')
          .height(400)
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })
          .backgroundColor('#E8E8E8')

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
              .margin({ top: -4 })

            Blank().height(24)

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
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
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                Blank().height(8)
                Row({ space: 12 }) {
                  ForEach(colorOptions, (color: string, index: number) => {
                    Stack() {
                    }
                    .width(30)
                    .height(30)
                    .borderRadius(15)
                    .backgroundColor(color)
                    .border({ width: this.selectedColorIndex === index ? 2 : 0, color: this.selectedColorIndex === index ? '#000000' : '#00000000' })
                    .onClick(() => {
                      this.selectedColorIndex = index;
                    })
                  }, (color: string, index: number) => index.toString())
                }
              }

              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                Blank().height(8)
                Row() {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity -= 1;
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
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      this.quantity += 1;
                    })
                }
                .alignItems(VerticalAlign.Center)
                .backgroundColor('#FFFFFF')
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
          .padding({ bottom: 40 })
        }
      }
      .layoutWeight(1)

      Row() {
        Column() {
          Text('Total Price')
            .fontSize(14)
            .fontColor('#808080')
          Text('$' + (245 * this.quantity))
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        Button('Add to Cart')
          .width(160)
          .height(50)
          .backgroundColor('#333333')
          .fontColor('#FFFFFF')
          .borderRadius(16)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#33000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
