// Quiz UI - ArkTS Implementation
// Converted from SwiftUI to ArkTS

// Design Tokens
interface ColorsType {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface TypographyType {
  display: TypographyItem;
  headline: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
}

class QuizTokens {
  static readonly Colors: ColorsType = {
    primary: '#7C3AED',
    secondary: '#22C55E',
    tertiary: '#F97316',
    background: '#FAFAFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  };

  static readonly Shapes: ShapesType = {
    small: 6,
    medium: 8,
    large: 12
  };

  static readonly Spacing: SpacingType = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static readonly Typography: TypographyType = {
    display: { size: 24, weight: FontWeight.Medium },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  };
}

// Root View
@Entry
@Component
struct QuizRootView {
  @State private selected: number | null = null;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  build() {
    Column() {
      // Top App Bar
      Row({ space: QuizTokens.Spacing.sm }) {
        Row()
          .width(20)
          .height(20)
          .borderRadius(QuizTokens.Shapes.small)
          .backgroundColor(QuizTokens.Colors.primary)

        Text('Quiz')
          .fontSize(QuizTokens.Typography.display.size)
          .fontWeight(QuizTokens.Typography.display.weight)
          .fontColor(QuizTokens.Colors.onSurface)
      }
      .width('100%')
      .padding({ top: 24, bottom: 16, left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

      // Scrollable Content
      Scroll() {
        Column({ space: QuizTokens.Spacing.lg }) {
          // Card
          Column({ space: QuizTokens.Spacing.lg }) {
            // Question Header
            Stack({ alignContent: Alignment.Center }) {
              Text('Question 1/4')
                .fontSize(QuizTokens.Typography.label.size)
                .fontWeight(QuizTokens.Typography.label.weight)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .width('100%')
            .height(120)
            .borderRadius(QuizTokens.Shapes.medium)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)

            // Question Text
            Text('Which planet is known as the Red Planet?')
              .fontSize(QuizTokens.Typography.headline.size)
              .fontWeight(QuizTokens.Typography.headline.weight)
              .fontColor(QuizTokens.Colors.onSurface)
              .width('100%')

            // Options
            Column({ space: QuizTokens.Spacing.sm }) {
              ForEach(this.options, (option: string, index: number) => {
                this.OptionButton(option, index)
              })
            }
            .width('100%')
          }
          .padding(QuizTokens.Spacing.lg)
          .backgroundColor(QuizTokens.Colors.surface)
          .borderRadius(QuizTokens.Shapes.large)
          .border({ width: 1, color: QuizTokens.Colors.outline })
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: 1 })
          .margin({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

          // Selected + Skip
          Row() {
            Column({ space: QuizTokens.Spacing.xs }) {
              Text('Selected')
                .fontSize(QuizTokens.Typography.label.size)
                .fontWeight(QuizTokens.Typography.label.weight)
                .fontColor(QuizTokens.Colors.onSurface)

              Text(this.selected !== null ? this.options[this.selected] : 'None')
                .fontSize(QuizTokens.Typography.title.size)
                .fontWeight(QuizTokens.Typography.title.weight)
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

      // Divider
      Divider()
        .color(QuizTokens.Colors.outline)
        .strokeWidth(1)

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }

  @Builder
  OptionButton(option: string, index: number) {
    Button({ type: ButtonType.Normal }) {
      Text(option)
        .fontSize(this.selected === index ? QuizTokens.Typography.title.size : QuizTokens.Typography.body.size)
        .fontWeight(this.selected === index ? QuizTokens.Typography.title.weight : QuizTokens.Typography.body.weight)
        .fontColor(this.selected === index ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ top: 8, bottom: 8, left: 16, right: 16 })
    }
    .onClick(() => {
      this.selected = index;
    })
    .width('100%')
    .borderRadius(QuizTokens.Shapes.medium)
    .backgroundColor(this.selected === index ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
    .border({ width: 1, color: QuizTokens.Colors.outline })
    .margin({ top: 6, bottom: 6 })
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: QuizTokens.Spacing.xs }) {
        Text('Progress')
          .fontSize(QuizTokens.Typography.label.size)
          .fontWeight(QuizTokens.Typography.label.weight)
          .fontColor(QuizTokens.Colors.onSurface)

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Background
          Row()
            .width('100%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)

          // Progress
          Row()
            .width('25%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.primary)
        }
        .width(140)
        .height(6)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      this.AssistChip('Review', false, () => {})

      Button('Next')
        .fontSize(QuizTokens.Typography.title.size)
        .fontWeight(QuizTokens.Typography.title.weight)
        .fontColor(QuizTokens.Colors.onPrimary)
        .width(140)
        .height(44)
        .borderRadius(QuizTokens.Shapes.large)
        .backgroundColor(QuizTokens.Colors.primary)
    }
    .width('100%')
    .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg, top: QuizTokens.Spacing.md, bottom: QuizTokens.Spacing.md })
    .backgroundColor(QuizTokens.Colors.background)
  }

  @Builder
  AssistChip(label: string, isOn: boolean, onTap: () => void) {
    Button({ type: ButtonType.Normal }) {
      Text(label)
        .fontSize(QuizTokens.Typography.label.size)
        .fontWeight(QuizTokens.Typography.label.weight)
        .fontColor(isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
        .padding({ top: 10, bottom: 10, left: 14, right: 14 })
    }
    .onClick(onTap)
    .borderRadius(QuizTokens.Shapes.small)
    .backgroundColor(isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
    .border({ width: 1, color: QuizTokens.Colors.outline })
  }
}