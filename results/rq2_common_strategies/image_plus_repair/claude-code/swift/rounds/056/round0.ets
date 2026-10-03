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
  static readonly display: Font = { size: 28, weight: FontWeight.Bold };
  static readonly headline: Font = { size: 20, weight: FontWeight.Medium };
  static readonly title: Font = { size: 16, weight: FontWeight.Medium };
  static readonly body: Font = { size: 14, weight: FontWeight.Regular };
  static readonly label: Font = { size: 12, weight: FontWeight.Medium };
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
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.md })

      ForEach([0, 1, 2], (it: number) => {
        Stack() {
          Text(`Meal ${it + 1}`)
            .fontSize(AppTypography.body.size)
            .fontWeight(AppTypography.body.weight)
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
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text(`Message ${it + 1}`)
              .fontSize(AppTypography.body.size)
              .fontWeight(AppTypography.body.weight)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
            Blank()
          } else {
            Blank()
            Text(`Message ${it + 1}`)
              .fontSize(AppTypography.body.size)
              .fontWeight(AppTypography.body.weight)
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
  private getProgressWidth(it: number): string {
    const progress = Math.min(1, Math.max(0, 0.3 + it * 0.1));
    return `${progress * 100}%`;
  }

  build() {
    Column() {
      Text('Weekly Calories')
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.md })

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          Rect()
            .width(this.getProgressWidth(it))
            .height('100%')
            .fill(AppColors.primary)
            .radius(AppShapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .margin({ bottom: AppSpacing.md })
      }, (it: number) => it.toString())

      Blank()
        .height(AppSpacing.lg)

      Button('Share Report')
        .fontSize(AppTypography.title.size)
        .fontWeight(AppTypography.title.weight)
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

  private aboutToAppear() {
    // Hide status bar
    // NOTE: Status bar hiding is handled at window level in ArkTS
  }

  build() {
    Stack() {
      // Gradient background
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[AppColors.primary + '1A', AppColors.secondary + '1A']
        })

      Column() {
        // Title
        Text('Diet Log')
          .fontSize(AppTypography.display.size)
          .fontWeight(AppTypography.display.weight)
          .fontColor(AppColors.onBackground)
          .padding(AppSpacing.lg)
          .width('100%')
          .textAlign(TextAlign.Center)

        // Custom TabRow
        Stack() {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Text(tab)
                .fontSize(AppTypography.body.size)
                .fontWeight(AppTypography.body.weight)
                .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
                .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
                .width('100%')
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.selectedTab = index;
                })
            }, (tab: string, index: number) => `${tab}_${index}')
          }
          .width('100%')

          // Tab indicator line
          Row() {
            Column()
              .width(100 / this.tabs.length + '%')
              .height(2)
              .backgroundColor(AppColors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)
          .translate({ x: this.selectedTab * (100 / this.tabs.length + '%' })
          .align(Alignment.BottomStart)
          .animation({ duration: 200, curve: Curve.EaseInOut)
          .position({ y: '100%' })
          .margin({ top: -2 })
        }
        .width('100%')
        .backgroundColor(AppColors.surface)

        // TabContent
        .position({ y: '100%' })
        .margin({ top: -2 })
      }
      .width('100%')
      .backgroundColor(AppColors.surface)

      // Page content below tab bar
      Column() {
        // Title area placeholder for tab bar height
        Column()
          .height(28 + AppSpacing.lg * 2 + AppSpacing.md * 2 + 2)
          .width('100%')

        // Swiper for page content
        Swiper(this.selectedTab) {
          MealsPage()
          ChatPage()
          StatsPage()
        }
        .width('100%')
        .layoutWeight(1)
        .indicator(false)
        .onChange((index: number) => {
          this.selectedTab = index;
        })
        .curve(Curve.EaseInOut)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
