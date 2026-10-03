// 008_EducationQuiz_en - Education Quiz - Playful Pastel
// Converted from Kotlin Compose to ArkTS

// App design tokens
class AppColors {
  static readonly primary: string = '#FF7C3AED'
  static readonly secondary: string = '#FF22C55E'
  static readonly tertiary: string = '#FFF97316'
  static readonly background: string = '#FFFAFAFF'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFF1F5F9'
  static readonly outline: string = '#FFE2E8F0'
  static readonly success: string = '#FF16A34A'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FF0F172A'
  static readonly onTertiary: string = '#FF111827'
  static readonly onBackground: string = '#FF0B1220'
  static readonly onSurface: string = '#FF0B1220'
}

class AppSpacing {
  static readonly xs: Length = 2
  static readonly sm: Length = 4
  static readonly md: Length = 6
  static readonly lg: Length = 8
  static readonly xl: Length = 12
  static readonly xxl: Length = 16
  static readonly xxxl: Length = 24
}

class AppShapes {
  static readonly small: Length = 6
  static readonly medium: Length = 8
  static readonly large: Length = 12
}

interface Question {
  id: number
  title: string
  options: string[]
  answer: number
}

const NAME: string = '008_EducationQuiz_en'
const UI_TYPE: string = 'Education Quiz'
const STYLE_THEME: string = 'Playful Pastel'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

@Entry
@Component
struct EducationQuiz {
  @State questions: Question[] = [
    { id: 1, title: 'Which planet is known as the Red Planet?', options: ['Earth', 'Mars', 'Venus', 'Jupiter'], answer: 1 },
    { id: 2, title: 'What is the chemical symbol for water?', options: ['H2O', 'CO2', 'NaCl', 'O2'], answer: 0 },
    { id: 3, title: 'Who wrote Hamlet?', options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], answer: 2 },
    { id: 4, title: 'What is the largest mammal?', options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], answer: 1 }
  ]
  @State currentIndex: number = 0
  @State selectedOption: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State isReview: boolean = false

  private handleNext(): void {
    if (this.completed) {
      return
    }
    if (this.selectedOption === this.questions[this.currentIndex].answer) {
      this.score += 1
    }
    if (this.currentIndex < this.questions.length - 1) {
      this.currentIndex += 1
      this.selectedOption = -1
    } else {
      this.completed = true
    }
  }

  private handleRestart(): void {
    this.currentIndex = 0
    this.selectedOption = -1
    this.score = 0
    this.completed = false
  }

  @Builder
  TopBar() {
    Row() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)

        Text('Quiz')
          .fontSize(24)
          .fontWeight(600)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.Center)
    .shadow({
      radius: 2,
      color: 'rgba(0,0,0,0.08)',
      offsetY: 1
    })
  }

  @Builder
  QuestionCard() {
    Column() {
      // Question header image/placeholder area
      Column() {
        Text(`Question ${this.currentIndex + 1}/${this.questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
      .justifyContent(FlexAlign.Center)

      Text(this.questions[this.currentIndex].title)
        .fontSize(18)
        .fontWeight(600)
        .fontColor(AppColors.onSurface)
        .width('100%')

      // Options as filter chips
      Column() {
        ForEach(this.questions[this.currentIndex].options, (option: string, index: number) => {
          this.OptionChip(option, index)
        }, (option: string, index: number) => index.toString())
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.10)',
      offsetY: 2
    })
  }

  @Builder
  OptionChip(option: string, index: number) {
    Row() {
      Text(option)
        .fontSize(this.selectedOption === index ? 14 : 12)
        .fontWeight(this.selectedOption === index ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.selectedOption === index ? AppColors.onPrimary : AppColors.onSurface)
    }
    .width('100%')
    .height(40)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(this.selectedOption === index ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.selectedOption = index
    })
  }

  @Builder
  BottomBar() {
    Row() {
      // Progress section
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Progress({
          value: this.completed
            ? this.questions.length
            : this.currentIndex + (this.selectedOption >= 0 ? 1 : 0),
          total: this.questions.length,
          type: ProgressType.Linear
        })
          .width(140)
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(3)
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        // Review chip
        Row() {
          Text('Review')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isReview ? AppColors.onSecondary : AppColors.onSurface)
        }
        .height(32)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .backgroundColor(this.isReview ? AppColors.secondary : AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .onClick(() => {
          this.isReview = !this.isReview
        })

        // Next/Finish button
        Button(this.currentIndex < this.questions.length - 1
          ? 'Next'
          : (!this.completed ? 'Finish' : 'Done'))
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .height(44)
          .width(140)
          .onClick(() => {
            this.handleNext()
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: 6,
      color: 'rgba(0,0,0,0.12)',
      offsetY: -2
    })
  }

  @Builder
  CompletionScreen() {
    Column() {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(600)
        .fontColor(AppColors.onSurface)

      Blank()
        .height(AppSpacing.lg)

      // Score card
      Column() {
        Text(`Score: ${this.score}/${this.questions.length}`)
          .fontSize(18)
          .fontWeight(600)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.large)
      .justifyContent(FlexAlign.Center)

      Blank()
        .height(AppSpacing.lg)

      Button('Restart')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.large)
        .height(44)
        .width('100%')
        .onClick(() => {
          this.handleRestart()
        })
    }
    .width('100%')
    .height('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.xl,
      bottom: AppSpacing.xl
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  QuizContent() {
    Column() {
      this.QuestionCard()

      Blank()
        .height(AppSpacing.lg)

      // Selected + Skip row
      Row() {
        Column() {
          Text('Selected')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.selectedOption >= 0
            ? this.questions[this.currentIndex].options[this.selectedOption]
            : 'None')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        // Skip chip
        Row() {
          Text('Skip')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .height(32)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.small)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .onClick(() => {
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .layoutWeight(1)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.md,
      bottom: AppSpacing.md
    })
  }

  build() {
    Column() {
      this.TopBar()

      if (this.completed) {
        this.CompletionScreen()
      } else {
        Scroll() {
          this.QuizContent()
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
