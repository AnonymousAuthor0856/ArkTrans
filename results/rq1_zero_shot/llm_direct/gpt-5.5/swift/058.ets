class AppTokens {
  static Colors = class {
    static readonly primary: string = '#111827'
    static readonly secondary: string = '#374151'
    static readonly tertiary: string = '#6B7280'
    static readonly background: string = '#F9FAFB'
    static readonly surface: string = '#FFFFFF'
    static readonly surfaceVariant: string = '#E5E7EB'
    static readonly outline: string = '#D1D5DB'
    static readonly success: string = '#16A34A'
    static readonly warning: string = '#F59E0B'
    static readonly error: string = '#EF4444'
    static readonly onPrimary: string = '#FFFFFF'
    static readonly onSecondary: string = '#FFFFFF'
    static readonly onTertiary: string = '#111827'
    static readonly onBackground: string = '#111827'
    static readonly onSurface: string = '#1F2937'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 28
    static readonly headlineSize: number = 20
    static readonly titleSize: number = 16
    static readonly bodySize: number = 14
    static readonly labelSize: number = 12

    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly headlineWeight: FontWeight = FontWeight.SemiBold
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodyWeight: FontWeight = FontWeight.Regular
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  static Shapes = class {
    static readonly small: number = 8
    static readonly medium: number = 12
    static readonly large: number = 16
  }

  static Spacing = class {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 36
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0
  private tabs: string[] = ['Overview', 'Ranking', 'Stats']
  private swiperController: SwiperController = new SwiperController()

  build() {
    Column({ space: 0 }) {
      Text('Step Challenge')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)

      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: $selectedTabIndex,
        onTabSelected: (index: number) => {
          this.selectedTabIndex = index
          this.swiperController.changeIndex(index, true)
        }
      })
        .width('100%')

      Swiper(this.swiperController) {
        OverviewPage()
          .width('100%')
          .height('100%')

        RankingPage()
          .width('100%')
          .height('100%')

        StatsPage()
          .width('100%')
          .height('100%')
      }
      .index(this.selectedTabIndex)
      .indicator(false)
      .loop(false)
      .duration(300)
      .curve(Curve.EaseInOut)
      .onChange((index: number) => {
        this.selectedTabIndex = index
      })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.surface, 1.0]
      ]
    })
  }
}

@Component
struct CustomTabRow {
  @Prop tabs: string[] = []
  @Link selectedTabIndex: number
  onTabSelected: (index: number) => void = () => {}

  build() {
    Column({ space: 0 }) {
      Row({ space: 0 }) {
        ForEach(this.tabs, (tab: string, index: number) => {
          Button({ type: ButtonType.Normal }) {
            Text(tab)
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(AppTokens.TypographyTokens.titleWeight)
              .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .textAlign(TextAlign.Center)
              .width('100%')
              .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(0)
          .padding(0)
          .layoutWeight(1)
          .onClick(() => {
            animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
              this.onTabSelected(index)
            })
          })
        }, (tab: string, index: number) => `${tab}-${index}`)
      }
      .width('100%')

      Row({ space: 0 }) {
        ForEach(this.tabs, (_tab: string, index: number) => {
          Column()
            .height(2)
            .layoutWeight(1)
            .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
        }, (_tab: string, index: number) => `indicator-${index}`)
      }
      .width('100%')
      .height(2)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct OverviewPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()
        .height(AppTokens.Spacing.lg)

      Button({ type: ButtonType.Normal }) {
        Text('Sync Device')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height('100%')
      }
      .width('60%')
      .height(48)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.large)
      .padding(0)
      .onClick(() => {
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

@Component
struct RankingPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          Text(`User ${it + 1}`)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()
            .layoutWeight(1)

          Text(`${9000 - it * 500} steps`)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
      }, (it: number) => `ranking-${it}`)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Start)
  }
}

@Component
struct StatsPage {
  private progressList: number[] = [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9]

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.progressList, (progress: number, index: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(20)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.small)

          Row()
            .width(`${Math.min(progress, 1) * 100}%`)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(20)
      }, (_progress: number, index: number) => `progress-${index}`)

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Start)
  }
}