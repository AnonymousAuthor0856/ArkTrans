import { Circle } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];
  private readonly unitPrice: number = 245;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // ---------- Main background ----------
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F7')

      // ---------- Scrollable content ----------
      Scroll() {
        Column() {
          // ===== Top image section =====
          Stack({ alignContent: Alignment.Top }) {
            Column()
              .width('100%')
              .height(400)
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            Column() {
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 200, height: 200 })
                  .fill(Color.White)
                  .shadow({ radius: 20, color: 'rgba(0, 0, 0, 0.2)', offsetX: 0, offsetY: 10 })

                SymbolGlyph($r('sys.symbol.house'))
                  .fontSize(100)
                  .fontColor(['#EFB495'])
              }
              .width(200)
              .height(200)
            }
            .width('100%')
            .height(400)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            Row() {
              // Back button
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 42, height: 42 }).fill(Color.White)
                Text('←')
                  .fontSize(22)
                  .fontColor(Color.Black)
              }
              .width(42)
              .height(42)
              .onClick(() => {
                // navigate back
              })

              Blank()

              // Favorite button
              Stack({ alignContent: Alignment.Center }) {
                Circle({ width: 42, height: 42 }).fill(Color.White)
                Text(this.isFavorite ? '♥' : '♡')
                  .fontSize(22)
                  .fontColor(this.isFavorite ? Color.Red : Color.Black)
              }
              .width(42)
              .height(42)
              .onClick(() => {
                this.isFavorite = !this.isFavorite;
              })
            }
            .width('100%')
            .padding(24)
          }
          .width('100%')
          .height(400)

          // ===== Content section =====
          Column() {
            // Title + rating
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
                  .fontColor(Color.Black)
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Subtitle
            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor(Color.Gray)
              .margin({ top: 2 })

            // Description title
            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 24 })

            // Description body
            Text('Experience the ultimate comfort with this modern minimalist armchair. ' +
              'Crafted with premium bamboo wood and soft linen fabric, it perfectly blends ' +
              'style and functionality for your living room.')
              .fontSize(14)
              .fontColor(Color.Gray)
              .lineHeight(22)
              .margin({ top: 8 })

            // Color + quantity row
            Row() {
              Column({ space: 8 }) {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Stack({ alignContent: Alignment.Center }) {
                      Circle({ width: 30, height: 30 }).fill(color)

                      if (this.selectedColorIndex === index) {
                        Circle({ width: 30, height: 30 })
                          .fill(Color.Transparent)
                          .stroke(Color.Black)
                          .strokeWidth(2)
                      }
                    }
                    .width(30)
                    .height(30)
                    .onClick(() => {
                      this.selectedColorIndex = index;
                    })
                  }, (color: string, index: number) => `${index}-${color}`)
                }
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Column({ space: 8 }) {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)

                Row() {
                  Text('-')
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
                    .width(28)
                    .textAlign(TextAlign.Center)

                  Text('+')
                    .fontSize(18)
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
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ top: 24 })

            // Bottom spacer so the content is not hidden behind the bottom bar
            Column()
              .width('100%')
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
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.Top)

      // ---------- Bottom surface ----------
      Row() {
        Column({ space: 2 }) {
          Text('Total Price')
            .fontSize(14)
            .fontColor(Color.Gray)

          Text(`$${this.unitPrice * this.quantity}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Row({ space: 8 }) {
            Text('🛒')
              .fontSize(20)
              .fontColor(Color.White)
            Text('Add to Cart')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
        }
        .width(160)
        .height(50)
        .backgroundColor('#333333')
        .borderRadius(16)
        .onClick(() => {
          // add to cart
        })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.1)', offsetX: 0, offsetY: -4 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}