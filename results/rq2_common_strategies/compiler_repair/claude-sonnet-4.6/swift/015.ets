import { promptAction } from '@kit.ArkUI';

class VideoItem {
  id: number;
  title: string;
  duration: string;

  constructor(id: number, title: string, duration: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
  }
}

const videos: VideoItem[] = [
  new VideoItem(1, 'Nature Documentary', '24:18'),
  new VideoItem(2, 'AI Explained', '18:52'),
  new VideoItem(3, 'Space Travel', '31:09'),
  new VideoItem(4, 'Modern Art Review', '15:45'),
  new VideoItem(5, 'Retro Music Visuals', '22:10'),
  new VideoItem(6, 'Daily News Recap', '12:34'),
];

// Color tokens
const PRIMARY: string = '#38BDF8';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#E0F2FE';
const ON_PRIMARY: string = '#001F2F';
const ON_SURFACE: string = '#082F49';

@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = '';

  build() {
    Column() {
      // Top Spacer
      Blank().height(30)

      // Top App Bar
      Stack() {
        Column()
          .width('100%')
          .height(70)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]]
          })

        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
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
          .fontColor(ON_SURFACE)
          .width('100%')
          .textAlign(TextAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // Video Grid
        Scroll() {
          Grid() {
            ForEach(videos, (video: VideoItem) => {
              GridItem() {
                Column({ space: 8 }) {
                  // Thumbnail
                  Stack() {
                    Column()
                      .width('100%')
                      .height(120)
                      .backgroundColor(SURFACE_VARIANT)
                      .borderRadius(8)

                    Text('Thumbnail')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#82082F49')
                  }
                  .width('100%')
                  .height(120)
                  .alignContent(Alignment.Center)

                  // Video Title
                  Text(video.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ON_SURFACE)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  // Duration
                  Text(video.duration)
                    .fontSize(13)
                    .fontColor('#B3082F49')
                    .width('100%')
                    .textAlign(TextAlign.Start)

                  // Play Button
                  Button('Play')
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ON_PRIMARY)
                    .width('100%')
                    .height(32)
                    .backgroundColor(PRIMARY)
                    .borderRadius(8)
                    .onClick(() => {
                      this.selectedVideo = video.title;
                      const dialogTitle: string = 'Playing Video';
                      const dialogMessage: string = 'Now playing: ' + this.selectedVideo;
                      promptAction.showDialog({
                        title: dialogTitle,
                        message: dialogMessage,
                        buttons: [
                          {
                            text: 'OK',
                            color: PRIMARY
                          }
                        ]
                      }).then(() => {
                        this.showDialog = false;
                      });
                    })
                }
                .padding(12)
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .backgroundColor(SURFACE)
                .borderRadius(12)
                .shadow({
                  color: '#1A000000',
                  radius: 4,
                  offsetX: 0,
                  offsetY: 1
                })
              }
            }, (video: VideoItem) => video.id.toString())
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
        colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[0xE0F2FE, 0.0], [0xF0F9FF, 1.0]]
    })
  }
}