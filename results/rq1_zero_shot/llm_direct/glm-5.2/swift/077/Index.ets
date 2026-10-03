// index.ets
import { Length, ResourceStr } from '@ohos.arkui.UIContext';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: ResourceColor[] = [
    '#EFB495',
    '#8D6E63',
    '#5D4037'
  ];

  build() {
    Stack() {
      // Main Background
      Column() {
        Scroll() {
          Column() {
            // Top Image Section
            Stack() {
              // Background shape
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40 });

              // Centered Icon Container
              Column() {
                Column()
                  .width(200)
                  .height(200)
                  .borderRadius(100)
                  .backgroundColor(Color.White)
                  .shadow({ radius: 20, color: '#33000000', offsetY: 10 });

                Text('🏠')
                  .fontSize(80)
                  .fontColor('#EFB495')
                  .position({ x: '50%', y: '50%' })
                  .translate({ x: '-50%', y: '-50%' });
              }
              .width('100%')
              .height(400)
              .justifyContent(FlexAlign.Center);

              // Top Buttons
              Row() {
                // Back Button
                Button() {
                  Text('←')
                    .fontSize(20)
                    .fontColor(Color.Black)
                    .width(42)
                    .height(42)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(21);
                }
                .backgroundColor(Color.Transparent);

                Blank();

                // Favorite Button
                Button() {
                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(20)
                    .fontColor(this.isFavorite ? Color.Red : Color.Black)
                    .width(42)
                    .height(42)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(Color.White)
                    .borderRadius(21);
                }
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                });
              }
              .width('100%')
              .padding(24);
            }
            .width('100%')
            .height(400);

            // Content Section
            Column() {
              // Title and Rating
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333');

                Blank();

                Row() {
                  Text('★')
                    .fontSize(20)
                    .fontColor('#FFC107');
                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black);
                }
              }
              .width('100%');

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 });

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ top: 24 });

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
                .margin({ top: 8 });

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black);

                  Row({ space: 12 }) {
                    ForEach(this.colors, (color: ResourceColor, index: number) => {
                      Stack() {
                        Column()
                          .width(30)
                          .height(30)
                          .borderRadius(15)
                          .backgroundColor(color);

                        if (this.selectedColorIndex === index) {
                          Column()
                            .width(30)
                            .height(30)
                            .borderRadius(15)
                            .border({ width: 2, color: Color.Black });
                        }
                      }
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      });
                    });
                  }
                  .margin({ top: 8 });
                }
                .alignItems(HorizontalAlign.Start);

                Blank();

                // Quantity Selection
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Color.Black);

                  Row() {
                    Text('-')
                      .fontSize(20)
                      .fontColor(Color.Black)
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity--;
                        }
                      });

                    Text(this.quantity.toString())
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(Color.Black)
                      .width(20)
                      .textAlign(TextAlign.Center);

                    Text('+')
                      .fontSize(16)
                      .fontColor(Color.Black)
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.quantity++;
                      });
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .margin({ top: 8 });
                }
                .alignItems(HorizontalAlign.End);
              }
              .width('100%')
              .margin({ top: 24 });

              // Extra padding at bottom
              Column()
                .height(100);
            }
            .padding(24)
            .alignItems(HorizontalAlign.Start);
          }
        }
        .scrollBar(BarState.Off);
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7');

      // Bottom Surface
      Column() {
        Blank();

        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor(Color.Gray);
            Text('$' + (245 * this.quantity).toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black);
          }
          .alignItems(HorizontalAlign.Start);

          Blank();

          Button() {
            Row() {
              Text('🛒')
                .fontSize(20);
              Text('Add to Cart')
                .fontSize(16)
                .fontWeight(FontWeight.Medium);
            }
            .fontColor(Color.White)
            .width(160)
            .height(50)
            .backgroundColor('#333333')
            .borderRadius(16)
            .justifyContent(FlexAlign.Center);
          }
          .backgroundColor(Color.Transparent);
        }
        .width('100%')
        .padding(24)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 16, color: '#1A000000', offsetY: -4 });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7');
  }
}