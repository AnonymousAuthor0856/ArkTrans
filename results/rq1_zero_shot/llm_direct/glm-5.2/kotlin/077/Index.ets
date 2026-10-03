// index.ets
import { Length, ResourceStr } from '@ohos.arkui.UIContext';

interface FurnitureDetailState {
  isFavorite: boolean;
  selectedColorIndex: number;
  quantity: number;
}

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: ResourceColor[] = ['#EFB495', '#8D6E63', '#5D4037'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background and Scrollable Content
      Column() {
        Scroll() {
          Column() {
            // Image / Icon Area
            Stack({ alignContent: Alignment.Center }) {
              // Circular Icon Container
              Column() {
                Image($r('sys.media.ohos_ic_public_home'))
                  .width(100)
                  .height(100)
                  .fillColor('#EFB495')
              }
              .width(200)
              .height(200)
              .backgroundColor(Color.White)
              .borderRadius(100)
              .shadow({ radius: 20, color: 'rgba(0,0,0,0.15)', offsetX: 0, offsetY: 10 })

              // Top Bar Icons
              Row() {
                // Back Button
                Column() {
                  Image($r('sys.media.ohos_ic_back'))
                    .width(24)
                    .height(24)
                    .fillColor(Color.Black)
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)

                // Favorite Button
                Column() {
                  Image(this.isFavorite ? $r('sys.media.ohos_ic_public_heart_filled') : $r('sys.media.ohos_ic_public_heart'))
                    .width(24)
                    .height(24)
                    .fillColor(this.isFavorite ? Color.Red : Color.Black)
                }
                .width(42)
                .height(42)
                .backgroundColor(Color.White)
                .borderRadius(21)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .onClick(() => {
                  this.isFavorite = !this.isFavorite;
                })
              }
              .width('100%')
              .padding(24)
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('100%')
            .height(400)
            .backgroundColor('#E8E8E8')
            .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            // Details Content
            Column() {
              // Title and Rating
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')

                Row() {
                  Image($r('sys.media.ohos_ic_public_star_filled'))
                    .width(20)
                    .height(20)
                    .fillColor('#FFC107')
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

              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(Color.Gray)
                .margin({ top: -4 })

              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ top: 24 })

              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(Color.Gray)
                .lineHeight(22)
                .margin({ top: 8 })

              // Color and Quantity Row
              Row() {
                // Color Selection
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  Row({ space: 12 }) {
                    ForEach(this.colors, (color: ResourceColor, index: number) => {
                      Stack() {
                        Column()
                          .width(30)
                          .height(30)
                          .borderRadius(15)
                          .backgroundColor(color)
                      }
                      .width(34)
                      .height(34)
                      .borderRadius(17)
                      .border({
                        width: this.selectedColorIndex === index ? 2 : 0,
                        color: Color.Black
                      })
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                    })
                  }
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                // Quantity Selector
                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                  Row() {
                    Text('-')
                      .fontSize(20)
                      .padding({ left: 8, right: 8 })
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity--;
                        }
                      })
                    Text(this.quantity.toString())
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .padding({ left: 8, right: 8 })
                    Image($r('sys.media.ohos_ic_public_add'))
                      .width(20)
                      .height(20)
                      .fillColor(Color.Black)
                      .onClick(() => {
                        this.quantity++;
                      })
                  }
                  .backgroundColor(Color.White)
                  .borderRadius(12)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .margin({ top: 8 })
                  .alignItems(VerticalAlign.Center)
                }
                .alignItems(HorizontalAlign.End)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Top)
              .margin({ top: 24 })
            }
            .width('100%')
            .padding(24)
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ bottom: 100 })
        }
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F7')

      // Bottom Action Bar
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
          Row() {
            Image($r('sys.media.ohos_ic_public_cart'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
            Text('Add to Cart')
              .fontColor(Color.White)
              .margin({ left: 8 })
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
      .shadow({ radius: 16, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -4 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}