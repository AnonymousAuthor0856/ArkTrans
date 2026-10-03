import { router } from '@kit.ArkUI'

// Color tokens
const Colors = {
  primary: 0xFF7C3AED,
  secondary: 0xFF22C55E,
  tertiary: 0xFFF97316,
  background: 0xFFFAFAFF,
  surface: 0xFFFFFFFF,
  surfaceVariant: 0xFFF1F5F9,
  outline: 0xFFE2E8F0,
  success: 0xFF16A34A,
  warning: 0xFFF59E0B,
  error: 0xFFEF4444,
  onPrimary: 0xFFFFFFFF,
  onSecondary: 0xFF0F172A,
  onTertiary: 0xFF111827,
  onBackground: 0xFF0B1220,
  onSurface: 0xFF0B1220,
}

interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
}

const QUESTIONS: QuestionUi[] = [
  { id: 1, title: 'Which planet is known as the Red Planet?', options: ['Earth', 'Mars', 'Venus', 'Jupiter'], answer: 1 },
  { id: 2, title: 'What is the chemical symbol for water?', options: ['H2O', 'CO2', 'NaCl', 'O2'], answer: 0 },
  { id: 3, title: 'Who wrote Hamlet?', options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], answer: 2 },
  { id: 4, title: 'What is the largest mammal?', options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], answer: 1 },
]

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0
  @State selected: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State reviewFlagged: boolean = false

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Box()
            .width(20)
            .height(20)
            .backgroundColor(Colors.primary)
            .borderRadius(6)
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)

      // Main Content
      if (this.completed) {
        this.CompletedView()
      } else {
        this.QuizView()
      }

      // Bottom Bar
      Column() {
        Divider().color(Colors.outline).strokeWidth(1)
        Row() {
          // Progress section
          Column({ space: 2 }) {
            Text('Progress')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Progress({
              value: this.completed ? QUESTIONS.length :
                (this.currentIndex + (this.selected >= 0 ? 1 : 0)),
              total: QUESTIONS.length,
              type: ProgressType.Linear
            })
              .width(140)
              .height(6)
              .color(Colors.primary)
              .backgroundColor(Colors.surfaceVariant)
          }
          .alignItems(HorizontalAlign.Start)

          Row({ space: 4 }) {
            // Review chip
            Button(this.reviewFlagged ? 'Review ✓' : 'Review')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.reviewFlagged ? Colors.onSecondary : Colors.onSurface)
              .backgroundColor(this.reviewFlagged ? Colors.secondary : Colors.surface)
              .borderWidth(1)
              .borderColor(Colors.outline)
              .borderRadius(6)
              .height(32)
              .padding({ left: 10, right: 10 })
              .onClick(() => {
                this.reviewFlagged = !this.reviewFlagged
              })

            // Next/Finish/Done button
            Button(this.currentIndex < QUESTIONS.length - 1 ? 'Next' :
              (!this.completed ? 'Finish' : 'Done'))
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onPrimary)
              .backgroundColor(Colors.primary)
              .borderRadius(12)
              .height(44)
              .width(140)
              .onClick(() => {
                if (!this.completed) {
                  if (this.selected === QUESTIONS[this.currentIndex].answer) {
                    this.score += 1
                  }
                  if (this.currentIndex < QUESTIONS.length - 1) {
                    this.currentIndex += 1
                    this.selected = -1
                  } else {
                    this.completed = true
                  }
                }
              })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor(Colors.surface)
      .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  CompletedView() {
    Column({ space: 8 }) {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Row() {
        Text(`Score: ${this.score}/${QUESTIONS.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .constraintSize({ minHeight: 120 })
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Button('Restart')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSecondary)
        .backgroundColor(Colors.secondary)
        .borderRadius(12)
        .width('100%')
        .height(44)
        .onClick(() => {
          this.currentIndex = 0
          this.selected = -1
          this.score = 0
          this.completed = false
        })
    }
    .layoutWeight(1)
    .width('100%')
    .padding({ left: 8, right: 8, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  QuizView() {
    Scroll() {
      Column({ space: 8 }) {
        // Question Card
        Column() {
          Column({ space: 6 }) {
            // Question number banner
            Row() {
              Text(`Question ${this.currentIndex + 1}/${QUESTIONS.length}`)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(Colors.onSurface)
            }
            .width('100%')
            .aspectRatio(2.8)
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(8)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)

            // Question title
            Text(QUESTIONS[this.currentIndex].title)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .width('100%')

            // Options
            Column({ space: 4 }) {
              ForEach(QUESTIONS[this.currentIndex].options, (option: string, i: number) => {
                this.OptionChip(option, i)
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding(8)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .constraintSize({ minHeight: 180 })
        .backgroundColor(Colors.surface)
        .borderRadius(12)
        .borderWidth(1)
        .borderColor(Colors.outline)
        .shadow({ radius: 4, color: '#24000000', offsetY: 1 })

        // Selected answer row
        Row() {
          Column({ space: 2 }) {
            Text('Selected')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
            Text(this.selected >= 0 ?
              QUESTIONS[this.currentIndex].options[this.selected] : 'None')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
          }
          .alignItems(HorizontalAlign.Start)

          Button('Skip')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .backgroundColor(Colors.surface)
            .borderWidth(1)
            .borderColor(Colors.outline)
            .borderRadius(6)
            .height(32)
            .padding({ left: 10, right: 10 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 24 })
    }
    .layoutWeight(1)
    .width('100%')
    .scrollBar(BarState.Off)
  }

  @Builder
  OptionChip(text: string, index: number) {
    Row() {
      Text(text)
        .fontSize(this.selected === index ? 14 : 12)
        .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Normal)
        .fontColor(this.selected === index ? Colors.onPrimary : Colors.onSurface)
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    }
    .width('100%')
    .backgroundColor(this.selected === index ? Colors.primary : Colors.surface)
    .borderRadius(8)
    .borderWidth(1)
    .borderColor(Colors.outline)
    .onClick(() => {
      this.selected = index
    })
  }
}