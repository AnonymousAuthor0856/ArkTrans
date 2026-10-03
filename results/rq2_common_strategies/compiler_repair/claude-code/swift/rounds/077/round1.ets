@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = [
    '#EFB495',
    '#8D6E63',
    '#5D4037'
  ];

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            // Top Image Section
            Stack() {
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
                Circle()
                  .fill(Color.White)
                  .width(200)
                  .height(200)
                  .shadow({
                    color: 'rgba(0,0,0,0.2)',
                    radius: 20,
                    offsetY: 10
                  })

                Text('🏠')
                  .fontSize(100)
                  .fontColor('#EFB495')
              }

              // Top Buttons
              Column() {
                Row() {
                  // Back Button
                  Button() {
                    Text('←')
                      .fontSize(20)
                      .fontColor(Color.Black)
                      .fontWeight(FontWeight.Medium)
                  }
                    .type(ButtonType.Circle)
                    .width(42)
                    .height(42)
                    .backgroundColor(Color.White)

                  Blank()

                  // Favorite Button
                  Button() {
                    Text(this.isFavorite ? '♥' : '♡')
                      .fontSize(20)
                      .fontColor(this.isFavorite ? Color.Red : Color.Black)
                      .fontWeight(FontWeight.Medium)
                  }
                    .type(ButtonType.Circle)
                    .width(42)
                    .height(42)
                    .backgroundColor(Color.White)
                    .onClick(() => {
                      this.isFavorite = !this.isFavorite;
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

            // Content Section
            Column({ space: 0 }) {
              // Title and Rating
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

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              Blank()
                .height(24)

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)

              Blank()
                .height(8)

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)

              Blank()
                .height(24)

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column({ space: 8 }) {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)

                  Row({ space: 12 }) {
                    ForEach(this.colors, (color: string, index: number) => {
                      Stack() {
                        Circle()
                          .fill(color)
                          .width(30)
                          .height(30)

                        if (this.selectedColorIndex === index) {
                          Circle()
                            .stroke({
                              color: Color.Black,
                              width: 2
                            })
                            .width(30)
                            .height(30)
                            .fill(Color.Transparent)
                        }
                      }
                        .onClick(() => {
                          this.selectedColorIndex = index;
                        })
                    }, (color: string, index: number) => index.toString())
                  }
                }
                  .alignItems(HorizontalAlign.Start)

                Blank()

                // Quantity Selection
                Column({ space: 8 }) {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)

                  Row() {
                    Text('-')
                      .fontSize(20)
                      .fontColor(Color.Black)
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity -= 1;
                        }
                      })

                    Text(this.quantity.toString())
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(Color.Black)
                      .width(20)
                      .textAlign(TextAlign.Center)

                    Text('+')
                      .fontSize(16)
                      .fontColor(Color.Black)
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.quantity += 1;
                      })
                  }
                    .alignItems(VerticalAlign.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(12)
                }
                  .alignItems(HorizontalAlign.End)
              }
                .width('100%')
                .alignItems(VerticalAlign.Top)

              // Extra padding at bottom of scrollable content
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
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.None)
      }
        .width('100%')
        .height('100%')

      // Bottom Surface
      Column() {
        Blank()

        Row() {
          Column({ space: 2 }) {
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
            Row({ space: 8 }) {
              Text('🛒')
                .fontSize(20)
                .fontColor(Color.White)

              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
            }
          }
            .width(160)
            .height(50)
            .backgroundColor('#333333')
            .borderRadius(16)
        }
          .width('100%')
          .padding(24)
          .backgroundColor(Color.White)
          .borderRadius({
            topLeft: 24,
            topRight: 24
          })
          .shadow({
            color: 'rgba(0,0,0,0.1)',
            radius: 16,
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
