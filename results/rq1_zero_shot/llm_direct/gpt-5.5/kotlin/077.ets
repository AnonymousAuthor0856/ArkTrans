@Entry
@Component
struct FurnitureDetailScreen {
  @State private isFavorite: boolean = false
  @State private selectedColorIndex: number = 0
  @State private quantity: number = 1

  private colorOptions: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('⌂')
                .fontSize(100)
                .fontColor('#EFB495')
            }
            .width(200)
            .height(200)
            .borderRadius(100)
            .backgroundColor(Color.White)
            .shadow({
              radius: 20,
              color: '#33000000',
              offsetX: 0,
              offsetY: 8
            })

            Row() {
              Button({ type: ButtonType.Circle, stateEffect: true }) {
                Text('‹')
                  .fontSize(34)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Normal)
              }
              .width(42)
              .height(42)
              .padding(0)
              .backgroundColor(Color.White)
              .onClick(() => {
              })

              Button({ type: ButtonType.Circle, stateEffect: true }) {
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(24)
                  .fontColor(this.isFavorite ? Color.Red : Color.Black)
              }
              .width(42)
              .height(42)
              .padding(0)
              .backgroundColor(Color.White)
              .onClick(() => {
                this.isFavorite = !this.isFavorite
              })
            }
            .width('100%')
            .padding(24)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .position({ x: 0, y: 0 })
          }
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({
            bottomLeft: 40,
            bottomRight: 40
          })

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
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
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
              .fontColor(Color.Gray)
              .offset({ y: -4 })
              .width('100%')

            Blank()
              .height(24)

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
              .width('100%')

            Blank()
              .height(8)

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor(Color.Gray)
              .lineHeight(22)
              .width('100%')

            Blank()
              .height(24)

            Row() {
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)

                Blank()
                  .height(8)

                Row() {
                  ForEach(this.colorOptions, (item: string, index: number) => {
                    Stack()
                      .width(30)
                      .height(30)
                      .borderRadius(15)
                      .backgroundColor(item)
                      .border({
                        width: this.selectedColorIndex === index ? 2 : 0,
                        color: this.selectedColorIndex === index ? Color.Black : Color.Transparent
                      })
                      .onClick(() => {
                        this.selectedColorIndex = index
                      })
                  }, (item: string) => item)
                }
                .justifyContent(FlexAlign.Start)
                .gap(12)
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)

                Blank()
                  .height(8)

                Row() {
                  Text('-')
                    .fontSize(20)
                    .fontColor(Color.Black)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity--
                      }
                    })

                  Text(this.quantity.toString())
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .padding({ left: 8, right: 8 })

                  Text('+')
                    .fontSize(20)
                    .fontColor(Color.Black)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      this.quantity++
                    })
                }
                .alignItems(VerticalAlign.Center)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({
                  left: 8,
                  right: 8,
                  top: 4,
                  bottom: 4
                })
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
        .width('100%')
        .padding({ bottom: 80 })
      }
      .width('100%')
      .height('100%')

      Row() {
        Column() {
          Text('Total Price')
            .fontSize(14)
            .fontColor(Color.Gray)

          Text('$' + (245 * this.quantity).toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Button({ stateEffect: true }) {
          Row() {
            Text('🛒')
              .fontSize(20)

            Blank()
              .width(8)

            Text('Add to Cart')
              .fontSize(14)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width(160)
        .height(50)
        .borderRadius(16)
        .backgroundColor('#333333')
        .onClick(() => {
        })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
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
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}