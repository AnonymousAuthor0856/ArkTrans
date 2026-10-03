// FurnitureShopApp.swift → ArkTS (HarmonyOS ArkUI)

@Entry
@Component
struct FurnitureShopApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    FurnitureDetailScreen()
    // .statusBarHidden(true)
    // ArkUI manages the system bar via the window API (setWindowSystemBarProperties)
    // rather than a per-view modifier, so the status bar is hidden at the window level.
  }
}

@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  // Color(red:green:blue:) values (0...1 range) converted to their hex equivalents.
  private colors: string[] = [
    '#EFB495', // 0.94, 0.71, 0.58
    '#8D6E63', // 0.55, 0.43, 0.39
    '#5D4037'  // 0.36, 0.25, 0.22
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      // Scrollable content (the bottom bar overlays its lower edge)
      Column({ space: 0 }) {
        Scroll() {
          Column({ space: 0 }) {
            // Top Image Section
            Stack({ alignContent: Alignment.Center }) {
              // Background shape
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                // clipShape(CustomCornerShape(radius: 40, corners: [.bottomLeft, .bottomRight]))
                .borderRadius({ bottomLeft: 40, bottomRight: 40 })

              // Centered Icon Container
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 200, height: 200 })
                  .fill(Color.White)
                  .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 10 })

                // Image(systemName: "house.fill")
                Text('🏠')
                  .fontSize(100)
                  .fontColor('#EFB495')
              }
              .width('100%')
              .height(400)

              // Top Buttons
              Column() {
                Row() {
                  // Back Button
                  Button({ type: ButtonType.Circle }) {
                    Text('←')
                      .fontSize(20)
                      .fontWeight(500)
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
                      .fontWeight(500)
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
                  .fontWeight(700)
                  .fontColor('#333333')

                Blank()

                Row({ space: 4 }) {
                  // Image(systemName: "star.fill")
                  Text('★')
                    .fontSize(20)
                    .fontColor('#FFC107')

                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(700)
                    .fontColor(Color.Black)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(300)
                .fontColor(Color.Gray)
                .margin({ top: -4 }) // Offset to match visual layout

              Blank().height(24)

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(600)
                .fontColor(Color.Black)

              Blank().height(8)

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22) // Approx lineHeight 22sp

              Blank().height(24)

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column({ space: 8 }) {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(600)
                    .fontColor(Color.Black)

                  Row({ space: 12 }) {
                    ForEach(this.colors, (color: string, index: number) => {
                      Stack({ alignContent: Alignment.Center }) {
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
                        this.selectedColorIndex = index
                      })
                    }, (color: string) => color)
                  }
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                // Quantity Selection
                Column({ space: 8 }) {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(600)
                    .fontColor(Color.Black)

                  Row({ space: 0 }) {
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

                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(700)
                      .fontColor(Color.Black)
                      .constraintSize({ minWidth: 20 })
                      .textAlign(TextAlign.Center)

                    // Image(systemName: "plus")
                    Text('+')
                      .fontSize(16)
                      .fontColor(Color.Black)
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

              // Extra padding at bottom of scrollable content to avoid overlap with bottom bar
              Blank().height(100)
            }
            .padding(24)
            .alignItems(HorizontalAlign.Start)
          }
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Surface
      Row() {
        Column({ space: 2 }) {
          Text('Total Price')
            .fontSize(14)
            .fontColor(Color.Gray)

          Text('$' + (245 * this.quantity).toString())
            .fontSize(24)
            .fontWeight(700)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Row({ space: 8 }) {
            // Image(systemName: "cart.fill")
            Text('🛒')
              .fontSize(20)
              .fontColor(Color.White)

            Text('Add to Cart')
              .fontSize(16)
              .fontWeight(500)
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
      .shadow({ radius: 16, color: '#1A000000', offsetX: 0, offsetY: -4 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Helper Components

// CustomCornerShape: rounds only the selected corners of a rectangle.
// SwiftUI implements it with UIBezierPath(roundedRect:byRoundingCorners:cornerRadii:).
// ArkUI has no standalone Shape protocol, so the same result is produced directly
// with the per-corner borderRadius API (see the calls above).
@Component
struct CustomCornerShape {
  @Prop radius: number = 0
  // UIRectCorner bitmask: 1 = topLeft, 2 = topRight, 4 = bottomLeft, 8 = bottomRight
  @Prop corners: number = 15 // .allCorners

  build() {
    Column()
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Black)
      .borderRadius({
        topLeft: (this.corners & 1) !== 0 ? this.radius : 0,
        topRight: (this.corners & 2) !== 0 ? this.radius : 0,
        bottomLeft: (this.corners & 4) !== 0 ? this.radius : 0,
        bottomRight: (this.corners & 8) !== 0 ? this.radius : 0
      })
  }
}

// Helper extension to apply custom corners easily via .cornerRadius modifier wrapper if needed,
// but strictly keeping it compatible with standard SwiftUI View modifier approach.
// ArkTS has no Swift-style extensions; ArkUI's built-in borderRadius({...}) modifier
// replaces cornerRadius(_:corners:) and is applied inline above.
