class AppColors {
  static primary: string = '#0EA5E9';
  static secondary: string = '#6366F1';
  static tertiary: string = '#06B6D4';
  static background: string = '#F1F5F9';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#D1D5DB';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#0F172A';
  static onBackground: string = '#1E293B';
  static onSurface: string = '#1E293B';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
}

@Entry
@Component
struct RootScreen {
  @State private selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  @Builder
  private TabRow() {
    Column({ space: 0 }) {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Text(tab)
            .fontSize(14)
            .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
            .height(48)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.selectedTab = index;
            })
        })
      }
      .width('100%')
      Row() {
        ForEach(this.tabs, (_tab: string, index: number) => {
          Rect()
            .height(2)
            .layoutWeight(1)
            .fill(this.selectedTab === index ? AppColors.primary : Color.Transparent)
        })
      }
      .width('100%')
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private MealsPage() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach([0, 1, 2], (index: number) => {
        Stack() {
          Text(`Meal ${index + 1}`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(12)
        .border({ width: 1, color: AppColors.outline })
      })

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private ChatPage() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach([0, 1, 2, 3, 4], (index: number) => {
        Row() {
          if (index % 2 === 0) {
            Text(`Message ${index + 1}`)
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(12)
            Blank()
          } else {
            Blank()
            Text(`Message ${index + 1}`)
              .fontSize(14)
              .fontColor(AppColors.onPrimary)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.primary)
              .borderRadius(12)
          }
        }
        .width('100%')
      })

      Blank()
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private StatsPage() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(24)
            .fill(AppColors.surfaceVariant)
            .radius(8)
          Rect()
            .width(`${Math.min(1, 0.3 + index * 0.1) * 100}%`)
            .height(24)
            .fill(AppColors.primary)
            .radius(8)
        }
        .width('100%')
        .height(24)
      })

      Blank()
        .height(AppSpacing.lg)

      Button('Share Report')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(16)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
  }

  @Builder
  private CurrentPage() {
    if (this.selectedTab === 0) {
      this.MealsPage()
    } else if (this.selectedTab === 1) {
      this.ChatPage()
    } else {
      this.StatsPage()
    }
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(AppSpacing.lg)

      this.TabRow()

      this.CurrentPage()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
