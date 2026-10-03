// Index.ets
interface ColorToken {
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

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors: ColorToken = {
    primary: '#FF111827',
    secondary: '#FF374151',
    tertiary: '#FF6B7280',
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111827',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937',
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  };
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];

  build() {
    Column() {
      // Header
      Text('Step Challenge')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .textAlign(TextAlign.Center);

      // Tabs
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.tabsController }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            if (index === 0) {
              OverviewPage()
            } else if (index === 1) {
              RankingPage()
            } else {
              StatsPage()
            }
          }
          .tabBar(this.TabBuilder(title, index))
        })
      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
    });
  }

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .margin({ top: 8, bottom: 8 });
      Divider()
        .strokeWidth(2)
        .color(this.currentIndex === index ? AppTokens.Colors.primary : 'transparent')
        .width('50%');
    }
    .width('100%')
    .justifyContent(FlexAlign.Center);
  }
}

@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface);

      Blank().height(AppTokens.Spacing.lg);

      Button('Sync Device')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(16)
        .width('60%')
        .height(48);
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center);
  }
}

@Component
struct RankingPage {
  private items: number[] = [0, 1, 2, 3, 4];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach(this.items, (item: number) => {
        Row() {
          Text(`User ${item + 1}`)
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface);
          Text(`${9000 - item * 500} steps`)
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface);
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(12)
        .justifyContent(FlexAlign.SpaceBetween);
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg);
  }
}

@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface);

      ForEach(this.days, (day: number) => {
        Row() {
          Row()
            .width(`${Math.min(30 + day * 10, 100)}%`)
            .height('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8);
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(8);
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center);
  }
}