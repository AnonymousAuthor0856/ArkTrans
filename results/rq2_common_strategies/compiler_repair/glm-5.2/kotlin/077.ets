import router from '@ohos.router';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: ResourceColor[] = ['#EFB495', '#8D6E63', '#5D4037'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            // Image Section
            Stack({ alignContent: Alignment.Center }) {
              // Background
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40 });

              // Circle Icon
              Column() {
                Text('🏠')
                  .fontSize(60)
                  .fontColor('#EFB495')
              }
              .width(200)
              .height(200)
              .borderRadius(100)
              .backgroundColor(Color.White)
              .shadow({ radius: 20, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 0 })
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center);

              // Top Bar
              Row() {
                // Back Button
                Button() {
                  Text('←')
                    .fontSize(22)
                    .fontColor(Color.Black)
                }
                .width(42)
                .height(42)
                .type(ButtonType.Circle)
                .backgroundColor(Color.White)
                .onClick(() => {
                  router.back();
                });

                // Favorite Button
                Button() {
                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(22)
                    .fontColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .width(42)
                .height(42)
                .type(ButtonType.Circle)
                .backgroundColor(Color.White)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                });
              }
              .width('100%')
              .padding(24)
              .justifyContent(FlexAlign.SpaceBetween);
            }
            .width('100%')
            .height(400);

            // Details Section
            Column() {
              // Title and Rating
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333');

                Row() {
                  Text('★')
                    .fontSize(20)
                    .fontColor('#FFC107');
                  Text('4.8')
                    .fontWeight(FontWeight.Bold)
                    .fontSize(16)
                    .margin({ left: 4 });
                }
                .alignItems(VerticalAlign.Center);
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);

              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 });

              Blank().height(24);

              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black);
              Blank().height(8);
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22);

              Blank().height(24);

              // Color and Quantity
              Row() {
                // Color Selection
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium);
                  Blank().height(8);
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
                            .width(38)
                            .height(38)
                            .borderRadius(19)
                            .border({ width: 2, color: Color.Black });
                        }
                      }
                      .width(38)
                      .height(38)
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      });
                    });
                  }
                }
                .alignItems(HorizontalAlign.Start);

                // Quantity Selection
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium);
                  Blank().height(8);
                  Row() {
                    Text('-')
                      .fontSize(20)
                      .padding({ left: 8, right: 8 })
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity--;
                        }
                      });
                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .padding({ left: 8, right: 8 });
                    Text('+')
                      .fontSize(20)
                      .padding({ left: 8, right: 8 })
                      .onClick(() => {
                        this.quantity++;
                      });
                  }
                  .alignItems(VerticalAlign.Center)
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 });
                }
                .alignItems(HorizontalAlign.End);
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween);
            }
            .width('100%')
            .padding(24)
            .alignItems(HorizontalAlign.Start);
          }
          .padding({ bottom: 100 });
        }
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7');

      // Bottom Bar
      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontColor(Color.Gray)
              .fontSize(14);
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black);
          }
          .alignItems(HorizontalAlign.Start);

          Button() {
            Row() {
              Text('🛒')
                .fontSize(18)
                .fontColor(Color.White);
              Text('Add to Cart')
                .fontSize(16)
                .fontColor(Color.White)
                .margin({ left: 8 });
            }
            .alignItems(VerticalAlign.Center);
          }
          .height(50)
          .width(160)
          .borderRadius(16)
          .backgroundColor('#333333');
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -4 });
    }
    .width('100%')
    .height('100%');
  }
}