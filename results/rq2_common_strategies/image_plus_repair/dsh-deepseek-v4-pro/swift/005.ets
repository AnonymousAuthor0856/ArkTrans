// Quiz UI (Android Compose -> SwiftUI -> ArkUI).
// HarmonyOS compatible; full-screen with status bar hidden.
// This file focuses on UI drawing only (no business logic).

// MARK: - Design Tokens (ported from Compose)
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

class QuizTypography {
  static readonly display: number = 24
  static readonly headline: number = 18
  static readonly title: number = 14
  static readonly body: number = 12
  static readonly label: number = 10
}

// MARK: - Root Screen
@Entry
@Component
struct QuizRootView {
  @State selected: number = -1
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top App Bar
        Row({ space: QuizSpacing.sm }) {
          Rect()
            .fill(QuizColors.primary)
            .width(20)
            .height(20)
            .radius(QuizShapes.small)
          Text('Quiz')
            .fontSize(QuizTypography.display)
            .fontWeight(600)
            .fontColor(QuizColors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 24, bottom: 16, left: QuizSpacing.lg, right: QuizSpacing.lg })

        Scroll() {
          Column({ space: QuizSpacing.lg }) {
            // Card
            Column({ space: QuizSpacing.lg }) {
              Stack() {
                Rect()
                  .fill(QuizColors.surfaceVariant)
                  .width('100%')
                  .height(120)
                  .radius(QuizShapes.medium)
                Text('Question 1/4')
                  .fontSize(QuizTypography.label)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QuizColors.onSurface)
              }
              .width('100%')

              Text('Which planet is known as the Red Planet?')
                .fontSize(QuizTypography.headline)
                .fontWeight(600)
                .fontColor(QuizColors.onSurface)

              Column({ space: QuizSpacing.sm }) {
                ForEach(this.options, (item: string, index: number) => {
                  Button() {
                    Row() {
                      Text(item)
                        .fontSize(this.selected === index ? QuizTypography.title : QuizTypography.body)
                        .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                        .fontColor(this.selected === index ? QuizColors.onPrimary : QuizColors.onSurface)
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.Start)
                    .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                    .backgroundColor(this.selected === index ? QuizColors.primary : QuizColors.surface)
                    .borderRadius(QuizShapes.medium)
                    .border({ width: 1, color: QuizColors.outline, radius: QuizShapes.medium })
                  }
                  .type(ButtonType.Normal)
                  .width('100%')
                  .margin({ top: 6, bottom: 6 })
                  .onClick(() => {
                    this.selected = index
                  })
                }, (item: string) => item)
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding(QuizSpacing.lg)
            .backgroundColor(QuizColors.surface)
            .borderRadius(QuizShapes.large)
            .border({ width: 1, color: QuizColors.outline, radius: QuizShapes.large })
            .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
            .margin({ left: QuizSpacing.lg, right: QuizSpacing.lg })

            // Selected + Skip
            Row() {
              Column({ space: QuizSpacing.xs }) {
                Text('Selected')
                  .fontSize(QuizTypography.label)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QuizColors.onSurface)
                Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                  .fontSize(QuizTypography.title)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(QuizColors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              AssistChip({ label: 'Skip', isOn: false, onTap: () => {} })
            }
            .width('100%')
            .padding({ left: QuizSpacing.lg, right: QuizSpacing.lg })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ top: QuizSpacing.md, bottom: 120 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(QuizColors.background)

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

// MARK: - Bottom Bar
@Component
struct BottomBar {
  @State reviewed: boolean = false
  @State progress: number = 0.25

  build() {
    Row() {
      Column({ space: QuizSpacing.xs }) {
        Text('Progress')
          .fontSize(QuizTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onSurface)
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .fill(QuizColors.surfaceVariant)
            .width(140)
            .height(6)
            .radius(3)
          Rect()
            .fill(QuizColors.primary)
            .width(Math.max(0, Math.min(1, this.progress)) * 140)
            .height(6)
            .radius(3)
          Circle({ width: 6, height: 6 })
            .fill(QuizColors.primary)
            .offset({ x: Math.max(0, Math.min(1, this.progress)) * 140 - 3, y: 0 })
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
          this.reviewed = !this.reviewed
        }
      })

      Button() {
        Text('Next')
          .fontSize(QuizTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onPrimary)
      }
      .type(ButtonType.Normal)
      .width(140)
      .height(44)
      .backgroundColor(QuizColors.primary)
      .borderRadius(QuizShapes.large)
      .onClick(() => {})
    }
    .width('100%')
    .padding({ left: QuizSpacing.lg, right: QuizSpacing.lg, top: QuizSpacing.md, bottom: QuizSpacing.md })
    .backgroundColor('#A6FAFAFF')
  }
}

// MARK: - Assist Chip
@Component
struct AssistChip {
  label: string = ''
  isOn: boolean = false
  onTap: () => void = () => {}

  build() {
    Button() {
      Text(this.label)
        .fontSize(QuizTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isOn ? QuizColors.onSecondary : QuizColors.onSurface)
        .padding({ top: 10, bottom: 10, left: 14, right: 14 })
        .backgroundColor(this.isOn ? QuizColors.secondary : QuizColors.surface)
        .borderRadius(QuizShapes.small)
        .border({ width: 1, color: QuizColors.outline, radius: QuizShapes.small })
    }
    .type(ButtonType.Normal)
    .onClick(() => {
      this.onTap()
    })
  }
}

// MARK: - Helpers
// Swift's `Color(hexRGB:)` extension is replaced by direct hex string literals
// (e.g. 0x7C3AED -> '#7C3AED') because ArkUI colors are ResourceColor strings.

// MARK: - App entry
// SwiftUI's `QuizApp: App` with `WindowGroup` maps to an @Entry page;
// status bar is hidden in full screen (see the @Entry decorator above).
