// Index.ets  (src/main/ets/pages/Index.ets)
interface QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;
}

const C_PRIMARY: string = '#7C3AED';
const C_SECONDARY: string = '#22C55E';
const C_TERTIARY: string = '#F97316';
const C_BACKGROUND: string = '#FAFAFF';
const C_SURFACE: string = '#FFFFFF';
const C_SURFACE_VARIANT: string = '#F1F5F9';
const C_OUTLINE: string = '#E2E8F0';
const C_ERROR: string = '#EF4444';
const C_ON_PRIMARY: string = '#FFFFFF';
const C_ON_SECONDARY: string = '#0F172A';
const C_ON_SURFACE: string = '#0B1220';

@Entry
@Component
struct Index {
  @State index: number = 0;
  @State selected: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State review: boolean = false;

  private questions: QuestionUi[] = [
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
  ];

  private handleNext(): void {
    if (this.completed) {
      return;
    }
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

  private handleRestart(): void {
    this.index = 0;
    this.selected = -1;
    this.score = 0;
    this.completed = false;
  }

  @Builder
  TopBar() {
    Row({ space: 4 }) {
      Text('')
        .width(20)
        .height(20)
        .backgroundColor(C_PRIMARY)
        .borderRadius(6)

      Text('Quiz')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_SURFACE)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuestionCard() {
    Column({ space: 6 }) {
      Stack() {
        Text(`Question ${this.index + 1}/${this.questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(C_SURFACE_VARIANT)
      .borderRadius(8)

      Text(this.questions[this.index].title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_SURFACE)
        .width('100%')
        .textAlign(TextAlign.Start)

      Column({ space: 4 }) {
        ForEach(this.questions[this.index].options, (opt: string, i: number) => {
          Row() {
            Text(opt)
              .fontSize(this.selected === i ? 14 : 12)
              .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
              .fontColor(this.selected === i ? C_ON_PRIMARY : C_ON_SURFACE)
          }
          .padding({ left: 14, right: 14, top: 9, bottom: 9 })
          .backgroundColor(this.selected === i ? C_PRIMARY : C_SURFACE)
          .borderRadius(8)
          .border({ width: 1, color: this.selected === i ? C_PRIMARY : C_OUTLINE })
          .onClick(() => {
            this.selected = i;
          })
        }, (opt: string, i: number) => `option_${i}_${this.selected}`)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(8)
    .backgroundColor(C_SURFACE)
    .borderRadius(12)
    .border({ width: 1, color: C_OUTLINE })
    .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SelectedRow() {
    Row() {
      Column({ space: 2 }) {
        Text('Selected')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)

        Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : 'None')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text('Skip')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)
      }
      .padding({ left: 14, right: 14, top: 6, bottom: 6 })
      .backgroundColor(C_SURFACE)
      .borderRadius(6)
      .border({ width: 1, color: C_OUTLINE })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  QuizList() {
    List({ space: 8 }) {
      ListItem() {
        this.QuestionCard()
      }

      ListItem() {
        this.SelectedRow()
      }
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .scrollBar(BarState.Off)
  }

  @Builder
  ResultView() {
    Column({ space: 8 }) {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_SURFACE)

      Stack() {
        Text(`Score: ${this.score}/${this.questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(C_PRIMARY)
      }
      .width('100%')
      .constraintSize({ minHeight: 120 })
      .backgroundColor(C_SURFACE_VARIANT)
      .borderRadius(12)

      Button() {
        Text('Restart')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SECONDARY)
      }
      .width('100%')
      .height(44)
      .backgroundColor(C_SECONDARY)
      .borderRadius(12)
      .onClick(() => {
        this.handleRestart();
      })
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: 8, right: 8, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_SURFACE)

        Progress({
          value: this.completed
            ? 100
            : (this.index + (this.selected >= 0 ? 1 : 0)) * 100 / this.questions.length,
          total: 100,
          type: ProgressType.Linear
        })
          .width(140)
          .height(6)
          .color(C_PRIMARY)
          .backgroundColor(C_SURFACE_VARIANT)
          .style({ strokeWidth: 6 })
      }
      .alignItems(HorizontalAlign.Start)

      Row({ space: 4 }) {
        Row() {
          Text('Review')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.review ? C_ON_SECONDARY : C_ON_SURFACE)
        }
        .padding({ left: 14, right: 14, top: 6, bottom: 6 })
        .backgroundColor(this.review ? C_SECONDARY : C_SURFACE)
        .borderRadius(6)
        .border({ width: 1, color: C_OUTLINE })
        .onClick(() => {
          this.review = !this.review;
        })

        Button() {
          Text(this.index < this.questions.length - 1
            ? 'Next'
            : (this.completed ? 'Done' : 'Finish'))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_ON_PRIMARY)
        }
        .width(140)
        .height(44)
        .backgroundColor(C_PRIMARY)
        .borderRadius(12)
        .onClick(() => {
          this.handleNext();
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(C_SURFACE)
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -1 })
  }

  build() {
    Column() {
      this.TopBar()

      if (this.completed) {
        this.ResultView()
      } else {
        this.QuizList()
      }

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
    .alignItems(HorizontalAlign.Center)
  }
}