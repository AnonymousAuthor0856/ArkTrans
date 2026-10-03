//
//  VideoLibraryApp.swift
//  iOS 16 compatible – full screen – Grid card layout
//

import window from '@ohos.window';

// MARK: - Tokens
interface VLC {
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

const VL_C: VLC = {
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

// Applies an alpha value to a #RRGGBB color string.
function withAlpha(hex: string, alpha: number): string {
  const r = parseInt(hex.substring(1, 3), 16);
  const g = parseInt(hex.substring(3, 5), 16);
  const b = parseInt(hex.substring(5, 7), 16);
  return 'rgba(' + r + ',' + g + ',' + b + ',' + alpha + ')';
}

class VideoItem {
  id: string;
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.id = title;
    this.title = title;
    this.duration = duration;
  }
}

@CustomDialog
struct VideoDialog {
  controller: CustomDialogController;
  @Prop selectedVideo: string;

  build() {
    Column() {
      Text("Playing Video")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL_C.onSurface)
      Text("Now playing: " + this.selectedVideo)
        .fontSize(14)
        .fontColor(VL_C.onSurface)
        .margin({ top: 8 })
      Button("OK")
        .fontSize(14)
        .fontColor(VL_C.onSecondary)
        .backgroundColor(VL_C.primary)
        .borderRadius(8)
        .margin({ top: 16 })
        .width('100%')
        .height(36)
        .onClick(() => {
          this.controller.close();
        })
    }
    .padding(24)
    .backgroundColor(VL_C.surface)
    .borderRadius(16)
    .width('80%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct VideoLibraryRoot {
  @State showDialog: boolean = false;
  @State selectedVideo: string = '';
  @State windowWidth: number = 360;
  @State windowHeight: number = 640;

  dialogController: CustomDialogController = new CustomDialogController({
    builder: VideoDialog({ selectedVideo: this.selectedVideo }),
    autoCancel: true,
    customStyle: true,
    alignment: DialogAlignment.Center,
    onWillDismiss: () => {
      this.showDialog = false;
    }
  });

  private readonly videos: VideoItem[] = [
    new VideoItem("Nature Documentary", "24:18"),
    new VideoItem("AI Explained", "18:52"),
    new VideoItem("Space Travel", "31:09"),
    new VideoItem("Modern Art Review", "15:45"),
    new VideoItem("Retro Music Visuals", "22:10"),
    new VideoItem("Daily News Recap", "12:34")
  ];

  private computeScale(): number {
    return Math.min(this.windowWidth / 360.0, this.windowHeight / 640.0);
  }

  private hideStatusBar(): void {
    let win = window.getLastWindow(this.getUIContext().getHostContext());
    win.then((w: window.Window) => {
      w.setWindowSystemBarProperties({ statusBarColor: '#00000000' });
    });
  }

  @Builder
  videoCard(video: VideoItem, scale: number) {
    Column() {
      // Thumbnail
      Stack() {
        Row()
          .width('100%')
          .height(120 * scale)
          .backgroundColor(VL_C.surfaceVariant)
          .borderRadius(8 * scale)
        Text("Thumbnail")
          .fontSize(11 * scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(withAlpha(VL_C.onSurface, 0.6))
      }
      .width('100%')
      .height(120 * scale)

      // Video Title
      Text(video.title)
        .fontSize(16 * scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL_C.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ top: 8 * scale })

      // Duration
      Text(video.duration)
        .fontSize(13 * scale)
        .fontColor(withAlpha(VL_C.onSurface, 0.7))
        .margin({ top: 8 * scale })

      // Play Button
      Button() {
        Text("Play")
          .fontSize(11 * scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL_C.onPrimary)
      }
      .width('100%')
      .height(32 * scale)
      .backgroundColor(VL_C.primary)
      .borderRadius(8 * scale)
      .margin({ top: 8 * scale })
      .onClick(() => {
        this.selectedVideo = video.title;
        this.showDialog = true;
        this.dialogController.open();
      })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(12 * scale)
    .backgroundColor(VL_C.surface)
    .borderRadius(12 * scale)
    .shadow({ radius: 2 * scale, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 * scale })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.TopStart }) {
        Column() {
          // ===== Top Spacer =====
          Row()
            .height(30 * this.computeScale()) // 调整到30sp

          // ===== Top App Bar =====
          Stack() {
            // 使用与整体背景相同的渐变
            Column()
              .width('100%')
              .height(70 * this.computeScale())
              .linearGradient({
                angle: 180,
                colors: [[VL_C.surfaceVariant, 0.0], [VL_C.background, 1.0]]
              })
            Text("Video Library")
              .fontSize(26 * this.computeScale())
              .fontWeight(FontWeight.Medium)
              .fontColor(VL_C.onSurface)
          }
          .width('100%')
          .height(70 * this.computeScale())

          // ===== Main Content Area =====
          Column() {
            // ===== Subtitle =====
            Text("Explore the latest videos")
              .fontSize(16 * this.computeScale())
              .fontWeight(FontWeight.Medium)
              .fontColor(VL_C.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({
                left: 16 * this.computeScale(),
                right: 16 * this.computeScale(),
                top: 12 * this.computeScale(),
                bottom: 12 * this.computeScale()
              })

            // ===== Video Grid =====
            Scroll() {
              Grid() {
                ForEach(this.videos, (video: VideoItem, index: number) => {
                  GridItem() {
                    this.videoCard(video, this.computeScale())
                  }
                }, (video: VideoItem, index: number) => video.id + index)
              }
              .columnsTemplate('1fr 1fr')
              .columnsGap(12 * this.computeScale())
              .rowsGap(12 * this.computeScale())
              .width('100%')
              .padding({
                left: 16 * this.computeScale(),
                right: 16 * this.computeScale(),
                top: 12 * this.computeScale(),
                bottom: 12 * this.computeScale()
              })
            }
            .width('100%')
            .layoutWeight(1)
            .scrollable(ScrollDirection.Vertical)
            .scrollBar(BarState.Off)
            .edgeEffect(EdgeEffect.Spring)
            .align(Alignment.Top)
          }
          .width('100%')
          .layoutWeight(1)
          .linearGradient({
            angle: 180,
            colors: [[VL_C.surfaceVariant, 0.0], [VL_C.background, 1.0]]
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [[VL_C.surfaceVariant, 0.0], [VL_C.background, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.windowWidth = Number(newValue.width);
      this.windowHeight = Number(newValue.height);
    })
    .onAppear(() => {
      this.hideStatusBar();
    })
  }
}
