const PRIMARY: string = '#7C3AED';
const SECONDARY: string = '#22C55E';
const TERTIARY: string = '#F97316';
const BACKGROUND: string = '#FAFAFF';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#F1F5F9';
const OUTLINE: string = '#E2E8F0';
const ON_PRIMARY: string = '#FFFFFF';
const ON_SECONDARY: string = '#0F172A';
const ON_SURFACE: string = '#0B1220';

interface QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;
}

@Entry
@Component
struct EducationQuizPage {
  @State index: number = 0;
  @State selected: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State reviewFlag: boolean = false;
  private questions: QuestionUi[] = [
    { id: 1, title: 'Which planet is known as the Red Planet?', options: ['Earth', 'Mars', 'Venus', 'Jupiter'], answer: 1 },
    { id: 2, title: 'What is the chemical symbol for water?', options: ['H2O', 'CO2', 'NaCl', 'O2'], answer: 0 },
    { id: 3, title: 'Who wrote Hamlet?', options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], answer: 2 },
    { id: 4, title: 'What is the largest mammal?', options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], answer: 1 }
  ];

  getProgress(): number {
    if (this.completed) {
      return 1;
    }
    const current: number = this.index + (this.selected >= 0 ? 1 : 0);
    return current / this.questions.length;
  }

  getButtonLabel(): string {
    if (this.index < this.questions.length - 1) {
      return 'Next';
    }
    if (!this.completed) {
      return 'Finish';
    }
    return 'Done';
  }

  getSelectedLabel(): string {
    if (this.selected >= 0) {
      return this.questions[this.index].options[this.selected];
    }
    return 'None';
  }

  onNext(): void {
    if (!this.completed) {
      if (this.selected === this.questions[this.index].answer) {
        this.score = this.score + 1;
      }
      if (this.index < this.questions.length - 1) {
        this.index = this.index + 1;
        this.selected = -1;
      } else {
        this.completed = true;
      }
    }
  }

  onRestart(): void {
    this.index = 0;
    this.selected = -1;
    this.score = 0;
    this.completed = false;
    this.reviewFlag = false;
  }

  build() {
    Column() {
      Row() {
        Row({ space: 4 }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(PRIMARY)
            .borderRadius(6)
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(SURFACE)

      if (this.completed) {
        Column() {
          Text('Quiz Completed')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)
          Column().height(8)
          Row() {
            Text('Score: ' + this.score + '/' + this.questions.length)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(PRIMARY)
          }
          .width('100%')
          .height(120)
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          Column().height(8)
          Button('Restart', { type: ButtonType.Normal })
            .width('100%')
            .height(44)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SECONDARY)
            .backgroundColor(SECONDARY)
            .borderRadius(12)
            .onClick(() => { this.onRestart(); })
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: 8, right: 8, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Scroll() {
          Column({ space: 8 }) {
            Column({ space: 6 }) {
              Row() {
                Text('Question ' + (this.index + 1) + '/' + this.questions.length)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor(SURFACE_VARIANT)
              .borderRadius(8)
              .justifyContent(FlexAlign.Center)

              Text(this.questions[this.index].title)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(ON_SURFACE)

              Column({ space: 4 }) {
                ForEach(this.questions[this.index].options, (option: string, i: number) => {
                  Row() {
                    Text(option)
                      .fontSize(this.selected === i ? 14 : 12)
                      .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
                      .fontColor(this.selected === i ? ON_PRIMARY : ON_SURFACE)
                  }
                  .width('100%')
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .backgroundColor(this.selected === i ? PRIMARY : SURFACE)
                  .border({ width: 1, color: OUTLINE })
                  .borderRadius(8)
                  .onClick(() => { this.selected = i; })
                }, (option: string, i: number) => option + '_' + i)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(8)
            .backgroundColor(SURFACE)
            .borderRadius(12)
            .border({ width: 1, color: OUTLINE })
            .constraintSize({ minHeight: 180 })
            .alignItems(HorizontalAlign.Start)

            Row() {
              Column({ space: 2 }) {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text(this.getSelectedLabel())
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
              }
              .alignItems(HorizontalAlign.Start)

              Row() {
                Text('Skip')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
              }
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor(SURFACE)
              .border({ width: 1, color: OUTLINE })
              .borderRadius(6)
              .onClick(() => {})
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 24 })
        }
        .layoutWeight(1)
        .width('100%')
      }

      Divider()
        .color(OUTLINE)
        .strokeWidth(1)

      Row() {
        Column({ space: 2 }) {
          Text('Progress')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)
          Progress({ value: this.getProgress(), total: 1, type: ProgressType.Linear })
            .width(140)
            .height(6)
            .color(PRIMARY)
            .backgroundColor(SURFACE_VARIANT)
        }
        .alignItems(HorizontalAlign.Start)

        Row({ space: 4 }) {
          Row() {
            Text('Review')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.reviewFlag ? ON_SECONDARY : ON_SURFACE)
          }
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(this.reviewFlag ? SECONDARY : SURFACE)
          .border({ width: 1, color: OUTLINE })
          .borderRadius(6)
          .onClick(() => { this.reviewFlag = !this.reviewFlag; })

          Button(this.getButtonLabel(), { type: ButtonType.Normal })
            .width(140)
            .height(44)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_PRIMARY)
            .backgroundColor(PRIMARY)
            .borderRadius(12)
            .onClick(() => { this.onNext(); })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor(SURFACE)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
