import { curves } from '@kit.ArkUI';

@Entry
@Component
struct FurnitureDetailScreen {
  @State isFavorite: boolean = false;
  @State selectedColorIndex: number = 0;
  @State quantity: number = 1;
  private colors: string[] = ['#EFB495', '#8D6E63', '#5D4037'];

  @Builder
  TopBar() {
    Row() {
      Button() {
        Text('←')
          .fontSize(20)
          .fontColor('#000000')
      }
      .width(42)
      .height(42)
      .borderRadius(21)
      .backgroundColor('#FFFFFF')
      .onClick(() => {})

      Blank()

      Button() {
        Text(this.isFavorite ? '♥' : '♡')
          .fontSize(20)
          .fontColor(this.isFavorite ? '#FF0000' : '#000000')
      }
      .width(42)
      .height(42)
      .borderRadius(21)
      .backgroundColor('#FFFFFF')
      .onClick(() => {
        this.isFavorite = !this.isFavorite;
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  ColorSelector() {
    Column() {
      Text('Color')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
      Row({ space: 12 }) {
        ForEach(this.colors, (color: string, index: number) => {
          Stack() {
            Circle()
              .fill(color)
              .width(30)
              .height(30)
            if (this.selectedColorIndex === index) {
              Circle()
                .fillOpacity(0)
                .width(30)
                .height(30)
                .stroke('#000000')
                .strokeWidth(2)
            }
          }
          .width(30)
          .height(30)
          .onClick(() => {
            this.selectedColorIndex = index;
          })
        })
      }
      .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  QuantitySelector() {
    Column() {
      Text('Quantity')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
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
        Text(`${this.quantity}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .padding({ left: 8, right: 8 })
        Text('+')
          .fontSize(20)
          .fontColor('#333333')
          .padding({ left: 8, right: 8 })
          .onClick(() => {
            this.quantity++;
          })
      }
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.End)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          // Hero Image Section
          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width('100%')
              .height(400)
              .backgroundColor('#E8E8E8')
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

            // Circular icon container
            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .fill('#FFFFFF')
                .width(200)
                .height(200)
                .shadow({ radius: 20, color: '#33000000', offsetX: 0, offsetY: 4 })
              Text('⌂')
                .fontSize(80)
                .fontColor('#EFB495')
            }
            .width(200)
            .height(200)

            // Top bar overlay
            Column() {
              this.TopBar()
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
                Text('★')
                  .fontSize(20)
                  .fontColor('#FFC107')
                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#333333')
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Text('Armchair')
              .fontSize(20)
              .fontWeight(FontWeight.Lighter)
              .fontColor('#808080')
              .margin({ top: 4 })

            Text('Description')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
              .margin({ top: 24 })

            Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
              .fontSize(14)
              .fontColor('#808080')
              .lineHeight(22)
              .margin({ top: 8 })

            // Color and Quantity Row
            Row() {
              this.ColorSelector()
              Blank()
              this.QuantitySelector()
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ top: 24 })
          }
          .width('100%')
          .padding(24)
        }
        .width('100%')
        .padding({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom Bar
      Column() {
        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor('#808080')
            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Row({ space: 8 }) {
              Text('🛒')
                .fontSize(20)
              Text('Add to Cart')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }
          }
          .width(160)
          .height(50)
          .borderRadius(16)
          .backgroundColor('#333333')
          .onClick(() => {})
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 16, color: '#33000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F7')
  }
}