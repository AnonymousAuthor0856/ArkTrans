// Education Quiz - Playful Pastel theme
// Converted from Kotlin Compose to ArkTS

import prompt from '@ohos.promptAction';

@Observed
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

@Observed
class QuizViewModel {
  questions: QuestionUi[] = [
    new QuestionUi(1, 'Which planet is known as the Red Planet?',
      ['Earth', 'Mars', 'Venus', 'Jupiter'], 1),
    new QuestionUi(2, 'What is the chemical symbol for water?',
      ['H2O', 'CO2', 'NaCl', 'O2'], 0),
    new QuestionUi(3, 'Who wrote Hamlet?',
      ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], 2),
    new QuestionUi(4, 'What is the largest mammal?',
      ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], 1)
  ];
  index: number = 0;
  selected: number = -1;
  score: number = 0;
  completed: boolean = false;
  reviewFlag: boolean = false;
}

// App design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#7C3AED';
    export const secondary: string = '#22C55E';
    export const tertiary: string = '#F97316';
    export const background: string = '#FAFAFF';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F1F5F9';
    export const outline: string = '#E2E8F0';
    export const success: string = '#16A34A';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#0F172A';
    export const onTertiary: string = '#111827';
    export const onBackground: string = '#0B1220';
    export const onSurface: string = '#0B1220';
  }

  export namespace Spacing {
    export const xs: Length = 2;
    export const sm: Length = 4;
    export const md: Length = 6;
    export const lg: Length = 8;
    export const xl: Length = 12;
    export const xxl: Length = 16;
    export const xxxl: Length = 24;
  }

  export namespace Shapes {
    export const small: Length = 6;
    export const medium: Length = 8;
    export const large: Length = 12;
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Row() {
        Row()
          .width(20)
          .height(20)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small);

        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: AppTokens.Spacing.sm });
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppTokens.Colors.surface);
  }
}

@Component
struct OptionChip {
  text: string = '';
  selected: boolean = false;
  onSelect: () => void = () => {};

  build() {
    Text(this.text)
      .fontSize(this.selected ? 14 : 12)
      .fontWeight(this.selected ? FontWeight.Medium : FontWeight.Normal)
      .fontColor(this.selected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.xxl, right: AppTokens.Spacing.xxl,
        top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })
      .backgroundColor(this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .border({
        width: 1,
        color: AppTokens.Colors.outline
      })
      .onClick(() => {
        this.onSelect();
      });
  }
}

@Component
struct AssistChipView {
  label: string = '';
  active: boolean = false;
  activeBgColor: string = AppTokens.Colors.surface;
  activeTextColor: string = AppTokens.Colors.onSurface;
  handleClick: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.active ? this.activeTextColor : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl,
        top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(this.active ? this.activeBgColor : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({
        width: 1,
        color: AppTokens.Colors.outline
      })
      .onClick(() => {
        this.handleClick();
      });
  }
}

@Component
struct QuestionCard {
  @ObjectLink vm: QuizViewModel;

  build() {
    Column() {
      Stack() {
        Text(`Question ${this.vm.index + 1}/${this.vm.questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface);
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium);

      Text(this.vm.questions[this.vm.index].title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })
        .width('100%');

      Column() {
        ForEach(this.vm.questions[this.vm.index].options, (option: string, idx: number) => {
          OptionChip({
            text: option,
            selected: this.vm.selected === idx,
            onSelect: () => {
              this.vm.selected = idx;
            }
          });
        }, (option: string, idx: number) => option + idx);
      }
      .margin({ top: AppTokens.Spacing.md })
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline
    })
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.14)',
      offsetY: 1
    });
  }
}

@Component
struct BottomBar {
  @ObjectLink vm: QuizViewModel;
  onNext: () => void = () => {};
  onToggleReview: () => void = () => {};

  build() {
    Row() {
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface);

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width(140)
            .height(6)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(3);
          Row()
            .width(this.getProgressWidth())
            .height(6)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(3);
        }
        .margin({ top: AppTokens.Spacing.xs });
      }
      .alignItems(HorizontalAlign.Start);

      Row() {
        AssistChipView({
          label: 'Review',
          active: this.vm.reviewFlag,
          activeBgColor: AppTokens.Colors.secondary,
          activeTextColor: AppTokens.Colors.onSecondary,
          handleClick: () => {
            this.vm.reviewFlag = !this.vm.reviewFlag;
            this.onToggleReview();
          }
        });

        Button(this.getButtonLabel())
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .height(44)
          .width(140)
          .onClick(() => {
            this.onNext();
          });
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: 6,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetY: 1.5
    });
  }

  getProgressWidth(): number {
    const total = this.vm.questions.length;
    const current = this.vm.completed ? total :
      (this.vm.index + (this.vm.selected >= 0 ? 1 : 0));
    return 140 * (current / total);
  }

  getButtonLabel(): string {
    if (this.vm.index < this.vm.questions.length - 1) {
      return 'Next';
    } else if (!this.vm.completed) {
      return 'Finish';
    }
    return 'Done';
  }
}

@Component
struct CompletedScreen {
  @ObjectLink vm: QuizViewModel;
  onRestart: () => void = () => {};

  build() {
    Column() {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface);

      Stack() {
        Text(`Score: ${this.vm.score}/${this.vm.questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary);
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.large)
      .margin({ top: AppTokens.Spacing.lg });

      Button('Restart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.large)
        .height(44)
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })
        .onClick(() => {
          this.onRestart();
        });
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
      top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center);
  }
}

@Component
struct QuizScreen {
  @State vm: QuizViewModel = new QuizViewModel();

  build() {
    Column() {
      TopBar();

      if (this.vm.completed) {
        CompletedScreen({
          vm: this.vm,
          onRestart: () => {
            this.vm.index = 0;
            this.vm.selected = -1;
            this.vm.score = 0;
            this.vm.completed = false;
            this.vm.reviewFlag = false;
          }
        })
        .layoutWeight(1);
      } else {
        Scroll() {
          Column() {
            QuestionCard({ vm: this.vm });

            Row() {
              Column() {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface);

                Text(this.vm.selected >= 0 ?
                  this.vm.questions[this.vm.index].options[this.vm.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs });
              }
              .alignItems(HorizontalAlign.Start);

              AssistChipView({
                label: 'Skip',
                active: false,
                activeBgColor: AppTokens.Colors.surface,
                activeTextColor: AppTokens.Colors.onSurface,
                handleClick: () => {
                  if (this.vm.index < this.vm.questions.length - 1) {
                    this.vm.index += 1;
                    this.vm.selected = -1;
                  } else {
                    this.vm.completed = true;
                  }
                }
              });
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ top: AppTokens.Spacing.lg });
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off);
      }

      BottomBar({
        vm: this.vm,
        onNext: () => {
          if (!this.vm.completed) {
            if (this.vm.selected === this.vm.questions[this.vm.index].answer) {
              this.vm.score += 1;
            }
            if (this.vm.index < this.vm.questions.length - 1) {
              this.vm.index += 1;
              this.vm.selected = -1;
            } else {
              this.vm.completed = true;
            }
          }
        },
        onToggleReview: () => {
        }
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}

@Entry
@Component
struct Index {
  build() {
    Column() {
      QuizScreen();
    }
    .width('100%')
    .height('100%');
  }
}
