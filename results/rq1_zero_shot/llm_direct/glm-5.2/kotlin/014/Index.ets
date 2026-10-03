// AppTokens.ets - Design tokens equivalent
class AppTokens {
  static readonly Colors = {
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
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 20,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
  };
}

// RootScreen.ets - Main UI Component
@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  
  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Podcasts')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 12, bottom: 12, left: 16, right: 16 })
      
      // Content Area
      Column() {
        // Gradient Background Container
        Column() {
          // Segmented Button Row
          Row() {
            ForEach(this.tabs, (label: string, index: number) => {
              Text(label)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(this.selectedTab === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                .layoutWeight(1)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedTab = index;
                })
            })
          }
          .width('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
          .padding(4)

          // Podcast List
          Column() {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                  Text('30 min episode')
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button('Play')
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(AppTokens.Shapes.small)
                  .height(36)
                  .onClick(() => {
                    this.showDialog = true;
                  })
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .margin({ bottom: AppTokens.Spacing.md })
            })
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg })
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
        })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .bindContentCover($$this.showDialog, this.dialogBuilder)
  }

  @Builder
  dialogBuilder() {
    Column() {
      Text('Playing Podcast')
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: 12 })

      Text('Streaming audio...')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.8)
        .margin({ bottom: 24 })

      Button('OK')
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontColor(AppTokens.Colors.primary)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .width('100%')
        .onClick(() => {
          this.showDialog = false;
        })
    }
    .padding(24)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .width('80%')
  }
}