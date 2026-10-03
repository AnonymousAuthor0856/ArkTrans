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
  static readonly onSurface60: string = 'rgba(8, 47, 73, 0.60)';
  static readonly onSurface70: string = 'rgba(8, 47, 73, 0.70)';
}

interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct VideoLibraryRoot {
  private readonly videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ];

  private showPlayingDialog(videoTitle: string): void {
    AlertDialog.show({
      title: 'Playing Video',
      message: `Now playing: ${videoTitle}`,
      autoCancel: true,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: 'OK',
        action: () => {
        }
      }
    });
  }

  @Builder
  private VideoCard(video: VideoItem) {
    Column({ space: 8 }) {
      Stack({ alignContent: Alignment.Center }) {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(VLColors.onSurface60)
      }
      .width('100%')
      .height(120)
      .borderRadius(8)
      .backgroundColor(VLColors.surfaceVariant)

      Text(video.title)
        .width('100%')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(VLColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Start)

      Text(video.duration)
        .width('100%')
        .fontSize(13)
        .fontColor(VLColors.onSurface70)
        .textAlign(TextAlign.Start)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Play')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(VLColors.onPrimary)
      }
      .width('100%')
      .height(32)
      .padding(0)
      .borderRadius(8)
      .backgroundColor(VLColors.primary)
      .onClick(() => {
        this.showPlayingDialog(video.title);
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(12)
    .borderRadius(12)
    .backgroundColor(VLColors.surface)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column({ space: 0 }) {
      Blank()
        .height(30)

      Stack({ alignContent: Alignment.Center }) {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(VLColors.onSurface)
      }
      .width('100%')
      .height(70)
      .linearGradient({
        angle: 180,
        colors: [
          [VLColors.surfaceVariant, 0.0],
          [VLColors.background, 1.0]
        ]
      })

      Column({ space: 0 }) {
        Text('Explore the latest videos')
          .width('100%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(VLColors.onSurface)
          .textAlign(TextAlign.Start)
          .padding({
            left: 16,
            right: 16,
            top: 12,
            bottom: 12
          })

        Scroll() {
          Grid() {
            ForEach(this.videos, (video: VideoItem) => {
              GridItem() {
                this.VideoCard(video)
              }
            }, (video: VideoItem) => video.title)
          }
          .width('100%')
          .columnsTemplate('1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .padding({
            left: 16,
            right: 16,
            top: 12,
            bottom: 12
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [VLColors.surfaceVariant, 0.0],
          [VLColors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [VLColors.surfaceVariant, 0.0],
        [VLColors.background, 1.0]
      ]
    })
  }
}