// Index.ets

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

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
    onSurface: '#082F49'
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Medium },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 20
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 1, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 3, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 6, radius: 12, dy: 6, opacity: 0.16 }
  };
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  @State showDialog: boolean = false;
  private tabs: string[] = ['Trending', 'Following', 'Recent'];
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow'];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // TopAppBar
        Text('Podcasts')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.background);

        // Content
        Column() {
          // SegmentedButtonRow
          Row({ space: AppTokens.Spacing.xs }) {
            ForEach(this.tabs, (label: string, index: number) => {
              Text(label)
                .fontSize(AppTokens.TypographyTokens.label.fontSize)
                .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                .fontColor(this.selectedTab === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                .backgroundColor(this.selectedTab === index ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                .borderRadius(AppTokens.Shapes.small)
                .onClick(() => {
                  this.selectedTab = index;
                })
                .layoutWeight(1)
                .textAlign(TextAlign.Center);
            }, (label: string) => label);
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg });

          // Podcast List
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.podcasts, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface);
                  Text('30 min episode')
                    .fontSize(AppTokens.TypographyTokens.body.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                    .margin({ top: AppTokens.Spacing.xs });
                }
                .alignItems(HorizontalAlign.Start);

                Button('Play')
                  .fontSize(AppTokens.TypographyTokens.label.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                  .fontColor(AppTokens.Colors.onSecondary)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(AppTokens.Shapes.small)
                  .onClick(() => {
                    this.showDialog = true;
                  });
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center);
            }, (podcast: string) => podcast);
          }
          .width('100%');
        }
        .width('100%')
        .height('100%')
        .padding(AppTokens.Spacing.lg)
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
        });
      }
      .width('100%')
      .height('100%');

      // AlertDialog
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text('Playing Podcast')
              .fontSize(AppTokens.TypographyTokens.title.fontSize)
              .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md });

            Text('Streaming audio...')
              .fontSize(AppTokens.TypographyTokens.body.fontSize)
              .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.8)
              .margin({ bottom: AppTokens.Spacing.lg });

            Button('OK')
              .fontSize(AppTokens.TypographyTokens.label.fontSize)
              .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
              .fontColor(AppTokens.Colors.primary)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.small)
              .onClick(() => {
                this.showDialog = false;
              });
          }
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .width('80%');
        }
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.4)');
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}