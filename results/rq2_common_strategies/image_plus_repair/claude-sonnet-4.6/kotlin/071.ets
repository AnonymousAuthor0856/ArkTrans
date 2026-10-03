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

@Entry
@Component
struct Index {
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
    new StreakCard('Rank', 'Top 12%')
  ]

  private progress: number = 0.45

  build() {
    Column() {
      // Top App Bar
      Row() {
        Stack() {
          Circle({ width: 30, height: 30 })
            .fill(Colors.surfaceVariant)
        }
        .width(48)
        .height(48)
        .alignContent(Alignment.Center)

        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#99311F10')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        Stack() {
          Circle({ width: 30, height: 30 })
            .fill('#59FF8A2A')
        }
        .width(48)
        .height(48)
        .alignContent(Alignment.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 4, right: 4 })
      .backgroundColor(Colors.background)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

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
            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(4)
                .backgroundColor('#FFE4CC')
                .borderRadius(2)
              Row()
                .width(`${this.progress * 100}%`)
                .height(4)
                .backgroundColor(Colors.primary)
                .borderRadius(2)
            }
            .width('100%')
            .height(4)

            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
              .lineHeight(28)

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
                .backgroundColor(this.selectedIndex === index ? '#33FF8A2A' : Colors.surfaceVariant)
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
            .backgroundColor('#33FFC857')
          }
          .width('100%')
          .padding(16)
          .borderRadius(28)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 8, color: '#38000000', offsetX: 0, offsetY: 4 })

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
                    .fontColor('#99311F10')
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
          .shadow({ radius: 4, color: '#2E000000', offsetX: 0, offsetY: 2 })
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