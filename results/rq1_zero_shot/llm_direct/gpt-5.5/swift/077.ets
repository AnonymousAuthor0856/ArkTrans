@Entry
@Component
struct FurnitureShopApp {
  @State private isFavorite: boolean = false
  @State private selectedColorIndex: number = 0
  @State private quantity: number = 1

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Stack() {
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({
                  bottomLeft: 40,
                  bottomRight: 40
                })

              Stack() {
                Circle()
                  .width(200)
                  .height(200)
                  .fill(Color.White)
                  .shadow({
                    radius: 20,
                    color: '#33000000',
                    offsetX: 0,
                    offsetY: 10
                  })

                Text('⌂')
                  .fontSize(100)
                  .fontColor('#EFB495')
                  .fontWeight(FontWeight.Bold)
              }
              .width(200)
              .height(200)

              Column() {
                Row() {
                  Button() {
                    Text('←')
                      .fontSize(20)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Color.Black)
                  }
                  .width(42)
                  .height(42)
                  .backgroundColor(Color.White)
                  .borderRadius(21)
                  .padding(0)

                  Blank()

                  Button() {
                    Text(this.isFavorite ? '♥' : '♡')
                      .fontSize(22)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.isFavorite ? Color.Red : Color.Black)
                  }
                  .width(42)
                  .height(42)
                  .backgroundColor(Color.White)
                  .borderRadius(21)
                  .padding(0)
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
                    .fontSize(20)
                    .fontColor('#FFC107')

                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
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
                .fontColor(Color.Gray)
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
                      Stack() {
                        Circle()
                          .width(30)
                          .height(30)
                          .fill(item)

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
                        this.selectedColorIndex = index
                      })
                    })
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
                    Text('-')
                      .fontSize(20)
                      .fontColor(Color.Black)
                      .textAlign(TextAlign.Center)
                      .width(40)
                      .height(32)
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity--
                        }
                      })

                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(Color.Black)
                      .textAlign(TextAlign.Center)
                      .minWidth(20)

                    Text('+')
                      .fontSize(20)
                      .fontColor(Color.Black)
                      .textAlign(TextAlign.Center)
                      .width(40)
                      .height(32)
                      .onClick(() => {
                        this.quantity++
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
                .height(100)
            }
            .width('100%')
            .padding(24)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        Row() {
          Column({ space: 2 }) {
            Text('Total Price')
              .fontSize(14)
              .fontColor(Color.Gray)

            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Row({ space: 8 }) {
              Text('🛒')
                .fontSize(20)

              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .width(160)
            .height(50)
          }
          .width(160)
          .height(50)
          .backgroundColor('#333333')
          .fontColor(Color.White)
          .borderRadius(16)
          .padding(0)
        }
        .width('100%')
        .padding(24)
        .backgroundColor(Color.White)
        .borderRadius({
          topLeft: 24,
          topRight: 24
        })
        .shadow({
          radius: 16,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -4
        })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}