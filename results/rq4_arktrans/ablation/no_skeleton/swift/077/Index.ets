@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Main Background ===
      Column() {
        // === ScrollView ===
        Scroll() {
          Column() {
            // === Top Image Section ===
            Stack() {
              // Background shape
              Column() {
                Blank()
              }
              .width('100%')
              .height(400)
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

              // Centered Icon Container
              Stack() {
                Image($r('app.media.startIcon'))
                  .width(100)
                  .height(100)
                  .fillColor('#EFB495')
              }
              .width(200)
              .height(200)
              .backgroundColor('#FFFFFF')
              .borderRadius(100)
              .shadow({ radius: 20, color: '#33000000', offsetY: 10 })

              // Top Buttons
              Column() {
                Row() {
                  // Back Button
                  Button() {
                    Image($r('app.media.startIcon'))
                      .width(20)
                      .height(20)
                      .fillColor('#000000')
                  }
                  .width(42)
                  .height(42)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(21)
                  .margin({ left: 24, top: 24 })

                  Blank()

                  // Favorite Button
                  Button() {
                    Image($r('app.media.startIcon'))
                      .width(20)
                      .height(20)
                      .fillColor(this.isFavorite ? '#FF0000' : '#000000')
                  }
                  .width(42)
                  .height(42)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(21)
                  .margin({ right: 24, top: 24 })
                  .onClick(() => {
                    this.isFavorite = !this.isFavorite
                  })
                }
                .width('100%')

                Blank()
              }
              .width('100%')
              .height(400)
            }
            .width('100%')

            // === Content Section ===
            Column() {
              // Title and Rating
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Blank()

                Row() {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .fillColor('#FFC107')

                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                    .margin({ left: 4 })
                }
              }
              .width('100%')

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor('#999999')
                .margin({ top: -4 })

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#000000')
                .margin({ top: 24 })

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor('#999999')
                .lineHeight(22)
                .margin({ top: 8 })

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')

                  Row() {
                    ForEach(this.colors.map((c, i) => ({ color: c, index: i })), (item: ColorItem) => {
                      Stack() {
                        Circle()
                          .width(30)
                          .height(30)
                          .fill(item.color)

                        if (this.selectedColorIndex === item.index) {
                          Circle()
                            .width(30)
                            .height(30)
                            .stroke('#000000')
                            .strokeWidth(2)
                        }
                      }
                      .onClick(() => {
                        this.selectedColorIndex = item.index
                      })
                    }, (item: ColorItem) => item.index.toString())
                  }
                  .margin({ top: 8 })
                }

                Blank()

                // Quantity Selection
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                    .textAlign(TextAlign.End)

                  Row() {
                    Button() {
                      Text('-')
                        .fontSize(20)
                        .fontColor('#000000')
                    }
                    .width(40)
                    .height(32)
                    .backgroundColor('#FFFFFF')
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

                    Button() {
                      Text('+')
                        .fontSize(16)
                        .fontColor('#000000')
                    }
                    .width(40)
                    .height(32)
                    .backgroundColor('#FFFFFF')
                    .onClick(() => {
                      this.quantity += 1
                    })
                  }
                  .backgroundColor('#FFFFFF')
                  .borderRadius(12)
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .margin({ top: 24 })

              // Extra padding at bottom of scrollable content to avoid overlap with bottom bar
              Blank().height(100)
            }
            .padding(24)
          }
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // === Bottom Surface ===
      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#999999')

            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor('#FFFFFF')

              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .margin({ left: 8 })
            }
          }
          .width(160)
          .height(50)
          .backgroundColor('#333333')
          .borderRadius(16)
        }
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#1A000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
  }
}

interface ColorItem {
  color: string;
  index: number;
}