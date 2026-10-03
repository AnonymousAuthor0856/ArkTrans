@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1
  
  private colors: Color[] = [Color('#EFB495'), Color('#8D6E63'), Color('#5D4037')]
  
  build() {
    Column() {
      // Main content area
      Scroll() {
        Column() {
          // Header image section
          Row() {
            Image($r('app.media.home_icon'))
              .width(200)
              .height(200)
              .borderRadius(100)
              .backgroundColor(Color.White)
              .shadow({ radius: 20, color: '#00000020', offsetX: 0, offsetY: 10 })
          }
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })
          
          // Navigation buttons
          Row() {
            Button() {
              Text('←')
                .fontSize(20)
                .fontColor(Color.Black)
            }
            .width(42)
            .height(42)
            .borderRadius(21)
            .backgroundColor(Color.White)
            
            Flex().justifyContent(FlexAlign.End)
            Button() {
              Text(this.isFavorite ? '❤️' : '🤍')
                .fontSize(20)
            }
            .width(42)
            .height(42)
            .borderRadius(21)
            .backgroundColor(Color.White)
            .onClick(() => {
              this.isFavorite = !this.isFavorite
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 24 })
          
          // Product info section
          Column() {
            // Title and rating
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
              
              Flex().justifyContent(FlexAlign.End)
              Row() {
                Text('⭐')
                  .fontSize(20)
                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 4 })
              }
            }
            .width('100%')
            
            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Light)
              .fontColor(Color.Gray)
              .margin({ top: -4 })
            
            // Description section
            Column() {
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(Color.Black)
              
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
                .margin({ top: 8 })
            }
            .margin({ top: 24 })
            
            // Color and quantity selection
            Row() {
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                
                Row() {
                  ForEach(this.colors, (color: Color, index: number) => {
                    Circle()
                      .width(30)
                      .height(30)
                      .fill(color)
                      .border({ width: this.selectedColorIndex === index ? 2 : 0, color: Color.Black })
                      .onClick(() => {
                        this.selectedColorIndex = index
                      })
                      .margin({ right: 12 })
                  })
                }
                .margin({ top: 8 })
              }
              
              Flex().justifyContent(FlexAlign.End)
              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                
                Row() {
                  Text('-')
                    .fontSize(20)
                    .onClick(() => {
                      if (this.quantity > 1) {
                        this.quantity--
                      }
                    })
                  
                  Text(`${this.quantity}`)
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .margin({ left: 8, right: 8 })
                  
                  Text('+')
                    .fontSize(20)
                    .onClick(() => {
                      this.quantity++
                    })
                }
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                .margin({ top: 8 })
              }
            }
            .width('100%')
            .margin({ top: 24 })
          }
          .padding(24)
        }
        .padding({ bottom: 80 })
      }
      
      // Bottom action bar
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
        
        Flex().justifyContent(FlexAlign.End)
        Button('Add to Cart 🛒')
          .backgroundColor('#333333')
          .borderRadius(16)
          .height(50)
          .width(160)
          .fontColor(Color.White)
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#00000020', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}