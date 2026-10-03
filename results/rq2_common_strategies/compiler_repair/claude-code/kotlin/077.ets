@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: ResourceColor[] = [0xFFEFB495, 0xFF8D6E63, 0xFF5D4037];

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            // Top image area
            Stack() {
              // Product icon placeholder
              Stack() {
                Text('🏠')
                  .fontSize(100)
                  .fontColor(0xFFEFB495)
              }
              .width(200)
              .height(200)
              .borderRadius(100)
              .backgroundColor(Color.White)
              .shadow({
                radius: 20,
                color: 'rgba(0,0,0,0.15)',
                offsetX: 0,
                offsetY: 4
              })
              .alignContent(Alignment.Center)

              // Top bar buttons
              Row() {
                // Back button
                Stack() {
                  Text('←')
                    .fontSize(20)
                    .fontColor(Color.Black)
                }
                .width(42)
                .height(42)
                .borderRadius(21)
                .backgroundColor(Color.White)
                .alignContent(Alignment.Center)
                .onClick(() => {})

                Blank()

                // Favorite button
                Stack() {
                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(20)
                    .fontColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .width(42)
                .height(42)
                .borderRadius(21)
                .backgroundColor(Color.White)
                .alignContent(Alignment.Center)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 24, bottom: 24 })
              .alignItems(VerticalAlign.Top)
            }
            .width('100%')
            .height(400)
            .backgroundColor(0xFFE8E8E8)
            .borderRadius({
              bottomLeft: 40,
              bottomRight: 40
            })
            .alignContent(Alignment.Center)

            // Product info section
            Column() {
              // Title and rating row
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(0xFF333333)

                Blank()

                Row() {
                  Text('★')
                    .fontSize(20)
                    .fontColor(0xFFFFC107)
                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .margin({ left: 4 })
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Category
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

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

              // Color and Quantity row
              Row() {
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  Row() {
                    ForEach(this.colors, (color: ResourceColor, index: number) => {
                      Stack() {
                        if (this.selectedColorIndex === index) {
                          Stack()
                            .width(30)
                            .height(30)
                            .borderRadius(15)
                            .backgroundColor(color)
                            .border({
                              width: 2,
                              color: Color.Black
                            })
                        } else {
                          Stack()
                            .width(30)
                            .height(30)
                            .borderRadius(15)
                            .backgroundColor(color)
                        }
                      }
                      .width(30)
                      .height(30)
                      .borderRadius(15)
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                    }, (color: ResourceColor, index: number) => index.toString())
                  }
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)

                  Row() {
                    Text('−')
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
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .margin({ top: 24 })
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding({ left: 24, right: 24, top: 24, bottom: 24 })
          }
          .padding({ bottom: 80 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(0xFFF5F5F7)

      // Bottom bar
      Stack() {
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

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Row() {
              Text('🛒')
                .fontSize(20)
              Text('Add to Cart')
                .fontSize(14)
                .fontColor(Color.White)
                .margin({ left: 8 })
            }
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.Center)
          }
          .width(160)
          .height(50)
          .backgroundColor(0xFF333333)
          .borderRadius(16)
          .onClick(() => {})
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({
        topLeft: 24,
        topRight: 24
      })
      .shadow({
        radius: 16,
        color: 'rgba(0,0,0,0.1)',
        offsetX: 0,
        offsetY: -4
      })
      .alignContent(Alignment.Center)
      .position({ x: 0, y: 0 })
      .markAnchor({ x: 0, y: 0 })
      .align(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
  }
}
