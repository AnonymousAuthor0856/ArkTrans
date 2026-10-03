interface VideoItem {
  title: string
  duration: string
}

interface ColorTokens {
  primary: string
  backgroundTop: string
  backgroundBottom: string
  surface: string
  onSurface: string
  muted: string
}

const COLORS: ColorTokens = {
  primary: '#38BDF8',
  backgroundTop: '#E0F2FE',
  backgroundBottom: '#F0F9FF',
  surface: '#FFFFFF',
  onSurface: '#082F49',
  muted: '#57748B'
}

@Entry
@Component
struct VideoLibraryApp {
  private readonly videos: VideoItem[] = [
    { title: 'Nature\nDocumentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art\nReview', duration: '15:45' },
    { title: 'Retro Music\nVisuals', duration: '22:10' },
    { title: 'Daily News\nRecap', duration: '12:34' }
  ]

  build() {
    Column() {
      Column() {
        Text('Video Library')
          .fontSize(52)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 48, bottom: 38 })
      }
      .height(208)
      .justifyContent(FlexAlign.End)

      Column() {
        Text('Explore the latest videos')
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLORS.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ left: 34, right: 34, top: 26, bottom: 24 })

        Scroll() {
          Grid() {
            ForEach(this.videos, (video: VideoItem) => {
              GridItem() {
                Column() {
                  Stack() {
                    Text('Thumbnail')
                      .fontSize(23)
                      .fontColor(COLORS.muted)
                      .fontWeight(FontWeight.Medium)
                  }
                  .width('100%')
                  .height(250)
                  .backgroundColor(COLORS.backgroundTop)
                  .borderRadius(16)

                  Text(video.title)
                    .fontSize(33)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(COLORS.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .maxLines(2)
                    .margin({ top: 20 })

                  Text(video.duration)
                    .fontSize(28)
                    .fontColor(COLORS.muted)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .margin({ top: 16, bottom: 18 })

                  Button('Play')
                    .fontSize(24)
                    .fontColor('#001F2F')
                    .fontWeight(FontWeight.Medium)
                    .width('100%')
                    .height(67)
                    .backgroundColor(COLORS.primary)
                    .borderRadius(16)
                    .onClick(() => {
                      AlertDialog.show({
                        title: 'Playing Video',
                        message: `Now playing: ${video.title.replace('\n', ' ')}`,
                        primaryButton: {
                          value: 'OK',
                          action: () => {}
                        }
                      })
                    })
                }
                .width('100%')
                .padding(25)
                .backgroundColor(COLORS.surface)
                .borderRadius(24)
                .shadow({
                  radius: 8,
                  color: '#1A000000',
                  offsetX: 0,
                  offsetY: 3
                })
              }
              .width('100%')
            }, (video: VideoItem) => video.title)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(24)
          .rowsGap(24)
          .width('100%')
          .padding({ left: 34, right: 34, bottom: 30 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .backgroundColor(COLORS.backgroundTop)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.backgroundBottom)
  }
}
