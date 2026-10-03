class VL {
  static readonly primary: ResourceColor = '#38BDF8';
  static readonly secondary: ResourceColor = '#0EA5E9';
  static readonly tertiary: ResourceColor = '#0369A1';
  static readonly background: ResourceColor = '#F0F9FF';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E0F2FE';
  static readonly outline: ResourceColor = '#BFE0F4';
  static readonly success: ResourceColor = '#16A34A';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#DC2626';
  static readonly onPrimary: ResourceColor = '#001F2F';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#082F49';
  static readonly onSurface: ResourceColor = '#082F49';
}

interface VideoItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct VideoLibraryRoot {
  @State private showDialog: boolean = false;
  @State private selectedVideo: string = '';
  @State private scale: number = 1;

  private readonly videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ];

  private updateScale(width: Length, height: Length): void {
    const w: number = Number(width);
    const h: number = Number(height);

    if (w > 0 && h > 0) {
      this.scale = Math.min(w / 360.0, h / 640.0);
    }
  }

  private showPlayingDialog(): void {
    this.showDialog = true;

    AlertDialog.show({
      title: 'Playing Video',
      message: `Now playing: ${this.selectedVideo}`,
      autoCancel: true,
      alignment: DialogAlignment.Center,
      primaryButton: {
        value: 'OK',
        action: () => {
          this.showDialog = false;
        }
      }
    });
  }

  @Builder
  private VideoCard(video: VideoItem) {
    Column({ space: 8 * this.scale }) {
      Stack() {
        Text('Thumbnail')
          .fontSize(11 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor('rgba(8, 47, 73, 0.60)')
      }
      .width('100%')
      .height(120 * this.scale)
      .backgroundColor(VL.surfaceVariant)
      .borderRadius(8 * this.scale)

      Text(video.title)
        .width('100%')
        .fontSize(16 * this.scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Start)

      Text(video.duration)
        .width('100%')
        .fontSize(13 * this.scale)
        .fontColor('rgba(8, 47, 73, 0.70)')
        .textAlign(TextAlign.Start)

      Button('Play', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(32 * this.scale)
        .fontSize(11 * this.scale)
        .fontWeight(FontWeight.Medium)
        .fontColor(VL.onPrimary)
        .backgroundColor(VL.primary)
        .borderRadius(8 * this.scale)
        .onClick(() => {
          this.selectedVideo = video.title;
          this.showPlayingDialog();
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(12 * this.scale)
    .backgroundColor(VL.surface)
    .borderRadius(12 * this.scale)
    .shadow({
      radius: 2 * this.scale,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: 1 * this.scale
    })
  }

  build() {
    Column() {
      Blank()
        .height(30 * this.scale)

      Stack() {
        Text('Video Library')
          .fontSize(26 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL.onSurface)
      }
      .width('100%')
      .height(70 * this.scale)
      .linearGradient({
        angle: 180,
        colors: [
          [VL.surfaceVariant, 0.0],
          [VL.background, 1.0]
        ]
      })

      Column() {
        Text('Explore the latest videos')
          .width('100%')
          .fontSize(16 * this.scale)
          .fontWeight(FontWeight.Medium)
          .fontColor(VL.onSurface)
          .textAlign(TextAlign.Start)
          .padding({
            left: 16 * this.scale,
            right: 16 * this.scale,
            top: 12 * this.scale,
            bottom: 12 * this.scale
          })

        Scroll() {
          Grid() {
            ForEach(this.videos, (video: VideoItem) => {
              GridItem() {
                this.VideoCard(video)
              }
              .align(Alignment.Top)
            }, (video: VideoItem) => video.title)
          }
          .width('100%')
          .columnsTemplate('1fr 1fr')
          .columnsGap(12 * this.scale)
          .rowsGap(12 * this.scale)
          .padding({
            left: 16 * this.scale,
            right: 16 * this.scale,
            top: 12 * this.scale,
            bottom: 12 * this.scale
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [
          [VL.surfaceVariant, 0.0],
          [VL.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [VL.surfaceVariant, 0.0],
        [VL.background, 1.0]
      ]
    })
    .onAreaChange((oldArea: Area, newArea: Area) => {
      this.updateScale(newArea.width, newArea.height);
    })
  }
}