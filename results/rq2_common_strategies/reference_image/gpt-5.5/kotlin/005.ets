class AppColors {
  static readonly primary: string = '#7C3AED'
  static readonly secondary: string = '#22C55E'
  static readonly tertiary: string = '#F97316'
  static readonly background: string = '#FAFAFF'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F1F5F9'
  static readonly outline: string = '#E2E8F0'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0F172A'
  static readonly onTertiary: string = '#111827'
  static readonly onBackground: string = '#0B1220'
  static readonly onSurface: string = '#0B1220'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number

  constructor(id: number, title: string, options: string[], answer: number) {
    this.id = id
    this.title = title
    this.options = options
    this.answer = answer
  }
}

@Entry
@Component
struct RootScreen {
  private questions: QuestionUi[] = [
    new QuestionUi(1, 'Which planet is known as the Red Planet?', ['Earth', 'Mars', 'Venus', 'Jupiter'], 1),
    new QuestionUi(2, 'What is the chemical symbol for water?', ['H2O', 'CO2', 'NaCl', 'O2'], 0),
    new QuestionUi(3, 'Who wrote Hamlet?', ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], 2),
    new QuestionUi(4, 'What is the largest mammal?', ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], 1)
  ]

  @State index: number = 0
  @State selected: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State reviewFlag: boolean = false

  private progressValue(): number {
    if (this.completed) {
      return 1
    }
    return (this.index + (this.selected >= 0 ? 1 : 0)) / this.questions.length
  }

  private progressWidth(): string {
    return `${Math.max(0, Math.min(100, this.progressValue() * 100))}%`
  }

  private currentQuestion(): QuestionUi {
    return this.questions[this.index]
  }

  private nextAction(): void {
    if (!this.completed) {
      if (this.selected === this.currentQuestion().answer) {
        this.score += 1
      }

      if (this.index < this.questions.length - 1) {
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
    this.reviewFlag = false
  }

  @Builder
  TopBar() {
    Row() {
      Row() {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)

        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(30)
          .margin({ left: AppSpacing.sm })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(88)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(6)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(3)

      Row()
        .width(this.progressWidth())
        .height(6)
        .backgroundColor(AppColors.primary)
        .borderRadius(3)
    }
    .width(140)
    .height(6)
    .clip(true)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(14)

        this.ProgressBar()
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Review')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.reviewFlag ? AppColors.onSecondary : AppColors.onSurface)
            .lineHeight(14)
        }
        .width(128)
        .height(32)
        .borderRadius(8)
        .backgroundColor(this.reviewFlag ? AppColors.secondary : AppColors.surface)
        .border({ width: 1, color: AppColors.outline })
        .onClick(() => {
          this.reviewFlag = !this.reviewFlag
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text(this.index < this.questions.length - 1 ? 'Next' : (!this.completed ? 'Finish' : 'Done'))
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
            .lineHeight(18)
        }
        .width(140)
        .height(44)
        .borderRadius(12)
        .backgroundColor(AppColors.primary)
        .margin({ left: AppSpacing.sm })
        .onClick(() => {
          this.nextAction()
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(61)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F4EEFF')
    .shadow({
      radius: 6,
      color: '#26000000',
      offsetX: 0,
      offsetY: -1
    })
  }

  @Builder
  OptionChip(option: string, optionIndex: number) {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(option)
        .fontSize(this.selected === optionIndex ? 14 : 12)
        .fontWeight(this.selected === optionIndex ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.selected === optionIndex ? AppColors.onPrimary : AppColors.onSurface)
        .lineHeight(this.selected === optionIndex ? 18 : 16)
        .padding({ left: 18, right: 18 })
    }
    .height(32)
    .borderRadius(8)
    .backgroundColor(this.selected === optionIndex ? AppColors.primary : AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.selected = optionIndex
    })
  }

  @Builder
  QuestionCard() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(`Question ${this.index + 1}/${this.questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(14)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(8)

      Text(this.currentQuestion().title)
        .width('100%')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)
        .margin({ top: AppSpacing.md })

      Column() {
        ForEach(this.currentQuestion().options, (option: string, optionIndex: number) => {
          this.OptionChip(option, optionIndex)
            .margin({ top: optionIndex === 0 ? 0 : AppSpacing.sm })
        }, (option: string, optionIndex: number) => `${optionIndex}-${option}`)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 6,
      color: '#26000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  SelectedRow() {
    Row() {
      Column() {
        Text('Selected')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(14)

        Text(this.selected >= 0 ? this.currentQuestion().options[this.selected] : 'None')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(18)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Skip')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(14)
      }
      .width(52)
      .height(32)
      .borderRadius(8)
      .backgroundColor(AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuizContent() {
    Scroll() {
      Column() {
        this.QuestionCard()

        this.SelectedRow()
          .margin({ top: AppSpacing.lg })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.xxxl
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .backgroundColor(AppColors.background)
  }

  @Builder
  CompletedContent() {
    Column() {
      Blank()
        .layoutWeight(1)

      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)

      Stack({ alignContent: Alignment.Center }) {
        Text(`Score: ${this.score}/${this.questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .lineHeight(24)
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(12)
      .margin({ top: AppSpacing.lg })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Restart')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .lineHeight(18)
      }
      .width('100%')
      .height(44)
      .borderRadius(12)
      .backgroundColor(AppColors.secondary)
      .margin({ top: AppSpacing.lg })
      .onClick(() => {
        this.restart()
      })

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .layoutWeight(1)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.xl,
      bottom: AppSpacing.xl
    })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  build() {
    Column() {
      this.TopBar()

      if (this.completed) {
        this.CompletedContent()
      } else {
        this.QuizContent()
      }

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}