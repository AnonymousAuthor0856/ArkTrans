// Index.ets — 087_StepChallenge_en / Health ControlPanel / Monochrome
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

const NAME: string = '087_StepChallenge_en';
const UI_TYPE: string = 'Health ControlPanel';
const STYLE_THEME: string = 'Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/* ---------------- Design tokens ---------------- */

class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppRadius {
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

/* ---------------- Page models ---------------- */

class RankItem {
  name: string;
  steps: number;

  constructor(name: string, steps: number) {
    this.name = name;
    this.steps = steps;
  }
}

class WeekBar {
  ratio: number; // 0 .. 1

  constructor(ratio: number) {
    this.ratio = ratio;
  }
}

/* ---------------- Root ---------------- */

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private titles: string[] = ['Overview', 'Ranking', 'Stats'];

  private rankList: RankItem[] = [
    new RankItem('User 1', 9000),
    new RankItem('User 2', 8500),
    new RankItem('User 3', 8000),
    new RankItem('User 4', 7500),
    new RankItem('User 5', 7000)
  ];

  private weekBars: WeekBar[] = [
    new WeekBar(0.30),
    new WeekBar(0.40),
    new WeekBar(0.50),
    new WeekBar(0.60),
    new WeekBar(0.70),
    new WeekBar(0.80),
    new WeekBar(0.90)
  ];

  aboutToAppear(): void {
    this.enableImmersiveMode();
  }

  // Same intent as WindowCompat.setDecorFitsSystemWindows(window, false) + hide(systemBars())
  private enableImmersiveMode(): void {
    try {
      const context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
      window.getLastWindow(context).then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true).catch((err: BusinessError) => {
          console.error(`${NAME} layoutFullScreen failed: ${err.code}`);
        });
        win.setWindowSystemBarEnable([]).catch((err: BusinessError) => {
          console.error(`${NAME} hideSystemBar failed: ${err.code}`);
        });
      }).catch((err: BusinessError) => {
        console.error(`${NAME} getLastWindow failed: ${err.code}`);
      });
    } catch (e) {
      console.error(`${NAME} immersive mode unavailable`);
    }
  }

  /* ---------- Tab bar item (selected = dark text + 3vp underline) ---------- */

  @Builder
  TabItem(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(AppTypography.title)
        .fontWeight(index === this.currentIndex ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(index === this.currentIndex ? AppColors.primary : AppColors.onSurface)
      Divider()
        .strokeWidth(3)
        .color(index === this.currentIndex ? AppColors.primary : Color.Transparent)
        .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  /* ---------- Page 1 : Overview ---------- */

  @Builder
  OverviewPage() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row() {}.width('100%').height(AppSpacing.xl + AppSpacing.sm) // Spacer(16) + spacedBy(12) x2

      Button('Sync Device')
        .type(ButtonType.Normal)
        .width('60%')
        .height(48)
        .borderRadius(AppRadius.large)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          // placeholder — sync action
        })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  /* ---------- Page 2 : Ranking ---------- */

  @Builder
  RankingPage() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.rankList, (item: RankItem) => {
        Row() {
          Text(item.name)
            .fontSize(AppTypography.body)
            .fontColor(AppColors.onSurface)
          Text(`${item.steps} steps`)
            .fontSize(AppTypography.body)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppRadius.medium)
        .justifyContent(FlexAlign.SpaceBetween)
      }, (item: RankItem) => item.name)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }

  /* ---------- Page 3 : Stats ---------- */

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      ForEach(this.weekBars, (bar: WeekBar) => {
        Stack({ alignContent: Alignment.Start }) {
          Row() {}
          .width('100%')
          .height(20)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.small)

          Row() {}
          .width(`${Math.round(bar.ratio * 100)}%`)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.small)
        }
        .width('100%')
        .height(20)
      }, (bar: WeekBar) => `${bar.ratio}`)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }

  /* ---------- Scaffold ---------- */

  build() {
    Column() {
      // App bar
      Row() {
        Text('Step Challenge')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)

      // TabRow + HorizontalPager
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.tabsController }) {
        TabContent() {
          this.OverviewPage()
        }
        .tabBar(this.TabItem(0, this.titles[0]))

        TabContent() {
          this.RankingPage()
        }
        .tabBar(this.TabItem(1, this.titles[1]))

        TabContent() {
          this.StatsPage()
        }
        .tabBar(this.TabItem(2, this.titles[2]))
      }
      .barMode(BarMode.Fixed)
      .barHeight(52)
      .barBackgroundColor(AppColors.surface)
      .divider({ strokeWidth: 0 })
      .scrollable(true)
      .animationDuration(250)
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180, // top -> bottom, matches Brush.verticalGradient
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
    })
    .backgroundColor(AppColors.background)
  }
}