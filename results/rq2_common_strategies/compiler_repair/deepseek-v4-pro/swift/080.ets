@Entry
@Component
struct FurnitureApp {
  @State selectedColorIndex: number = 0

  private colors: string[] = ['#212121', '#795548', '#9E9E9E']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF')

      Column({ space: 0 }) {
        // Header bar
        Row({ space: 0 }) {
          Button() {
            Text('←')
              .fontSize(20)
              .foregroundColor('#000000')
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          Blank()

          Text('Details')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#000000')

          Blank()

          Button() {
            Text('♡')
              .fontSize(20)
              .foregroundColor('#000000')
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16 })

        // Content area
        List({ space: 0 }) {
          ListItem() {
            Column({ space: 0 }) {
              // Image placeholder
              Stack({ alignContent: Alignment.Center }) {
                Column()
                  .width('100%')
                  .height(300)
                  .backgroundColor('#F5F5F5')
                  .borderRadius(32)
                Text('🛒')
                  .fontSize(80)
                  .foregroundColor('#BDBDBD')
              }
              .width('100%')

              Blank().height(32)

              // Product info section
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Column({ space: 8 }) {
                    Text('Modern Lounge\nChair')
                      .fontSize(26)
                      .fontWeight(FontWeight.Bold)
                      .foregroundColor('#000000')
                      .lineHeight(32)
                    Text('Minimalist Series')
                      .fontSize(16)
                      .foregroundColor('#808080')
                  }
                  .alignItems(HorizontalAlign.Start)
                  Blank()

                  Text('$1299')
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .foregroundColor('#000000')
                }
                .width('100%')

                Blank().height(24)

                Row({ space: 0 }) {
                  Text('★')
                    .fontSize(20)
                    .foregroundColor('#FFC107')
                  Blank().width(4)
                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .foregroundColor('#000000')
                  Blank().width(8)
                  Text('(238 Reviews)')
                    .fontSize(14)
                    .foregroundColor('#808080')
                }
                .width('100%')

                Blank().height(24)

                Text('Colors')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#000000')

                Blank().height(12)

                Row({ space: 12 }) {
                  ForEach(this.colors, (color: string, index: number) => {
                    Stack({ alignContent: Alignment.Center }) {
                      Column()
                        .width(32)
                        .height(32)
                        .borderRadius(16)
                        .backgroundColor(color)
                        .border({
                          width: this.selectedColorIndex === index ? 2 : 0,
                          color: '#808080',
                          radius: 16
                        })
                      if (this.selectedColorIndex === index) {
                        Column()
                          .width(10)
                          .height(10)
                          .backgroundColor('#FFFFFF')
                          .borderRadius(5)
                      }
                    }
                    .width(32)
                    .height(32)
                    .onClick(() => {
                      this.selectedColorIndex = index
                    })
                  })
                }
                .width('100%')
              }
              .width('100%')

              // Bottom spacer
              Blank().height(24)
            }
            .padding({ left: 24, right: 24 })
          }
        }
        .width('100%')
        .layoutWeight(1)

        // Bottom action section
        Row({ space: 16 }) {
          Button() {
            Text('Add to Cart')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#FFFFFF')
              .width('100%')
              .height(56)
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .height(56)
          .backgroundColor('#000000')
          .borderRadius(16)

          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width(56)
              .height(56)
              .backgroundColor('#F5F5F5')
              .borderRadius(16)
            Text('♥')
              .fontSize(24)
              .foregroundColor('#000000')
          }
          .width(56)
          .height(56)
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}