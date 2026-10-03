// Index.ets

interface VideoItem {
  title: string;
  duration: string;
}

class AppColors {
  primary: string = '#FF38BDF8';
  secondary: string = '#FF0EA5E9';
  tertiary: string = '#FF0369A1';
  background: string = '#FFF0F9FF';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE0F2FE';
  outline: string = '#FFBFE0F4';
  success: string = '#FF16A34A';
  warning: string = '#FFF59E0B';
  error: string = '#FFDC2626';
  onPrimary: string = '#FF001F2F';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FFFFFFFF';
  onBackground: string = '#FF082F49';
  onSurface: string = '#FF082F49';
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppShapes {
  small: number = 8;
  medium: number = 12;
  large: number = 20;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
  static Shapes: AppShapes = new AppShapes();
}

@Entry
@Component
struct RootScreen {
  private videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.background)
      .alignItems(VerticalAlign.Center);

      // Content Area
      Scroll() {
        Column() {
          Text('Explore the latest videos')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md });

          // Grid Layout
          Grid() {
            ForEach(this.videos, (item: VideoItem) => {
              GridItem() {
                Column() {
                  // Thumbnail Box
                  Stack() {
                    Text('Thumbnail')
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                      .opacity(0.6);
                  }
                  .width('100%')
                  .height(120)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.small)
                  .alignContent(Alignment.Center);

                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .margin({ top: AppTokens.Spacing.sm })
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis });

                  Text(item.duration)
                    .fontSize(13)
                    .fontColor(AppTokens.Colors.onSurface)
                    .opacity(0.7)
                    .margin({ top: AppTokens.Spacing.xs });

                  Button('Play')
                    .width('100%')
                    .height(40)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .backgroundColor(AppTokens.Colors.primary)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .borderRadius(AppTokens.Shapes.small)
                    .margin({ top: AppTokens.Spacing.sm });
                }
                .width('100%')
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.medium)
                .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 });
              }
            }, (item: VideoItem) => item.title);
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .padding(AppTokens.Spacing.lg);
        }
        .width('100%')
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.background, 1.0]]
        });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}