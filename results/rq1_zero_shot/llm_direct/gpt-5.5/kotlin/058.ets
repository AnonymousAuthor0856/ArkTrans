const NAME: string = '087_StepChallenge_en'
const UI_TYPE: string = 'Health ControlPanel'
const STYLE_THEME: string = 'Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: ResourceColor = '#111827'
  static readonly secondary: ResourceColor = '#374151'
  static readonly tertiary: ResourceColor = '#6B7280'
  static readonly background: ResourceColor = '#F9FAFB'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E5E7EB'
  static readonly outline: ResourceColor = '#D1D5DB'
  static readonly success: ResourceColor = '#16A34A'
  static readonly warning: ResourceColor = '#F59E0B'
  static readonly error: ResourceColor = '#EF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
  static readonly onTertiary: ResourceColor = '#111827'
  static readonly onBackground: ResourceColor = '#111827'
  static readonly onSurface: ResourceColor = '#1F2937'
}

class AppTypographyTokens {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineSize: number = 20
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleSize: number = 16
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16)
}

@Component
struct OverviewPage {
  build() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Sync Device')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onPrimary)
      }
      .width('60%')
      .height(48)
      .borderRadius(AppShapes.large)
      .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RankingPage {
  private users: number[] = [0, 1, 2, 3, 4]

  build() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.users, (item: number) => {
        Row() {
          Text(`User ${item + 1}`)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onSurface)

          Text(`${9000 - item * 500} steps`)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding(AppSpacing.md)
        .justifyContent(FlexAlign.SpaceBetween)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
  }
}

@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)

      ForEach(this.days, (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width(`${Math.min(0.3 + item * 0.1, 1) * 100}%`)
            .height('100%')
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(20)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
        .clip(true)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  @State currentPage: number = 0
  private tabsController: TabsController = new TabsController()

  @Builder
  TabBar(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.labelWeight)
        .fontColor(this.currentPage === index ? AppColors.primary : AppColors.onSurface)

      Row()
        .width('40%')
        .height(2)
        .margin({ top: 6 })
        .backgroundColor(this.currentPage === index ? AppColors.primary : Color.Transparent)
        .borderRadius(1)
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Text('Step Challenge')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(AppTypographyTokens.displayWeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding(AppSpacing.lg)
      .justifyContent(FlexAlign.Center)

      Tabs({
        barPosition: BarPosition.Start,
        index: this.currentPage,
        controller: this.tabsController
      }) {
        TabContent() {
          OverviewPage()
        }
        .tabBar(this.TabBar('Overview', 0))

        TabContent() {
          RankingPage()
        }
        .tabBar(this.TabBar('Ranking', 1))

        TabContent() {
          StatsPage()
        }
        .tabBar(this.TabBar('Stats', 2))
      }
      .width('100%')
      .layoutWeight(1)
      .barMode(BarMode.Fixed)
      .barHeight(48)
      .vertical(false)
      .animationDuration(250)
      .onChange((index: number) => {
        this.currentPage = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180,
      colors: [
        [AppColors.surfaceVariant, 0.0],
        [AppColors.surface, 1.0]
      ]
    })
  }
}