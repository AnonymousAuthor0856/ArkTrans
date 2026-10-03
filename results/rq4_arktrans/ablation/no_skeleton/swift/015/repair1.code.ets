interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false
  @State selectedVideo: string = ""

  private readonly videos: Array<VideoItem> = [
    { title: "Nature Documentary", duration: "24:18" },
    { title: "AI Explained", duration: "18:52" },
    { title: "Space Travel", duration: "31:09" },
    { title: "Modern Art Review", duration: "15:45" },
    { title: "Retro Music Visuals", duration: "22:10" },
    { title: "Daily News Recap", duration: "12:34" }
  ]

  build() {
    Column() {
      // Top Spacer
      Blank().height(30)

      // Top App Bar
      Stack() {
        Text("Video Library")
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#082F49')
      }
      .width('100%')
      .height(70)
      .linearGradient({
        angle: 90,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })

      // Main Content Area
      Column() {
        // Subtitle
        Text("Explore the latest videos")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // Video Grid
        Scroll() {
          Grid() {
            ForEach(this.videos, (item: VideoItem) => {
              GridItem() {
                Column({ space: 8 }) {
                  // Thumbnail
                  Row()
                    .backgroundColor('#E0F2FE')
                    .borderRadius(8)
                    .height(120)
                    .justifyContent(FlexAlign.Center)
                    .alignItems(VerticalAlign.Center)
                    .width('100%')
                    .child(() => {
                      Text("Thumbnail")
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#082F49')
                        .opacity(0.6)
                    })

                  // Video Title
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#082F49')
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .width('100%')
                    .textAlign(TextAlign.Start)

                  // Duration
                  Text(item.duration)
                    .fontSize(13)
                    .fontColor('#082F49')
                    .opacity(0.7)

                  // Play Button
                  Button() {
                    Text("Play")
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#001F2F')
                  }
                  .width('100%')
                  .height(32)
                  .backgroundColor('#38BDF8')
                  .borderRadius(8)
                  .onClick(() => {
                    this.selectedVideo = item.title
                    this.showDialog = true
                  })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({ radius: 2, color: '#1A000000', offsetY: 1 })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .layoutWeight(1)
      }
      .linearGradient({
        angle: 90,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
    })
    .dialog(this.showDialog ? CustomDialog({
      title: 'Playing Video',
      message: `Now playing: ${this.selectedVideo}`,
      onConfirm: () => {
        this.showDialog = false
      }
    }) : undefined)
  }
}

@Component
struct CustomDialog {
  title: string = ''
  message: string = ''
  onConfirm: () => void = () => {}

  build() {
    Dialog() {
      Column() {
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 8 })
        
        Text(this.message)
          .fontSize(14)
          .margin({ bottom: 20 })
        
        Button() {
          Text("OK")
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(40)
        .backgroundColor('#38BDF8')
        .borderRadius(8)
        .onClick(() => {
          this.onConfirm()
        })
      }
      .width('80%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
    }
    .autoCancel(false)
  }
}