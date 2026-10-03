class QuizColors {
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

class QuizShapes {
  static readonly small: number = 6
  static readonly medium: number = 8
  static readonly large: number = 12
}

class QuizSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

@Component
struct AssistChip {
  label: string = ''
  @Prop isOn: boolean = false
  onTap: () => void = () => {
  }

  build() {
    Text(this.label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isOn ? QuizColors.onSecondary : QuizColors.onSurface)
      .padding({
        top: 10,
        bottom: 10,
        left: 14,
        right: 14
      })
      .backgroundColor(this.isOn ? QuizColors.secondary : QuizColors.surface)
      .borderRadius(QuizShapes.small)
      .border({
        width: 1,
        color: QuizColors.outline
      })
      .onClick(() => {
        this.onTap()
      })
  }
}

@Component
struct BottomBar {
  @State reviewed: boolean = false
  @State progress: number = 0.25
  private readonly progressWidth: number = 140

  build() {
    Column() {
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(QuizColors.outline)

      Row() {
        Column({ space: QuizSpacing.xs }) {
          Text('Progress')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(QuizColors.onSurface)

          Stack({ alignContent: Alignment.Start }) {
            Row()
              .width(this.progressWidth)
              .height(6)
              .backgroundColor(QuizColors.surfaceVariant)
              .borderRadius(3)

            Row()
              .width(Math.max(0, Math.min(1, this.progress)) * this.progressWidth)
              .height(6)
              .backgroundColor(QuizColors.primary)
              .borderRadius(3)

            Row()
              .width(6)
              .height(6)
              .backgroundColor(QuizColors.primary)
              .borderRadius(3)
              .margin({
                left: Math.max(0, Math.min(1, this.progress)) * this.progressWidth - 3
              })
          }
          .width(this.progressWidth)
          .height(6)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        AssistChip({
          label: 'Review',
          isOn: this.reviewed,
          onTap: () => {
            this.reviewed = !this.reviewed
          }
        })

        Text('Next')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onPrimary)
          .textAlign(TextAlign.Center)
          .width(140)
          .height(44)
          .backgroundColor(QuizColors.primary)
          .borderRadius(QuizShapes.large)
          .margin({
            left: QuizSpacing.xxl
          })
          .onClick(() => {
          })
      }
      .width('100%')
      .height(56)
      .padding({
        left: QuizSpacing.lg,
        right: QuizSpacing.lg,
        top: QuizSpacing.md,
        bottom: QuizSpacing.md
      })
      .backgroundColor('#A6FAFAFF')
    }
    .width('100%')
    .backgroundColor('#A6FAFAFF')
  }
}

@Entry
@Component
struct QuizRootView {
  @State selected: number = -1
  private readonly options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row({ space: QuizSpacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(QuizColors.primary)
            .borderRadius(QuizShapes.small)

          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(QuizColors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          top: 24,
          bottom: 16,
          left: QuizSpacing.lg,
          right: QuizSpacing.lg
        })

        Scroll() {
          Column({ space: QuizSpacing.lg }) {
            Column({ space: QuizSpacing.lg }) {
              Row() {
                Text('Question 1/4')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QuizColors.onSurface)
              }
              .width('100%')
              .height(120)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(QuizColors.surfaceVariant)
              .borderRadius(QuizShapes.medium)

              Text('Which planet is known as the Red Planet?')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizColors.onSurface)
                .width('100%')

              Column({ space: QuizSpacing.sm }) {
                ForEach(this.options, (option: string, index: number) => {
                  Text(option)
                    .fontSize(this.selected === index ? 14 : 12)
                    .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                    .fontColor(this.selected === index ? QuizColors.onPrimary : QuizColors.onSurface)
                    .padding({
                      top: 8,
                      bottom: 8,
                      left: 16,
                      right: 16
                    })
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
                      this.selected = index
                    })
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
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QuizColors.onSurface)

                Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QuizColors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

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
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(QuizColors.background)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
  }
}