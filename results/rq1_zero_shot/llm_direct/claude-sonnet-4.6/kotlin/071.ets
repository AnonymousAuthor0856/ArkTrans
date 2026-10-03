import { router } from '@kit.ArkUI'

// Design Tokens
const Colors = {
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
  onSurface: '#311F10',
}

const Spacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 36,
  xxxl: 46,
}

interface QuizQuestion {
  category: string
  prompt: string
  options: string[]
  hint: string
}

interface StreakCard {
  label: string
  value: string
}

@Entry
@Component
struct RootScreen {
  @State selectedIndex: number = -1

  private question: QuizQuestion = {
    category: 'Citrus crafts',
    prompt: 'Which zest carrier gives the brightest aroma when infused cold?',
    options: ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    hint: 'Think surface area'
  }

  private streaks: StreakCard[] = [
    { label: 'Current streak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ]

  private progress: number = 0.45

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(Colors.surfaceVariant)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // Title
        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // Action Icon
        Stack() {
          Circle()
            .width(30)
            .height(30)
            .fill(Colors.primary)
            .opacity(0.35)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.xs, right: Spacing.xs })
      .backgroundColor(Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column({ space: Spacing.md }) {
          // Question Card
          Column({ space: Spacing.sm }) {
            // Category Row
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
              Text('45%')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(Colors.secondary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // Progress Bar
            Progress({
              value: this.progress * 100,
              total: 100,
              type: ProgressType.Linear
            })
              .width('100%')
              .height(4)
              .color(Colors.primary)
              .backgroundColor(Colors.surfaceVariant)

            // Question Prompt
            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .lineHeight(28)
              .width('100%')

            // Options
            Column({ space: Spacing.xs }) {
              ForEach(this.question.options, (option: string, index: number) => {
                Row() {
                  Text(option)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                }
                .width('100%')
                .padding(Spacing.sm)
                .borderRadius(18)
                .backgroundColor(this.selectedIndex === index
                  ? Colors.primary
                  : Colors.surfaceVariant)
                .opacity(this.selectedIndex === index ? 0.85 : 1.0)
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

            // Hint Box
            Row() {
              Text(`Hint: ${this.question.hint}`)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
            }
            .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
            .borderRadius(10)
            .backgroundColor(Colors.secondary)
            .opacity(0.8)
          }
          .width('100%')
          .padding(Spacing.md)
          .borderRadius(28)
          .backgroundColor(Colors.surface)
          .shadow({
            radius: 8,
            color: '#00000038',
            offsetX: 0,
            offsetY: 4
          })

          // Trackers Card
          Column({ space: Spacing.xs }) {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .lineHeight(28)
              .width('100%')

            // Streak Row
            Row({ space: Spacing.sm }) {
              ForEach(this.streaks, (streak: StreakCard) => {
                Column({ space: Spacing.xxs }) {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .opacity(0.7)
                    .textAlign(TextAlign.Center)
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .padding(Spacing.sm)
                .borderRadius(18)
                .backgroundColor(Colors.surfaceVariant)
                .alignItems(HorizontalAlign.Center)
              })
            }
            .width('100%')

            // Submit Button
            Button('Submit answer')
              .width('100%')
              .height(48)
              .borderRadius(18)
              .backgroundColor(Colors.primary)
              .fontColor(Colors.onPrimary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {})
          }
          .width('100%')
          .padding(Spacing.md)
          .borderRadius(28)
          .backgroundColor(Colors.surface)
          .shadow({
            radius: 4,
            color: '#0000002E',
            offsetX: 0,
            offsetY: 2
          })
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.sm,
          bottom: Spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}