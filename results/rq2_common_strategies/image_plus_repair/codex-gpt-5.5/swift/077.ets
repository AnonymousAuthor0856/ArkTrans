@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack() {
      Column({ space: 0 }) {
        Scroll() {
          Column({ space: 0 }) {
            Stack() {
              Column() {}
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40 })

              Stack() {
                Circle()
                  .width(200)
                  .height(200)
                  .fill('#FFFFFF')
                  .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 10 })
                Text('⌂')
                  .fontSize(112)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(this.colors[this.selectedColorIndex])
                  .margin({ top: -12 })
              }
              .width(200)
              .height(200)
              .align(Alignment.Center)

              Row() {
                Button() {
                  Text('←')
                    .fontSize(30)
                    .fontColor('#000000')
                    .width(42)
                    .height(42)
                    .textAlign(TextAlign.Center)
                }
                .width(42)
                .height(42)
                .padding(0)
                .backgroundColor('#FFFFFF')
                .borderRadius(21)

                Blank().layoutWeight(1)

                Button() {
                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(29)
                    .fontColor(this.isFavorite ? '#E53935' : '#000000')
                    .width(42)
                    .height(42)
                    .textAlign(TextAlign.Center)
                }
                .width(42)
                .height(42)
                .padding(0)
                .backgroundColor('#FFFFFF')
                .borderRadius(21)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite
                })
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24 })
              .alignItems(VerticalAlign.Top)
            }
            .width('100%')
            .height(400)

            Column({ space: 0 }) {
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                  .layoutWeight(1)
                Row({ space: 4 }) {
                  Text('★')
                    .fontSize(22)
                    .fontColor('#FFC107')
                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              Text('Armchair')
                .fontSize(20)
                .fontColor('#909094')
                .margin({ top: -4 })

              Blank().height(24)
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
              Blank().height(8)
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor('#909094')
                .lineHeight(23)
              Blank().height(24)

              Row() {
                Column({ space: 8 }) {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Row({ space: 12 }) {
                    ForEach(this.colors, (color: string, index: number) => {
                      Circle()
                        .width(30)
                        .height(30)
                        .fill(color)
                        .border({
                          width: this.selectedColorIndex === index ? 2 : 0,
                          color: '#000000'
                        })
                        .onClick(() => {
                          this.selectedColorIndex = index
                        })
                    }, (color: string, index: number) => `${index}`)
                  }
                }
                Blank().layoutWeight(1)
                Column({ space: 8 }) {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                  Row() {
                    Text('-')
                      .fontSize(22)
                      .fontColor('#000000')
                      .width(40)
                      .height(36)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity -= 1
                        }
                      })
                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#000000')
                      .width(20)
                      .textAlign(TextAlign.Center)
                    Text('+')
                      .fontSize(20)
                      .fontColor('#000000')
                      .width(40)
                      .height(36)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.quantity += 1
                      })
                  }
                  .height(36)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(12)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)

              Blank().height(110)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 24 })
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Row() {
          Column({ space: 2 }) {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#909094')
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Blank().layoutWeight(1)

          Button() {
            Row({ space: 8 }) {
              Text('🛒')
                .fontSize(21)
                .fontColor('#FFFFFF')
              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .justifyContent(FlexAlign.Center)
          }
          .width(160)
          .height(50)
          .padding(0)
          .backgroundColor('#333333')
          .borderRadius(16)
        }
        .width('100%')
        .height(98)
        .padding({ left: 24, right: 24 })
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 16, color: '#1A000000', offsetX: 0, offsetY: -4 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
