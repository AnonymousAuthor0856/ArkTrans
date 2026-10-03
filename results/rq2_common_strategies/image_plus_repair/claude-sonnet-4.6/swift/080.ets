@Entry
@Component
struct FurnitureDetailScreen {
  build() {
    Column() {
      // Header
      Row() {
        Button() {
          Text('←')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .onClick(() => {})

        Text('Details')
          .fontSize(18)
          .fontWeight(600)
          .fontColor('#000000')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button() {
          Text('♡')
            .fontSize(20)
            .fontColor('#000000')
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.White)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Product Image Placeholder
          Stack() {
            Column()
              .width('100%')
              .height(300)
              .backgroundColor('#F5F5F5')
              .borderRadius(32)

            Text('🛒')
              .fontSize(60)
              .fontColor('#BDBDBD')
          }
          .width('100%')
          .height(300)
          .margin({ top: 24 })

          // Product Info
          Column() {
            // Title and Price Row
            Row() {
              Column() {
                Text('Modern Lounge\nChair')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
                  .lineHeight(36)

                Text('Minimalist Series')
                  .fontSize(16)
                  .fontColor('#9E9E9E')
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Start)

              Text('$1299')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Top)
            .margin({ top: 32 })

            // Rating Row
            Row() {
              Text('★')
                .fontSize(20)
                .fontColor('#FFC107')

              Text('4.8')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .margin({ left: 4 })

              Text('(238 Reviews)')
                .fontSize(14)
                .fontColor('#9E9E9E')
                .margin({ left: 8 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .margin({ top: 24 })

            // Colors Section
            Text('Colors')
              .fontSize(18)
              .fontWeight(600)
              .fontColor('#000000')
              .margin({ top: 24 })
              .alignSelf(ItemAlign.Start)

            Row() {
              // Color 1 - Dark (selected)
              Stack() {
                Circle({ width: 32, height: 32 })
                  .fill('#212121')

                Circle({ width: 36, height: 36 })
                  .fill(Color.Transparent)
                  .border({ width: 2, color: '#80808080', radius: 18 })

                Circle({ width: 10, height: 10 })
                  .fill(Color.White)
              }
              .width(36)
              .height(36)

              // Color 2 - Brown
              Stack() {
                Circle({ width: 32, height: 32 })
                  .fill('#795548')
              }
              .width(32)
              .height(32)
              .margin({ left: 12 })

              // Color 3 - Gray
              Stack() {
                Circle({ width: 32, height: 32 })
                  .fill('#9E9E9E')
              }
              .width(32)
              .height(32)
              .margin({ left: 12 })
            }
            .margin({ top: 12 })
            .alignSelf(ItemAlign.Start)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })

          Column()
            .height(24)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom Action Section
      Row() {
        Button() {
          Text('Add to Cart')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
        .layoutWeight(1)
        .height(56)
        .backgroundColor('#000000')
        .borderRadius(16)
        .onClick(() => {})

        Stack() {
          Column()
            .width(56)
            .height(56)
            .backgroundColor('#F5F5F5')
            .borderRadius(16)

          Text('♥')
            .fontSize(24)
            .fontColor('#000000')
        }
        .width(56)
        .height(56)
        .margin({ left: 16 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24, top: 16 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}