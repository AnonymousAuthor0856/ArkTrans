@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037']

  build() {
    Stack() {
      // Main Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')

      // Scrollable Content
      Scroll() {
        Column({ space: 0 }) {
          // Top Image Section
          Stack() {
            // Background shape
            Column()
              .width('100%')
              .height(400)
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            // Centered Icon Container
            Stack() {
              Circle()
                .fill(Color.White)
                .width(200)
                .height(200)
                .shadow({ radius: 20, color: 'rgba(0, 0, 0, 0.2)', offsetY: 10 })

              Text('🏠')
                .fontSize(80)
                .fontColor('#EFB495')
            }
            .width('100%')
            .height(400)
            .justifyContent(FlexAlign.Center)

            // Top Buttons
            Column() {
              Row() {
                // Back Button
                Button() {
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .justifyContent(FlexAlign.Center)

                Blank()

                // Favorite Button
                Button() {
                  this.isFavorite = !this.isFavorite
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .justifyContent(FlexAlign.Center)
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
          Column({ space: 0 }) {
            // Title and Rating
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              Blank()

              Row({ space: 4 }) {
                Text('⭐')
                  .fontSize(20)

                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
              }
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Subtitle
            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#808080')
              .margin({ top: -4 })

            Blank()
              .height(24)

            // Description Title
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')

            Blank()
              .height(8)

            // Description Body
            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#808080')
              .lineHeight(22)

            Blank()
              .height(24)

            // Color and Quantity Row
            Row() {
              // Color Selection
              Column({ space: 8 }) {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Stack() {
                      Circle()
                        .fill(color)
                        .width(30)
                        .height(30)

                      if (this.selectedColorIndex === index) {
                        Circle()
                          .fillOpacity(0)
                          .stroke('#000000')
                          .strokeWidth(2)
                          .width(30)
                          .height(30)
                      }
                    }
                    .width(30)
                    .height(30)
                    .onClick(() => {
                      this.selectedColorIndex = index
                    })
                  })
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              // Quantity Selection
              Column({ space: 8 }) {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')

                Row({ space: 0 }) {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#000000')
                    .width(40)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity -= 1
                      }
                    })

                  Text(`${this.quantity}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                    .constraintSize({ minWidth: 20 })
                    .textAlign(TextAlign.Center)

                  Text('+')
                    .fontSize(16)
                    .fontColor('#000000')
                    .width(40)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      this.quantity += 1
                    })
                }
                .backgroundColor(Color.White)
                .borderRadius(12)
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

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
      .height('100%')
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Surface
      Column() {
        Blank()

        Row() {
          Column({ space: 2 }) {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#808080')

            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
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
        .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.1)', offsetY: -4 })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}