@Entry
@Component
struct FurnitureDetailScreen {
  @State selectedColorIndex: number = 0;
  @State isFavorite: boolean = false;

  private colorOptions: string[] = ['#212121', '#795548', '#9E9E9E'];

  build() {
    Column() {
      // Header Bar
      Row() {
        Row() {
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Image($r('sys.media.ohos_ic_back'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .margin({ left: 24, top: 24 })
        }
        .layoutWeight(1)

        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ top: 24 })

        Row() {
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Image($r('sys.media.ohos_ic_heart'))
              .width(24)
              .height(24)
              .fillColor(this.isFavorite ? '#FF0000' : '#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .margin({ right: 24, top: 24 })
          .onClick(() => {
            this.isFavorite = !this.isFavorite;
          })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height(72)

      // Product Image Placeholder
      Column() {
        Image($r('sys.media.ohos_ic_public_cart'))
          .width(80)
          .height(80)
          .fillColor('#BDBDBD')
      }
      .width('100%')
      .height(300)
      .backgroundColor('#F5F5F5')
      .borderRadius(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin({ left: 24, right: 24, top: 24 })

      // Product Info Section
      Column() {
        Row() {
          Column() {
            Text('Modern Lounge Chair')
              .fontSize(26)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .lineHeight(32)

            Text('Minimalist Series')
              .fontSize(16)
              .fontColor('#808080')
              .margin({ top: 8 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Text('$1299')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        // Rating Row
        Row() {
          Image($r('sys.media.ohos_ic_star'))
            .width(20)
            .height(20)
            .fillColor('#FFC107')

          Text('4.8')
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ left: 4 })

          Text('(238 Reviews)')
            .fontColor('#808080')
            .fontSize(14)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        Text('Colors')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .margin({ top: 24 })

        Row() {
          ForEach(this.colorOptions, (color: string, index: number) => {
            Column() {
              if (this.selectedColorIndex === index) {
                Column() {
                  Column()
                    .width(10)
                    .height(10)
                    .backgroundColor('#FFFFFF')
                    .borderRadius(5)
                }
                .width(32)
                .height(32)
                .backgroundColor(color)
                .borderRadius(16)
                .border({ width: 2, color: '#D3D3D3', radius: 16 })
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
              } else {
                Column()
                  .width(32)
                  .height(32)
                  .backgroundColor(color)
                  .borderRadius(16)
              }
            }
            .margin({ right: 12 })
            .onClick(() => {
              this.selectedColorIndex = index;
            })
          })
        }
        .margin({ top: 12 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 32 })

      Blank()
        .layoutWeight(1)

      // Bottom Action Section
      Row() {
        Button('Add to Cart')
          .height(56)
          .layoutWeight(1)
          .backgroundColor('#000000')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .borderRadius(16)

        Column() {
          Image($r('sys.media.ohos_ic_heart'))
            .width(24)
            .height(24)
            .fillColor('#000000')
        }
        .width(56)
        .height(56)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}