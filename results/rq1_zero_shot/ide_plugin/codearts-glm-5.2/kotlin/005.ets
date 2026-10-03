const AppColors = {
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

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
}

interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
}

@Entry
@Component
struct Index {
  @State index: number = 0
  @State selected: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State flags: string[] = []
  private questions: QuestionUi[] = [
    { id: 1, title: 'Which planet is known as the Red Planet?', options: ['Earth', 'Mars', 'Venus', 'Jupiter'], answer: 1 },
    { id: 2, title: 'What is the chemical symbol for water?', options: ['H2O', 'CO2', 'NaCl', 'O2'], answer: 0 },
    { id: 3, title: 'Who wrote Hamlet?', options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], answer: 2 },
    { id: 4, title: 'What is the largest mammal?', options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], answer: 1 }
  ]

  build() {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Column()
          .width(20)
          .height(20)
          .backgroundColor(AppColors.primary)
          .borderRadius(4)
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      if (this.completed) {
        this.CompletedView()
      } else {
        this.QuizView()
      }

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  QuizView() {
    List({ space: AppSpacing.lg }) {
      ListItem() {
        this.QuestionCard()
      }
      ListItem() {
        this.SelectedRow()
      }
      ListItem() {
        Blank().height(AppSpacing.xxxl)
      }
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl })
    .scrollBar(BarState.Off)
  }

  @Builder
  QuestionCard() {
    Column({ space: AppSpacing.md }) {
      Text(`Question ${this.index + 1}/${this.questions.length}`)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .aspectRatio(2.8)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(8)
        .textAlign(TextAlign.Center)

      Text(this.questions[this.index].title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Column({ space: AppSpacing.sm }) {
        ForEach(this.questions[this.index].options, (option: string, i: number) => {
          Text(option)
            .fontSize(this.selected === i ? 14 : 12)
            .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selected === i ? AppColors.onPrimary : AppColors.onSurface)
            .backgroundColor(this.selected === i ? AppColors.primary : AppColors.surface)
            .border({ width: 1, color: AppColors.outline, radius: 8 })
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .onClick(() => {
              this.selected = i
            })
        }, (option: string, i: number) => i.toString())
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
  }

  @Builder
  SelectedRow() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Selected')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : 'None')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('Skip')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: 4 })
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  CompletedView() {
    Column({ space: AppSpacing.lg }) {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(`Score: ${this.score}/${this.questions.length}`)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')
        .height(120)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(12)
        .textAlign(TextAlign.Center)

      Button('Restart')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .width('100%')
        .height(44)
        .onClick(() => {
          this.index = 0
          this.selected = -1
          this.score = 0
          this.completed = false
        })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.xl, bottom: AppSpacing.xl })
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Progress({
          value: this.completed ? this.questions.length : (this.index + (this.selected >= 0 ? 1 : 0)),
          total: this.questions.length,
          type: ProgressType.Linear
        })
          .width(140)
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)
      }
      .alignItems(HorizontalAlign.Start)

      Row({ space: AppSpacing.sm }) {
        Text('Review')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.flags.includes('Review') ? AppColors.onSecondary : AppColors.onSurface)
          .backgroundColor(this.flags.includes('Review') ? AppColors.secondary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .onClick(() => {
            const idx = this.flags.indexOf('Review')
            if (idx >= 0) {
              this.flags.splice(idx, 1)
            } else {
              this.flags.push('Review')
            }
          })

        Button(this.index < this.questions.length - 1 ? 'Next' : (this.completed ? 'Done' : 'Finish'))
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(12)
          .height(44)
          .width(140)
          .onClick(() => {
            if (!this.completed) {
              if (this.selected === this.questions[this.index].answer) {
                this.score = this.score + 1
              }
              if (this.index < this.questions.length - 1) {
                this.index = this.index + 1
                this.selected = -1
              } else {
                this.completed = true
              }
            }
          })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}