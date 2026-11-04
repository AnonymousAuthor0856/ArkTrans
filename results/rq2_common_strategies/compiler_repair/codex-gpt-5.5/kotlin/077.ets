class ColorOption {
  value: string

  constructor(value: string) {
    this.value = value
  }
}

@Entry
@Component
struct Index {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: ColorOption[] = [
    new ColorOption('#EFB495'),
    new ColorOption('#8D6E63'),
    new ColorOption('#5D4037')
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Stack() {
            Stack() {
              Circle()
                .width(200)
                .height(200)
                .fill(Color.White)
                .shadow({ radius: 20, color: 'rgba(0,0,0,0.16)', offsetY: 10 })
              Text('⌂')
                .fontSize(96)
                .fontColor('#EFB495')
                .fontWeight(FontWeight.Bold)
            }
            .align(Alignment.Center)

            Row() {
              Button('‹')
                .fontSize(28)
                .fontColor(Color.Black)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .width(42)
                .height(42)
                .padding(0)

              Button(this.isFavorite ? '♥' : '♡')
                .fontSize(24)
                .fontColor(this.isFavorite ? Color.Red : Color.Black)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .width(42)
                .height(42)
                .padding(0)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(24)
            .align(Alignment.Top)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })

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
                  .fontColor(Color.Black)
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .width('100%')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor(Color.Gray)
              .margin({ top: 2 })

            Text('Description')
              .width('100%')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })
            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .width('100%')
              .fontSize(14)
              .fontColor(Color.Gray)
              .lineHeight(22)
              .margin({ top: 8 })

            Row() {
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
                Row() {
                  ForEach(this.colors, (item: ColorOption, index: number) => {
                    Circle()
                      .width(30)
                      .height(30)
                      .fill(item.value)
                      .border({ width: this.selectedColorIndex === index ? 2 : 0, color: this.selectedColorIndex === index ? Color.Black : Color.Transparent })
                      .onClick(() => {
                        this.selectedColorIndex = index
                      })
                      .margin({ right: 12 })
                  })
                }
                .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
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
                    .fontColor(Color.Black)
                    .padding({ left: 8, right: 8 })
                  Text('+')
                    .fontSize(20)
                    .fontColor(Color.Black)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      this.quantity++
                    })
                }
                .height(40)
                .padding({ left: 8, right: 8 })
                .borderRadius(12)
                .backgroundColor(Color.White)
                .alignItems(VerticalAlign.Center)
                .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
          .margin({ bottom: 96 })
        }
        .width('100%')
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
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Button() {
          Row() {
            Text('🛒')
              .fontSize(18)
              .fontColor(Color.White)
            Text('Add to Cart')
              .fontSize(15)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .width(160)
        .height(50)
        .borderRadius(16)
        .backgroundColor('#333333')
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 16, color: 'rgba(0,0,0,0.16)', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
