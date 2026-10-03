import window from '@ohos.window';

const NAME: string = '085_DietLog_en';
const UI_TYPE: string = 'Health Messenger';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: ResourceColor = '#0EA5E9';
  static readonly secondary: ResourceColor = '#6366F1';
  static readonly tertiary: ResourceColor = '#06B6D4';
  static readonly background: ResourceColor = '#F1F5F9';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E2E8F0';
  static readonly outline: ResourceColor = '#D1D5DB';
  static readonly success: ResourceColor = '#22C55E';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#0F172A';
  static readonly onBackground: ResourceColor = '#1E293B';
  static readonly onSurface: ResourceColor = '#1E293B';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

@Entry
@Component
struct MainPage {
  @State currentPage: number = 0;
  private tabsController: TabsController = new TabsController();
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  @Builder
  TabBarBuilder(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(AppTypography.bodySize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentPage === index ? AppColors.primary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentPage = index;
      this.tabsController.changeIndex(index);
    })
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text('Diet Log')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)

      Tabs({
        barPosition: BarPosition.Start,
        index: this.currentPage,
        controller: this.tabsController
      }) {
        TabContent() {
          MealsPage()
        }
        .tabBar(this.TabBarBuilder(0, this.tabs[0]))

        TabContent() {
          ChatPage()
        }
        .tabBar(this.TabBarBuilder(1, this.tabs[1]))

        TabContent() {
          StatsPage()
        }
        .tabBar(this.TabBarBuilder(2, this.tabs[2]))
      }
      .width('100%')
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .animationDuration(250)
      .onChange((index: number) => {
        this.currentPage = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        ['rgba(14, 165, 233, 0.10)', 0.0],
        ['rgba(99, 102, 241, 0.10)', 1.0]
      ]
    })
  }
}

@Component
struct MealsPage {
  private mealItems: number[] = [0, 1, 2];

  build() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTypography.headlineSize)
        .fontWeight(600)
        .fontColor(AppColors.onSurface)

      ForEach(this.mealItems, (item: number) => {
        Stack({ alignContent: Alignment.Center }) {
          Text(`Meal ${item + 1}`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline
        })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }
}

@Component
struct ChatPage {
  private messages: number[] = [0, 1, 2, 3, 4];

  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(600)
        .fontColor(AppColors.onSurface)

      ForEach(this.messages, (item: number) => {
        Row() {
          Text(`Message ${item + 1}`)
            .fontSize(AppTypography.bodySize)
            .fontWeight(FontWeight.Regular)
            .fontColor(item % 2 === 0 ? AppColors.onSurface : AppColors.onPrimary)
            .padding(AppSpacing.md)
            .backgroundColor(item % 2 === 0 ? AppColors.surfaceVariant : AppColors.primary)
            .borderRadius(AppShapes.medium)
        }
        .width('100%')
        .padding({
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .justifyContent(item % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }
}

@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(600)
        .fontColor(AppColors.onSurface)

      ForEach(this.days, (item: number) => {
        Row() {
          Blank()
            .width(`${Math.min(100, (0.3 + item * 0.1) * 100)}%`)
            .height('100%')
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .clip(true)
      }, (item: number) => item.toString())

      Blank()
        .height(AppSpacing.lg)

      Button('Share Report')
        .width('60%')
        .height(48)
        .borderRadius(AppShapes.large)
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onSecondary)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}