@Entry
@Component
struct Index {
  @State videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 12 }) {
        Text('Explore the latest videos')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .margin({ top: 60, bottom: 12 })

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              Column() {
                // Thumbnail placeholder
                Stack({ alignContent: Alignment.Center }) {
                  Text('Thumbnail')
                    .fontSize(14)
                    .fontColor('#082F49')
                    .opacity(0.6)
                }
                .width('100%')
                .height(120)
                .backgroundColor('#E0F2FE')
                .borderRadius(12)

                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#082F49')
                  .margin({ top: 12 })

                Text(item.duration)
                  .fontSize(14)
                  .fontColor('#082F49')
                  .opacity(0.7)
                  .margin({ top: 4 })

                Button('Play')
                  .width('100%')
                  .height(40)
                  .backgroundColor('#38BDF8')
                  .borderRadius(12)
                  .margin({ top: 12 })
                  .onClick(() => {
                    // Play action
                  })
              }
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#F0F9FF')

      // Top App Bar
      Row() {
        Text('Video Library')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
  }
}

interface VideoItem {
  title: string
  duration: string
}