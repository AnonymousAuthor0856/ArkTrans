// Translated from SwiftUI (077.swift) to ArkTS / ArkUI

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    FurnitureDetailScreen()
    // .statusBarHidden(true)
  }
}

@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  colors: string[] = [
    '#EFB495',
    '#8D6E63',
    '#5D4037'
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          // Top Image Section
          Stack() {
            Blank().width('100%').height(400).backgroundColor('#E8E8E8').borderRadius({ bottomLeft: 40, bottomRight: 40 })

            // Centered Icon Container
            Stack() {
              Blank().width(200).height(200).backgroundColor('#FFFFFF').borderRadius(100).shadow({ radius: 20, color: '#33000000', offsetY: 10 })
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
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#000000')
                }
                .width(42)
                .height(42)
                .backgroundColor('#FFFFFF')
                .borderRadius(21)
                .onClick(() => {})

                Blank()

                // Favorite Button
                Button() {
                  Text(this.isFavorite ? '❤' : '🤍')
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isFavorite ? '#FF0000' : '#000000')
                }
                .width(42)
                .height(42)
                .backgroundColor('#FFFFFF')
                .borderRadius(21)
                .onClick(() => { this.isFavorite = !this.isFavorite })
              }
              .padding(24)
              Blank()
            }
            .height(400)
            .width('100%')
          }

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
                  .fontColor('#000000')
              }
            }
            .alignItems(VerticalAlign.Center)

            // Subtitle
            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#808080')
              .margin({ top: -4 })

            Blank().height(24)

            // Description Title
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Semibold)
              .fontColor('#000000')

            Blank().height(8)

            // Description Body
            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#808080')
              // lineSpacing(6)

            Blank().height(24)

            // Color and Quantity Row
            Row() {
              // Color Selection
              Column({ space: 8 }) {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Semibold)
                  .fontColor('#000000')

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Stack() {
                      Blank().width(30).height(30).backgroundColor(color).borderRadius(15)

                      if (this.selectedColorIndex === index) {
                        Blank().width(30).height(30).borderRadius(15).border({ width: 2, color: '#000000' })
                      }
                    }
                    .onClick(() => { this.selectedColorIndex = index })
                  }, (color: string) => color)
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              // Quantity Selection
              Column({ space: 8 }) {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Semibold)
                  .fontColor('#000000')

                Row({ space: 0 }) {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#000000')
                    .width(40)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .onClick(() => {
                      if (this.quantity > 1) { this.quantity -= 1 }
                    })

                  Text(this.quantity.toString())
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                    .width(20)
                    .textAlign(TextAlign.Center)

                  Text('+')
                    .fontSize(16)
                    .fontColor('#000000')
                    .width(40)
                    .height(32)
                    .textAlign(TextAlign.Center)
                    .onClick(() => { this.quantity += 1 })
                }
                .alignItems(VerticalAlign.Center)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
              }
              .alignItems(HorizontalAlign.End)
            }
            .alignItems(VerticalAlign.Top)

            // Extra padding to avoid overlap with bottom bar
            Blank().height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(24)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)

      // Bottom Surface
      Column() {
        Blank()
        Row() {
          Column({ space: 2 }) {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#808080')

            Text('$' + (245 * this.quantity))
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
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
            }
            .fontColor('#FFFFFF')
            .width(160)
            .height(50)
            .backgroundColor('#333333')
            .borderRadius(16)
          }
          .onClick(() => {})
        }
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
    .backgroundColor('#F5F5F7')
  }
}
