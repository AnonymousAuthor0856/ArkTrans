// AppTokens (Atomic Design System)
class AppTokensColors {
  primary: number = 0xFF0EA5E9;
  secondary: number = 0xFF6366F1;
  tertiary: number = 0xFF06B6D4;
  background: number = 0xFFF1F5F9;
  surface: number = 0xFFFFFFFF;
  surfaceVariant: number = 0xFFE2E8F0;
  outline: number = 0xFFD1D5DB;
  success: number = 0xFF22C55E;
  warning: number = 0xFFF59E0B;
  error: number = 0xFFEF4444;
  onPrimary: number = 0xFFFFFFFF;
  onSecondary: number = 0xFFFFFFFF;
  onTertiary: number = 0xFF0F172A;
  onBackground: number = 0xFF1E293B;
  onSurface: number = 0xFF1E293B;
}

class AppTokensTypography {
  display: number = 28;
  headline: number = 20;
  title: number = 16;
  body: number = 14;
  label: number = 12;
}

class AppTokensShapes {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

class AppTokensSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

class AppTokens {
  static Colors: AppTokensColors = new AppTokensColors();
  static Typography: AppTokensTypography = new AppTokensTypography();
  static Shapes: AppTokensShapes = new AppTokensShapes();
  static Spacing: AppTokensSpacing = new AppTokensSpacing();
}

// Helper function to coerce a value in range (mimic Kotlin's coerceIn)
function coerceIn(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(value, max));
}

// RootScreen Component
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background Gradient
      Column() {
        // Fallback background
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.primary, 0.1],
          [AppTokens.Colors.secondary, 0.1]
        ]
      })
      .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Title Box
        Row() {
          Text('Diet Log')
            .fontSize(AppTokens.Typography.display)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)

        // Custom TabRow
        Tabs({ barPosition: BarPosition.Start, index: this.selectedTab }) {
          ForEach(this.tabs, (tabName: string, index?: number) => {
            TabContent() {
              if (index === 0) {
                MealsPage()
              } else if (index === 1) {
                ChatPage()
              } else {
                StatsPage()
              }
            }
            .tabBar(this.TabBuilder(tabName, index))
          })
        }
        .onChange((index: number) => {
          this.selectedTab = index;
        })
        .barMode(BarMode.Fixed)
        .barWidth('100%')
        .animationDuration(200)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TabBuilder(tabName: string, index?: number) {
    Column() {
      Text(tabName)
        .fontSize(AppTokens.Typography.body)
        .fontWeight(FontWeight.Normal)
        .fontColor(index === this.selectedTab ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      // Indicator line
      Divider()
        .color(index === this.selectedTab ? AppTokens.Colors.primary : Color.Transparent)
        .strokeWidth(2)
        .width('100%')
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// MealsPage Component
@Component
struct MealsPage {
  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        Text("Today's Meals")
          .fontSize(AppTokens.Typography.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        ForEach([0, 1, 2], (it: number) => {
          Row() {
            Text(`Meal ${it + 1}`)
              .fontSize(AppTokens.Typography.body)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(80)
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: AppTokens.Colors.outline })
        })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
    .width('100%')
    .height('100%')
  }
}

// ChatPage Component
@Component
struct ChatPage {
  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.sm }) {
        Text('Diet Chat')
          .fontSize(AppTokens.Typography.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        ForEach([0, 1, 2, 3, 4], (it: number) => {
          Row() {
            if (it % 2 === 0) {
              Text(`Message ${it + 1}`)
                .fontSize(AppTokens.Typography.body)
                .fontWeight(FontWeight.Normal)
                .fontColor(AppTokens.Colors.onSurface)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
              Blank()
            } else {
              Blank()
              Text(`Message ${it + 1}`)
                .fontSize(AppTokens.Typography.body)
                .fontWeight(FontWeight.Normal)
                .fontColor(AppTokens.Colors.onPrimary)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(AppTokens.Shapes.medium)
            }
          }
          .width('100%')
        })
      }
      .alignItems(HorizontalAlign.Start)
      .padding(AppTokens.Spacing.lg)
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .align(Alignment.TopStart)
    .width('100%')
    .height('100%')
  }
}

// StatsPage Component
@Component
struct StatsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTokens.Typography.headline)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Row() {
          // Progress bar segment
          Row()
            .width(`${coerceIn(0.3 + it * 0.1, 0, 1) * 100}%`)
            .height('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)

          Blank()
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Share Report')
        .width('60%')
        .height(48)
        .fontSize(AppTokens.Typography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
    }
    .alignItems(HorizontalAlign.Center)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .height('100%')
  }
}

// App Entry Point
@Entry
struct DietLogApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}