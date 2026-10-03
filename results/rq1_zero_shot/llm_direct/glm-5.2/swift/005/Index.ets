// Quiz UI (SwiftUI -> ArkTS).
// Full-screen with status bar hidden.
// This file focuses on UI drawing only (no business logic).

// MARK: - Design Tokens (ported from Compose)
class QuizTokens {
  static Colors: Record<string, string> = {
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
    onSurface: '#0B1220',
  };

  static Shapes: Record<string, number> = {
    small: 6,
    medium: 8,
    large: 12,
  };

  static Spacing: Record<string, number> = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  };
}

// MARK: - Root Screen
@Entry
@Component
struct QuizRootView {
  @State selected: number | null = null;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizTokens.Colors.onSurface)
          .margin({ left: QuizTokens.Spacing.sm })
      }
      .width('100%')
      .height(56)
      .padding({ top: 24, bottom: 16, left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

      // Scrollable Content
      Scroll() {
        Column() {
          // Card
          Column() {
            // Question 1/4 Placeholder
            Stack() {
              Text('Question 1/4')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
            }
            .width('100%')
            .height(120)
            .borderRadius(QuizTokens.Shapes.medium)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)

            Text('Which planet is known as the Red Planet?')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(QuizTokens.Colors.onSurface)
              .margin({ top: QuizTokens.Spacing.lg })
              .width('100%')

            // Options
            Column() {
              ForEach(this.options, (option: string, i: number) => {
                Button({ type: ButtonType.Normal, stateEffect: false }) {
                  Text(option)
                    .fontSize(this.selected === i ? 14 : 12)
                    .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
                    .fontColor(this.selected === i ? QuizTokens.Colors.onPrimary : QuizTokens.Colors.onSurface)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                }
                .backgroundColor(this.selected === i ? QuizTokens.Colors.primary : QuizTokens.Colors.surface)
                .borderRadius(QuizTokens.Shapes.medium)
                .border({ width: 1, color: QuizTokens.Colors.outline })
                .margin({ top: i === 0 ? 0 : QuizTokens.Spacing.sm, bottom: QuizTokens.Spacing.sm })
                .onClick(() => {
                  this.selected = i;
                })
              })
            }
            .width('100%')
            .margin({ top: QuizTokens.Spacing.lg })
          }
          .padding(QuizTokens.Spacing.lg)
          .backgroundColor(QuizTokens.Colors.surface)
          .borderRadius(QuizTokens.Shapes.large)
          .border({ width: 1, color: QuizTokens.Colors.outline })
          .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
          .margin({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg })

          // Selected + Skip
          Row() {
            Column() {
              Text('Selected')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
              Text(this.selected !== null ? this.options[this.selected] : 'None')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(QuizTokens.Colors.onSurface)
                .margin({ top: QuizTokens.Spacing.xs })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            // Skip AssistChip
            AssistChip({ label: 'Skip', isOn: false })
          }
          .width('100%')
          .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg, top: QuizTokens.Spacing.lg })
        }
        .padding({ top: QuizTokens.Spacing.md, bottom: 120 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Divider
      Divider()
        .color(QuizTokens.Colors.outline)
        .strokeWidth(1)

      // Bottom Bar
      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizTokens.Colors.background)
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  @State reviewed: boolean = false;
  @State progress: number = 0.25;

  build() {
    Row() {
      // Progress
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizTokens.Colors.onSurface)
        
        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Background Track
          Column()
            .width('100%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(QuizTokens.Colors.surfaceVariant)
          
          // Filled Progress
          Row() {
            Column()
              .width(6)
              .height(6)
              .borderRadius(3)
              .backgroundColor(QuizTokens.Colors.primary)
          }
          .width(`${Math.max(0, Math.min(1, this.progress)) * 100}%`)
          .height(6)
        }
        .width(140)
        .height(6)
        .margin({ top: QuizTokens.Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Review AssistChip
      AssistChip({ 
        label: 'Review', 
        isOn: this.reviewed, 
        onTap: () => { this.reviewed = !this.reviewed; } 
      })

      // Next Button
      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('Next')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizTokens.Colors.onPrimary)
      }
      .width(140)
      .height(44)
      .backgroundColor(QuizTokens.Colors.primary)
      .borderRadius(QuizTokens.Shapes.large)
      .margin({ left: QuizTokens.Spacing.lg })
    }
    .width('100%')
    .padding({ left: QuizTokens.Spacing.lg, right: QuizTokens.Spacing.lg, top: QuizTokens.Spacing.md, bottom: QuizTokens.Spacing.md })
    .backgroundColor('#A6FAFAFF') // background.opacity(0.65)
  }
}

// MARK: - Assist Chip
@Component
struct AssistChip {
  @Prop label: string;
  @Prop isOn: boolean;
  onTap: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isOn ? QuizTokens.Colors.onSecondary : QuizTokens.Colors.onSurface)
        .padding({ top: 10, bottom: 10, left: 14, right: 14 })
    }
    .backgroundColor(this.isOn ? QuizTokens.Colors.secondary : QuizTokens.Colors.surface)
    .borderRadius(QuizTokens.Shapes.small)
    .border({ width: 1, color: QuizTokens.Colors.outline })
    .onClick(this.onTap)
  }
}