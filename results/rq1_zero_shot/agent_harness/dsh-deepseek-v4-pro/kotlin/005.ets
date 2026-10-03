interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
}

const Colors = {
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

const Spacing = {
  xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
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

  progressValue(): number {
    if (this.completed) {
      return 1
    }
    return (this.index + (this.selected >= 0 ? 1 : 0)) / this.questions.length
  }

  nextLabel(): string {
    if (this.index < this.questions.length - 1) {
      return 'Next'
    }
    if (!this.completed) {
      return 'Finish'
    }
    return 'Done'
  }

  onNext(): void {
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
  }

  onRestart(): void {
    this.index = 0
    this.selected = -1
    this.score = 0
    this.completed = false
  }

  toggleFlag(label: string): void {
    const i = this.flags.indexOf(label)
    if (i >= 0) {
      this.flags.splice(i, 1)
    } else {
      this.flags.push(label)
    }
  }

  build() {
    Column() {
      Row() {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(Colors.primary)
          .borderRadius(6)
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      if (this.completed) {
        Column({ space: Spacing.lg }) {
          Text('Quiz Completed')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
          Blank().height(Spacing.lg)
          Stack() {
            Text('Score: ' + this.score + '/' + this.questions.length)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.primary)
          }
          .width('100%')
          .height(120)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
          Blank().height(Spacing.lg)
          Button('Restart')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSecondary)
            .backgroundColor(Colors.secondary)
            .borderRadius(12)
            .width('100%')
            .height(44)
            .onClick(() => { this.onRestart() })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.xl, bottom: Spacing.xl })
        .justifyContent(FlexAlign.Center)
      } else {
        Scroll() {
          Column({ space: Spacing.lg }) {
            Column({ space: Spacing.md }) {
              Stack() {
                Text('Question ' + (this.index + 1) + '/' + this.questions.length)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(8)

              Text(this.questions[this.index].title)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              Column({ space: Spacing.sm }) {
                ForEach(this.questions[this.index].options, (t: string, i: number) => {
                  Button(t)
                    .fontSize(this.selected === i ? 14 : 12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.selected === i ? Colors.onPrimary : Colors.onSurface)
                    .backgroundColor(this.selected === i ? Colors.primary : Colors.surface)
                    .borderRadius(8)
                    .border({ width: 1, color: Colors.outline })
                    .height(40)
                    .width('100%')
                    .onClick(() => { this.selected = i })
                }, (t: string, i: number) => t + i.toString())
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
            .padding(Spacing.lg)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
            .alignItems(HorizontalAlign.Start)

            Row() {
              Column({ space: Spacing.xs }) {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Button('Skip')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
                .backgroundColor(Colors.surface)
                .borderRadius(6)
                .border({ width: 1, color: Colors.outline })
                .height(32)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        }
        .layoutWeight(1)
        .width('100%')
        .align(Alignment.Top)
      }

      Row() {
        Column({ space: Spacing.xs }) {
          Text('Progress')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Progress({ value: this.progressValue(), total: 1, type: ProgressType.Linear })
            .width(140)
            .height(6)
            .color(Colors.primary)
            .backgroundColor(Colors.surfaceVariant)
        }
        .alignItems(HorizontalAlign.Start)

        Row({ space: Spacing.sm }) {
          Button('Review')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.flags.indexOf('Review') >= 0 ? Colors.onSecondary : Colors.onSurface)
            .backgroundColor(this.flags.indexOf('Review') >= 0 ? Colors.secondary : Colors.surface)
            .borderRadius(6)
            .border({ width: 1, color: Colors.outline })
            .height(32)
            .onClick(() => { this.toggleFlag('Review') })
          Button(this.nextLabel())
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(12)
            .height(44)
            .width(140)
            .onClick(() => { this.onNext() })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
