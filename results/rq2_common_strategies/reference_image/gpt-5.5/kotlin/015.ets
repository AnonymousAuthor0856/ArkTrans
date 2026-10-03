class AppColors {
  static readonly PRIMARY: string = '#38BDF8'
  static readonly SECONDARY: string = '#0EA5E9'
  static readonly TERTIARY: string = '#0369A1'
  static readonly BACKGROUND: string = '#F0F9FF'
  static readonly SURFACE: string = '#FFFFFF'
  static readonly SURFACE_VARIANT: string = '#E0F2FE'
  static readonly OUTLINE: string = '#BFE0F4'
  static readonly SUCCESS: string = '#16A34A'
  static readonly WARNING: string = '#F59E0B'
  static readonly ERROR: string = '#DC2626'
  static readonly ON_PRIMARY: string = '#001F2F'
  static readonly ON_SECONDARY: string = '#FFFFFF'
  static readonly ON_TERTIARY: string = '#FFFFFF'
  static readonly ON_BACKGROUND: string = '#082F49'
  static readonly ON_SURFACE: string = '#082F49'
  static readonly ON_SURFACE_70: string = '#B3082F49'
  static readonly ON_SURFACE_60: string = '#99082F49'
}

class VideoItem {
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.title = title
    this.duration = duration
  }
}

@Entry
@Component
struct Index {
  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ]

  @Builder
  VideoCard(item: VideoItem) {
    Column({ space: 8 }) {
      Column() {
        Text('Thumbnail')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.ON_SURFACE_60)
      }
      .width('100%')
      .height(120)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.SURFACE_VARIANT)
      .borderRadius(8)

      Text(item.title)
        .width('100%')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.ON_SURFACE)
        .lineHeight(19)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(item.duration)
        .width('100%')
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.ON_SURFACE_70)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Play')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.ON_PRIMARY)
      }
      .width('100%')
      .height(40)
      .padding(0)
      .borderRadius(8)
      .backgroundColor(AppColors.PRIMARY)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(AppColors.SURFACE)
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: '#1F082F49',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      Row() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.ON_SURFACE)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.BACKGROUND)

      Column() {
        Text('Explore the latest videos')
          .width('100%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.ON_SURFACE)
          .margin({ bottom: 12 })

        Grid() {
          ForEach(this.videos, (item: VideoItem) => {
            GridItem() {
              this.VideoCard(item)
            }
          }, (item: VideoItem) => item.title)
        }
        .width('100%')
        .layoutWeight(1)
        .columnsTemplate('1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: 16,
        right: 16,
        top: 16,
        bottom: 16
      })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.SURFACE_VARIANT, 0.0],
          [AppColors.BACKGROUND, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.BACKGROUND)
  }
}