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
}

@Entry
@Component
struct QuizRootView {
  @State selected: number = -1;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];
  @State reviewed: boolean = false;
  @State progress: number = 0.25;

  @Builder
  AssistChip(label: string, isOn: boolean, onTap: () => void) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
      .padding({ top: 10, bottom: 10, left: 14, right: 14 })
      .backgroundColor(isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
      .border({ width: 1, color: QuizTokens.Colors.outline, radius: QuizTokens.Shapes.small })
      .borderRadius(QuizTokens.Shapes.small)
      .onClick(onTap)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
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
            .width(140 * Math.max(0, Math.min(1, this.progress)))
            .height(6)
            .backgroundColor(QuizTokens.Colors.primary)
            .borderRadius(3)

          // Dot marker
          Row()
            .width(6)
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.primary)
            .margin({ left: Math.max(0, 140 * Math.max(0, Math.min(1, this.progress)) - 3) })
        }
        .width(140)
        .height(6)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      this.AssistChip('Review', this.reviewed, () => {
        this.reviewed = !this.reviewed;
      })

      Text('Next')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizTokens.Colors.onPrimary)
        .width(100)
        .height(44)
        .textAlign(TextAlign.Center)
        .backgroundColor(QuizTokens.Colors.primary)
        .borderRadius(QuizTokens.Shapes.large)
        .margin({ left: QuizTokens.Spacing.lg })
    }
    .width('100%')
    .padding({
      left: QuizTokens.Spacing.lg,
      right: QuizTokens.Spacing.lg,
      top: QuizTokens.Spacing.md,
      bottom: QuizTokens.Spacing.md
    })
    .backgroundColor(QuizTokens.Colors.background)
    .border({ width: { top: 1 }, color: QuizTokens.Colors.outline })
  }

  build() {
    Column() {
      // Top App Bar
      Row({ space: QuizTokens.Spacing.sm }) {
        Row()
          .width(20)
          .height(20)
          .backgroundColor(QuizTokens.Colors.primary)
          .borderRadius(QuizTokens.Shapes.small)

        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
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

      // Scrollable content
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
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .width('100%')
            .height(120)

            // Question text
            Text('Which planet is known as the Red Planet?')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(QuizTokens.Colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Options
            Column({ space: QuizTokens.Spacing.sm }) {
              ForEach(this.options, (option: string, i: number) => {
                Text(option)
                  .fontSize(this.selected === i ? 14 : 12)
                  .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selected === i ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
                  .width('100%')
                  .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                  .backgroundColor(this.selected === i ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
                  .border({ width: 1, color: QuizTokens.Colors.outline, radius: QuizTokens.Shapes.medium })
                  .borderRadius(QuizTokens.Shapes.medium)
                  .margin({ top: 6, bottom: 6 })
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
          .border({ width: 1, color: QuizTokens.Colors.outline, radius: QuizTokens.Shapes.large })
          .borderRadius(QuizTokens.Shapes.large)
          .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
          .margin({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

          // Selected + Skip row
          Row() {
            Column({ space: QuizTokens.Spacing.xs }) {
              Text('Selected')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)

              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            this.AssistChip('Skip', false, () => {})
          }
          .width('100%')
          .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })
        }
        .padding({ top: QuizTokens.Spacing.md, bottom: 120 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }
}