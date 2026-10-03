@Entry
@Component
struct VideoLibraryPage {
  @State showDialog: boolean = false
  @State selectedVideo: string = ''

  private videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ]

  build() {
    Stack() {
      Column() {
        // Top spacer
        Blank()
          .height(30)

        // Top App Bar
        Stack() {
          Text('Video Library')
            .fontSize(26)
            .fontWeight(600)
            .fontColor(VLC.onSurface)
        }
        .width('100%')
        .height(70)

        // Main Content Area
        Column({ space: 0 }) {
          // Subtitle
          Text('Explore the latest videos')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(VLC.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })

          // Video Grid (ScrollView + Grid)
          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem, index: number) => {
                GridItem() {
                  this.VideoCard(video)
                }
              }, (video: VideoItem) => video.title)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            .width('100%')
          }
          .scrollBar(BarState.Off)
          .flexGrow(1)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Play dialog
      if (this.showDialog) {
        Stack() {
          Column() {
            Text('Playing Video')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(VLC.onSurface)
              .margin({ top: 20, bottom: 10 })

            Text(`Now playing: ${this.selectedVideo}`)
              .fontSize(14)
              .fontColor(VLC.onSurface)
              .margin({ bottom: 20 })
              .textAlign(TextAlign.Center)

            Button('OK')
              .width(120)
              .height(36)
              .fontSize(14)
              .backgroundColor(VLC.primary)
              .fontColor(VLC.onPrimary)
              .margin({ bottom: 20 })
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width(280)
          .backgroundColor(VLC.surface)
          .borderRadius(16)
          .alignItems(HorizontalAlign.Center)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.15)',
            offsetX: 0,
            offsetY: 4
          })
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0, 0, 0, 0.3)')
        .alignContent(Alignment.Center)
        .onClick(() => {
          this.showDialog = false
        })
      }
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
    })
  }

  @Builder
  VideoCard(video: VideoItem) {
    Column({ space: 8 }) {
      // Thumbnail
      Stack() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(VLC.onSurface)
          .opacity(0.6)
      }
      .width('100%')
      .height(120)
      .backgroundColor(VLC.surfaceVariant)
      .borderRadius(8)

      // Video Title
      Text(video.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(VLC.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // Duration
      Text(video.duration)
        .fontSize(13)
        .fontColor(VLC.onSurface)
        .opacity(0.7)
        .width('100%')
        .textAlign(TextAlign.Start)

      // Play Button
      Button('Play')
        .width('100%')
        .height(32)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(VLC.onPrimary)
        .backgroundColor(VLC.primary)
        .borderRadius(8)
        .onClick(() => {
          this.selectedVideo = video.title
          this.showDialog = true
        })
    }
    .width('100%')
    .padding(12)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(VLC.surface)
    .borderRadius(12)
    .shadow({
      radius: 2,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 1
    })
  }
}

interface VideoItem {
  title: string
  duration: string
}

namespace VLC {
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
