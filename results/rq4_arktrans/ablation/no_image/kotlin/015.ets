@Entry
@Component
struct Index {
  @State exploreTheLatestVideos: string = 'Explore the latest videos'
  @State thumbnail: string = 'Thumbnail'
  @State itemTitle: string = 'item.title'
  @State itemDuration: string = 'item.duration'
  @State play: string = 'Play'
  @State videoLibrary: string = 'Video Library'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text(this.exploreTheLatestVideos)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')

        Grid() {
          GridItem() {
            Column() {
              Column({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Text(this.thumbnail)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                }
                .width('100%')
                .height(120)
                .backgroundColor('#E0F2FE')

                Text(this.itemTitle)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#082F49')

                Text(this.itemDuration)
                  .fontSize(14)
                  .fontColor('#082F49')

                Button() {
                  Text(this.play)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                }
                .height(40)
                .width('100%')
                .backgroundColor('#082F49')
                .borderRadius(8)
              }
              .width('100%')
              .padding(12)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
          }
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })

      Row() {
        Text(this.videoLibrary)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')
    }
    .width('100%')
    .height('100%')
  }
}