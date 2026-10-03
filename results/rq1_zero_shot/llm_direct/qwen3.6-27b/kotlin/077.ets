import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  build() {
    Column() {
      Stack({ alignContent: Alignment.Bottom }) {
        // Scrollable Content
        Scroll() {
          Column() {
            // Image Header Section
            Column() {
              // Placeholder for the image background
              Row()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40 })
                .position({ x: 0, y: 0 })

              // Center Icon (Furniture Placeholder)
              Column() {
                SymbolGlyph($r('sys.symbol.home'))
                  .fontSize(100)
                  .fontColor('#EFB495')
              }
              .width(200)
              .height(200)
              .justifyContent(FlexAlign.Center)
              .backgroundColor(Color.White)
              .borderRadius(100)
              .shadow({ radius: 20, color: '#33000000', offsetY: 10 })
              .position({ x: '50%', y: '50%' })
              .translate({ x: '-50%', y: '-50%' })

              // Top Navigation Buttons
              Row() {
                // Back Button
                Button() {
                  SymbolGlyph($r('sys.symbol.chevron_left'))
                    .fontSize(24)
                    .fontColor(Color.Black)
                }
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .width(42)
                .height(42)
                .onClick(() => {
                  // Handle back
                })

                Flex().grow(1)

                // Favorite Button
                Button() {
                  if (this.isFavorite) {
                    SymbolGlyph($r('sys.symbol.heart_fill'))
                      .fontSize(24)
                      .fontColor(Color.Red)
                  } else {
                    SymbolGlyph($r('sys.symbol.heart'))
                      .fontSize(24)
                      .fontColor(Color.Black)
                  }
                }
                .type(ButtonType.Normal)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .width(42)
                .height(42)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
              }
              .width('100%')
              .padding({ left: 24, right: 24, top: 50 }) // Adjusted top padding for status bar safety
              .position({ x: 0, y: 0 })
            }
            .width('100%')
            .height(400)
            .alignItems(HorizontalAlign.Start)

            // Details Section
            Column() {
              // Title and Rating
              Row() {
                Text("Modern Lounge")
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Flex().grow(1)

                Row() {
                  SymbolGlyph($r('sys.symbol.star_fill'))
                    .fontSize(20)
                    .fontColor('#FFC107')
                  Text("4.8")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .margin({ left: 4 })
                }
              }
              .width('100%')

              Text("Armchair")
                .fontSize(20)
                .fontWeight(FontWeight.Light)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              // Description
              Column() {
                Text("Description")
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(Color.Black)
                  .margin({ top: 24 })

                Text("Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.")
                  .fontSize(14)
                  .fontColor(Color.Gray)
                  .lineHeight(22)
                  .margin({ top: 8 })
              }

              // Options (Color & Quantity)
              Row() {
                // Color Selection
                Column() {
                  Text("Color")
                    .fontSize(18)
                    .fontWeight(FontWeight.SemiBold)

                  Row() {
                    ForEach([
                      { color: '#EFB495', index: 0 },
                      { color: '#8D6E63', index: 1 },
                      { color: '#5D4037', index: 2 }
                    ], (item: { color: string, index: number }) => {
                      Circle({ width: 30, height: 30 })
                        .fill(item.color)
                        .border({
                          width: this.selectedColorIndex === item.index ? 2 : 0,
                          color: this.selectedColorIndex === item.index ? Color.Black : Color.Transparent
                        })
                        .onClick(() => {
                          this.selectedColorIndex = item.index;
                        })
                        .margin({ right: 12 })
                    })
                  }
                  .margin({ top: 8 })
                }

                Flex().grow(1)

                // Quantity Selection
                Column({ alignItems: HorizontalAlign.End }) {
                  Text("Quantity")
                    .fontSize(18)
                    .fontWeight(FontWeight.SemiBold)

                  Row() {
                    Text("-")
                      .fontSize(20)
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity--;
                        }
                      })
                      .padding({ left: 8, right: 8 })

                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .padding({ left: 8, right: 8 })

                    SymbolGlyph($r('sys.symbol.plus'))
                      .fontSize(20)
                      .onClick(() => {
                        this.quantity++;
                      })
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .padding({ top: 4, bottom: 4 })
                  .margin({ top: 8 })
                }
              }
              .width('100%')
              .margin({ top: 24 })
            }
            .width('100%')
            .padding(24)
            .margin({ bottom: 100 }) // Space for bottom sheet
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom Sheet / Action Bar
        Column() {
          Row() {
            Column() {
              Text("Total Price")
                .fontSize(14)
                .fontColor(Color.Gray)
              Text(`$${245 * this.quantity}`)
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }

            Flex().grow(1)

            Button("Add to Cart") {
              Row() {
                SymbolGlyph($r('sys.symbol.cart_fill'))
                  .fontSize(20)
                Text("Add to Cart")
                  .margin({ left: 8 })
              }
            }
            .type(ButtonType.Capsule)
            .backgroundColor('#333333')
            .fontColor(Color.White)
            .width(160)
            .height(50)
            .borderRadius(16)
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 16, color: '#33000000', offsetY: -4 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')
    }
    .width('100%')
    .height('100%')
  }
}