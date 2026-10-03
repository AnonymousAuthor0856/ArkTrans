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

class AppColors {
  static readonly primary: string = '#FF8A2A'
  static readonly primarySoft: string = '#33FF8A2A'
  static readonly secondary: string = '#FFC857'
  static readonly secondarySoft: string = '#33FFC857'
  static readonly tertiary: string = '#68D672'
  static readonly background: string = '#FFF9F2'
  static readonly surface: string = '#FFFFFF'
  static readonly elevatedSurface: string = '#FFF1E6'
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
  static readonly onSurfaceMuted: string = '#B3311F10'
  static readonly lavenderTrack: string = '#F1E6FF'
  static readonly circleLeft: string = '#FFDFC0'
  static readonly circleRight: string = '#FFD0A6'
}

class Spacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 36
  static readonly xxxl: number = 46
}

class Radius {
  static readonly small: number = 10
  static readonly medium: number = 18
  static readonly large: number = 28
  static readonly circle: number = 999
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
struct QuizForgePage {
  @State selectedIndex: number = -1

  private question: QuizQuestion = new QuizQuestion(
    'Citrus crafts',
    'Which zest carrier gives the brightest aroma when infused cold?',
    ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    'Think surface area'
  )

  private streaks: StreakCard[] = [
    new StreakCard('Current\nstreak', '5 days'),
    new StreakCard('Accuracy', '84%'),
    new StreakCard('Rank', 'Top 12%')
  ]

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: Spacing.md }) {
          this.QuestionCard()
          this.TrackersCard()
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.sm,
          bottom: Spacing.xl
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Stack()
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(AppColors.circleLeft)
          .opacity(0.9)
          .onClick(() => {
          })

        Blank()

        Stack()
          .width(60)
          .height(60)
          .borderRadius(30)
          .backgroundColor(AppColors.circleRight)
          .opacity(0.9)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 26, right: 26 })

      Column() {
        Text('QuizForge')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(34)

        Text('Aroma sprint')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurfaceMuted)
          .lineHeight(28)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(118)
    .padding({ top: 18 })
    .backgroundColor(AppColors.background)
  }

  @Builder
  QuestionCard() {
    Column({ space: Spacing.sm }) {
      Row() {
        Text(this.question.category)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(34)

        Blank()

        Text('45%')
          .fontSize(26)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
          .lineHeight(32)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      this.ProgressBar(45)

      Text(this.question.prompt)
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(56)
        .margin({ top: Spacing.xs, bottom: Spacing.xs })

      Column({ space: Spacing.md }) {
        ForEach(this.question.options, (option: string, index: number) => {
          this.OptionChip(option, index)
        }, (option: string) => option)
      }
      .width('100%')

      Row() {
        Text('Hint: ' + this.question.hint)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(30)
      }
      .padding({
        left: Spacing.sm,
        right: Spacing.sm,
        top: Spacing.xs,
        bottom: Spacing.xs
      })
      .margin({ top: Spacing.sm })
      .borderRadius(Radius.small)
      .backgroundColor(AppColors.secondarySoft)
    }
    .width('100%')
    .padding({
      left: 32,
      right: 32,
      top: 32,
      bottom: 32
    })
    .borderRadius(Radius.large)
    .backgroundColor(AppColors.elevatedSurface)
    .shadow({
      radius: 8,
      color: '#18000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  ProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.lavenderTrack)

      Row()
        .width(progress + '%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(AppColors.primary)
    }
    .width('86%')
    .height(8)
    .margin({ top: Spacing.xs, bottom: Spacing.md })
  }

  @Builder
  OptionChip(option: string, index: number) {
    Row() {
      Text(option)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(36)
    }
    .width('100%')
    .minHeight(84)
    .padding({
      left: 24,
      right: 24,
      top: Spacing.sm,
      bottom: Spacing.sm
    })
    .alignItems(VerticalAlign.Center)
    .borderRadius(Radius.medium)
    .backgroundColor(this.selectedIndex === index ? AppColors.primarySoft : AppColors.surfaceVariant)
    .border({
      width: 1.5,
      color: this.selectedIndex === index ? AppColors.primary : AppColors.outline,
      radius: Radius.medium
    })
    .onClick(() => {
      this.selectedIndex = index
    })
  }

  @Builder
  TrackersCard() {
    Column({ space: Spacing.lg }) {
      Text('Trackers')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(48)

      Row({ space: Spacing.sm }) {
        ForEach(this.streaks, (streak: StreakCard) => {
          this.StreakItem(streak)
        }, (streak: StreakCard) => streak.label)
      }
      .width('100%')

      Button('Submit answer')
        .width('100%')
        .height(52)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(Radius.medium)
        .margin({ top: Spacing.sm })
    }
    .width('100%')
    .padding({
      left: 32,
      right: 32,
      top: 32,
      bottom: 32
    })
    .borderRadius(Radius.large)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 6,
      color: '#12000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  StreakItem(streak: StreakCard) {
    Column({ space: Spacing.xxs }) {
      Text(streak.label)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurfaceMuted)
        .lineHeight(26)
        .textAlign(TextAlign.Center)

      Text(streak.value)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(36)
        .textAlign(TextAlign.Center)
    }
    .layoutWeight(1)
    .height(124)
    .padding({
      left: Spacing.xs,
      right: Spacing.xs,
      top: Spacing.md,
      bottom: Spacing.md
    })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .borderRadius(Radius.medium)
    .backgroundColor(AppColors.surfaceVariant)
  }
}