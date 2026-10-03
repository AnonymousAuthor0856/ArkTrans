const NAME = '085_DietLog_en'
const UI_TYPE = 'Health Messenger'
const STYLE_THEME = 'Cold Gradient'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#0EA5E9',
    secondary: '#6366F1',
    tertiary: '#06B6D4',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#D1D5DB',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#1E293B',
    onSurface: '#1E293B',
  }

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 },
  }
}

@Entry
@Component
struct RootScreen {
  @State currentTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']

  build() {
    Column() {
      Text('Diet Log')
        .fontSize(AppTokens.TypographyTokens.display.fontSize)
        .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .textAlign(TextAlign.Center)

      Tabs({ barPosition: BarPosition.Start, index: this.currentTab }) {
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
          .tabBar(this.TabBuilder(index, title))
        }, (title: string, index: number) => index.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .onChange((index: number) => {
        this.currentTab = index
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#1A0EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
  }

  @Builder
  TabBuilder(index: number, title: string) {
    Column() {
      Text(title)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(this.currentTab === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct MealsPage {
  build() {
    Column() {
      Text("Today's Meals")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2], (i: number) => {
        Column() {
          Text(`Meal ${i + 1}`)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .justifyContent(FlexAlign.Center)
        .margin({ top: AppTokens.Spacing.md })
      }, (i: number) => i.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct ChatPage {
  build() {
    Column() {
      Text('Diet Chat')
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4], (i: number) => {
        Row() {
          if (i % 2 === 0) {
            Column() {
              Text(`Message ${i + 1}`)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
          } else {
            Blank()
            Column() {
              Text(`Message ${i + 1}`)
                .fontSize(AppTokens.TypographyTokens.body.fontSize)
                .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
          }
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .alignItems(VerticalAlign.Center)
      }, (i: number) => i.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct StatsPage {
  build() {
    Column() {
      Text('Weekly Calories')
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (i: number) => {
        Row() {
          Column()
            .width(`${Math.min(0.3 + i * 0.1, 1) * 100}%`)
            .height(24)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .margin({ top: AppTokens.Spacing.sm })
      }, (i: number) => i.toString())

      Button('Share Report')
        .type(ButtonType.Normal)
        .width('60%')
        .height(48)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
        .margin({ top: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}