@Entry
@Component
struct FurnitureDetailPage {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: ResourceColor[] = [
    '#EFB495',
    '#8D6E63',
    '#5D4037'
  ]

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            // Top Image Section
            Stack() {
              // Background shape with bottom rounded corners
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({
                  bottomLeft: 40,
                  bottomRight: 40
                })

              // Centered Icon Container
              Stack() {
                Circle({ width: 200, height: 200 })
                  .fill(Color.White)
                  .shadow({
                    radius: 20,
                    color: 'rgba(0,0,0,0.2)',
                    offsetY: 10
                  })

                Text('\u{e88a}')
                  .fontSize(100)
                  .fontColor('#EFB495')
                  .fontFamily('Material Icons')
              }

              // Top Buttons
              Column() {
                Row() {
                  // Back Button
                  Button() {
                    Text('\u{e5c4}')
                      .fontSize(20)
                      .fontColor(Color.Black)
                      .fontFamily('Material Icons')
                  }
                  .width(42)
                  .height(42)
                  .type(ButtonType.Circle)
                  .backgroundColor(Color.White)
                  .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })

                  Blank()

                  // Favorite Button
                  Button() {
                    Text(this.isFavorite ? '\u{e87d}' : '\u{e87e}')
                      .fontSize(20)
                      .fontColor(this.isFavorite ? Color.Red : Color.Black)
                      .fontFamily('Material Icons')
                  }
                  .width(42)
                  .height(42)
                  .type(ButtonType.Circle)
                  .backgroundColor(Color.White)
                  .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
                  .onClick(() => {
                    this.isFavorite = !this.isFavorite
                  })
                }
                .width('100%')
                .padding({ left: 24, right: 24, top: 24 })

                Blank()
              }
              .width('100%')
              .height(400)
            }
            .width('100%')

            // Content Section
            Column() {
              // Title and Rating
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Blank()

                Row() {
                  Text('\u{e838}')
                    .fontSize(20)
                    .fontColor('#FFC107')
                    .fontFamily('Material Icons')
                    .margin({ right: 4 })

                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(600)
                .fontColor(Color.Black)
                .margin({ top: 24 })

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
                .margin({ top: 8 })

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(Color.Black)
                    .margin({ bottom: 8 })

                  Row() {
                    ForEach(this.colors, (color: ResourceColor, index: number) => {
                      Stack() {
                        Circle({ width: 30, height: 30 })
                          .fill(color)

                        if (this.selectedColorIndex === index) {
                          Circle({ width: 30, height: 30 })
                            .fill(null)
                            .stroke(Color.Black, 2)
                        }
                      }
                      .margin({ right: index < this.colors.length - 1 ? 12 : 0 })
                      .onClick(() => {
                        this.selectedColorIndex = index
                      })
                    }, (color: ResourceColor, index: number) => index.toString())
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                // Quantity Selection
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(Color.Black)
                    .margin({ bottom: 8 })

                  Row() {
                    Text('-')
                      .fontSize(20)
                      .fontColor(Color.Black)
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
                      .fontColor(Color.Black)
                      .minWidth(20)
                      .textAlign(TextAlign.Center)

                    Text('\u{e145}')
                      .fontSize(16)
                      .fontColor(Color.Black)
                      .fontFamily('Material Icons')
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.quantity += 1
                      })
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .margin({ top: 24 })
              .alignItems(VerticalAlign.Top)

              // Extra bottom padding
              Blank()
                .height(100)
            }
            .width('100%')
            .padding(24)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // Bottom Surface
      Column() {
        Blank()

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

          Blank()

          Button() {
            Row() {
              Text('\u{e8cc}')
                .fontSize(20)
                .fontColor(Color.White)
                .fontFamily('Material Icons')
                .margin({ right: 8 })

              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width(160)
          .height(50)
          .type(ButtonType.Capsule)
          .backgroundColor('#333333')
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
          color: 'rgba(0,0,0,0.1)',
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
