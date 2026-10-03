@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colors: string[] = ['#EFBB95', '#8D6E63', '#5D4037']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          // Image Section
          Stack({ alignContent: Alignment.TopStart }) {
            // Background
            Column()
              .width('100%')
              .height(400)
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            // Center circle with icon
            Column() {
              Image($r('app.media.startIcon'))
                .width(100)
                .height(100)
                .fillColor('#EFBB95')
            }
            .width(200)
            .height(200)
            .borderRadius(100)
            .backgroundColor(Color.White)
            .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 4 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .position({ x: '50%', y: '50%' })
            .translate({ x: -100, y: 80 })

            // Top bar with back and favorite buttons
            Row() {
              Button({ type: ButtonType.Circle }) {
                Text('<')
                  .fontSize(18)
                  .fontColor(Color.Black)
                  .fontWeight(FontWeight.Bold)
              }
              .width(42)
              .height(42)
              .backgroundColor(Color.White)

              Button({ type: ButtonType.Circle }) {
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(18)
                  .fontColor(this.isFavorite ? Color.Red : Color.Black)
              }
              .width(42)
              .height(42)
              .backgroundColor(Color.White)
              .onClick(() => {
                this.isFavorite = !this.isFavorite
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(24)
          }
          .width('100%')
          .height(400)
          .clip(true)
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })

          // Content Section
          Column() {
            // Title and Rating Row
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
                  .fontWeight(FontWeight.Bold)
                  .fontSize(16)
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor(Color.Gray)
              .margin({ top: -4 })

            // Description
            Column() {
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ bottom: 8 })

              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .margin({ top: 24 })

            // Color and Quantity Row
            Row() {
              // Color Selection
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 8 })

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
                          .stroke(Color.Black)
                          .strokeWidth(2)
                      }
                    }
                    .onClick(() => {
                      this.selectedColorIndex = index
                    })
                  })
                }
              }
              .alignItems(HorizontalAlign.Start)

              // Quantity Selection
              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 8 })

                Row() {
                  Text('-')
                    .fontSize(20)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity--
                      }
                    })

                  Text(`${this.quantity}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .padding({ left: 8, right: 8 })

                  Text('+')
                    .fontSize(20)
                    .padding({ left: 8, right: 8 })
                    .onClick(() => {
                      this.quantity++
                    })
                }
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .alignItems(VerticalAlign.Center)
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ top: 24 })
          }
          .padding(24)
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // Bottom padding
          Column()
            .height(80)
        }
        .width('100%')
        .backgroundColor('#F5F5F7')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      // Bottom Bar
      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontColor(Color.Gray)
              .fontSize(14)
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Button() {
            Row({ space: 8 }) {
              Text('🛒')
                .fontSize(16)
                .fontColor(Color.White)
              Text('Add to Cart')
                .fontColor(Color.White)
                .fontSize(14)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width(160)
          .height(50)
          .backgroundColor('#333333')
          .borderRadius(16)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding(24)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#33000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}