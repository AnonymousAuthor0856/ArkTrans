@Entry
@Component
struct FurnitureShopApp {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')

      // Top image section (grey area with circle)
      Stack() {
        Column()
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })

        // Centered white circle with house icon
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(200)
            .height(200)
            .backgroundColor('#FFFFFF')
            .borderRadius(100)
            .shadow({ radius: 20, color: '#33000000', offsetY: 10 })
          Text('🛋️')
            .fontSize(80)
        }
        .position({ x: '50%', y: '50%' })

        // Top buttons: back and favourite
        Row({ space: 0 }) {
          Button() {
            Text('←')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#000000')
              .width(42)
              .height(42)
              .textAlign(TextAlign.Center)
          }
          .width(42)
          .height(42)
          .backgroundColor('#FFFFFF')
          .borderRadius(21)
          .margin({ left: 24 })

          Blank()

          Button() {
            Text(this.isFavorite ? '♥' : '♡')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor(this.isFavorite ? '#FF0000' : '#000000')
              .width(42)
              .height(42)
              .textAlign(TextAlign.Center)
          }
          .width(42)
          .height(42)
          .backgroundColor('#FFFFFF')
          .borderRadius(21)
          .margin({ right: 24 })
          .onClick(() => {
            this.isFavorite = !this.isFavorite
          })
        }
        .width('100%')
        .height(400)
        .alignItems(VerticalAlign.Top)
        .padding({ top: 24 })
      }
      .width('100%')

      // Scrollable content below image (using List with ListItem)
      List({ space: 0 }) {
        ListItem() {
          Column({ space: 0 }) {
            // Title and rating
            Row({ space: 0 }) {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .foregroundColor('#333333')
              Blank()
              Row({ space: 4 }) {
                Text('★')
                  .fontSize(20)
                  .foregroundColor('#FFC107')
                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .foregroundColor('#000000')
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Subtitle
            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Normal)
              .foregroundColor('#808080')
              .margin({ top: -4 })

            Blank().height(24)

            // Description title
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#000000')

            Blank().height(8)

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .foregroundColor('#808080')
              .lineHeight(22) // Use lineHeight instead of lineSpacing

            Blank().height(24)

            // Color and Quantity row
            Row({ space: 0 }) {
              // Color selection
              Column({ space: 8 }) {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#000000')

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, i: number) => {
                    Stack({ alignContent: Alignment.Center }) {
                      Column()
                        .width(30)
                        .height(30)
                        .borderRadius(15)
                        .backgroundColor(color)
                        .border({
                          width: this.selectedColorIndex === i ? 2 : 0,
                          color: '#000000'
                        })
                    }
                    .width(30)
                    .height(30)
                    .onClick(() => {
                      this.selectedColorIndex = i
                    })
                  })
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              // Quantity selection
              Column({ space: 8 }) {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#000000')
                  .alignSelf(ItemAlign.End)

                Row({ space: 0 }) {
                  Text('-')
                    .fontSize(20)
                    .foregroundColor('#000000')
                    .width(40)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity -= 1
                      }
                    })
                  Text(this.quantity.toString())
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .foregroundColor('#000000')
                    .width(30)
                    .textAlign(TextAlign.Center)
                  Text('+')
                    .fontSize(16)
                    .foregroundColor('#000000')
                    .width(40)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      this.quantity += 1
                    })
                }
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            // Extra bottom padding
            Blank().height(100)
          }
          .width('100%')
          .padding(24)
        }
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom bar (overlay)
      Column() {
        Blank()
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Total Price')
              .fontSize(14)
              .foregroundColor('#808080')
            Text('$' + (245 * this.quantity).toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#000000')
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
                .foregroundColor('#FFFFFF')
            }
            .width(160)
            .height(50)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
          }
          .width(160)
          .height(50)
          .backgroundColor('#333333')
          .borderRadius(16)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 16, color: '#1A000000', offsetY: -4 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}