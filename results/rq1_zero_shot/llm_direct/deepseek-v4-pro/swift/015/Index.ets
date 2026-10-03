// VideoLibraryApp.ets
import { promptAction } from '@kit.ArkUI';

// Color tokens
class VLColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#0369A1';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BFE0F4';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#001F2F';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#082F49';
  static readonly onSurface: string = '#082F49';
}

// Video item model
class VideoItem {
  id: string;
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.id = `${Date.now()}_${Math.random()}`;
    this.title = title;
    this.duration = duration;
  }
}

@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = '';
  @State videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ];

  @Builder
  VideoCard(video: VideoItem, scale: number) {
    Column({ space: 8 * scale }) {
      // Thumbnail
      Stack() {
        Row()
          .width('100%')
          .height(120 * scale)
          .backgroundColor(VLColors.surfaceVariant)
          .borderRadius(8 * scale)

        Text('Thumbnail')
          .fontSize(11 * scale)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49')
      }
      .width('100%')
      .height(120 * scale)

      // Video Title
      Text(video.title)
        .fontSize(16 * scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VLColors.onSurface)
        .width('100%')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Start)

      // Duration
      Text(video.duration)
        .fontSize(13 * scale)
        .fontColor('#B3082F49')
        .width('100%')
        .textAlign(TextAlign.Start)

      // Play Button
      Button('Play')
        .fontSize(11 * scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VLColors.onPrimary)
        .width('100%')
        .height(32 * scale)
        .backgroundColor(VLColors.primary)
        .borderRadius(8 * scale)
        .onClick(() => {
          this.selectedVideo = video.title;
          this.showDialog = true;
        })
    }
    .width('100%')
    .padding(12 * scale)
    .backgroundColor(VLColors.surface)
    .borderRadius(12 * scale)
    .shadow({
      radius: 2 * scale,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 1 * scale
    })
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack() {
      // Background gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [[VLColors.surfaceVariant, 0.0], [VLColors.background, 1.0]]
        })

      Column({ space: 0 }) {
        // Top Spacer
        Row()
          .width('100%')
          .height(30)

        // Top App Bar
        Stack() {
          Column()
            .width('100%')
            .height(70)
            .linearGradient({
              angle: 180,
              colors: [[VLColors.surfaceVariant, 0.0], [VLColors.background, 1.0]]
            })

          Text('Video Library')
            .fontSize(26)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(VLColors.onSurface)
        }
        .width('100%')
        .height(70)

        // Main Content Area
        Column({ space: 0 }) {
          // Subtitle
          Text('Explore the latest videos')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(VLColors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ left: 16, right: 16, top: 12, bottom: 12 })

          // Video Grid
          Scroll() {
            Grid() {
              ForEach(this.videos, (video: VideoItem) => {
                GridItem() {
                  this.VideoCard(video, 1.0)
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
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          angle: 180,
          colors: [[VLColors.surfaceVariant, 0.0], [VLColors.background, 1.0]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .onChange((oldValue: boolean, newValue: boolean) => {
      if (this.showDialog) {
        promptAction.showDialog({
          title: 'Playing Video',
          message: `Now playing: ${this.selectedVideo}`,
          buttons: [
            {
              text: 'OK',
              color: VLColors.primary
            }
          ]
        }).then(() => {
          this.showDialog = false;
        });
      }
    })
  }
}