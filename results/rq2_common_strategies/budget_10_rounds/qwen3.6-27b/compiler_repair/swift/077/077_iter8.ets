import { router } from '@kit.ArkRouter';

@Entry
@Component
struct FurnitureShopApp {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = [
    '#EFB495', // Light Orange/Brown
    '#8D6E63', // Medium Brown
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
          Column({ space: 0 }) {
            // Top Image Section
            Stack({ alignContent: Alignment.Center }) {
              // Background shape with custom corners
              Path({
                commands: `M 0 0 A 40 40 0 0 1 40 40 L 40 ${400 - 40} A 40 40 0 0 1 0 ${400} Z`
              })
              .width('100%')
              .height(400)
              .fill('#E8E8E8')
              
              // Centered Icon Container
              Stack() {
                Circle()
                  .fill(Color.White)
                  .width(200)
                  .height(200)
                  .shadow({ radius: 20, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 10 })
                
                Image($r('app.media.ic_house')) // Placeholder for house icon
                  .width(100)
                  .height(100)
                  .objectFit(ImageFit.Contain)
                  .fillColor('#EFB495')
              }

              // Top Buttons Overlay
              Column() {
                Row() {
                  // Back Button
                  Button() {
                    Text("")
                  }
                  .type(ButtonType.Circle)
                  .backgroundColor(Color.White)
                  .width(42)
                  .height(42)
                  .onClick(() => {
                    try {
                      router.back();
                    } catch (exception) {
                      console.error(`Failed to go back.`);
                    }
                  })
                  .fontColor(Color.Black)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)

                  Flex({ justifyContent: FlexAlign.End })
                  
                  // Favorite Button
                  Button() {
                    Text("")
                  }
                  .type(ButtonType.Circle)
                  .backgroundColor(Color.White)
                  .width(42)
                  .height(42)
                  .onClick(() => {
                    this.isFavorite = !this.isFavorite;
                  })
                  .fontColor(this.isFavorite ? Color.Red : Color.Black)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                }
                .padding(24)
                .width('100%')
                
                Flex({ justifyContent: FlexAlign.End }).height('100%')
              }
              .width('100%')
              .height(400)
            }

            // Content Section
            Column({ space: 0 }) {
              // Title and Rating
              Row() {
                Text("Modern Lounge")
                  .font({ size: 26, weight: FontWeight.Bold, family: 'System' })
                  .fontColor('#333333')
                
                Flex({ justifyContent: FlexAlign.End })
                
                Row({ space: 4 }) {
                  Image($r('app.media.ic_star_fill')) // Placeholder
                    .width(20)
                    .height(20)
                    .fillColor('#FFC107')
                  
                  Text("4.8")
                    .font({ size: 16, weight: FontWeight.Bold, family: 'System' })
                    .fontColor(Color.Black)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Subtitle
              Text("Armchair")
                .font({ size: 20, weight: FontWeight.Lighter, family: 'System' })
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              Blank().height(24)

              // Description Title
              Text("Description")
                .font({ size: 18, weight: FontWeight.Bold, family: 'System' })
                .fontColor(Color.Black)

              Blank().height(8)

              // Description Body
              Text("Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.")
                .font({ size: 14, family: 'System' })
                .fontColor(Color.Gray)
                .lineHeight(22) // Approx lineHeight 22sp

              Blank().height(24)

              // Color and Quantity Row
              Row({ space: 24 }) {
                // Color Selection
                Column({ space: 8 }) {
                  Text("Color")
                    .font({ size: 18, weight: FontWeight.Bold, family: 'System' })
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

                Flex({ justifyContent: FlexAlign.End })

                // Quantity Selection
                Column({ space: 8 }, { horizontalAlignment: HorizontalAlign.End }) {
                  Text("Quantity")
                    .font({ size: 18, weight: FontWeight.Bold, family: 'System' })
                    .fontColor(Color.Black)
                  
                  Row({ space: 0 }) {
                    Text("-")
                      .font({ size: 20, family: 'System' })
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
                      .font({ size: 18, weight: FontWeight.Bold, family: 'System' })
                      .fontColor(Color.Black)
                      .textAlign(TextAlign.Center)
                      .width(20)
                    
                    Image($r('app.media.ic_plus')) // Placeholder
                      .width(16)
                      .height(16)
                      .fillColor(Color.Black)
                      .width(40)
                      .height(32)
                      .onClick(() => {
                        this.quantity += 1;
                      })
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)

              // Extra padding at bottom of scrollable content
              Blank().height(100)
            }
            .padding(24)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // Bottom Surface
        Column() {
          Flex({ justifyContent: FlexAlign.End }).layoutWeight(1)
          
          Row() {
            Column({ space: 2 }) {
              Text("Total Price")
                .font({ size: 14, family: 'System' })
                .fontColor(Color.Gray)
              
              Text(`$${245 * this.quantity}`)
                .font({ size: 24, weight: FontWeight.Bold, family: 'System' })
                .fontColor(Color.Black)
            }
            
            Flex({ justifyContent: FlexAlign.End })
            
            Button() {
              Row({ space: 8 }) {
                Image($r('app.media.ic_cart_fill')) // Placeholder
                  .width(20)
                  .height(20)
                  .fillColor(Color.White)
                Text("Add to Cart")
                  .font({ size: 16, weight: FontWeight.Medium, family: 'System' })
                  .fontColor(Color.White)
              }
            }
            .type(ButtonType.Capsule)
            .backgroundColor('#333333')
            .width(160)
            .height(50)
            .borderRadius(16)
          }
          .padding(24)
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius({ topLeft: 24, topRight: 24, bottomLeft: 0, bottomRight: 0 })
          .shadow({ radius: 16, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -4 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}