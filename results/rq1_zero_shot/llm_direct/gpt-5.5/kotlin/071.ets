const NAME: string = '163*QuizForge*en'
const UI_TYPE: string = 'Quiz'
const STYLE_THEME: string = 'Citrus Pop'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const COLOR_PALETTE: string =
  'primary:#FF8A2A secondary:#FFC857 tertiary:#68D672 background:#FFF9F2 surface:#FFFFFF surfaceVariant:#FFE4CC outline:#E2B088 success:#2AC28B warning:#FFB347 error:#F45B69 onPrimary:#2C0D00 onSecondary:#301A00 onTertiary:#083919 onBackground:#1E1205 onSurface:#311F10'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string = 'QuestionCard,OptionChip,Progress'
const EXTRA: string = 'Citrus quiz forge with cards, chips, and timed progress'

class DesignColors {
  static readonly primary: string = '#FF8A2A'
  static readonly secondary: string = '#FFC857'
  static readonly tertiary: string = '#68D672'
  static readonly background: string = '#FFF9F2'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFE4CC'
  static readonly outline: string = '#E2B088'
  static readonly success: string = '#2AC28B'
  static readonly warning: string = '#FFB347'
  static readonly error: string = '#F45B69'
  static readonly onPrimary: string = '#2C0D00'
  static readonly onSecondary: string = '#301A00'
  static readonly onTertiary: string = '#083919'
  static readonly onBackground: string = '#1E1205'
  static readonly onSurface: string = '#311F10'

  static readonly primary20: string = '#33FF8A2A'
  static readonly primary35: string = '#59FF8A2A'
  static readonly secondary20: string = '#33FFC857'
  static readonly onSurface70: string = '#B3311F10'
}

class DesignTypography {
  static readonly displaySize: number = 30
  static readonly displayLineHeight: number = 34
  static readonly headlineSize: number = 22
  static readonly headlineLineHeight: number = 28
  static readonly titleSize: number = 16
  static readonly titleLineHeight: number = 22
  static readonly bodySize: number = 14
  static readonly bodyLineHeight: number = 20
  static readonly labelSize: number = 12
  static readonly labelLineHeight: number = 16
}

class DesignShape {
  static readonly small: number = 10
  static readonly medium: number = 18
  static readonly large: number = 28
}

class DesignSpacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 36
  static readonly xxxl: number = 46
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

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.18)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.22)
  static readonly level3: ShadowSpec = new ShadowSpec(12, 12, 6, 0.26)
  static readonly level4: ShadowSpec = new ShadowSpec(18, 18, 8, 0.3)
  static readonly level5: ShadowSpec = new ShadowSpec(26, 26, 12, 0.34)
}

class QuizQuestion {
  category: string
  prompt: string
  options: string[]
  hint: string

  constructor(category: string, prompt: string, options: string[], hint: string) {
    this.category = category
    this.prompt = prompt
    this.options = options
    this.hint = hint
  }
}

class StreakCard {
  label: string
  value: string

  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedIndex: number = -1

  private question: QuizQuestion = new QuizQuestion(
    'Citrus crafts',
    'Which zest carrier gives the brightest aroma when infused cold?',
    ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    'Think surface area'
  )

  private streaks: StreakCard[] = [
    new StreakCard('Current streak', '5 days'),
    new StreakCard('Accuracy', '84%'),
    new StreakCard('Rank', 'Top 12%')
  ]

  private progress: number = 45

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Button({ type: ButtonType.Circle }) {
          Blank()
            .width(30)
            .height(30)
            .backgroundColor(DesignColors.surfaceVariant)
            .borderRadius(15)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .stateEffect(false)
        .onClick(() => {
        })

        Blank()
          .layoutWeight(1)

        Button({ type: ButtonType.Circle }) {
          Blank()
            .width(30)
            .height(30)
            .backgroundColor(DesignColors.primary35)
            .borderRadius(15)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .stateEffect(false)
        .onClick(() => {
        })
      }
      .width('100%')
      .height(64)
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('QuizForge')
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onSurface)

