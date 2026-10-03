import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureShopApp {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = [
    '#EFB495', // Light Orange
    '#8D6E63', // Brown
    '#5D4037'  // Dark Brown
  ];

  build() {
    Column() {
      Stack({ alignContent: Alignment.Top }) {
        // Main Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#F5F5F7')

        Scroll() {
          Column() {
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

                Image($r('app.media.ic_house')) // Placeholder for house icon
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#EFB495')
              }
              .position({ x: '50%', y: '50%' })
              .translate({ x: '-50%', y: '-50%' })

              // Top Buttons
              Row() {
                // Back Button
                Button() {
                  Image($r('app.media.ic_back')) // Placeholder for back arrow
                    .width(20)
                    .height(20)
                    .fillColor(Color.Black)
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .onClick(() => {
                  // Handle back action
                })

                Flex().justifyContent(FlexAlign.End)
                
                // Favorite Button
                Button() {
                  Image(this.isFavorite ? $r('app.media.ic_heart_fill') : $r('app.media.ic_heart')) // Placeholders
                    .width(20)
                    .height(20)
                    .fillColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
              }
              .width('100%')
              .padding(24)
            }
            .width('100%')

            // Content Section
            Column({ space: 24 }) {
              // Title and Rating
              Row() {
                Text("Modern Lounge")
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Flex().justifyContent(FlexAlign.End)

                Row({ space: 4 }) {
                  Image($r('app.media.ic_star')) // Placeholder for star
                    .width(20)
                    .height(20)
                    .fillColor('#FFC107')

                  Text("4.8")
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                }
              }
              .width('100%')

              // Subtitle
              Text("Armchair")
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              // Description
              Column({ space: 8 }) {
                Text("Description")
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.Black)

                Text("Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.")
                  .fontSize(14)
                  .fontColor(Color.Gray)
                  .lineHeight(22)
              }

              // Color and Quantity Row
              Row({ space: 24 }) {
                // Color Selection
                Column({ space: 8 }) {
                  Text("Color")
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
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
                            .stroke(Color.Black)
                            .strokeWidth(2)
                            .width(30)
                            .height(30)
                        }
                      }
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                    })
                  }
                }

                Flex().justifyContent(FlexAlign.End)

                // Quantity Selection
                Column({ space: 8 }) {
                  Text("Quantity")
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black)

                  Row({ space: 0 }) {
                    Text("-")
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
                      .width(20)
                      .textAlign(TextAlign.Center)

                    Text("+")
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
                }
              }
              .width('100%')

              // Extra padding at bottom of scrollable content to avoid overlap with bottom bar
              Column().height(100)
            }
            .padding(24)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom Surface
      Column() {
        Row() {
          Column({ space: 2 }) {
            Text("Total Price")
              .fontSize(14)
              .fontColor(Color.Gray)

            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }

          Flex().justifyContent(FlexAlign.End)

          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.ic_cart')) // Placeholder for cart icon
                .width(20)
                .height(20)
                .fillColor(Color.White)
              
              Text("Add to Cart")
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
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.1)', offsetY: -4 })
      }
      .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}