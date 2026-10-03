// Quiz UI (Android Compose -> SwiftUI -> ArkTS).
// Full-screen with status bar hidden.
// This file focuses on UI drawing only (no business logic).

// MARK: - Design Tokens (ported from Compose)
interface QuizColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface QuizTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface QuizSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface QuizShapes {
  small: number;
  medium: number;
  large: number;
}

class QuizTokens {
  static readonly Colors: QuizColors = {
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

  static readonly Shapes: QuizShapes = {
    small: 6, medium: 8, large: 12
  };

  static readonly Spacing: QuizSpacing = {
    xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
  };

  static readonly Typography: QuizTypography = {
    display: { size: 24, weight: FontWeight.Semibold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };
}

// MARK: - Root Screen
@Entry
@Component
struct QuizRootView {
  @State selected: number | null = null;
  options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top App Bar
        Row({ space: QuizTokens.Spacing.sm }) {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(QuizTokens.Colors.primary)
            .borderRadius(QuizTokens.Shapes.small)
          Text('Quiz')
            .fontSize(QuizTokens.Typography.display.size)
            .fontWeight(QuizTokens.Typography.display.weight)
            .fontColor(QuizTokens.Colors.onSurface)
        }
        .padding({ top: 24, bottom: 16, left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

        Scroll() {
          Column({ space: QuizTokens.Spacing.lg }) {
            // Card
            Column({ space: QuizTokens.Spacing.lg }) {
              Stack() {
                Text('Question 1/4')
                  .fontSize(QuizTokens.Typography.label.size)
                  .fontWeight(QuizTokens.Typography.label.weight)
                  .fontColor(QuizTokens.Colors.onSurface)
              }
              .width('100%')
              .height(120)
              .backgroundColor(QuizTokens.Colors.surfaceVariant)
              .borderRadius(QuizTokens.Shapes.medium)

              Text('Which planet is known as the Red Planet?')
                .fontSize(QuizTokens.Typography.headline.size)
                .fontWeight(QuizTokens.Typography.headline.weight)
                .fontColor(QuizTokens.Colors.onSurface)

              Column({ space: QuizTokens.Spacing.sm }) {
                ForEach(this.options, (option: string, i: number) => {
                  Button(option)
                    .fontSize(this.selected === i ? QuizTokens.Typography.title.size : QuizTokens.Typography.body.size)
                    .fontWeight(this.selected === i ? QuizTokens.Typography.title.weight : QuizTokens.Typography.body.weight)
                    .fontColor(this.selected === i ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
                    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                    .backgroundColor(this.selected === i ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
                    .borderRadius(QuizTokens.Shapes.medium)
                    .border({ width: 1, color: QuizTokens.Colors.outline })
                    .onClick(() => { this.selected = i; })
                }, (option: string) => option)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(QuizTokens.Spacing.lg)
            .backgroundColor(QuizTokens.Colors.surface)
            .borderRadius(QuizTokens.Shapes.large)
            .border({ width: 1, color: QuizTokens.Colors.outline })
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: 1 })
            .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

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
              AssistChip({ label: 'Skip', isOn: false, onTap: () => {} })
            }
            .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })
          }
          .padding({ top: QuizTokens.Spacing.md, bottom: 120 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(QuizTokens.Colors.background)

      // Bottom Bar
      Column() {
        Blank()
        BottomBar()
      }
      .width('100%')
      .height('100%')
    }
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  @State reviewed: boolean = false;
  @State progress: number = 0.25;

  build() {
    Row() {
      Column({ space: QuizTokens.Spacing.xs }) {
        Text('Progress')
          .fontSize(QuizTokens.Typography.label.size)
          .fontWeight(QuizTokens.Typography.label.weight)
          .fontColor(QuizTokens.Colors.onSurface)
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width(140)
            .height(6)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
            .borderRadius(3)
          Row()
            .width(140 * Math.max(0, Math.min(1, this.progress)))
            .height(6)
            .backgroundColor(QuizTokens.Colors.primary)
            .borderRadius(3)
          Circle()
            .width(6)
            .height(6)
            .fill(QuizTokens.Colors.primary)
            .margin({ left: 140 * Math.max(0, Math.min(1, this.progress)) - 3 })
        }
        .width(140)
        .height(6)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      AssistChip({ label: 'Review', isOn: this.reviewed, onTap: () => { this.reviewed = !this.reviewed; } })

      Button('Next')
        .fontSize(QuizTokens.Typography.title.size)
        .fontWeight(QuizTokens.Typography.title.weight)
        .width(140)
        .height(44)
        .backgroundColor(QuizTokens.Colors.primary)
        .fontColor(QuizTokens.Colors.onPrimary)
        .borderRadius(QuizTokens.Shapes.large)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg, top: QuizTokens.Spacing.md, bottom: QuizTokens.Spacing.md })
    .backgroundColor('#A6FAFAFF')
  }
}

// MARK: - Assist Chip
@Component
struct AssistChip {
  @Prop label: string = '';
  @Prop isOn: boolean = false;
  onTap: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(QuizTokens.Typography.label.size)
      .fontWeight(QuizTokens.Typography.label.weight)
      .fontColor(this.isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
      .padding({ top: 10, bottom: 10, left: 14, right: 14 })
      .backgroundColor(this.isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
      .border({ width: 1, color: QuizTokens.Colors.outline })
      .borderRadius(QuizTokens.Shapes.small)
      .onClick(() => { this.onTap(); })
  }
}
