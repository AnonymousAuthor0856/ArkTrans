@Entry
@Component
struct FurnitureDetailScreen {
  @State selectedColorIndex: number = 0
  private colors: string[] = ['#212121', '#795548', '#9E9E9E']

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Button() {
            Image($r('sys.media.ohos_ic_public_arrow_left'))
              .width(20)
              .height(20)
              .fillColor(Color.Black)
          }
          .width(48)
          .height(48)
          .type(ButtonType.Circle)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#E0E0E0' })

          Text('Details')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Button() {
            Text('♡')
              .fontSize(22)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .type(ButtonType.Circle)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#E0E0E0' })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16 })

        // Content - Scrollable
        Scroll() {
          Column() {
            // Product Image Placeholder
            Stack() {
              RoundRectPlaceholder()

              Text('\u{1F6D2}')
                .fontSize(80)
                .fontColor('#BDBDBD')
            }
            .width('100%')
            .height(300)

            // Product Info
            Column() {
              Row() {
                Column() {
                  Text('Modern Lounge\nChair')
                    .fontSize(26)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                    .lineHeight(32)

                  Text('Minimalist Series')
                    .fontSize(16)
                    .fontColor(Color.Gray)
                    .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text('$1299')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)

              // Rating
              Row() {
                Text('★')
                  .fontSize(20)
                  .fontColor('#FFC107')

                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
                  .margin({ left: 4 })

                Text('(238 Reviews)')
                  .fontSize(14)
                  .fontColor(Color.Gray)
                  .margin({ left: 8 })
              }
              .width('100%')
              .margin({ top: 24 })

              // Colors
              Text('Colors')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
                .margin({ top: 24 })

              Row() {
                ForEach(this.colors, (color: string, index: number) => {
                  ColorSelector({ color: color, isSelected: index === this.selectedColorIndex })
                    .onClick(() => {
                      this.selectedColorIndex = index
                    })
                }, (color: string, index: number) => color + index.toString())
              }
              .margin({ top: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 32 })
          }
          .width('100%')
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // Bottom Actions
        Row() {
          Button('Add to Cart')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .backgroundColor(Color.Black)
            .layoutWeight(1)
            .height(56)
            .borderRadius(16)

          Stack() {
            Text('❤')
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .width(56)
          .height(56)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct RoundRectPlaceholder {
  build() {
    Stack() {
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .borderRadius(32)
  }
}

@Component
struct ColorSelector {
  color: string = ''
  isSelected: boolean = false

  build() {
    Stack() {
      Circle()
        .width(32)
        .height(32)
        .fill(this.color)

      if (this.isSelected) {
        Circle()
          .width(32)
          .height(32)
          .stroke(Color.Gray)
          .strokeWidth(2)
          .fill(Color.Transparent)
          .opacity(0.5)

        Circle()
          .width(10)
          .height(10)
          .fill(Color.White)
      }
    }
    .width(32)
    .height(32)
    .margin({ right: 12 })
  }
}
