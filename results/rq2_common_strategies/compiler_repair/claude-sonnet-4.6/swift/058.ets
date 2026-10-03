import { curves } from '@kit.ArkUI';

// AppTokens - Colors, Typography, Shapes, Spacing
class AppColorsClass {
  primary: string = '#111827';
  secondary: string = '#374151';
  tertiary: string = '#6B7280';
  background: string = '#F9FAFB';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E5E7EB';
  outline: string = '#D1D5DB';
  success: string = '#16A34A';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#111827';
  onBackground: string = '#111827';
  onSurface: string = '#1F2937';
}

class TypographyStyle {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypographyClass {
  display: TypographyStyle = new TypographyStyle(28, FontWeight.Bold);
  headline: TypographyStyle = new TypographyStyle(20, FontWeight.Medium);
  title: TypographyStyle = new TypographyStyle(16, FontWeight.Medium);
  body: TypographyStyle = new TypographyStyle(14, FontWeight.Normal);
  label: TypographyStyle = new TypographyStyle(12, FontWeight.Medium);
}

class AppShapesClass {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

class AppSpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

const AppColors: AppColorsClass = new AppColorsClass();
const AppTypography: AppTypographyClass = new AppTypographyClass();
const AppShapes: AppShapesClass = new AppShapesClass();
const AppSpacing: AppSpacingClass = new AppSpacingClass();

// OverviewPage Component
@Component
struct OverviewPage {
  build() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      Button("Sync Device")
        .fontSize(AppTypography.title.size)
        .fontWeight(AppTypography.title.weight)
        .fontColor(AppColors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
  }
}

// RankingPage Component
@Component
struct RankingPage {
  private rankData: number[] = [0, 1, 2, 3, 4];

  build() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.rankData, (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontColor(AppColors.onSurface)
            .fontSize(AppTypography.body.size)
            .fontWeight(AppTypography.body.weight)

          Blank()

          Text(`${9000 - it * 500} steps`)
            .fontColor(AppColors.onSurface)
            .fontSize(AppTypography.body.size)
            .fontWeight(AppTypography.body.weight)
        }
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
      }, (it: number) => it.toString())
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(AppColors.surface)
  }
}

// StatsPage Component
@Component
struct StatsPage {
  private weekData: number[] = [0, 1, 2, 3, 4, 5, 6];

  clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max);
  }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text("Weekly Progress")
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)

      ForEach(this.weekData, (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          Row()
            .width(`${this.clamp((0.3 + it * 0.1), 0, 1) * 100}%`)
            .height(20)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(20)
      }, (it: number) => it.toString())

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(AppColors.surface)
  }
}

// CustomTabRow Component
@Component
struct CustomTabRow {
  @Prop selectedTabIndex: number = 0;
  tabs: string[] = [];
  onTabSelected: (index: number) => void = () => {};

  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(AppTypography.title.size)
            .fontWeight(AppTypography.title.weight)
            .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
            .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.onTabSelected(index);
            })
        }, (tab: string) => tab)
      }
      .width('100%')
      .backgroundColor(AppColors.surface)

      Row() {
        Blank()
          .width(`${(100 / this.tabs.length) * this.selectedTabIndex}%`)
          .height(2)
          .animation({
            duration: 200,
            curve: curves.interpolatingSpring(0, 1, 228, 30),
          })

        Row()
          .width(`${100 / this.tabs.length}%`)
          .height(2)
          .backgroundColor(AppColors.primary)
          .animation({
            duration: 200,
            curve: curves.interpolatingSpring(0, 1, 228, 30),
          })
      }
      .width('100%')
      .height(2)
      .backgroundColor(AppColors.surfaceVariant)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }
}

// RootScreen - Main Entry Component
@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private tabsController: TabsController = new TabsController();

  build() {
    Column({ space: 0 }) {
      Text("Step Challenge")
        .fontSize(AppTypography.display.size)
        .fontWeight(AppTypography.display.weight)
        .fontColor(AppColors.onBackground)
        .padding(AppSpacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(Color.Transparent)

      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: this.selectedTabIndex,
        onTabSelected: (index: number) => {
          this.selectedTabIndex = index;
          this.tabsController.changeIndex(index);
        }
      })

      Tabs({
        barPosition: BarPosition.Start,
        index: this.selectedTabIndex,
        controller: this.tabsController
      }) {
        TabContent() {
          OverviewPage()
        }
        .tabBar('')

        TabContent() {
          RankingPage()
        }
        .tabBar('')

        TabContent() {
          StatsPage()
        }
        .tabBar('')
      }
      .barHeight(0)
      .animationDuration(300)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .layoutWeight(1)
      .backgroundColor(AppColors.surface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}