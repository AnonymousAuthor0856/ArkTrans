import { router } from '@kit.ArkUI'

class QuizQuestion {
  category: string
  prompt: string
  options: string[]
  hint: string

  constructor(category: string, prompt: string, options: string[], hint: string) {
    this.category = category
    this.prompt = prompt
    this.options = options
    this.hint = hint
  }
}

class StreakCard {
  label: string
  value: string

  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

const Colors = {
  primary: 0xFFFF8A2A,
  secondary: 0xFFFFC857,
  tertiary: 0xFF68D672,
  background: 0xFFFFF9F2,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFFFE4CC,
  outline: 0xFFE2B088,
  success: 0xFF2AC28B,
  warning: 0xFFFFB347,
  error: 0xFFF45B69,
  onPrimary: 0xFF2C0D00,
  onSecondary: 0xFF301A00,
  onTertiary: 0xFF083919,
  onBackground: 0xFF1E1205,
  onSurface: 0xFF311F10,
}

@Entry
@Component
struct RootScreen {
  @State selectedIndex: number = -1

  private question: QuizQuestion = new QuizQuestion(
    'Citrus crafts',
    'Which zest carrier gives the brightest aroma when infused cold?',
    ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    'Think surface area'
  )

  private streaks: StreakCard[] = [
    new StreakCard('Current streak', '5 days'),
    new StreakCard('Accuracy', '84%'),
    new StreakCard('Rank', 'Top 12%'),
  ]

  private progress: number = 0.45

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(Colors.surfaceVariant)
        }
        .width(40)
        .height(40)

        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(0x99311F10)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(0x59FF8A2A)
        }
        .width(40)
        .height(40)
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 16 }) {
          // Question Card
          Column({ space: 12 }) {
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text('45%')
                .fontSize(14)
                .fontColor(Colors.secondary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // Progress bar
            Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(Colors.primary)
              .backgroundColor(Colors.surfaceVariant)
              .style({ strokeWidth: 6 })

            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .lineHeight(28)

            // Options
            Column({ space: 8 }) {
              ForEach(this.question.options, (option: string, index: number) => {
                Row() {
                  Text(option)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                }
                .width('100%')
                .padding(12)
                .borderRadius(18)
                .backgroundColor(this.selectedIndex === index ? 0x33FF8A2A : Colors.surfaceVariant)
                .border({
                  width: 1,
                  color: this.selectedIndex === index ? Colors.primary : Colors.outline,
                  radius: 18
                })
                .onClick(() => {
                  this.selectedIndex = index
                })
              })
            }
            .width('100%')

            // Hint box
            Row() {
              Text(`Hint: ${this.question.hint}`)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
            }
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .borderRadius(10)
            .backgroundColor(0x33FFC857)
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 8, color: 0x38000000, offsetX: 0, offsetY: 4 })

          // Trackers Card
          Column({ space: 8 }) {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .lineHeight(28)

            Row({ space: 12 }) {
              ForEach(this.streaks, (streak: StreakCard) => {
                Column({ space: 4 }) {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(0x99311F10)
                    .textAlign(TextAlign.Center)
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .padding(12)
                .borderRadius(18)
                .backgroundColor(Colors.surfaceVariant)
                .alignItems(HorizontalAlign.Center)
              })
            }
            .width('100%')

            // Submit button
            Button('Submit answer')
              .width('100%')
              .height(48)
              .borderRadius(18)
              .backgroundColor(Colors.primary)
              .fontColor(Colors.onPrimary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 4, color: 0x2E000000, offsetX: 0, offsetY: 2 })
        }
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}