        Text('Aroma sprint')
          .fontSize(DesignTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.labelLineHeight)
          .fontColor(DesignColors.onSurface70)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(DesignColors.background)
  }

  @Builder
  QuestionCard() {
    Column({ space: DesignSpacing.sm }) {
      Row() {
        Text(this.question.category)
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onSurface)

        Text('45%')
          .fontSize(DesignTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .lineHeight(DesignTypography.bodyLineHeight)
          .fontColor(DesignColors.secondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Progress({
        value: this.progress,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(6)
        .color(DesignColors.primary)
        .backgroundColor(DesignColors.surfaceVariant)
        .borderRadius(3)

      Text(this.question.prompt)
        .fontSize(DesignTypography.headlineSize)
        .fontWeight(FontWeight.Bold)
        .lineHeight(DesignTypography.headlineLineHeight)
        .fontColor(DesignColors.onSurface)
        .width('100%')

      Column({ space: DesignSpacing.xs }) {
        ForEach(this.question.options, (option: string, index: number) => {
          Column() {
            Text(option)
              .fontSize(DesignTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(DesignTypography.titleLineHeight)
              .fontColor(DesignColors.onSurface)
              .width('100%')
          }
          .width('100%')
          .padding(DesignSpacing.sm)
          .backgroundColor(this.selectedIndex === index ? DesignColors.primary20 : DesignColors.surfaceVariant)
          .borderRadius(DesignShape.medium)
          .border({
            width: 1,
            color: this.selectedIndex === index ? DesignColors.primary : DesignColors.outline,
            style: BorderStyle.Solid
          })
          .onClick(() => {
            this.selectedIndex = index
          })
        }, (option: string, index: number) => `${index}-${option}`)
      }
      .width('100%')

      Row() {
        Text(`Hint: ${this.question.hint}`)
          .fontSize(DesignTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.labelLineHeight)
          .fontColor(DesignColors.onSurface)
      }
      .padding({
        left: DesignSpacing.sm,
        right: DesignSpacing.sm,
        top: DesignSpacing.xs,
        bottom: DesignSpacing.xs
      })
      .backgroundColor(DesignColors.secondary20)
      .borderRadius(DesignShape.small)
    }
    .width('100%')
    .padding(DesignSpacing.md)
    .backgroundColor(DesignColors.surface)
    .borderRadius(DesignShape.large)
    .shadow({
      radius: ElevationMapping.level2.radius,
      color: '#38311F10',
      offsetX: 0,
      offsetY: ElevationMapping.level2.dy
    })
  }

  @Builder
  TrackersCard() {
    Column({ space: DesignSpacing.xs }) {
      Text('Trackers')
        .fontSize(DesignTypography.headlineSize)
        .fontWeight(FontWeight.Bold)
        .lineHeight(DesignTypography.headlineLineHeight)
        .fontColor(DesignColors.onSurface)
        .width('100%')

      Row({ space: DesignSpacing.sm }) {
        ForEach(this.streaks, (streak: StreakCard, index: number) => {
          Column({ space: DesignSpacing.xxs }) {
            Text(streak.label)
              .fontSize(DesignTypography.labelSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(DesignTypography.labelLineHeight)
              .fontColor(DesignColors.onSurface70)
              .textAlign(TextAlign.Center)
              .maxLines(2)

            Text(streak.value)
              .fontSize(DesignTypography.titleSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(DesignTypography.titleLineHeight)
              .fontColor(DesignColors.onSurface)
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .padding(DesignSpacing.sm)
          .backgroundColor(DesignColors.surfaceVariant)
          .borderRadius(DesignShape.medium)
          .alignItems(HorizontalAlign.Center)
        }, (streak: StreakCard, index: number) => `${index}-${streak.label}`)
      }
      .width('100%')

      Button() {
        Text('Submit answer')
          .fontSize(DesignTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .lineHeight(DesignTypography.titleLineHeight)
          .fontColor(DesignColors.onPrimary)
      }
      .width('100%')
      .height(48)
      .margin({ top: DesignSpacing.xs })
      .backgroundColor(DesignColors.primary)
      .borderRadius(DesignShape.medium)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(DesignSpacing.md)
    .backgroundColor(DesignColors.surface)
    .borderRadius(DesignShape.large)
    .shadow({
      radius: ElevationMapping.level1.radius,
      color: '#2E311F10',
      offsetX: 0,
      offsetY: ElevationMapping.level1.dy
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: DesignSpacing.md }) {
          this.QuestionCard()
          this.TrackersCard()
        }
        .width('100%')
        .padding({
          left: DesignSpacing.lg,
          right: DesignSpacing.lg,
          top: DesignSpacing.sm,
          bottom: DesignSpacing.sm
        })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignColors.background)
  }
}