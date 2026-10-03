interface VideoItem {
  title: string;
  duration: string;
}

const videos: VideoItem[] = [
  { title: "Nature Documentary", duration: "24:18" },
  { title: "AI Explained", duration: "18:52" },
  { title: "Space Travel", duration: "31:09" },
  { title: "Modern Art Review", duration: "15:45" },
  { title: "Retro Music Visuals", duration: "22:10" },
  { title: "Daily News Recap", duration: "12:34" }
];

@Entry
@Component
struct Index {
  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Video Library")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#082F49')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor('#F0F9FF')

      // Content
      Scroll() {
        Column() {
          Text("Explore the latest videos")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#082F49')
            .width('100%')
            .padding({ bottom: 12 })

          Grid() {
            ForEach(videos, (item: VideoItem) => {
              GridItem() {
                Column() {
                  // Thumbnail
                  Stack() {
                    Text("Thumbnail")
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('rgba(8,47,73,0.6)')
                  }
                  .width('100%')
                  .height(120)
                  .backgroundColor('#E0F2FE')
                  .borderRadius(8)
                  .alignContent(Alignment.Center)

                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                    .width('100%')
                    .margin({ top: 8 })

                  Text(item.duration)
                    .fontSize(13)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('rgba(8,47,73,0.7)')
                    .width('100%')
                    .margin({ top: 4 })

                  Button("Play")
                    .width('100%')
                    .height(40)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#001F2F')
                    .backgroundColor('#38BDF8')
                    .borderRadius(8)
                    .margin({ top: 8 })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({
                  radius: 4,
                  color: 'rgba(0,0,0,0.12)',
                  offsetX: 0,
                  offsetY: 2
                })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .width('100%')
        }
        .padding(16)
        .width('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}