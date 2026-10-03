// AppTokens - Design system constants
interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

interface TypographyToken {
  size: number
  weight: FontWeight
}

interface TypographyTokens {
  display: TypographyToken
  headline: TypographyToken
  title: TypographyToken
  body: TypographyToken
  label: TypographyToken
}

interface ShapeTokens {
  small: number
  medium: number
  large: number
}

interface SpacingTokens {
  xs: number
  sm: number
  md: number
  lg: number
  xl: number
  xxl: number
}

class AppTokens {
  static readonly Colors: ColorTokens = {
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
    onSurface: '#1F2937'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: ShapeTokens = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }
}

// Helper function to clamp values
function clamp(value: number, min: number, max: number): number {
  return Math.min(Math.max(value, min), max)
}

// Interface for User data
interface User {
  name: string
  steps: number
}

// RootScreen Component
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']

  build() {
    Column() {
      // Title
      Text('Step Challenge')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      // Custom Tab Row
      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: this.selectedTabIndex,
        onTabSelected: (index: number) => {
          this.selectedTabIndex = index
        }
      })

      // Pager Content
      Swiper() {
        // Overview Page
        OverviewPage()

        // Ranking Page
        RankingPage()

        // Stats Page
        StatsPage()
      }
      .index(this.selectedTabIndex)
      .indicator(false)
      .loop(false)
      .onChange((index: number) => {
        this.selectedTabIndex = index
      })
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
    })
  }
}

// CustomTabRow Component
@Component
struct CustomTabRow {
  private tabs: string[] = []
  private selectedTabIndex: number = 0
  private onTabSelected: (index: number) => void = () => {}

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button(tab)
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.onTabSelected(index)
            })
        })
      }
      .width('100%')

      // Indicator
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width(`${100 / this.tabs.length}%`)
          .height(2)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ left: `${(this.selectedTabIndex * 100) / this.tabs.length}%` })
          .animation({ duration: 200, curve: Curve.EaseInOut })
      }
      .width('100%')
      .height(2)
    }
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// OverviewPage Component
@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Sync Device')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('60%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Center)
  }
}

// RankingPage Component
@Component
struct RankingPage {
  private users: User[] = [
    { name: 'User 1', steps: 9000 },
    { name: 'User 2', steps: 8500 },
    { name: 'User 3', steps: 8000 },
    { name: 'User 4', steps: 7500 },
    { name: 'User 5', steps: 7000 }
  ]

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach(this.users, (user: User) => {
        Row() {
          Text(user.name)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`${user.steps} steps`)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// StatsPage Component
@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.days, (it: number) => {
        Row() {
          Row()
            .width(`${clamp(0.3 + it * 0.1, 0, 1) * 100}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
      })

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// Main Entry Point
@Entry
struct StepChallengeApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}