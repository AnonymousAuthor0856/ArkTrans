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
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Background
      Column() {
        Scroll() {
          Column() {
            // Top Image Section
            Stack({ alignContent: Alignment.TopStart }) {
              // Background shape
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40 })

              // Centered Icon Container
              Column() {
                Stack() {
                  Circle()
                    .width(200)
                    .height(200)
                    .fill(Color.White)
                    .shadow({ radius: 20, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 10 })

                  Image($r('app.media.startIcon'))
                    .width(100)
                    .height(100)
                    .fillColor('#EFB495')
                    .objectFit(ImageFit.Contain)
                }
              }
              .width('100%')
              .height(400)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)

              // Top Buttons
              Row() {
                // Back Button
                Button({ type: ButtonType.Circle }) {
                  Text('←')
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black)
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .onClick(() => {})

                Blank()

                // Favorite Button
                Button({ type: ButtonType.Circle }) {
                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
              }
              .width('100%')
              .padding(24)
              .justifyContent(FlexAlign.SpaceBetween)
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
                .width('100%')
                .margin({ top: 2 })

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .width('100%')
                .margin({ top: 24 })

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
                .width('100%')
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
                    ForEach(this.colors, (color: string, index: number) => {
                      Stack() {
                        Circle()
                          .width(30)
                          .height(30)
                          .fill(color)

                        if (this.selectedColorIndex === index) {
                          Circle()
                            .width(34)
                            .height(34)
                            .fill('transparent')
                            .strokeWidth(2)
                            .stroke(Color.Black)
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
                      .textAlign(TextAlign.Center)
                      .constraintSize({ minWidth: 20 })

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
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .margin({ top: 8 })
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
              .margin({ top: 24 })

              // Bottom padding
              Column()
                .height(100)
            }
            .padding(24)
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // Bottom Surface
      Row() {
        Column() {
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
        .onClick(() => {})
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -4 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}