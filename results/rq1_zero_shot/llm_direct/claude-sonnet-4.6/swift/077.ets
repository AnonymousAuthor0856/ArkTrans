import { router } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  readonly colors: string[] = [
    '#EFB495',
    '#8D6E63',
    '#5D4037'
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Main Background
      Column() {
        Scroll() {
          Column() {
            // Top Image Section
            Stack({ alignContent: Alignment.TopStart }) {
              // Background shape
              Column()
                .width('100%')
                .height(400)
                .backgroundColor('#E8E8E8')
                .borderRadius({ bottomLeft: 40, bottomRight: 40, topLeft: 0, topRight: 0 })

              // Centered Icon Container
              Stack() {
                Circle()
                  .fill(Color.White)
                  .width(200)
                  .height(200)
                  .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 10 })

                Image($r('sys.media.ohos_ic_public_home'))
                  .width(100)
                  .height(100)
                  .fillColor('#EFB495')
              }
              .width('100%')
              .height(400)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)

              // Top Buttons
              Column() {
                Row() {
                  // Back Button
                  Button({ type: ButtonType.Circle }) {
                    Image($r('sys.media.ohos_ic_back'))
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

                  Blank()

                  // Favorite Button
                  Button({ type: ButtonType.Circle }) {
                    Image(this.isFavorite
                      ? $r('sys.media.ohos_ic_public_favor_filled')
                      : $r('sys.media.ohos_ic_public_favor'))
                      .width(20)
                      .height(20)
                      .fillColor(this.isFavorite ? Color.Red : Color.Black)
                  }
                  .width(42)
                  .height(42)
                  .backgroundColor(Color.White)
                  .onClick(() => {
                    this.isFavorite = !this.isFavorite;
                  })
                }
                .width('100%')
                .padding(24)
              }
              .width('100%')
              .height(400)
              .justifyContent(FlexAlign.Start)
            }
            .width('100%')
            .height(400)

            // Content Section
            Column() {
              // Title and Rating
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Blank()

                Row({ space: 4 }) {
                  Image($r('sys.media.ohos_ic_public_favor_filled'))
                    .width(20)
                    .height(20)
                    .fillColor('#FFC107')

                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                }
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)

              // Subtitle
              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .width('100%')
                .margin({ top: 2 })

              // Description Title
              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .width('100%')
                .margin({ top: 24 })

              // Description Body
              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
                .width('100%')
                .margin({ top: 8 })

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column() {
                  Text('Color')
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
                            .width(30)
                            .height(30)
                            .stroke(Color.Black, 2)
                            .fill('transparent')
                        }
                      }
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                    })
                  }
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                // Quantity Selection
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
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
                      .minFontSize(18)
                      .textAlign(TextAlign.Center)
                      .constraintSize({ minWidth: 20 })

                    Image($r('sys.media.ohos_ic_public_add'))
                      .width(16)
                      .height(16)
                      .fillColor(Color.Black)
                      .width(40)
                      .height(32)
                      .objectFit(ImageFit.Contain)
                      .onClick(() => {
                        this.quantity += 1;
                      })
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .margin({ top: 8 })
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
              .margin({ top: 24 })

              // Bottom padding to avoid overlap with bottom bar
              Column()
                .height(100)
            }
            .padding(24)
            .alignItems(HorizontalAlign.Start)
            .width('100%')
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // Bottom Surface
      Row() {
        Column() {
          Text('Total Price')
            .fontSize(14)
            .fontColor(Color.Gray)

          Text(`$${245 * this.quantity}`)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Row({ space: 8 }) {
            Image($r('sys.media.ohos_ic_public_add'))
              .width(20)
              .height(20)
              .fillColor(Color.White)

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
        .onClick(() => {})
      }
      .padding(24)
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24, bottomLeft: 0, bottomRight: 0 })
      .shadow({ radius: 16, color: '#1A000000', offsetX: 0, offsetY: -4 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}