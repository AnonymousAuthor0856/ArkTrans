import { router } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = ['#FFEFB495', '#FF8D6E63', '#FF5D4037'];

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
              .backgroundColor('#FFE8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })
              .clip(true)

            // Center circle with icon
            Stack() {
              Circle()
                .width(200)
                .height(200)
                .fill(Color.White)
                .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 4 })

              Image($r('app.media.startIcon'))
                .width(100)
                .height(100)
                .fillColor('#FFEFB495')
            }
            .width('100%')
            .height(400)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            // Top bar with back and favorite buttons
            Row() {
              Button({ type: ButtonType.Circle }) {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .fillColor(Color.Black)
              }
              .width(42)
              .height(42)
              .backgroundColor(Color.White)
              .onClick(() => {
                router.back();
              })

              Button({ type: ButtonType.Circle }) {
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(20)
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
            .justifyContent(FlexAlign.SpaceBetween)
            .padding(24)
          }
          .width('100%')
          .height(400)

          // Content Section
          Column() {
            // Title and Rating Row
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FF333333')

              Row() {
                Text('★')
                  .fontSize(20)
                  .fontColor('#FFFFC107')
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

            // Subtitle
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
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 24 })

            // Color and Quantity Row
            Row() {
              // Color Section
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .margin({ bottom: 8 })

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Circle()
                      .width(30)
                      .height(30)
                      .fill(color)
                      .border({
                        width: this.selectedColorIndex === index ? 2 : 0,
                        color: this.selectedColorIndex === index ? Color.Black : Color.Transparent,
                        radius: 15
                      })
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                  })
                }
              }
              .alignItems(HorizontalAlign.Start)

              // Quantity Section
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
                        this.quantity--;
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
                      this.quantity++;
                    })
                }
                .alignItems(VerticalAlign.Center)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ bottom: 80 })
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
                .fontSize(18)
                .fontColor(Color.White)
              Text('Add to Cart')
                .fontColor(Color.White)
                .fontSize(16)
            }
            .alignItems(VerticalAlign.Center)
          }
          .height(50)
          .width(160)
          .backgroundColor('#FF333333')
          .borderRadius(16)
          .onClick(() => {})
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
    .backgroundColor('#FFF5F5F7')
  }
}