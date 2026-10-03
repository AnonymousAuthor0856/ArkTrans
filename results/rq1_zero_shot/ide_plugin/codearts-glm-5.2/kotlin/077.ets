@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1
  private colorOptions: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  @Builder
  ColorDotBuilder(color: string, index: number) {
    Column() {}
      .width(30)
      .height(30)
      .backgroundColor(color)
      .borderRadius(15)
      .borderWidth(this.selectedColorIndex === index ? 2 : 0)
      .borderColor(this.selectedColorIndex === index ? '#000000' : '#00000000')
      .onClick(() => {
        this.selectedColorIndex = index
      })
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          Stack() {
            Column() {
              Text('🏠')
                .fontSize(80)
                .fontColor('#EFB495')
            }
            .width(200)
            .height(200)
            .backgroundColor('#FFFFFF')
            .borderRadius(100)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Row() {
              Column() {
                Text('←')
                  .fontSize(20)
                  .fontColor('#000000')
              }
              .width(42)
              .height(42)
              .backgroundColor('#FFFFFF')
              .borderRadius(21)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)

              Column() {
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(20)
                  .fontColor(this.isFavorite ? '#FF0000' : '#000000')
              }
              .width(42)
              .height(42)
              .backgroundColor('#FFFFFF')
              .borderRadius(21)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .onClick(() => {
                this.isFavorite = !this.isFavorite
              })
            }
            .width('100%')
            .padding(24)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Top)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({ topLeft: 0, topRight: 0, bottomLeft: 40, bottomRight: 40 })

          Column() {
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .layoutWeight(1)

              Row() {
                Text('★')
                  .fontSize(20)
                  .fontColor('#FFC107')
                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
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
              .fontColor('#888888')
              .margin({ top: 4 })

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .margin({ top: 24 })

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#888888')
              .lineHeight(22)
              .margin({ top: 8 })

            Row() {
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Row() {
                  ForEach(this.colorOptions, (color: string, index: number) => {
                    this.ColorDotBuilder(color, index)
                  }, (color: string) => color)
                }
                .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Row() {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      if (this.quantity > 1) this.quantity--
                    })

                  Text(`${this.quantity}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })

                  Text('+')
                    .fontSize(20)
                    .fontColor('#000000')
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      this.quantity++
                    })
                }
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ top: 8 })
                .alignItems(VerticalAlign.Center)
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Top)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .padding({ bottom: 80 })

      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#888888')
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Button('Add to Cart') {
            Row() {
              Text('🛒')
                .fontSize(18)
              Text('Add to Cart')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .margin({ left: 8 })
            }
            .alignItems(VerticalAlign.Center)
          }
            .type(ButtonType.Normal)
            .backgroundColor('#333333')
            .borderRadius(16)
            .width(160)
            .height(50)
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24, bottomLeft: 0, bottomRight: 0 })
      .position({ x: 0, y: '100%' })
      .markAnchor({ x: 0, y: '100%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}