@Entry
@Component
struct Index {
  build() {
    FurnitureDetailScreen()
  }
}

@Component
struct FurnitureDetailScreen {
  @State private isFavorite: boolean = false
  @State private selectedColorIndex: number = 0
  @State private quantity: number = 1

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack() {
      Scroll() {
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width('100%')
              .height(400)
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            Stack({ alignContent: Alignment.Center }) {
              Text('⌂')
                .fontSize(120)
                .fontWeight(FontWeight.Bold)
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
              offsetY: 10
            })

            Column() {
              Row() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('←')
                    .fontSize(34)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black)
                }
                .width(42)
                .height(42)
                .borderRadius(21)
                .backgroundColor(Color.White)
                .onClick(() => {
                })

                Blank()

                Stack({ alignContent: Alignment.Center }) {
                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(34)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .width(42)
                .height(42)
                .borderRadius(21)
                .backgroundColor(Color.White)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite
                })
              }
              .width('100%')
              .padding(24)

              Blank()
            }
            .width('100%')
            .height(400)
          }
          .width('100%')
          .height(400)

          Column() {
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              Blank()

              Row({ space: 4 }) {
                Text('★')
                  .fontSize(32)
                  .fontColor('#FFC107')

                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#8E8E93')
              .margin({ top: -4 })

            Blank()
              .height(24)

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)

            Blank()
              .height(8)

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#8E8E93')
              .lineHeight(22)

            Blank()
              .height(24)

            Row() {
              Column({ space: 8 }) {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.Black)

                Row({ space: 12 }) {
                  ForEach(this.colors, (item: string, index: number) => {
                    Stack()
                      .width(30)
                      .height(30)
                      .borderRadius(15)
                      .backgroundColor(item)
                      .border({
                        width: this.selectedColorIndex === index ? 2 : 0,
                        color: Color.Black
                      })
                      .onClick(() => {
                        this.selectedColorIndex = index
                      })
                  }, (item: string) => item)
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Column({ space: 8 }) {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.Black)

                Row() {
                  Stack({ alignContent: Alignment.Center }) {
                    Text('-')
                      .fontSize(20)
                      .fontColor(Color.Black)
                  }
                  .width(40)
                  .height(32)
                  .onClick(() => {
                    if (this.quantity > 1) {
                      this.quantity -= 1
                    }
                  })

                  Text(this.quantity.toString())
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                    .textAlign(TextAlign.Center)
                    .minWidth(20)

                  Stack({ alignContent: Alignment.Center }) {
                    Text('+')
                      .fontSize(20)
                      .fontColor(Color.Black)
                  }
                  .width(40)
                  .height(32)
                  .onClick(() => {
                    this.quantity += 1
                  })
                }
                .height(32)
                .backgroundColor(Color.White)
                .borderRadius(12)
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            Blank()
              .height(120)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(24)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)

      Column() {
        Blank()

        Row() {
          Column({ space: 2 }) {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#8E8E93')

            Text('$' + (245 * this.quantity).toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Row({ space: 8 }) {
            Text('🛒')
              .fontSize(22)
              .fontColor(Color.White)

            Text('Add to Cart')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .width(160)
          .height(50)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#333333')
          .borderRadius(16)
          .onClick(() => {
          })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 34 })
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 16,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -4
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}