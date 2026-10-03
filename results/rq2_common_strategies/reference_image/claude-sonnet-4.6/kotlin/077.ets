/**
 * FurnitureDetail.ets — ArkTS/ArkUI port of the Compose furniture detail screen.
 * Entry file: pages/FurnitureDetail.ets (declared in main_pages.json).
 * Edge-to-edge: in EntryAbility.onWindowStageCreate() call
 *   windowStage.getMainWindowSync().setWindowLayoutFullScreen(true)
 */
const IC_HOME: string = 'M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z';
const IC_BACK: string = 'M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z';
const IC_FAVORITE: string =
  'M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09' +
  'C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z';
const IC_FAVORITE_BORDER: string =
  'M16.5 3c-1.74 0-3.41.81-4.5 2.09C10.91 3.81 9.24 3 7.5 3 4.42 3 2 5.42 2 8.5c0 3.78 3.4 6.86 ' +
  '8.55 11.54L12 21.35l1.45-1.32C18.6 15.36 22 12.28 22 8.5 22 5.42 19.58 3 16.5 3zm-4.4 15.55l-.1.1-.1-.1' +
  'C7.14 14.24 4 11.39 4 8.5 4 6.5 5.5 5 7.5 5c1.54 0 3.04.99 3.57 2.36h1.87C13.46 5.99 14.96 5 16.5 5' +
  'c2 0 3.5 1.5 3.5 3.5 0 2.89-3.14 5.74-7.9 10.05z';
const IC_STAR: string = 'M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z';
const IC_ADD: string = 'M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z';
const IC_CART: string =
  'M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 ' +
  '0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49' +
  'c.08-.14.12-.31.12-.49 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z';

@Entry
@Component
struct FurnitureDetail {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;

  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];
  private unitPrice: number = 245;

  // Vector icon helper (24x24 viewport, scaled to any size)
  @Builder
  Icon(path: string, iconSize: number, tint: ResourceColor) {
    Shape() {
      Path().commands(path)
    }
    .viewPort({ x: 0, y: 0, width: 24, height: 24 })
    .width(iconSize)
    .height(iconSize)
    .fill(tint)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // ---------------- scrollable content ----------------
      Scroll() {
        Column() {
          // ---- hero header ----
          Stack({ alignContent: Alignment.Top }) {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                this.Icon(IC_BACK, 20, Color.Black)
              }
              .width(42)
              .height(42)
              .backgroundColor(Color.White)
              .borderRadius(21)
              .onClick(() => {
              })

              Stack({ alignContent: Alignment.Center }) {
                this.Icon(
                  this.isFavorite ? IC_FAVORITE : IC_FAVORITE_BORDER,
                  22,
                  this.isFavorite ? '#FF0000' : Color.Black
                )
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
            .justifyContent(FlexAlign.SpaceBetween)

            Column() {
              Stack({ alignContent: Alignment.Center }) {
                this.Icon(IC_HOME, 100, '#EFB495')
              }
              .width(200)
              .height(200)
              .backgroundColor(Color.White)
              .borderRadius(100)
              .shadow({ radius: 20, color: '#1F000000', offsetX: 0, offsetY: 0 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(400)
          .backgroundColor('#E8E8E8')
          .borderRadius({ bottomLeft: 40, bottomRight: 40 })
          .clip(true)

          // ---- info block ----
          Column() {
            Row() {
              Text('Modern Lounge')
                .fontSize(26)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')

              Row() {
                this.Icon(IC_STAR, 20, '#FFC107')
                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Normal)
              .fontColor('#808080')
              .offset({ x: 0, y: -4 })

            Column().height(24).width('100%')

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)

            Column().height(8).width('100%')

            Text('Experience the ultimate comfort with this modern minimalist armchair. ' +
              'Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style ' +
              'and functionality for your living room.')
              .fontSize(14)
              .fontColor('#808080')
              .lineHeight(22)

            Column().height(24).width('100%')

            Row() {
              // ---- colour picker ----
              Column() {
                Text('Color')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)

                Column().height(8).width('100%')

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Column()
                      .width(30)
                      .height(30)
                      .borderRadius(15)
                      .backgroundColor(color)
                      .border({
                        width: this.selectedColorIndex === index ? 2 : 0,
                        color: this.selectedColorIndex === index ? Color.Black : Color.Transparent,
                        radius: 15
                      })
                      .onClick(() => {
                        this.selectedColorIndex = index;
                      })
                  }, (color: string, index: number) => index.toString() + '-' + color)
                }
              }
              .alignItems(HorizontalAlign.Start)

              // ---- quantity stepper ----
              Column() {
                Text('Quantity')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)

                Column().height(8).width('100%')

                Row() {
                  Text('-')
                    .fontSize(20)
                    .fontColor('#333333')
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

                  Stack({ alignContent: Alignment.Center }) {
                    this.Icon(IC_ADD, 20, Color.Black)
                  }
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
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .padding({ bottom: 80 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // ---------------- bottom checkout bar ----------------
      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#808080')

            Text('$' + (this.unitPrice * this.quantity).toString())
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            this.Icon(IC_CART, 20, Color.White)
            Text('Add to Cart')
              .fontSize(16)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .height(50)
          .width(160)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#333333')
          .borderRadius(16)
          .onClick(() => {
          })
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#14000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}