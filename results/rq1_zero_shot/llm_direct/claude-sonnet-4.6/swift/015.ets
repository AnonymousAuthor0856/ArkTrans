import { promptAction } from '@kit.ArkUI';

// Color tokens
const VL_C = {
  primary: '#38BDF8',
  secondary: '#0EA5E9',
  tertiary: '#0369A1',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#BFE0F4',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#001F2F',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#082F49',
  onSurface: '#082F49',
};

interface VideoItem {
  id: number;
  title: string;
  duration: string;
}

const videos: VideoItem[] = [
  { id: 1, title: 'Nature Documentary', duration: '24:18' },
  { id: 2, title: 'AI Explained', duration: '18:52' },
  { id: 3, title: 'Space Travel', duration: '31:09' },
  { id: 4, title: 'Modern Art Review', duration: '15:45' },
  { id: 5, title: 'Retro Music Visuals', duration: '22:10' },
  { id: 6, title: 'Daily News Recap', duration: '12:34' },
];

@Entry
@Component
struct VideoLibraryRoot {
  @State selectedVideo: string = '';

  build() {
    Column({ space: 0 }) {
      // Top Spacer
      Blank()
        .height(30)

      // Top App Bar
      Stack() {
        // Background gradient
        Column()
          .width('100%')
          .height(70)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]],
          })

        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL_C.onSurface)
      }
      .width('100%')
      .height(70)

      // Main Content Area
      Column({ space: 0 }) {
        // Subtitle
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL_C.onSurface)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({
            left: 16,
            right: 16,
            top: 12,
            bottom: 12,
          })

        // Video Grid
        Scroll() {
          Grid() {
            ForEach(videos, (video: VideoItem) => {
              GridItem() {
                Column({ space: 0 }) {
                  // Thumbnail
                  Stack() {
                    Column()
                      .width('100%')
                      .height(120)
                      .borderRadius(8)
                      .backgroundColor(VL_C.surfaceVariant)

                    Text('Thumbnail')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(`${VL_C.onSurface}99`)
                  }
                  .width('100%')
                  .height(120)

                  // Video Title
                  Text(video.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(VL_C.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .margin({ top: 8 })

                  // Duration
                  Text(video.duration)
                    .fontSize(13)
                    .fontColor(`${VL_C.onSurface}B2`)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .margin({ top: 8 })

                  // Play Button
                  Button('Play')
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(VL_C.onPrimary)
                    .width('100%')
                    .height(32)
                    .backgroundColor(VL_C.primary)
                    .borderRadius(8)
                    .margin({ top: 8 })
                    .onClick(() => {
                      this.selectedVideo = video.title;
                      promptAction.showDialog({
                        title: 'Playing Video',
                        message: `Now playing: ${this.selectedVideo}`,
                        buttons: [
                          {
                            text: 'OK',
                            color: VL_C.primary,
                          },
                        ],
                      });
                    })
                }
                .padding(12)
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .backgroundColor(VL_C.surface)
                .borderRadius(12)
                .shadow({
                  color: '#1A000000',
                  radius: 2,
                  offsetX: 0,
                  offsetY: 1,
                })
              }
            }, (video: VideoItem) => video.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({
            left: 16,
            right: 16,
            top: 12,
            bottom: 12,
          })
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]],
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]],
    })
  }
}