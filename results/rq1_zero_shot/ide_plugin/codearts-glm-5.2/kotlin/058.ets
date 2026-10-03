const NAME = '087_StepChallenge_en'
const UI_TYPE = 'Health ControlPanel'
const STYLE_THEME = 'Monochrome'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111827',
    onBackground: '#111827',
    onSurface: '#1F2937',
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
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      Text('Step Challenge')
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
              OverviewPage()
            } else if (index === 1) {
              RankingPage()
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
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
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
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Button('Sync Device')
        .type(ButtonType.Normal)
        .width('60%')
        .height(48)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
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

@Component
struct RankingPage {
  build() {
    Column() {
      ForEach([0, 1, 2, 3, 4], (i: number) => {
        Row() {
          Text(`User ${i + 1}`)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`${9000 - i * 500} steps`)
            .fontSize(AppTokens.TypographyTokens.body.fontSize)
            .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ bottom: AppTokens.Spacing.sm })
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
      Text('Weekly Progress')
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (i: number) => {
        Row() {
          Column()
            .width(`${Math.min(0.3 + i * 0.1, 1) * 100}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .margin({ top: AppTokens.Spacing.sm })
      }, (i: number) => i.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}