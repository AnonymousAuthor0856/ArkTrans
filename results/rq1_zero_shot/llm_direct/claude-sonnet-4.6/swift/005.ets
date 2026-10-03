import { router } from '@kit.ArkUI';

// Design Tokens
namespace QuizTokens {
  export namespace Colors {
    export const primary = '#7C3AED';
    export const secondary = '#22C55E';
    export const tertiary = '#F97316';
    export const background = '#FAFAFF';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#F1F5F9';
    export const outline = '#E2E8F0';
    export const success = '#16A34A';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#0F172A';
    export const onTertiary = '#111827';
    export const onBackground = '#0B1220';
    export const onSurface = '#0B1220';
  }

  export namespace Shapes {
    export const small = 6;
    export const medium = 8;
    export const large = 12;
  }

  export namespace Spacing {
    export const xs = 2;
    export const sm = 4;
    export const md = 6;
    export const lg = 8;
    export const xl = 12;
    export const xxl = 16;
    export const xxxl = 24;
  }

  export namespace Typography {
    export const displaySize = 24;
    export const displayWeight = FontWeight.SemiBold;
    export const headlineSize = 18;
    export const headlineWeight = FontWeight.SemiBold;
    export const titleSize = 14;
    export const titleWeight = FontWeight.Medium;
    export const bodySize = 12;
    export const bodyWeight = FontWeight.Normal;
    export const labelSize = 10;
    export const labelWeight = FontWeight.Medium;
  }
}

// Assist Chip Component
@Component
struct AssistChip {
  label: string = '';
  isOn: boolean = false;
  onTap: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(QuizTokens.Typography.labelSize)
      .fontWeight(QuizTokens.Typography.labelWeight)
      .fontColor(this.isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
      .padding({ top: 10, bottom: 10, left: 14, right: 14 })
      .backgroundColor(this.isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
      .border({ width: 1, color: QuizTokens.Colors.outline, radius: QuizTokens.Shapes.small })
      .borderRadius(QuizTokens.Shapes.small)
      .onClick(() => {
        this.onTap();
      })
  }
}

// Bottom Bar Component
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

        Stack({ alignContent: Alignment.Start }) {
          // Background track
          Row()
            .width(140)
            .height(6)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
            .borderRadius(3)

          // Progress fill
          Row()
            .width(Math.max(0, Math.min(1, this.progress)) * 140)
            .height(6)
            .backgroundColor(QuizTokens.Colors.primary)
            .borderRadius(3)

          // Dot marker
          Row()
            .width(6)
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.primary)
            .margin({ left: Math.max(0, Math.min(1, this.progress)) * 140 - 3 })
        }
        .width(140)
        .height(6)
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
      .margin({ right: QuizTokens.Spacing.lg })

      Text('Next')
        .fontSize(QuizTokens.Typography.titleSize)
        .fontWeight(QuizTokens.Typography.titleWeight)
        .fontColor(QuizTokens.Colors.onPrimary)
        .width(140)
        .height(44)
        .textAlign(TextAlign.Center)
        .backgroundColor(QuizTokens.Colors.primary)
        .borderRadius(QuizTokens.Shapes.large)
        .onClick(() => {})
    }
    .width('100%')
    .padding({
      left: QuizTokens.Spacing.lg,
      right: QuizTokens.Spacing.lg,
      top: QuizTokens.Spacing.md,
      bottom: QuizTokens.Spacing.md
    })
    .backgroundColor(QuizTokens.Colors.background)
    .opacity(0.95)
    .alignItems(VerticalAlign.Center)
  }
}

// Main Quiz Root View
@Entry
@Component
struct QuizRootView {
  @State selected: number = -1;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top App Bar
        Row({ space: QuizTokens.Spacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(QuizTokens.Colors.primary)
            .borderRadius(QuizTokens.Shapes.small)

          Text('Quiz')
            .fontSize(QuizTokens.Typography.displaySize)
            .fontWeight(QuizTokens.Typography.displayWeight)
            .fontColor(QuizTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          top: 24,
          bottom: 16,
          left: QuizTokens.Spacing.lg,
          right: QuizTokens.Spacing.lg
        })

        Divider()
          .color(QuizTokens.Colors.outline)
          .strokeWidth(1)

        // Scrollable Content
        Scroll() {
          Column({ space: QuizTokens.Spacing.lg }) {
            // Question Card
            Column({ space: QuizTokens.Spacing.lg }) {
              // Image placeholder
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
              .height(120)

              Text('Which planet is known as the Red Planet?')
                .fontSize(QuizTokens.Typography.headlineSize)
                .fontWeight(QuizTokens.Typography.headlineWeight)
                .fontColor(QuizTokens.Colors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              // Answer Options
              Column({ space: QuizTokens.Spacing.sm }) {
                ForEach(this.options, (option: string, i: number) => {
                  Text(option)
                    .fontSize(this.selected === i
                      ? QuizTokens.Typography.titleSize
                      : QuizTokens.Typography.bodySize)
                    .fontWeight(this.selected === i
                      ? QuizTokens.Typography.titleWeight
                      : QuizTokens.Typography.bodyWeight)
                    .fontColor(this.selected === i
                      ? QuizTokens.Colors.onPrimary
                      : QuizTokens.Colors.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                    .margin({ top: 6, bottom: 6 })
                    .backgroundColor(this.selected === i
                      ? QuizTokens.Colors.primary
                      : QuizTokens.Colors.surface)
                    .border({
                      width: 1,
                      color: QuizTokens.Colors.outline,
                      radius: QuizTokens.Shapes.medium
                    })
                    .borderRadius(QuizTokens.Shapes.medium)
                    .onClick(() => {
                      this.selected = i;
                    })
                })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(QuizTokens.Spacing.lg)
            .backgroundColor(QuizTokens.Colors.surface)
            .border({
              width: 1,
              color: QuizTokens.Colors.outline,
              radius: QuizTokens.Shapes.large
            })
            .borderRadius(QuizTokens.Shapes.large)
            .shadow({
              radius: 3,
              color: '#14000000',
              offsetX: 0,
              offsetY: 1
            })
            .margin({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

            // Selected + Skip Row
            Row() {
              Column({ space: QuizTokens.Spacing.xs }) {
                Text('Selected')
                  .fontSize(QuizTokens.Typography.labelSize)
                  .fontWeight(QuizTokens.Typography.labelWeight)
                  .fontColor(QuizTokens.Colors.onSurface)

                Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                  .fontSize(QuizTokens.Typography.titleSize)
                  .fontWeight(QuizTokens.Typography.titleWeight)
                  .fontColor(QuizTokens.Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              AssistChip({
                label: 'Skip',
                isOn: false,
                onTap: () => {}
              })
            }
            .width('100%')
            .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })
            .alignItems(VerticalAlign.Center)
          }
          .padding({ top: QuizTokens.Spacing.md, bottom: 120 })
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(QuizTokens.Colors.background)

      // Bottom Bar overlay
      Column() {
        Divider()
          .color(QuizTokens.Colors.outline)
          .strokeWidth(1)
        BottomBar()
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }
}