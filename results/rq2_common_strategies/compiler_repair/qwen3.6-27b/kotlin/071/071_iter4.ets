import { window } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// Design Tokens and Constants
const NAME = "163*QuizForge*en"
const UI_TYPE = "Quiz"
const STYLE_THEME = "Citrus Pop"
const LANG = "en"
const BASELINE_SIZE = "720x1280"
const COLOR_PALETTE = "primary:#FF8A2A secondary:#FFC857 tertiary:#68D672 background:#FFF9F2 surface:#FFFFFF surfaceVariant:#FFE4CC outline:#E2B088 success:#2AC28B warning:#FFB347 error:#F45B69 onPrimary:#2C0D00 onSecondary:#301A00 onTertiary:#083919 onBackground:#1E1205 onSurface:#311F10"
const DENSITY_SPACING = "Compact"
const COMPLEXITY = "QuestionCard,OptionChip,Progress"
const EXTRA = "Citrus quiz forge with cards, chips, and timed progress"

class DesignTokens {
  static Colors: Record<string, string> = {
    primary: '#FF8A2A',
    secondary: '#FFC857',
    tertiary: '#68D672',
    background: '#FFF9F2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFE4CC',
    outline: '#E2B088',
    success: '#2AC28B',
    warning: '#FFB347',
    error: '#F45B69',
    onPrimary: '#2C0D00',
    onSecondary: '#301A00',
    onTertiary: '#083919',
    onBackground: '#1E1205',
    onSurface: '#311F10'
  }

  static Spacing: Record<string, number> = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 36,
    xxxl: 46
  }
}

interface QuizQuestion {
  category: string;
  prompt: string;
  options: Array<string>;
  hint: string;
}

interface StreakCard {
  label: string;
  value: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedIndex: number = -1
  private progress: number = 0.45

  // Data initialization
  private question: QuizQuestion = {
    category: "Citrus crafts",
    prompt: "Which zest carrier gives the brightest aroma when infused cold?",
    options: ["Dried peel sachet", "Twist garnish", "Zester microplane", "Candied strip"],
    hint: "Think surface area"
  }

  private streaks: Array<StreakCard> = [
    { label: "Current streak", value: "5 days" },
    { label: "Accuracy", value: "84%" },
    { label: "Rank", value: "Top 12%" }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Back)
        Button() {
          Circle({ width: 30, height: 30 })
            .fill(DesignTokens.Colors.surfaceVariant)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Handle back click
        })

        // Title Area
        Column() {
          Text("QuizForge")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .lineHeight(22)
            .fontColor(DesignTokens.Colors.onSurface)
          
          Text("Aroma sprint")
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .lineHeight(16)
            .fontColor('#B31E1205') // Approximate alpha 0.7 of onSurface
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        // Action Icon (Profile/Settings)
        Button() {
          Circle({ width: 30, height: 30 })
            .fill('#59FF8A2A') // Approximate alpha 0.35 of primary
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Handle action click
        })
      }
      .width('100%')
      .height(56) // Standard top bar height approx
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Scrollable Content
      Scroll() {
        Column() {
          // Question Card
          Column() {
            // Header Row
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .lineHeight(22)
                .fontColor(DesignTokens.Colors.onSurface)
              
              Blank().layoutWeight(1)
              
              Text("45%")
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .lineHeight(20)
                .fontColor(DesignTokens.Colors.secondary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // Progress Bar
            Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(4)
              .color(DesignTokens.Colors.primary)
              .backgroundColor('#FFE4CC') // Surface variant as track
              .margin({ top: DesignTokens.Spacing.sm, bottom: DesignTokens.Spacing.sm })

            // Prompt
            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .lineHeight(28)
              .fontColor(DesignTokens.Colors.onSurface)
              .margin({ bottom: DesignTokens.Spacing.sm })

            // Options List
            Column() {
              ForEach(this.question.options, (option: string, index: number) => {
                const isActive = this.selectedIndex === index
                Column() {
                  Text(option)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .lineHeight(22)
                    .fontColor(DesignTokens.Colors.onSurface)
                }
                .width('100%')
                .padding(DesignTokens.Spacing.sm)
                .borderRadius(18)
                .backgroundColor(isActive ? '#33FF8A2A' : DesignTokens.Colors.surfaceVariant) // Alpha 0.2 for active
                .border({
                  width: 1,
                  color: isActive ? DesignTokens.Colors.primary : DesignTokens.Colors.outline,
                  radius: 18
                })
                .onClick(() => {
                  this.selectedIndex = index
                })
                .margin({ bottom: DesignTokens.Spacing.xs })
              })
            }

            // Hint Box
            Column() {
              Text(`Hint: ${this.question.hint}`)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .lineHeight(16)
                .fontColor(DesignTokens.Colors.onSurface)
            }
            .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
            .borderRadius(10)
            .backgroundColor('#33FFC857') // Alpha 0.2 of secondary
            .margin({ top: DesignTokens.Spacing.md })

          }
          .padding(DesignTokens.Spacing.md)
          .borderRadius(28)
          .backgroundColor(DesignTokens.Colors.surface)
          .shadow({
            radius: 8,
            color: '#38000000', // Approximate shadow opacity
            offsetX: 0,
            offsetY: 4
          })

          // Trackers Card
          Column() {
            Text("Trackers")
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .lineHeight(28)
              .fontColor(DesignTokens.Colors.onSurface)
              .margin({ bottom: DesignTokens.Spacing.xs })

            Row({ space: DesignTokens.Spacing.sm }) {
              ForEach(this.streaks, (streak: StreakCard) => {
                Column() {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .lineHeight(16)
                    .fontColor('#B31E1205') // Alpha 0.7
                    .textAlign(TextAlign.Center)
                  
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .lineHeight(22)
                    .fontColor(DesignTokens.Colors.onSurface)
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .padding(DesignTokens.Spacing.sm)
                .borderRadius(18)
                .backgroundColor(DesignTokens.Colors.surfaceVariant)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center)
              })
            }
            .width('100%')
            .margin({ top: DesignTokens.Spacing.sm, bottom: DesignTokens.Spacing.md })

            // Submit Button
            Button("Submit answer")
              .width('100%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onPrimary)
              .backgroundColor(DesignTokens.Colors.primary)
              .borderRadius(18)
              .onClick(() => {
                // Handle submit
              })
          }
          .padding(DesignTokens.Spacing.md)
          .borderRadius(28)
          .backgroundColor(DesignTokens.Colors.surface)
          .shadow({
            radius: 4,
            color: '#2E000000', // Approximate shadow opacity
            offsetX: 0,
            offsetY: 2
          })
          .margin({ top: DesignTokens.Spacing.md })

        }
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.sm, bottom: DesignTokens.Spacing.sm })
        .spacing(DesignTokens.Spacing.md)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}