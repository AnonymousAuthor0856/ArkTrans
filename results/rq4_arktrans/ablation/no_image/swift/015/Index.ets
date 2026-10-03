@Entry
@Component
struct Index {
  @State showDialog: boolean = false
  @State selectedVideo: string = ''

  build() {
    Stack() {
      Column() {
        Blank().height(30)

        Stack() {
          Rect()
            .linearGradient({
              angle: 180,
              colors: [['#E6E1E5', 0], ['#1C1B1F', 1]]
            })
            .height(70)

          Text('Video Library')
            .fontColor('#1C1B1F')
            .fontSize(26)
            .fontWeight(FontWeight.SemiBold)
        }.height(70)

        Column() {
          Text('Explore the latest videos')
            .padding({ top: 12, bottom: 12 })
            .padding({ left: 16, right: 16 })
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#1C1B1F')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Scroll() {
            Grid() {
              ForEach([1, 2, 3, 4], (item: number) => {
                GridItem() {
                  Column() {
                    Rect()
                      .fill(Color('#E6E1E5'))
                      .borderRadius(8)
                      .height(120)
                      .overlay(
                        Text('Thumbnail')
                          .fontColor('#1C1B1F')
                          .opacity(0.6)
                          .fontSize(11)
                          .fontWeight(FontWeight.Medium)
                      )

                    Text('Sample Video Title')
                      .maxLines(2)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .fixedSize(false)
                      .fontColor('#1C1B1F')
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)

                    Text('00:10')
                      .fontColor('#1C1B1F')
                      .opacity(0.7)
                      .fontSize(13)

                    Button() {
                      Text('Play')
                        .fontColor('#FFFFFF')
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                    }
                    .backgroundColor('#9C27B0')
                    .borderRadius(8)
                    .height(32)
                    .width('100%')
                  }
                  .padding(12)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(12)
                  .shadow({ radius: 2, color: '#1F000000', offsetX: 0, offsetY: 1 })
                  .width('100%')
                  .alignItems(HorizontalAlign.Start)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .padding({ top: 12, bottom: 12 })
            .padding({ left: 16, right: 16 })
          }
        }
        .linearGradient({
          angle: 180,
          colors: [['#E6E1E5', 0], ['#1C1B1F', 1]]
        })
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}