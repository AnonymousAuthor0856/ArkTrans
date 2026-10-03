// Quiz UI (SwiftUI -> ArkTS)
// Full-screen quiz interface with question card, options, and bottom progress bar.

// MARK: - Design Tokens
class QuizTokens {
  static class Colors {
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
  static class Shapes {
    static readonly small: number = 6;
    static readonly medium: number = 8;
    static readonly large: number = 12;
  }
  static class Spacing {
    static readonly xs: number = 2;
    static readonly sm: number = 4;
    static readonly md: number = 6;
    static readonly lg: number = 8;
    static readonly xl: number = 12;
    static readonly xxl: number = 16;
    static readonly xxxl: number = 24;
  }
  static class Typography {
    static readonly displaySize: number = 24;
    static readonly displayWeight: FontWeight = FontWeight.SemiBold;
    static readonly headlineSize: number = 18;
    static readonly headlineWeight: FontWeight = FontWeight.SemiBold;
    static readonly titleSize: number = 14;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 12;
    static readonly bodyWeight: FontWeight = FontWeight.Regular;
    static readonly labelSize: number = 10;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  }
}

// MARK: - Assist Chip Component
@Component
struct AssistChip {
  label: string = '';
  isOn: boolean = false;
  onTap: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(QuizTokens.Typography.labelSize)
      .fontWeight(QuizTokens.Typography.labelWeight)
      .fontColor(this.isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
      .backgroundColor(this.isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
      .borderRadius(QuizTokens.Shapes.small)
      .border({ width: 1, color: QuizTokens.Colors.outline })
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
          .fontSize(QuizTokens.Typography.labelSize)
          .fontWeight(QuizTokens.Typography.labelWeight)
          .fontColor(QuizTokens.Colors.onSurface)
          .margin({ bottom: QuizTokens.Spacing.xs })

        Stack() {
          // Background track
          Row()
            .width('100%')
            .height(6)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
            .borderRadius(3)

          // Progress fill
          Row()
            .width(this.progress * 100 + '%')
            .height(6)
            .backgroundColor(QuizTokens.Colors.primary)
            .borderRadius(3)
            .alignSelf(ItemAlign.Start)

          // Dot marker at end of progress
          Circle({ width: 6, height: 6 })
            .fill(QuizTokens.Colors.primary)
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

      AssistChip({ label: 'Review', isOn: this.reviewed, onTap: () => { this.reviewed = !this.reviewed; } })
        .margin({ right: QuizTokens.Spacing.lg })

      Button('Next')
        .fontSize(QuizTokens.Typography.titleSize)
        .fontWeight(QuizTokens.Typography.titleWeight)
        .fontColor(QuizTokens.Colors.onPrimary)
        .backgroundColor(QuizTokens.Colors.primary)
        .borderRadius(QuizTokens.Shapes.large)
        .width(140)
        .height(44)
    }
    .width('100%')
    .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg, top: QuizTokens.Spacing.md, bottom: QuizTokens.Spacing.md })
    .backgroundColor(QuizTokens.Colors.background)
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
          .backgroundColor(QuizTokens.Colors.primary)
          .borderRadius(QuizTokens.Shapes.small)
          .margin({ right: QuizTokens.Spacing.sm })

        Text('Quiz')
          .fontSize(QuizTokens.Typography.displaySize)
          .fontWeight(QuizTokens.Typography.displayWeight)
          .fontColor(QuizTokens.Colors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 24, bottom: 16, left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

      Scroll() {
        Column() {
          // Question Card
          Column() {
            // Question header placeholder
            Stack() {
              Row()
                .width('100%')
                .height(120)
                .backgroundColor(QuizTokens.Colors.surfaceVariant)
                .borderRadius(QuizTokens.Shapes.medium)

              Text('Question 1/4')
                .fontSize(QuizTokens.Typography.labelSize)
                .fontWeight(QuizTokens.Typography.labelWeight)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .width('100%')

            Text('Which planet is known as the Red Planet?')
              .fontSize(QuizTokens.Typography.headlineSize)
              .fontWeight(QuizTokens.Typography.headlineWeight)
              .fontColor(QuizTokens.Colors.onSurface)
              .margin({ top: QuizTokens.Spacing.lg })

            // Option buttons
            Column() {
              ForEach(this.options, (item: string, index: number) => {
                Button(item)
                  .fontSize(this.selected === index ? QuizTokens.Typography.titleSize : QuizTokens.Typography.bodySize)
                  .fontWeight(this.selected === index ? QuizTokens.Typography.titleWeight : QuizTokens.Typography.bodyWeight)
                  .fontColor(this.selected === index ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
                  .backgroundColor(this.selected === index ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
                  .borderRadius(QuizTokens.Shapes.medium)
                  .border({ width: 1, color: QuizTokens.Colors.outline })
                  .width('100%')
                  .height(40)
                  .padding({ left: 16, right: 16 })
                  .margin({ top: 6, bottom: 6 })
                  .onClick(() => { this.selected = index; })
              }, (item: string, index: number) => item + index.toString())
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: QuizTokens.Spacing.sm })
          }
          .width('100%')
          .padding(QuizTokens.Spacing.lg)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(QuizTokens.Colors.surface)
          .borderRadius(QuizTokens.Shapes.large)
          .border({ width: 1, color: QuizTokens.Colors.outline })
          .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
          .margin({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

          // Selected + Skip row
          Row() {
            Column() {
              Text('Selected')
                .fontSize(QuizTokens.Typography.labelSize)
                .fontWeight(QuizTokens.Typography.labelWeight)
                .fontColor(QuizTokens.Colors.onSurface)
                .margin({ bottom: QuizTokens.Spacing.xs })

              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(QuizTokens.Typography.titleSize)
                .fontWeight(QuizTokens.Typography.titleWeight)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            AssistChip({ label: 'Skip', isOn: false, onTap: () => {} })
          }
          .width('100%')
          .margin({ top: QuizTokens.Spacing.lg, left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })
        }
        .width('100%')
        .padding({ top: QuizTokens.Spacing.md, bottom: 120 })
      }
      .width('100%')
      .layoutWeight(1)

      Divider()
        .color(QuizTokens.Colors.outline)
        .strokeWidth(1)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }
}
