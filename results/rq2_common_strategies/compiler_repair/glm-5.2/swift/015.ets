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

// MARK: - Models
class VideoItem {
  id: string;
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.id = `${title}-${duration}-${Math.random().toString(36).substr(2, 9)}`;
    this.title = title;
    this.duration = duration;
  }
}

// MARK: - Main Entry
@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = "";
  
  private videos: VideoItem[] = [
    new VideoItem("Nature Documentary", "24:18"),
    new VideoItem("AI Explained", "18:52"),
    new VideoItem("Space Travel", "31:09"),
    new VideoItem("Modern Art Review", "15:45"),
    new VideoItem("Retro Music Visuals", "22:10"),
    new VideoItem("Daily News Recap", "12:34")
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column()
        .linearGradient({
          angle: 180,
          colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
        })
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 });

      // Main Content
      Column() {
        // Top Spacer
        Column().height(30).width('100%');

        // Top App Bar
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .linearGradient({
              angle: 180,
              colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
            })
            .width('100%')
            .height(70);
          
          Text("Video Library")
            .fontSize(26)
            .fontWeight(FontWeight.Medium)
            .fontColor(VLC.onSurface);
        }
        .width('100%')
        .height(70);

        // Main Content Area
        Column() {
          // Subtitle
          Text("Explore the latest videos")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(VLC.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 });

          // Video Grid
          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem) => {
                GridItem() {
                  Column() {
                    // Thumbnail
                    Stack({ alignContent: Alignment.Center }) {
                      Text("Thumbnail")
                        .fontSize(11)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(VLC.onSurface)
                        .opacity(0.6);
                    }
                    .width('100%')
                    .height(120)
                    .backgroundColor(VLC.surfaceVariant)
                    .borderRadius(8);

                    // Video Title
                    Text(video.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(VLC.onSurface)
                      .maxLines(2)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .margin({ top: 8 })
                      .width('100%')
                      .textAlign(TextAlign.Start);

                    // Duration
                    Text(video.duration)
                      .fontSize(13)
                      .fontColor(VLC.onSurface)
                      .opacity(0.7)
                      .margin({ top: 4 })
                      .width('100%')
                      .textAlign(TextAlign.Start);

                    // Play Button
                    Button("Play", { type: ButtonType.Capsule })
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(VLC.onPrimary)
                      .width('100%')
                      .height(32)
                      .backgroundColor(VLC.primary)
                      .margin({ top: 8 })
                      .onClick(() => {
                        this.selectedVideo = video.title;
                        this.showDialog = true;
                      });
                  }
                  .padding(12)
                  .backgroundColor(VLC.surface)
                  .borderRadius(12)
                  .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
                  .alignItems(HorizontalAlign.Start)
                  .height('100%');
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(12)
            .rowsGap(12)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 });
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off);
        }
        .layoutWeight(1)
        .linearGradient({
          angle: 180,
          colors: [[VLC.surfaceVariant, 0.0], [VLC.background, 1.0]]
        });
      }
      .width('100%')
      .height('100%');

      // Alert Dialog
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          // Dim Background
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('rgba(0,0,0,0.4)')
            .onClick(() => {
              this.showDialog = false;
            });

          // Dialog Content
          Column() {
            Text("Playing Video")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(VLC.onSurface)
              .margin({ bottom: 12 });

            Text(`Now playing: ${this.selectedVideo}`)
              .fontSize(16)
              .fontColor(VLC.onSurface)
              .margin({ bottom: 24 });

            Button("OK", { type: ButtonType.Capsule })
              .width('100%')
              .backgroundColor(VLC.primary)
              .fontColor(VLC.onPrimary)
              .onClick(() => {
                this.showDialog = false;
              });
          }
          .width('80%')
          .padding(24)
          .backgroundColor(VLC.surface)
          .borderRadius(16);
        }
        .width('100%')
        .height('100%');
      }
    }
    .width('100%')
    .height('100%');
  }
}