import { promptAction } from '@kit.ArkUI';

interface VideoItem {
  id: number;
  title: string;
  duration: string;
}

@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = '';

  private videos: VideoItem[] = [
    { id: 1, title: 'Nature Documentary', duration: '24:18' },
    { id: 2, title: 'AI Explained', duration: '18:52' },
    { id: 3, title: 'Space Travel', duration: '31:09' },
    { id: 4, title: 'Modern Art Review', duration: '15:45' },
    { id: 5, title: 'Retro Music Visuals', duration: '22:10' },
    { id: 6, title: 'Daily News Recap', duration: '12:34' },
  ];

  // Color tokens
  readonly colorPrimary: string = '#38BDF8';
  readonly colorBackground: string = '#F0F9FF';
  readonly colorSurface: string = '#FFFFFF';
  readonly colorSurfaceVariant: string = '#E0F2FE';
  readonly colorOnSurface: string = '#082F49';
  readonly colorOnPrimary: string = '#001F2F';
  readonly colorOnSurfaceMuted: string = '#4A7A9B';

  build() {
    Column() {
      // Top Spacer
      Row()
        .height(30)

      // Top App Bar
      Stack() {
        Column()
          .width('100%')
          .height(70)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
          })

        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnSurface)
      }
      .width('100%')
      .height(70)
      .alignContent(Alignment.Center)

      // Main Content Area
      Column() {
        // Subtitle
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colorOnSurface)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // Video Grid
        Scroll() {
          Grid() {
            ForEach(this.videos, (video: VideoItem) => {
              GridItem() {
                Column({ space: 8 }) {
                  // Thumbnail
                  Stack() {
                    Column()
                      .width('100%')
                      .height(120)
                      .backgroundColor(this.colorSurfaceVariant)
                      .borderRadius(8)

                    Text('Thumbnail')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#4A7A9B')
                  }
                  .width('100%')
                  .height(120)
                  .alignContent(Alignment.Center)

                  // Video Title
                  Text(video.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorOnSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  // Duration
                  Text(video.duration)
                    .fontSize(13)
                    .fontColor('#4A7A9B')
                    .width('100%')
                    .textAlign(TextAlign.Start)

                  // Play Button
                  Button('Play')
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.colorOnPrimary)
                    .width('100%')
                    .height(32)
                    .backgroundColor(this.colorPrimary)
                    .borderRadius(8)
                    .onClick(() => {
                      this.selectedVideo = video.title;
                      promptAction.showDialog({
                        title: 'Playing Video',
                        message: `Now playing: ${this.selectedVideo}`,
                        buttons: [
                          {
                            text: 'OK',
                            color: '#38BDF8'
                          }
                        ]
                      }).then(() => {
                        this.showDialog = false;
                      });
                    })
                }
                .padding(12)
                .backgroundColor(this.colorSurface)
                .borderRadius(12)
                .shadow({
                  color: '#1A000000',
                  radius: 4,
                  offsetX: 0,
                  offsetY: 1
                })
                .alignItems(HorizontalAlign.Start)
                .width('100%')
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#E0F2FE', 0.0], ['#F0F9FF', 1.0]]
    })
  }
}