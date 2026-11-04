class QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;

  constructor(id: number, title: string, options: string[], answer: number) {
    this.id = id;
    this.title = title;
    this.options = options;
    this.answer = answer;
  }
}

class QuizColors {
  static primary: string = '#7C3AED';
  static secondary: string = '#22C55E';
  static tertiary: string = '#F97316';
  static background: string = '#FAFAFF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F1F5F9';
  static outline: string = '#E2E8F0';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#0F172A';
  static onSurface: string = '#0B1220';
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State selectedOption: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State reviewSelected: boolean = false;

  private questions: QuestionUi[] = [
    new QuestionUi(1, 'Which planet is known as the Red Planet?', ['Earth', 'Mars', 'Venus', 'Jupiter'], 1),
    new QuestionUi(2, 'What is the chemical symbol for water?', ['H2O', 'CO2', 'NaCl', 'O2'], 0),
    new QuestionUi(3, 'Who wrote Hamlet?', ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], 2),
    new QuestionUi(4, 'What is the largest mammal?', ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], 1)
  ];

  private progressValue(): number {
    if (this.completed) {
      return 1;
    }
    let answered: number = this.currentIndex + (this.selectedOption >= 0 ? 1 : 0);
    return answered / this.questions.length;
  }

  private actionText(): string {
    if (this.currentIndex < this.questions.length - 1) {
      return 'Next';
    }
    if (!this.completed) {
      return 'Finish';
    }
    return 'Done';
  }

  private submitAnswer(): void {
    if (this.completed) {
      return;
    }
    if (this.selectedOption === this.questions[this.currentIndex].answer) {
      this.score = this.score + 1;
    }
    if (this.currentIndex < this.questions.length - 1) {
      this.currentIndex = this.currentIndex + 1;
      this.selectedOption = -1;
    } else {
      this.completed = true;
    }
  }

  private restart(): void {
    this.currentIndex = 0;
    this.selectedOption = -1;
    this.score = 0;
    this.completed = false;
  }

  @Builder
  AssistChip(label: string, active: boolean, action: () => void) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(active ? QuizColors.onSecondary : QuizColors.onSurface)
      .lineHeight(14)
      .padding({ left: 10, right: 10, top: 6, bottom: 6 })
      .backgroundColor(active ? QuizColors.secondary : QuizColors.surface)
      .border({ width: 1, color: QuizColors.outline, radius: 6 })
      .onClick(action)
  }

  @Builder
  OptionChip(label: string, optionIndex: number) {
    Text(label)
      .fontSize(this.selectedOption === optionIndex ? 14 : 12)
      .fontWeight(this.selectedOption === optionIndex ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedOption === optionIndex ? QuizColors.onPrimary : QuizColors.onSurface)
      .lineHeight(this.selectedOption === optionIndex ? 18 : 16)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.selectedOption === optionIndex ? QuizColors.primary : QuizColors.surface)
      .border({ width: 1, color: QuizColors.outline, radius: 8 })
      .onClick(() => {
        this.selectedOption = optionIndex;
      })
  }

  @Builder
  QuestionCard() {
    Column({ space: 6 }) {
      Stack() {
        Text('Question ' + (this.currentIndex + 1).toString() + '/' + this.questions.length.toString())
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onSurface)
          .lineHeight(14)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(QuizColors.surfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center)

      Text(this.questions[this.currentIndex].title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.onSurface)
        .lineHeight(24)

      Column({ space: 4 }) {
        ForEach(this.questions[this.currentIndex].options, (option: string, optionIndex: number) => {
          this.OptionChip(option, optionIndex)
        }, (option: string) => option)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .constraintSize({ minHeight: 180 })
    .padding(8)
    .backgroundColor(QuizColors.surface)
    .border({ width: 1, color: QuizColors.outline, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  CompletionView() {
    Column({ space: 8 }) {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.onSurface)
        .lineHeight(24)
      Stack() {
        Text('Score: ' + this.score.toString() + '/' + this.questions.length.toString())
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.primary)
          .lineHeight(24)
      }
      .width('100%')
      .constraintSize({ minHeight: 120 })
      .backgroundColor(QuizColors.surfaceVariant)
      .borderRadius(12)
      .alignContent(Alignment.Center)

      Button('Restart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.onSecondary)
        .backgroundColor(QuizColors.secondary)
        .borderRadius(12)
        .height(44)
        .width('100%')
        .onClick(() => {
          this.restart();
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 8, right: 8, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ActiveQuizView() {
    Scroll() {
      Column({ space: 8 }) {
        this.QuestionCard()

        Row() {
          Column({ space: 2 }) {
            Text('Selected')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(QuizColors.onSurface)
              .lineHeight(14)
            Text(this.selectedOption >= 0 ? this.questions[this.currentIndex].options[this.selectedOption] : 'None')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(QuizColors.onSurface)
              .lineHeight(18)
          }
          this.AssistChip('Skip', false, () => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 24 })
    }
    .width('100%')
    .height('100%')
  }

  build() {
    Column() {
      Row({ space: 4 }) {
        Blank()
          .width(20)
          .height(20)
          .backgroundColor(QuizColors.primary)
          .borderRadius(6)
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onSurface)
          .lineHeight(30)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(QuizColors.surface)

      if (this.completed) {
        this.CompletionView()
      } else {
        this.ActiveQuizView()
      }

      Row() {
        Column({ space: 2 }) {
          Text('Progress')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(QuizColors.onSurface)
            .lineHeight(14)
          Progress({ value: this.progressValue(), total: 1, type: ProgressType.Linear })
            .width(140)
            .height(6)
            .color(QuizColors.primary)
            .backgroundColor(QuizColors.surfaceVariant)
        }
        Row({ space: 4 }) {
          this.AssistChip('Review', this.reviewSelected, () => {
            this.reviewSelected = !this.reviewSelected;
          })
          Button(this.actionText())
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(QuizColors.onPrimary)
            .backgroundColor(QuizColors.primary)
            .borderRadius(12)
            .width(140)
            .height(44)
            .onClick(() => {
              this.submitAnswer();
            })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(QuizColors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetX: 0, offsetY: -1 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
  }
}
