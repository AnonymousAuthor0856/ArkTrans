import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - Tokens & Constants
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const VL_C: ColorTokens = {
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
  onSurface: '#082F49'
};

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
  @State videos: VideoItem[] = [
    { id: 1, title: 'Nature Documentary', duration: '24:18' },
    { id: 2, title: 'AI Explained', duration: '18:52' },
    { id: 3, title: 'Space Travel', duration: '31:09' },
    { id: 4, title: 'Modern Art Review', duration: '15:45' },
    { id: 5, title: 'Retro Music Visuals', duration: '22:10' },
    { id: 6, title: 'Daily News Recap', duration: '12:34' }
  ];

  build() {
    Column() {
      // Top Spacer
      Blank().height('30vp')

      // Top App Bar
      Stack() {
        // Background Gradient for Header
        Column()
          .width('100%')
          .height('70vp')
          .linearGradient({
            angle: 90,
            colors: [[VL_C.surfaceVariant, 0], [VL_C.background, 1]]
          })

        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(VL_C.onSurface)
      }
      .width('100%')
      .height('70vp')

      // Main Content Area
      Column() {
        // Subtitle
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL_C.onSurface)
          .alignSelf(ItemAlign.Start)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // Video Grid
        Scroll() {
          GridContainer() {
            ForEach(this.videos, (video: VideoItem) => {
              GridItem() {
                this.VideoCard(video)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(12)
          .columnsGap(12)
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .layoutWeight(1)
      }
      .linearGradient({
        angle: 90,
        colors: [[VL_C.surfaceVariant, 0], [VL_C.background, 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VL_C.background)
    .onAppear(async () => {
      // Ensure full screen behavior if needed via window manager in real app entry
      try {
        let windowClass: window.Window = await window.getMainWindowSync();
        await windowClass.setWindowLayoutFullScreen(true);
      } catch (error) {
        console.error('Failed to set full screen');
      }
    })
  }

  @Builder
  VideoCard(video: VideoItem) {
    Column({ space: 8 }) {
      // Thumbnail
      Row() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor('#082F49')
          .opacity(0.6)
      }
      .width('100%')
      .height(120)
      .borderRadius(8)
      .backgroundColor(VL_C.surfaceVariant)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Video Title
      Text(video.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL_C.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .textAlign(TextAlign.Start)

      // Duration
      Text(video.duration)
        .fontSize(13)
        .fontColor('#082F49')
        .opacity(0.7)

      // Play Button
      Button() {
        Text('Play')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL_C.onPrimary)
      }
      .width('100%')
      .height(32)
      .backgroundColor(VL_C.primary)
      .borderRadius(8)
      .onClick(() => {
        this.selectedVideo = video.title;
        this.showDialog = true;
      })
    }
    .padding(12)
    .backgroundColor(VL_C.surface)
    .borderRadius(12)
    .shadow({ radius: 6, color: '#000000', offsetX: 0, offsetY: 2 })
    .width('100%')
  }
}