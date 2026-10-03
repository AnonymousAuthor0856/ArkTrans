const NAME: string = '012PodcastListen'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Cold Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

const AppTokens = {
  Colors: {
    primary: '#38BDF8',
    secondary: '#0EA5E9',
    tertiary: '#0284C7',
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
    onSurface: '#082F49',
    onSurface70: 'rgba(8, 47, 73, 0.7)',
    onSurface80: 'rgba(8, 47, 73, 0.8)'
  },
  TypographyTokens: {
    displaySize: 28,
    titleSize: 18,
    bodySize: 14,
    labelSize: 12
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 20
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  },
  ElevationMapping: {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 }
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

  private showPlayingDialog(): void {
    AlertDialog.show({
      title: 'Playing Podcast',
      message: 'Streaming audio...',
      alignment: DialogAlignment.Center,
      autoCancel: true,
      backgroundColor: AppTokens.Colors.surface,
      primaryButton: {
        value: 'OK',
        fontColor: AppTokens.Colors.primary,
        action: () => {
        }
      }
    })
  }

  @Builder
  private SegmentedTab(label: string, index: number) {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .height(40)
      .layoutWeight(1)
      .borderRadius(AppTokens.Shapes.small)
      .backgroundColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .fontColor(this.selectedTab === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .fontSize(AppTokens.TypographyTokens.labelSize)
      .fontWeight(FontWeight.Medium)
      .border({
        width: 1,
        color: this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.outline
      })
      .onClick(() => {
        this.selectedTab = index
      })
  }

  @Builder
  private PodcastCard(title: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Text('30 min episode')
          .margin({ top: 4 })
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface70)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Play', { type: ButtonType.Normal, stateEffect: true })
        .height(40)
        .padding({ left: 18, right: 18 })
        .borderRadius(AppTokens.Shapes.small)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          this.showPlayingDialog()
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }

  build() {
    Column() {
      Row() {
        Text('Podcasts')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.tabs, (label: string, index: number) => {
            this.SegmentedTab(label, index)
          }, (label: string) => label)
        }
        .width('100%')

        Column({ space: AppTokens.Spacing.md }) {
          ForEach(this.podcasts, (podcast: string) => {
            this.PodcastCard(podcast)
          }, (podcast: string) => podcast)
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}