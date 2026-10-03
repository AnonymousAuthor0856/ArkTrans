const NAME: string = "085_DietLog_en";
const UI_TYPE: string = "Health Messenger";
const STYLE_THEME: string = "Cold Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct MainActivity {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  @Builder
  TabRowView() {
    Row() {
      ForEach(this.tabs, (title: string, index: number) => {
        Column() {
          Text(title)
            .fontSize(14)
            .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
            .fontWeight(this.selectedTab === index ? FontWeight.SemiBold : FontWeight.Normal)
            .textAlign(TextAlign.Center)
            .width('100%')
          Rect()
            .width(this.selectedTab === index ? 34 : 0)
            .height(3)
            .fill(AppColors.primary)
            .radius(2)
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .height(50)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedTab = index;
        })
      })
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  MealsPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
      ForEach([1, 2, 3], (meal: number) => {
        Column() {
          Text(`Meal ${meal}`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppColors.surface)
        .borderRadius(12)
        .border({ width: 1, color: AppColors.outline })
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  ChatPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          Text(`Message ${item + 1}`)
            .fontSize(14)
            .fontColor(item % 2 === 0 ? AppColors.onSurface : AppColors.onPrimary)
            .padding(AppSpacing.md)
            .backgroundColor(item % 2 === 0 ? AppColors.surfaceVariant : AppColors.primary)
            .borderRadius(12)
        }
        .width('100%')
        .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
        .justifyContent(item % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
  }

  @Builder
  StatsPage() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width('100%')
            .height(24)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(8)
          Blank()
            .width(`${Math.min(100, Math.round((0.3 + item * 0.1) * 100))}%`)
            .height(24)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
      })

      Blank().height(AppSpacing.lg)

      Button('Share Report')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .borderRadius(16)
        .alignSelf(ItemAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)

      this.TabRowView()

      Scroll() {
        Column() {
          if (this.selectedTab === 0) {
            this.MealsPage()
          } else if (this.selectedTab === 1) {
            this.ChatPage()
          } else {
            this.StatsPage()
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
  }
}
