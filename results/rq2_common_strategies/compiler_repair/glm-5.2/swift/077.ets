// FurnitureShopApp.ets

@Entry
@Component
struct FurnitureShopApp {
  build() {
    Column() {
      FurnitureDetailScreen()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
export struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: ResourceColor[] = [
    '#EFB495',
    '#8D6E63',
    '#5D4037'
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Main Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')

      Column() {
        // Scrollable Content
        Scroll() {
          Column() {
            // Top Image Section
            Stack({ alignContent: Alignment.Center }) {
              // Background shape
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40 })

              // Centered Icon Container
              Column() {
                Column()
                  .width(200)
                  .height(200)
                  .backgroundColor(Color.White)
                  .borderRadius(100)
                  .shadow({ radius: 20, color: '#33000000', offsetY: 10 })

                Image($r('sys.symbol.house_fill'))
                  .width(100)
                  .height(100)
                  .fillColor('#EFB495')
                  .margin({ top: -150 }) // Pull image up to overlap the circle container
              }
              .width('100%')
              .height(400)
              .justifyContent(FlexAlign.Center)

              // Top Buttons
              Row() {
                // Back Button
                Button() {
                  // Action
                }
                .type(ButtonType.Circle)
                .backgroundColor(Color.White)
                .width(42)
                .height(42)
                .shadow({ radius: 4, color: '#1A000000' })

                Blank()

                // Favorite Button
                Button() {
                  Image(this.isFavorite ? $r('sys.symbol.heart_fill') : $r('sys.symbol.heart'))
                    .width(20)
                    .height(20)
                    .fillColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .type(ButtonType.Circle)
                .backgroundColor(Color.White)
                .width(42)
                .height(42)
                .shadow({ radius: 4, color: '#1A000000' })
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
              }
              .width('100%')
              .padding(24)
            }
            .width('100%')
            .height(400)

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
                  Image($r('sys.symbol.star_fill'))
                    .width(20)
                    .height(20)
                    .fillColor('#FFC107')
                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                    .margin({ left: 4 })
                }
              }
              .width('100%')

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
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
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black)

                  Row({ space: 12 }) {
                    ForEach(this.colors, (color: ResourceColor, index: number) => {
                      Stack() {
                        Circle({ width: 30, height: 30 })
                          .fill(color)
                        
                        if (this.selectedColorIndex === index) {
                          Circle({ width: 30, height: 30 })
                            .fill(Color.Transparent)
                            .stroke(Color.Black)
                            .strokeWidth(2)
                        }
                      }
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                    })
                  }
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                // Quantity Selection
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
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

                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(Color.Black)
                      .constraintSize({ minWidth: 20 })
                      .textAlign(TextAlign.Center)

                    Image($r('sys.symbol.plus'))
                      .width(16)
                      .height(16)
                      .fillColor(Color.Black)
                      .width(40)
                      .height(32)
                      .objectFit(ImageFit.Contain)
                      .onClick(() => {
                        this.quantity += 1;
                      })
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .margin({ top: 24 })

              // Bottom padding to avoid overlap
              Column()
                .height(100)
            }
            .padding(24)
            .alignItems(HorizontalAlign.Start)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      // Bottom Surface
      Column() {
        Blank()

        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor(Color.Gray)
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Row() {
              Image($r('sys.symbol.cart_fill'))
                .width(20)
                .height(20)
                .fillColor(Color.White)
              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.White)
                .margin({ left: 8 })
            }
          }
          .type(ButtonType.Capsule)
          .backgroundColor('#333333')
          .height(50)
          .constraintSize({ minWidth: 160 })
          .borderRadius(16)
        }
        .width('100%')
        .padding(24)
        .backgroundColor(Color.White)
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