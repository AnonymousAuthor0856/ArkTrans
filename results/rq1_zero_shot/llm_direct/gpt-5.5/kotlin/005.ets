interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
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

class AppTokens {
  static readonly Colors = {
    primary: '#7C3AED',
    secondary: '#22C55E',
    tertiary: '#F97316',
    background: '#FAFAFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }

  static readonly Shapes = {
    small: 6,
    medium: 8,
    large: 12
  }

  static readonly ElevationMapping = {
    level1: new ShadowSpec(1, 2, 0.5, 0.12),
    level2: new ShadowSpec(2, 4, 1, 0.14),
    level3: new ShadowSpec(3, 6, 1.5, 0.16),
    level4: new ShadowSpec(4, 8, 2, 0.18),
    level5: new ShadowSpec(5, 10, 2.5, 0.2)
  }
}

const questions: QuestionUi[] = [
  {
    id: 1,
    title: 'Which planet is known as the Red Planet?',
    options: ['Earth', 'Mars', 'Venus', 'Jupiter'],
    answer: 1
  },
  {
    id: 2,
    title: 'What is the chemical symbol for water?',
    options: ['H2O', 'CO2', 'NaCl', 'O2'],
    answer: 0
  },
  {
    id: 3,
    title: 'Who wrote Hamlet?',
    options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'],
    answer: 2
  },
  {
    id: 4,
    title: 'What is the largest mammal?',
    options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
    answer: 1
  }
]

@Entry
@Component
struct RootScreen {
  @State index: number = 0
  @State selected: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State flags: string[] = []

  private hasReview(): boolean {
    return this.flags.indexOf('Review') >= 0
  }

  private toggleReview(): void {
    if (this.hasReview()) {
      this.flags = this.flags.filter((item: string) => item !== 'Review')
    } else {
      this.flags = ['Review']
    }
  }

  private progressValue(): number {
    if (this.completed) {
      return 100
    }
    return ((this.index + (this.selected >= 0 ? 1 : 0)) / questions.length) * 100
  }

  private nextButtonText(): string {
    if (this.index < questions.length - 1) {
      return 'Next'
    }
    if (!this.completed) {
      return 'Finish'
    }
    return 'Done'
  }

  private onNext(): void {
    if (!this.completed) {
      if (this.selected === questions[this.index].answer) {
        this.score += 1
      }
      if (this.index < questions.length - 1) {
        this.index += 1
        this.selected = -1
      } else {
        this.completed = true
      }
    }
  }

  private restart(): void {
    this.index = 0
    this.selected = -1
    this.score = 0
    this.completed = false
    this.flags = []
  }

  @Builder
  AppTitle() {
    Row({ space: AppTokens.Spacing.sm }) {
      Blank()
        .width(20)
        .height(20)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.small)

      Text('Quiz')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(30)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  TopBar() {
    Row() {
      this.AppTitle()
    }
    .width('100%')
    .height(64)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(14)

        Progress({
          value: this.progressValue(),
          total: 100,
          type: ProgressType.Linear
        })
          .width(140)
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(3)
      }
      .alignItems(HorizontalAlign.Start)

      Row({ space: AppTokens.Spacing.sm }) {
        Button('Review', { type: ButtonType.Normal, stateEffect: true })
          .height(36)
          .padding({ left: 12, right: 12 })
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.hasReview() ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
          .backgroundColor(this.hasReview() ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .onClick(() => {
            this.toggleReview()
          })

        Button(this.nextButtonText(), { type: ButtonType.Normal, stateEffect: true })
          .width(140)
          .height(44)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .onClick(() => {
            this.onNext()
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level3.radius,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level3.dy
    })
  }

  @Builder
  CompletedContent() {
    Column() {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(24)

      Blank()
        .height(AppTokens.Spacing.lg)

      Row() {
        Text(`Score: ${this.score}/${questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.primary)
          .lineHeight(24)
      }
      .width('100%')
      .height(120)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Restart', { type: ButtonType.Normal, stateEffect: true })
        .width('100%')
        .height(44)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
        .onClick(() => {
          this.restart()
        })
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.xl,
      bottom: AppTokens.Spacing.xl
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  OptionChip(optionText: string, optionIndex: number) {
    Button(optionText, { type: ButtonType.Normal, stateEffect: true })
      .height(38)
      .padding({ left: 12, right: 12 })
      .fontSize(this.selected === optionIndex ? 14 : 12)
      .fontWeight(this.selected === optionIndex ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selected === optionIndex ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .backgroundColor(this.selected === optionIndex ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        this.selected = optionIndex
      })
  }

  @Builder
  QuestionCard() {
    Column({ space: AppTokens.Spacing.md }) {
      Row() {
        Text(`Question ${this.index + 1}/${questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(14)
      }
      .width('100%')
      .aspectRatio(2.8)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)

      Text(questions[this.index].title)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onSurface)
        .lineHeight(24)

      Column({ space: AppTokens.Spacing.sm }) {
        ForEach(questions[this.index].options, (item: string, optionIndex: number) => {
          this.OptionChip(item, optionIndex)
        }, (item: string) => item)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .constraintSize({ minHeight: 180 })
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SelectedRow() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text('Selected')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(14)

        Text(this.selected >= 0 ? questions[this.index].options[this.selected] : 'None')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .lineHeight(18)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Skip', { type: ButtonType.Normal, stateEffect: true })
        .height(36)
        .padding({ left: 12, right: 12 })
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: AppTokens.Colors.outline })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuizContent() {
    List({ space: AppTokens.Spacing.lg }) {
      ListItem() {
        this.QuestionCard()
      }

      ListItem() {
        this.SelectedRow()
      }
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppTokens.Spacing.lg,
      right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.xxxl
    })
    .backgroundColor(AppTokens.Colors.background)
  }

  build() {
    Column() {
      this.TopBar()

      if (this.completed) {
        this.CompletedContent()
          .layoutWeight(1)
      } else {
        this.QuizContent()
          .layoutWeight(1)
      }

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}