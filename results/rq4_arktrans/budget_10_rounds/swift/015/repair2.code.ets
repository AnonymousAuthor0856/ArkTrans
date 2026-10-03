import { AlertDialog } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @State showDialog: boolean = false
  @State selectedVideo: string = ''

  build() {
    Stack() {
      Column() {
        // Header Section
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#013A58')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 40, bottom: 20 })

        // Subtitle
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#013A58')
          .alignSelf(ItemAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // Scrollable Grid Content
        Scroll() {
          Grid() {
            ForEach([
              { title: 'Nature Documentary', duration: '24:18' },
              { title: 'AI Explained', duration: '18:52' },
              { title: 'Space Travel', duration: '31:09' },
              { title: 'Modern Art Review', duration: '15:45' }
            ], (item: VideoItem) => {
              GridItem() {
                Column() {
                  // Thumbnail Placeholder
                  Rect()
                    .fill('#E1F0FA')
                    .borderRadius(8)
                    .height(120)
                    .width('100%')
                    .overlay(
                      Text('Thumbnail')
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#013A58')
                        .opacity(0.6)
                    )

                  // Title
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#013A58')
                    .maxLines(2)
                    .width('100%')
                    .margin({ top: 12, bottom: 4 })
                    .textAlign(TextAlign.Start)

                  // Duration
                  Text(item.duration)
                    .fontSize(13)
                    .fontColor('#013A58')
                    .opacity(0.7)
                    .margin({ bottom: 12 })

                  // Play Button
                  Button() {
                    Text('Play')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FFFFFF')
                  }
                  .backgroundColor('#38BDF8')
                  .borderRadius(8)
                  .height(32)
                  .width('100%')
                  .onClick(() => {
                    this.selectedVideo = item.title
                    this.showDialog = true
                  })
                }
                .padding(12)
                .width('100%')
                .height('100%')
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({ radius: 2, color: '#1F000000', offsetY: 1 })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 20 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [['#E1F0FA', 0], ['#F0F8FF', 1]]
      })

      // Alert Dialog Implementation
      if (this.showDialog) {
        new AlertDialog({
          message: `Now playing: ${this.selectedVideo}`,
          buttons: [
            {
              value: 'OK',
              action: () => {
                this.showDialog = false
              }
            }
          ]
        }).show()
      }
    }
    .width('100%')
    .height('100%')
  }
}

interface VideoItem {
  title: string;
  duration: string;
}