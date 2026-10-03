/*
 * 085_DietLog_en — Health Messenger / Cold Gradient / en / 720x1280
 * ArkTS (ArkUI declarative) port of the Compose "Diet Log" single-file UI.
 * File: entry/src/main/ets/pages/Index.ets
 */

const NAME: string = '085_DietLog_en';
const UI_TYPE: string = 'Health Messenger';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#06B6D4';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0F172A';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';
  static readonly primaryA10: string = '#1A0EA5E9';
  static readonly secondaryA10: string = '#1A6366F1';
  static readonly transparent: string = '#00000000';
}

class AppTypography {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
  static readonly weightBold: number = 700;
  static readonly weightSemiBold: number = 600;
  static readonly weightMedium: number = 500;
  static readonly weightNormal: number = 400;
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

class AppElevation {
  static readonly level1Radius: number = 4;
  static readonly level1Dy: number = 2;
  static readonly level1Opacity: number = 0.12;
  static readonly level2Radius: number = 8;
  static readonly level2Dy: number = 4;
  static readonly level2Opacity: number = 0.14;
  static readonly level3Radius: number = 12;
  static readonly level3Dy: number = 6;
  static readonly level3Opacity: number = 0.16;
}

@Entry
@Component
struct DietLogPage {
  @State currentIndex: number = 0;
  private swiperController: SwiperController = new SwiperController();
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  @Builder
  TabItem(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(AppTypography.title)
        .fontWeight(this.currentIndex === index ? AppTypography.weightMedium : AppTypography.weightNormal)
        .fontColor(this.currentIndex === index ? AppColors.primary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .width('100%')

      Divider()
        .strokeWidth(3)
        .color(this.currentIndex === index ? AppColors.primary : AppColors.transparent)
        .width('100%')
    }
    .height(48)
    .justifyContent(FlexAlign.End)
    .onClick(() => {
      this.currentIndex = index;
      this.swiperController.changeIndex(index, true);
    })
  }

  @Builder
  TabRow() {
    Column() {
      Row() {
        ForEach(this.tabs, (title: string, index: number) => {
          this.TabItem(index, title);
        }, (title: string, index: number) => index.toString() + title)
      }
      .width('100%')
      .height(48)
      .backgroundColor(AppColors.surface)

      Divider()
        .strokeWidth(1)
        .color(AppColors.outline)
        .width('100%')
    }
    .width('100%')
  }

  @Builder
  MealCard(label: string) {
    Row() {
      Text(label)
        .fontSize(AppTypography.body)
        .fontWeight(AppTypography.weightNormal)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  MealsPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTypography.headline)
        .fontWeight(AppTypography.weightSemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')

      this.MealCard('Meal 1');
      this.MealCard('Meal 2');
      this.MealCard('Meal 3');
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  ChatBubble(index: number) {
    Row() {
      Text(`Message ${index + 1}`)
        .fontSize(AppTypography.body)
        .fontWeight(AppTypography.weightNormal)
        .fontColor(index % 2 === 0 ? AppColors.onSurface : AppColors.onPrimary)
        .padding(AppSpacing.md)
        .backgroundColor(index % 2 === 0 ? AppColors.surfaceVariant : AppColors.primary)
        .borderRadius(AppShapes.medium)
        .constraintSize({ maxWidth: '75%' })
    }
    .width('100%')
    .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
    .justifyContent(index % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
  }

  @Builder
  ChatPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTypography.headline)
        .fontWeight(AppTypography.weightSemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')

      ForEach([0, 1, 2, 3, 4], (index: number) => {
        this.ChatBubble(index);
      }, (index: number) => index.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  StatBar(index: number) {
    Row() {
      Row()
        .width(`${(0.3 + index * 0.1) > 1 ? 100 : Math.round((0.3 + index * 0.1) * 100)}%`)
        .height(24)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
    }
    .width('100%')
    .height(24)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.small)
  }

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTypography.headline)
        .fontWeight(AppTypography.weightSemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        this.StatBar(index);
      }, (index: number) => index.toString())

      Blank().height(AppSpacing.lg)

      Button('Share Report')
        .fontSize(AppTypography.title)
        .fontWeight(AppTypography.weightMedium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .width('60%')
        .height(48)
        .borderRadius(AppShapes.large)
        .onClick(() => {
        })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  build() {
    Column() {
      // Header
      Row() {
        Text('Diet Log')
          .fontSize(AppTypography.display)
          .fontWeight(AppTypography.weightBold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)

      // Tab bar
      this.TabRow();

      // Pager content
      Swiper(this.swiperController) {
        this.MealsPage();
        this.ChatPage();
        this.StatsPage();
      }
      .index(this.currentIndex)
      .loop(false)
      .indicator(false)
      .duration(250)
      .layoutWeight(1)
      .width('100%')
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.primaryA10, 0.0],
        [AppColors.secondaryA10, 1.0]
      ]
    })
  }
}