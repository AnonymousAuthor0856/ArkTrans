const NAME: string = '008_EducationQuiz_en';
const UI_TYPE: string = 'Education Quiz';
const STYLE_THEME: string = 'Playful Pastel';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

class AppColors {
  static readonly primary: string = '#7C3AED';
  static readonly secondary: string = '#22C55E';
  static readonly tertiary: string = '#F97316';
  static readonly background: string = '#FAFAFF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#0B1220';
  static readonly onSurface: string = '#0B1220';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

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

@Entry
@Component
struct MainActivity {
  @State index: number = 0;
  @State selected: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State flags: string[] = [];
  private questions: QuestionUi[] = [
    new QuestionUi(1, 'Which planet is known as the Red Planet?', ['Earth', 'Mars', 'Venus', 'Jupiter'], 1),
    new QuestionUi(2, 'What is the chemical symbol for water?', ['H2O', 'CO2', 'NaCl', 'O2'], 0),
    new QuestionUi(3, 'Who wrote Hamlet?', ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], 2),
    new QuestionUi(4, 'What is the largest mammal?', ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], 1)
  ];

  toggleFlag(label: string): void {
    if (this.flags.includes(label)) {
      this.flags = this.flags.filter((item: string) => item !== label);
    } else {
      this.flags = [...this.flags, label];
    }
  }

  progressValue(): number {
    if (this.completed) {
      return 100;
    }
    return ((this.index + (this.selected >= 0 ? 1 : 0)) / this.questions.length) * 100;
  }

  nextQuestion(): void {
    if (this.completed) {
      return;
    }
    if (this.selected === this.questions[this.index].answer) {
      this.score += 1;
    }
    if (this.index < this.questions.length - 1) {
      this.index += 1;
      this.selected = -1;
    } else {
      this.completed = true;
    }
  }

  restart(): void {
    this.index = 0;
    this.selected = -1;
    this.score = 0;
    this.completed = false;
  }

  @Builder
  Header(): void {
    Row({ space: AppSpacing.sm }) {
      Rect().width(20).height(20).fill(AppColors.primary).radius(6);
      Text('Quiz')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface);
  }

  @Builder
  OptionChip(option: string, optionIndex: number): void {
    Button(option)
      .fontSize(this.selected === optionIndex ? 14 : 12)
      .fontWeight(this.selected === optionIndex ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selected === optionIndex ? AppColors.onPrimary : AppColors.onSurface)
      .backgroundColor(this.selected === optionIndex ? AppColors.primary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(8)
      .height(36)
      .padding({ left: 10, right: 10 })
      .onClick(() => {
        this.selected = optionIndex;
      });
  }

  @Builder
  QuestionCard(): void {
    Column({ space: AppSpacing.md }) {
      Stack() {
        Text(`Question ${this.index + 1}/${this.questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(8)
      .alignContent(Alignment.Center);

      Text(this.questions[this.index].title)
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);

      Column({ space: AppSpacing.sm }) {
        ForEach(this.questions[this.index].options, (option: string, optionIndex: number) => {
          this.OptionChip(option, optionIndex);
        }, (option: string) => option)
      }
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .constraintSize({ minHeight: 180 })
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  SelectedSummary(): void {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Selected')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : 'None')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Button('Skip')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline })
        .borderRadius(6)
        .height(32);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  CompletionView(): void {
    Column() {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      Blank().height(AppSpacing.lg);
      Stack() {
        Text(`Score: ${this.score}/${this.questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.primary);
      }
      .width('100%')
      .constraintSize({ minHeight: 120 })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(12)
      .alignContent(Alignment.Center);
      Blank().height(AppSpacing.lg);
      Button('Restart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .borderRadius(12)
        .width('100%')
        .height(44)
        .onClick(() => {
          this.restart();
        });
    }
    .width('100%')
    .height('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.xl, bottom: AppSpacing.xl })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  BottomBar(): void {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
          .width(140)
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant);
      }
      .alignItems(HorizontalAlign.Start);
      Blank();
      Row({ space: AppSpacing.sm }) {
        Button('Review')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.flags.includes('Review') ? AppColors.onSecondary : AppColors.onSurface)
          .backgroundColor(this.flags.includes('Review') ? AppColors.secondary : AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(6)
          .height(32)
          .onClick(() => {
            this.toggleFlag('Review');
          });
        Button(this.index < this.questions.length - 1 ? 'Next' : (!this.completed ? 'Finish' : 'Done'))
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(12)
          .width(140)
          .height(44)
          .onClick(() => {
            this.nextQuestion();
          });
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      this.Header();
      if (this.completed) {
        this.CompletionView();
      } else {
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            this.QuestionCard();
            this.SelectedSummary();
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.xxxl });
        }
        .layoutWeight(1);
      }
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
