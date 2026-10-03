// VideoLibraryApp.ets

// MARK: - Tokens
class VLC {
  static primary: string = '#38BDF8';
  static secondary: string = '#0EA5E9';
  static tertiary: string = '#0369A1';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#BFE0F4';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#DC2626';
  static onPrimary: string = '#001F2F';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#FFFFFF';
  static onBackground: string = '#082F49';
  static onSurface: string = '#082F49';
}

// MARK: - Model
class VideoItem {
  id: string;
  title: string;
  duration: string;

  constructor(id: string, title: string, duration: string) {
    this.id = id;
    this.title = title;
    this.duration = duration;
  }
}

// MARK: - Main Entry
@Entry
@Component
struct VideoLibraryApp {
  @State showDialog: boolean = false;
  @State selectedVideo: string = '';
  private videos: VideoItem[] = [
    new VideoItem('1', 'Nature Documentary', '24:18'),
    new VideoItem('2', 'AI Explained', '18:52'),
    new VideoItem('3', 'Space Travel', '31:09'),
    new VideoItem('4', 'Modern Art Review', '15:45'),
    new VideoItem('5', 'Retro Music Visuals', '22:10'),
    new VideoItem('6', 'Daily News Recap', '12:34')
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column() {
        LinearGradient({
          direction: GradientDirection.Bottom,
          colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
        })
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      // Main Content
      Column() {
        // Top Spacer
        Column().height(30).width('100%')

        // Top App Bar
        Stack({ alignContent: Alignment.Center }) {
          LinearGradient({
            direction: GradientDirection.Bottom,
            colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
          })
          .width('100%')
          .height(70)

          Text('Video Library')
            .fontSize(26)
            .fontWeight(FontWeight.Medium)
            .fontColor(VLC.onSurface)
        }
        .width('100%')
        .height(70)

        // Main Content Area
        Column() {
          // Subtitle
          Text('Explore the latest videos')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(VLC.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })

          // Video Grid
          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem) => {
                GridItem() {
                  // Card
                  Column() {
                    // Thumbnail
                    Stack({ alignContent: Alignment.Center }) {
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
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .margin({ top: 8, bottom: 8 })

                    // Duration
                    Text(video.duration)
                      .fontSize(13)
                      .fontColor(VLC.onSurface)
                      .opacity(0.7)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .margin({ bottom: 8 })

                    // Play Button
                    Button({ type: ButtonType.Normal }) {
                      Text('Play')
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(VLC.onPrimary)
                    }
                    .width('100%')
                    .height(32)
                    .borderRadius(8)
                    .backgroundColor(VLC.primary)
                    .onClick(() => {
                      this.selectedVideo = video.title;
                      this.showDialog = true;
                    })
                  }
                  .padding(12)
                  .backgroundColor(VLC.surface)
                  .borderRadius(12)
                  .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
                  .alignItems(HorizontalAlign.Start)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .layoutWeight(1)
        .background(LinearGradient({
          direction: GradientDirection.Bottom,
          colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
        }))
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .alertDialog({
      title: 'Playing Video',
      message: `Now playing: ${this.selectedVideo}`,
      confirm: {
        value: 'OK',
        action: () => {
          this.showDialog = false;
        }
      },
      cancel: () => {
        this.showDialog = false;
      }
    })
    // Visibility binding for the custom alert dialog
    .visibility(this.showDialog ? Visibility.Visible : Visibility.Visible) 
  }
}