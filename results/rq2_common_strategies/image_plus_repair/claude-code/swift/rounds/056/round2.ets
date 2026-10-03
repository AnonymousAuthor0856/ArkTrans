// AppTokens - Atomic Design System

// Colors
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
}

// Typography
class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// Shapes (border radius)
class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

// Spacing
class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// MARK: - MealsPage

@Component
struct MealsPage {
  build() {
    Column() {
      Text('Today\'s Meals')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.md })

      ForEach([0, 1, 2], (it: number) => {
        Stack() {
          Text('Meal ' + (it + 1))
            .fontSize(AppTypography.bodySize)
            .fontWeight(AppTypography.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({ width: 1, color: AppColors.outline })
        .margin({ bottom: AppSpacing.md })
      }, (it: number) => it.toString())

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - ChatPage

@Component
struct ChatPage {
  build() {
    Column() {
      Text('Diet Chat')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text('Message ' + (it + 1))
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
            Blank()
          } else {
            Blank()
            Text('Message ' + (it + 1))
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onPrimary)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
          }
        }
        .width('100%')
        .margin({ bottom: AppSpacing.sm })
      }, (it: number) => it.toString())

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - StatsPage

@Component
struct StatsPage {
  private progressValues: number[] = [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];

  build() {
    Column() {
      Text('Weekly Calories')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.md })

      ForEach(this.progressValues, (progress: number, index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width(progress * 100 + '%')
            .height('100%')
            .fill(AppColors.primary)
            .radius(AppShapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .margin({ bottom: AppSpacing.md })
      }, (progress: number, index: number) => index.toString())

      Blank()
        .height(AppSpacing.lg)

      Button('Share Report')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.large)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .justifyContent(FlexAlign.Start)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Column() {
      // Title
      Text('Diet Log')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
        .padding(AppSpacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      // Tabs
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          MealsPage()
        }
        .tabBar(this.TabBarBuilder(0))

        TabContent() {
          ChatPage()
        }
        .tabBar(this.TabBarBuilder(1))

        TabContent() {
          StatsPage()
        }
        .tabBar(this.TabBarBuilder(2))
      }
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .barBackgroundColor(AppColors.surface)
      .selectedIndex(this.selectedTab)
      .onChange((index: number) => {
        this.selectedTab = index;
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
  }

  @Builder
  TabBarBuilder(index: number) {
    Column() {
      Text(this.tabs[index])
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
      if (this.selectedTab === index) {
        Column()
          .width('33%')
          .height(2)
          .backgroundColor(AppColors.primary)
          .margin({ top: 4 })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedTab = index;
    })
  }
}
