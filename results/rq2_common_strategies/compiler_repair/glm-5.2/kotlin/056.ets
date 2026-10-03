// Index.ets

const NAME: string = "085_DietLog_en";
const UI_TYPE: string = "Health Messenger";
const STYLE_THEME: string = "Cold Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: "#FF0EA5E9",
    secondary: "#FF6366F1",
    tertiary: "#FF06B6D4",
    background: "#FFF1F5F9",
    surface: "#FFFFFFFF",
    surfaceVariant: "#FFE2E8F0",
    outline: "#FFD1D5DB",
    success: "#FF22C55E",
    warning: "#FFF59E0B",
    error: "#FFEF4444",
    onPrimary: "#FFFFFFFF",
    onSecondary: "#FFFFFFFF",
    onTertiary: "#FF0F172A",
    onBackground: "#FF1E293B",
    onSurface: "#FF1E293B",
  };

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.SemiBold },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec,
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 } as ShadowSpec,
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 } as ShadowSpec,
  };
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ["Meals", "Chat", "Stats"];

  build() {
    Column() {
      // Header
      Row() {
        Text("Diet Log")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(AppTokens.Spacing.lg)

      // Tabs
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            if (index === 0) {
              MealsPage()
            } else if (index === 1) {
              ChatPage()
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
      .barMode(BarMode.Fixed)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.primary, 0.1], [AppTokens.Colors.secondary, 0.1]]
    })
  }

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
      Divider()
        .color(this.currentIndex === index ? AppTokens.Colors.primary : 'transparent')
        .width('100%')
        .strokeWidth(2)
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Text(`Meal ${item}`)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .justifyContent(FlexAlign.Center)
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([1, 2, 3, 4, 5], (item: number) => {
        Row() {
          Text(`Message ${item}`)
            .fontColor(item % 2 === 0 ? AppTokens.Colors.onSurface : AppTokens.Colors.onPrimary)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(item % 2 === 0 ? AppTokens.Colors.surfaceVariant : AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .justifyContent(item % 2 === 0 ? FlexAlign.Start : FlexAlign.End)
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct StatsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([1, 2, 3, 4, 5, 6, 7], (item: number) => {
        Row() {
          Row() {
          }
          .width(`${Math.min(0.3 + item * 0.1, 1.0) * 100}%`)
          .height('100%')
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Blank().height(AppTokens.Spacing.lg)

      Button("Share Report") {
      }
      .width('60%')
      .height(48)
      .borderRadius(AppTokens.Shapes.large)
      .backgroundColor(AppTokens.Colors.secondary)
      .fontColor(AppTokens.Colors.onSecondary)
      .fontSize(AppTokens.TypographyTokens.title.fontSize)
      .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}