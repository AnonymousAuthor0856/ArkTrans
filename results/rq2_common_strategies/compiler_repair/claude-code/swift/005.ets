// Quiz UI (SwiftUI -> ArkTS)
// Full-screen quiz interface with question card, options, and bottom progress bar.

// MARK: - Design Tokens
class QuizColors {
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

class QuizTypography {
  static readonly displaySize: number = 24;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 18;
  static readonly headlineWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 14;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 12;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 10;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

// MARK: - Assist Chip Component
@Component
struct AssistChip {
  label: string = '';
  isOn: boolean = false;
  onTap: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(QuizTypography.labelSize)
      .fontWeight(QuizTypography.labelWeight)
      .fontColor(this.isOn ? QuizColors.onSecondary : QuizColors.onSurface)
      .backgroundColor(this.isOn ? QuizColors.secondary : QuizColors.surface)
      .borderRadius(QuizShapes.small)
      .border({ width: 1, color: QuizColors.outline })
      .padding({ top: 10, bottom: 10, left: 14, right: 14 })
      .onClick(() => this.onTap())
  }
}

// MARK: - Bottom Bar Component
@Component
struct BottomBar {
  @State reviewed: boolean = false;
  @State progress: number = 0.25;

  build() {
    Row() {
      Column() {
        Text('Progress')
          .fontSize(QuizTypography.labelSize)
          .fontWeight(QuizTypography.labelWeight)
          .fontColor(QuizColors.onSurface)
          .margin({ bottom: QuizSpacing.xs })

        Stack() {
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(QuizColors.surfaceVariant)
            .borderRadius(3)

          Row()
            .width(this.progress * 100 + '%')
            .height(6)
            .backgroundColor(QuizColors.primary)
            .borderRadius(3)
            .alignSelf(ItemAlign.Start)

          Circle({ width: 6, height: 6 })
            .fill(QuizColors.primary)
            .width(6)
            .height(6)
            .margin({ left: this.progress * 140 - 3 })
            .alignSelf(ItemAlign.Start)
        }
        .width(140)
        .height(6)
        .alignContent(Alignment.Start)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      AssistChip({
        label: 'Review',
        isOn: this.reviewed,
        onTap: () => {
          this.reviewed = !this.reviewed;
        }
      })
        .margin({ right: QuizSpacing.lg })

      Button('Next')
        .fontSize(QuizTypography.titleSize)
        .fontWeight(QuizTypography.titleWeight)
        .fontColor(QuizColors.onPrimary)
        .backgroundColor(QuizColors.primary)
        .borderRadius(QuizShapes.large)
        .width(140)
        .height(44)
    }
    .width('100%')
    .padding({
      left: QuizSpacing.lg,
      right: QuizSpacing.lg,
      top: QuizSpacing.md,
      bottom: QuizSpacing.md
    })
    .backgroundColor(QuizColors.background)
    .opacity(0.65)
  }
}

// MARK: - Quiz Root View
@Entry
@Component
struct QuizRootView {
  @State selected: number = -1;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row()
          .width(20)
          .height(20)
          .backgroundColor(QuizColors.primary)
          .borderRadius(QuizShapes.small)
          .margin({ right: QuizSpacing.sm })

        Text('Quiz')
          .fontSize(QuizTypography.displaySize)
          .fontWeight(QuizTypography.displayWeight)
          .fontColor(QuizColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 24, bottom: 16, left: QuizSpacing.lg, right: QuizSpacing.lg })

      Scroll() {
        Column() {
          // Question Card
          Column() {
            // Question header placeholder
            Stack() {
              Row()
                .width('100%')
                .height(120)
                .backgroundColor(QuizColors.surfaceVariant)
                .borderRadius(QuizShapes.medium)

              Text('Question 1/4')
                .fontSize(QuizTypography.labelSize)
                .fontWeight(QuizTypography.labelWeight)
                .fontColor(QuizColors.onSurface)
            }
            .width('100%')

            Text('Which planet is known as the Red Planet?')
              .fontSize(QuizTypography.headlineSize)
              .fontWeight(QuizTypography.headlineWeight)
              .fontColor(QuizColors.onSurface)
              .margin({ top: QuizSpacing.lg })

            // Option buttons
            Column() {
              ForEach(this.options, (item: string, index: number) => {
                Button(item)
                  .fontSize(this.selected === index ? QuizTypography.titleSize : QuizTypography.bodySize)
                  .fontWeight(this.selected === index ? QuizTypography.titleWeight : QuizTypography.bodyWeight)
                  .fontColor(this.selected === index ? QuizColors.onPrimary : QuizColors.onSurface)
                  .backgroundColor(this.selected === index ? QuizColors.primary : QuizColors.surface)
                  .borderRadius(QuizShapes.medium)
                  .border({ width: 1, color: QuizColors.outline })
                  .width('100%')
                  .height(40)
                  .padding({ left: 16, right: 16 })
                  .margin({ top: 6, bottom: 6 })
                  .onClick(() => {
                    this.selected = index;
                  })
              }, (item: string, index: number) => item + index.toString())
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: QuizSpacing.sm })
          }
          .width('100%')
          .padding(QuizSpacing.lg)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(QuizColors.surface)
          .borderRadius(QuizShapes.large)
          .border({ width: 1, color: QuizColors.outline })
          .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
          .margin({ left: QuizSpacing.lg, right: QuizSpacing.lg })

          // Selected + Skip row
          Row() {
            Column() {
              Text('Selected')
                .fontSize(QuizTypography.labelSize)
                .fontWeight(QuizTypography.labelWeight)
                .fontColor(QuizColors.onSurface)
                .margin({ bottom: QuizSpacing.xs })

              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(QuizTypography.titleSize)
                .fontWeight(QuizTypography.titleWeight)
                .fontColor(QuizColors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            AssistChip({ label: 'Skip', isOn: false, onTap: () => {} })
          }
          .width('100%')
          .margin({ top: QuizSpacing.lg, left: QuizSpacing.lg, right: QuizSpacing.lg })
        }
        .width('100%')
        .padding({ top: QuizSpacing.md, bottom: 120 })
      }
      .width('100%')
      .layoutWeight(1)

      Divider()
        .color(QuizColors.outline)
        .strokeWidth(1)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
  }
}
