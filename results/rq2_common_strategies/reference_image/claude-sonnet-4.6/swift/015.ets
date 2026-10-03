// VideoLibraryRoot.ets
// HarmonyOS ArkTS (ArkUI, declarative) port of the SwiftUI video-library screen.

import display from '@ohos.display';

// MARK: - Design tokens

class VL {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#0369A1';
  static readonly background: string = '#F0F9FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E0F2FE';
  static readonly outline: string = '#BFE0F4';
  static readonly onPrimary: string = '#001F2F';
  static readonly onSurface: string = '#082F49';
  static readonly shadow: string = '#1A000000';
}

// MARK: - Model

class VideoItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = '';
  @State scale: number = 1;

  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ];

  aboutToAppear(): void {
    try {
      const d: display.Display = display.getDefaultDisplaySync();
      const s: number = Math.min(px2vp(d.width) / 360, px2vp(d.height) / 640);
      if (s > 0) {
        this.scale = s;
      }
    } catch (e) {
      this.scale = 1;
    }
  }

  // MARK: - Card

  @Builder
  videoCard(video: VideoItem) {
    Column({ space: 8 * this.scale }) {
      // Thumbnail placeholder
      Text('Thumbnail')
        .fontSize(11 * this.scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL.onSurface)
        .opacity(0.6)
        .width('100%')
        .height(120 * this.scale)
        .textAlign(TextAlign.Center)
        .align(Alignment.Center)
        .backgroundColor(VL.surfaceVariant)
        .borderRadius(8 * this.scale)

      // Title
      Text(video.title)
        .fontSize(16 * this.scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      // Duration
      Text(video.duration)
        .fontSize(13 * this.scale)
        .fontColor(VL.onSurface)
        .opacity(0.7)
        .width('100%')
        .textAlign(TextAlign.Start)

      // Play button
      Button('Play')
        .fontSize(11 * this.scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL.onPrimary)
        .width('100%')
        .height(32 * this.scale)
        .backgroundColor(VL.primary)
        .borderRadius(8 * this.scale)
        .padding(0)
        .onClick(() => {
          this.selectedVideo = video.title;
          this.showDialog = true;
          AlertDialog.show({
            title: 'Playing Video',
            message: 'Now playing: ' + this.selectedVideo,
            confirm: {
              value: 'OK',
              action: () => {
                this.showDialog = false;
              }
            }
          });
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(12 * this.scale)
    .backgroundColor(VL.surface)
    .borderRadius(12 * this.scale)
    .shadow({
      radius: 2 * this.scale,
      color: VL.shadow,
      offsetX: 0,
      offsetY: 1 * this.scale
    })
  }

  // MARK: - Page

  build() {
    Column() {
      // ===== Top spacer =====
      Row()
        .width('100%')
        .height(30 * this.scale)

      // ===== Top app bar =====
      Stack() {
        Text('Video Library')
          .fontSize(26 * this.scale)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(VL.onSurface)
      }
      .width('100%')
      .height(70 * this.scale)

      // ===== Subtitle =====
      Text('Explore the latest videos')
        .fontSize(16 * this.scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({
          left: 16 * this.scale,
          right: 16 * this.scale,
          top: 12 * this.scale,
          bottom: 12 * this.scale
        })

      // ===== Video grid =====
      Grid() {
        ForEach(this.videos, (item: VideoItem) => {
          GridItem() {
            this.videoCard(item)
          }
        }, (item: VideoItem) => item.title)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12 * this.scale)
      .rowsGap(12 * this.scale)
      .padding({
        left: 16 * this.scale,
        right: 16 * this.scale,
        top: 12 * this.scale,
        bottom: 12 * this.scale
      })
      .scrollBar(BarState.Off)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(VL.background)
    .linearGradient({
      angle: 180,
      colors: [[VL.surfaceVariant, 0.0], [VL.background, 1.0]]
    })
  }
}