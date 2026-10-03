@Entry
@Component
struct VideoLibraryRoot {
  @State selectedVideo: string = ''

  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ]

  private scale: number = 1.0

  aboutToAppear() {
    const screenW = px2vp(pixelMap.get(0))
    const screenH = px2vp(pixelMap.get(1))
    this.scale = Math.min(screenW / 360.0, screenH / 640.0)
  }

  private showPlayDialog(video: VideoItem): void {
    this.selectedVideo = video.title
    AlertDialog.show({
      title: 'Playing Video',
      message: 'Now playing: ' + this.selectedVideo,
      confirm: {
        value: 'OK',
        action: () => {
        }
      }
    })
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          colors: [[VL_C.surfaceVariant, 0.0], [VL_C.background, 1.0]],
          direction: GradientDirection.Bottom
        })

      Column({ space: 0 }) {
        // Top Spacer
        Blank()
          .height(30 * this.scale)

        // Top App Bar
        Stack() {
          Column()
            .width('100%')
            .height(70 * this.scale)
            .linearGradient({
              colors: [[VL_C.surfaceVariant, 0.0], [VL_C.background, 1.0]],
              direction: GradientDirection.Bottom
            })

          Text('Video Library')
            .fontSize(26 * this.scale)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(VL_C.onSurface)
        }
        .width('100%')
        .height(70 * this.scale)

        // Main Content Area
        Column({ space: 0 }) {
          // Subtitle
          Text('Explore the latest videos')
            .fontSize(16 * this.scale)
            .fontWeight(FontWeight.Medium)
            .fontColor(VL_C.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16 * this.scale, right: 16 * this.scale, top: 12 * this.scale, bottom: 12 * this.scale })

          // Video Grid
          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem) => {
                GridItem() {
                  Column({ space: 8 * this.scale }) {
                    // Thumbnail
                    Stack() {
                      Text('Thumbnail')
                        .fontSize(11 * this.scale)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(VL_C.onSurface)
                        .opacity(0.6)
                    }
                    .width('100%')
                    .height(120 * this.scale)
                    .backgroundColor(VL_C.surfaceVariant)
                    .borderRadius(8 * this.scale)

                    // Video Title
                    Text(video.title)
                      .fontSize(16 * this.scale)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(VL_C.onSurface)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    // Duration
                    Text(video.duration)
                      .fontSize(13 * this.scale)
                      .fontColor(VL_C.onSurface)
                      .opacity(0.7)
                      .width('100%')
                      .textAlign(TextAlign.Start)

                    // Play Button
                    Button('Play')
                      .fontSize(11 * this.scale)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(VL_C.onPrimary)
                      .width('100%')
                      .height(32 * this.scale)
                      .backgroundColor(VL_C.primary)
                      .borderRadius(8 * this.scale)
                      .onClick(() => {
                        this.selectedVideo = video.title
                        this.showDialog = true
                      })
                  }
                  .width('100%')
                  .padding(12 * this.scale)
                  .alignItems(HorizontalAlign.Start)
                  .backgroundColor(VL_C.surface)
                  .borderRadius(12 * this.scale)
                  .shadow({
                    radius: 2 * this.scale,
                    color: 'rgba(0, 0, 0, 0.1)',
                    offsetX: 0,
                    offsetY: 1 * this.scale
                  })
                }
              }, (video: VideoItem) => video.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12 * this.scale)
            .rowsGap(12 * this.scale)
            .padding({ left: 16 * this.scale, right: 16 * this.scale, top: 12 * this.scale, bottom: 12 * this.scale })
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          colors: [[VL_C.surfaceVariant, 0.0], [VL_C.background, 1.0]],
          direction: GradientDirection.Bottom
        })
      }
      .width('100%')
      .height('100%')

      // Alert Dialog
      if (this.showDialog) {
        AlertDialog.show({
          title: 'Playing Video',
          message: 'Now playing: ' + this.selectedVideo,
          confirm: {
            value: 'OK',
            action: () => {
              this.showDialog = false
            }
          },
          onCancel: () => {
            this.showDialog = false
          }
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}

class VideoItem {
  id: string
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.id = title + '_' + duration
    this.title = title
    this.duration = duration
  }
}

namespace VL_C {
  export const primary: string = '#38BDF8'
  export const secondary: string = '#0EA5E9'
  export const tertiary: string = '#0369A1'
  export const background: string = '#F0F9FF'
  export const surface: string = '#FFFFFF'
  export const surfaceVariant: string = '#E0F2FE'
  export const outline: string = '#BFE0F4'
  export const success: string = '#16A34A'
  export const warning: string = '#F59E0B'
  export const error: string = '#DC2626'
  export const onPrimary: string = '#001F2F'
  export const onSecondary: string = '#FFFFFF'
  export const onTertiary: string = '#FFFFFF'
  export const onBackground: string = '#082F49'
  export const onSurface: string = '#082F49'
}
