// VideoLibraryApp.ets

// ============ Design Tokens ============
class AppTokens {
  static readonly Colors = {
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
  }

  static readonly Typography = {
    display: { fontSize: 26, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 13, fontWeight: FontWeight.Normal },
    label: { fontSize: 11, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 20
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Elevation = {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 }
  }
}

// ============ Data Model ============
class VideoItem {
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.title = title
    this.duration = duration
  }
}

// ============ Main Entry ============
@Entry
@Component
struct VideoLibraryApp {
  private videos: VideoItem[] = [
    new VideoItem('Nature Documentary', '24:18'),
    new VideoItem('AI Explained', '18:52'),
    new VideoItem('Space Travel', '31:09'),
    new VideoItem('Modern Art Review', '15:45'),
    new VideoItem('Retro Music Visuals', '22:10'),
    new VideoItem('Daily News Recap', '12:34')
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Video Library')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Content Area
      Scroll() {
        Column() {
          Text('Explore the latest videos')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md })

          // Grid Layout
          Grid() {
            ForEach(this.videos, (item: VideoItem) => {
              GridItem() {
                this.VideoCard(item)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .padding(AppTokens.Spacing.lg)
        }
        .width('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.surfaceVariant, 0.0],
            [AppTokens.Colors.background, 1.0]
          ]
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  VideoCard(item: VideoItem) {
    Column() {
      // Thumbnail Placeholder
      Stack({ alignContent: Alignment.Center }) {
        Text('Thumbnail')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.6)
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .margin({ bottom: AppTokens.Spacing.sm })

      // Title
      Text(item.title)
        .fontSize(AppTokens.Typography.title.fontSize)
        .fontWeight(AppTokens.Typography.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 4 })

      // Duration
      Text(item.duration)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ bottom: AppTokens.Spacing.sm })

      // Play Button
      Button('Play') {
        Text('Play')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .type(ButtonType.Capsule)
      .width('100%')
      .height(40)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.small)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level1.dy
    })
  }
}