@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;
  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];

  build() {
    Column() {
      Scroll() {
        Column() {
          // Top image section with rounded bottom corners
          Stack() {
            // Circular white area with house icon
            Stack() {
              Column() {
                // Simple house shape using text emoji
                Text('\u{2302}')
                  .fontSize(100)
                  .fontColor('#EFB495')
              }
            }
            .width(200)
            .height(200)
            .backgroundColor(Color.White)
            .borderRadius(100)
            .shadow({ radius: 20, color: '#40000000' })

            // Top action buttons row
            Row() {
              // Back button
              Stack() {
                Text('\u{2039}')
                  .fontSize(32)
                  .fontColor(Color.Black)
                  .margin({ bottom: 4 })
              }
              .width(42)
              .height(42)
              .backgroundColor(Color.White)
              .borderRadius(21)

              // Favorite button
              Stack() {
                Text(this.isFavorite ? '\u{2764}' : '\u{2661}')
                  .fontSize(22)
                  .fontColor(this.isFavorite ? Color.Red : Color.Black)
              }
              .width(42)
              .height(42)
              .backgroundColor(Color.White)
              .borderRadius(21)
              .onClick(() => {
                this.isFavorite = !this.isFavorite;
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding({ left: 24, right: 24, top: 24 })
          }
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })
          .clip(true)

          // Content section
          Column() {
            // Title and rating row
            Row() {
              Column() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
                Text('Armchair')
                  .fontSize(20)
                  .fontWeight(FontWeight.Lighter)
                  .fontColor(Color.Gray)
                  .margin({ top: -4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              // Rating
              Row() {
                Text('\u{2605}')
                  .fontSize(20)
                  .fontColor('#FFC107')
                Text('4.8')
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Description
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
              .margin({ top: 24 })

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor(Color.Gray)
              .lineHeight(22)
              .margin({ top: 8 })

            // Color and quantity row
            Row() {
              // Color selector
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                Row() {
                  ForEach(this.colors, (color: string, index: number) => {
                    Stack() {
                      Stack() {
                      }
                      .width(this.selectedColorIndex === index ? 26 : 30)
                      .height(this.selectedColorIndex === index ? 26 : 30)
                      .backgroundColor(color)
                      .borderRadius(this.selectedColorIndex === index ? 13 : 15)
                    }
                    .width(30)
                    .height(30)
                    .backgroundColor(this.selectedColorIndex === index ? Color.Black : Color.Transparent)
                    .borderRadius(15)
                    .alignContent(Alignment.Center)
                    .margin({ right: 12 })
                    .onClick(() => {
                      this.selectedColorIndex = index;
                    })
                  })
                }
                .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              // Quantity selector
              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                Row() {
                  Text('-')
                    .fontSize(20)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity--;
                      }
                    })
                  Text(this.quantity.toString())
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .padding({ left: 8, right: 8 })
                  Text('+')
                    .fontSize(20)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      this.quantity++;
                    })
                }
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)

      // Bottom bar
      Row() {
        Column() {
          Text('Total Price')
            .fontColor(Color.Gray)
            .fontSize(14)
          Text('$' + (245 * this.quantity).toString())
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // Add to Cart button
        Row() {
          Text('\u{1F6D2}')
            .fontSize(20)
          Text('Add to Cart')
            .fontColor(Color.White)
            .fontSize(16)
            .margin({ left: 8 })
        }
        .width(160)
        .height(50)
        .backgroundColor('#333333')
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#20000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}
