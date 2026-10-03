import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

class QuizColors {
  static readonly primary: ResourceColor = '#7C3AED';
  static readonly secondary: ResourceColor = '#22C55E';
  static readonly tertiary: ResourceColor = '#F97316';
  static readonly background: ResourceColor = '#FAFAFF';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#F1F5F9';
  static readonly outline: ResourceColor = '#E2E8F0';
  static readonly success: ResourceColor = '#16A34A';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#EF4444';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#0F172A';
  static readonly onTertiary: ResourceColor = '#111827';
  static readonly onBackground: ResourceColor = '#0B1220';
  static readonly onSurface: ResourceColor = '#0B1220';
}

class QuizShapes {
  static readonly small: number = 6;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class QuizSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

@Entry
@Component
struct QuizRootView {
  @State private selected: number = -1;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this), (err: BusinessError, win: window.Window) => {
      if (err.code) {
        return;
      }
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    });
  }

  @Builder
  private OptionItem(option: string, index: number) {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Text(option)
        .fontSize(this.selected === index ? 14 : 12)
        .fontWeight(this.selected === index ? 500 : 400)
        .fontColor(this.selected === index ? QuizColors.onPrimary : QuizColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({
          top: 8,
          bottom: 8,
          left: 16,
          right: 16
        })
    }
    .width('100%')
    .backgroundColor(this.selected === index ? QuizColors.primary : QuizColors.surface)
    .borderRadius(QuizShapes.medium)
    .border({
      width: 1,
      color: QuizColors.outline
    })
    .margin({
      top: 6,
      bottom: 6
    })
    .onClick(() => {
      this.selected = index;
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row({ space: QuizSpacing.sm }) {
          Blank()
            .width(20)
            .height(20)
            .backgroundColor(QuizColors.primary)
            .borderRadius(QuizShapes.small)

          Text('Quiz')
            .fontSize(24)
            .fontWeight(600)
            .fontColor(QuizColors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .padding({
          top: 24,
          bottom: 16,
          left: QuizSpacing.lg,
          right: QuizSpacing.lg
        })

        Scroll() {
          Column({ space: QuizSpacing.lg }) {
            Column({ space: QuizSpacing.lg }) {
              Stack({ alignContent: Alignment.Center }) {
                Text('Question 1/4')
                  .fontSize(10)
                  .fontWeight(500)
                  .fontColor(QuizColors.onSurface)
              }
              .width('100%')
              .height(120)
              .backgroundColor(QuizColors.surfaceVariant)
              .borderRadius(QuizShapes.medium)

              Text('Which planet is known as the Red Planet?')
                .fontSize(18)
                .fontWeight(600)
                .fontColor(QuizColors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              Column({ space: QuizSpacing.sm }) {
                ForEach(this.options, (option: string, index: number) => {
                  this.OptionItem(option, index);
                }, (option: string) => option)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(QuizSpacing.lg)
            .backgroundColor(QuizColors.surface)
            .borderRadius(QuizShapes.large)
            .border({
              width: 1,
              color: QuizColors.outline
            })
            .shadow({
              radius: 3,
              color: '#14000000',
              offsetX: 0,
              offsetY: 1
            })
            .margin({
              left: QuizSpacing.lg,
              right: QuizSpacing.lg
            })

            Row() {
              Column({ space: QuizSpacing.xs }) {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(500)
                  .fontColor(QuizColors.onSurface)

                Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(500)
                  .fontColor(QuizColors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()
                .layoutWeight(1)

              AssistChip({
                label: 'Skip',
                isOn: false,
                onTap: () => {
                }
              })
            }
            .width('100%')
            .padding({
              left: QuizSpacing.lg,
              right: QuizSpacing.lg
            })
          }
          .width('100%')
          .padding({
            top: QuizSpacing.md,
            bottom: 120
          })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        Divider()
          .color(QuizColors.outline)

        BottomBar()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
  }
}

@Component
struct BottomBar {
  @State private reviewed: boolean = false;
  @State private progress: number = 0.25;

  private progressWidth(): number {
    return Math.max(0, Math.min(1, this.progress)) * 140;
  }

  build() {
    Row() {
      Column({ space: QuizSpacing.xs }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(500)
          .fontColor(QuizColors.onSurface)

        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width(140)
            .height(6)
            .backgroundColor(QuizColors.surfaceVariant)
            .borderRadius(3)

          Blank()
            .width(this.progressWidth())
            .height(6)
            .backgroundColor(QuizColors.primary)
            .borderRadius(3)

          Blank()
            .width(6)
            .height(6)
            .backgroundColor(QuizColors.primary)
            .borderRadius(3)
            .translate({
              x: this.progressWidth() - 3,
              y: 0
            })
        }
        .width(140)
        .height(6)
      }
      .width(140)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      AssistChip({
        label: 'Review',
        isOn: this.reviewed,
        onTap: () => {
          this.reviewed = !this.reviewed;
        }
      })

      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('Next')
          .fontSize(14)
          .fontWeight(500)
          .fontColor(QuizColors.onPrimary)
      }
      .width(140)
      .height(44)
      .backgroundColor(QuizColors.primary)
      .borderRadius(QuizShapes.large)
      .margin({
        left: QuizSpacing.lg
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .padding({
      left: QuizSpacing.lg,
      right: QuizSpacing.lg,
      top: QuizSpacing.md,
      bottom: QuizSpacing.md
    })
    .backgroundColor('#A6FAFAFF')
  }
}

@Component
struct AssistChip {
  label: string = '';
  isOn: boolean = false;
  onTap: () => void = () => {
  };

  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Text(this.label)
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.isOn ? QuizColors.onSecondary : QuizColors.onSurface)
        .padding({
          top: 10,
          bottom: 10,
          left: 14,
          right: 14
        })
    }
    .backgroundColor(this.isOn ? QuizColors.secondary : QuizColors.surface)
    .borderRadius(QuizShapes.small)
    .border({
      width: 1,
      color: QuizColors.outline
    })
    .onClick(() => {
      this.onTap();
    })
  }
}