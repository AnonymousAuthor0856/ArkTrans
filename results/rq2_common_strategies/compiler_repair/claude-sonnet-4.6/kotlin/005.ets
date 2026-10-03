import { router } from '@kit.ArkUI'

interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
}

const PRIMARY_COLOR = '#7C3AED'
const SECONDARY_COLOR = '#22C55E'
const TERTIARY_COLOR = '#F97316'
const BACKGROUND_COLOR = '#FAFAFF'
const SURFACE_COLOR = '#FFFFFF'
const SURFACE_VARIANT_COLOR = '#F1F5F9'
const OUTLINE_COLOR = '#E2E8F0'
const ON_PRIMARY_COLOR = '#FFFFFF'
const ON_SECONDARY_COLOR = '#0F172A'
const ON_SURFACE_COLOR = '#0B1220'

const QUESTIONS: QuestionUi[] = [
  { id: 1, title: "Which planet is known as the Red Planet?", options: ["Earth", "Mars", "Venus", "Jupiter"], answer: 1 },
  { id: 2, title: "What is the chemical symbol for water?", options: ["H2O", "CO2", "NaCl", "O2"], answer: 0 },
  { id: 3, title: "Who wrote Hamlet?", options: ["Charles Dickens", "Mark Twain", "William Shakespeare", "Jane Austen"], answer: 2 },
  { id: 4, title: "What is the largest mammal?", options: ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"], answer: 1 }
]

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0
  @State selectedOption: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State reviewFlagged: boolean = false

  getProgressValue(): number {
    if (this.completed) return 1.0
    return (this.currentIndex + (this.selectedOption >= 0 ? 1 : 0)) / QUESTIONS.length
  }

  handleNext() {
    if (!this.completed) {
      if (this.selectedOption === QUESTIONS[this.currentIndex].answer) {
        this.score += 1
      }
      if (this.currentIndex < QUESTIONS.length - 1) {
        this.currentIndex += 1
        this.selectedOption = -1
      } else {
        this.completed = true
      }
    }
  }

  handleRestart() {
    this.currentIndex = 0
    this.selectedOption = -1
    this.score = 0
    this.completed = false
    this.reviewFlagged = false
  }

  getNextButtonText(): string {
    if (this.currentIndex < QUESTIONS.length - 1) return "Next"
    if (!this.completed) return "Finish"
    return "Done"
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row({ space: 4 }) {
          Column()
            .width(20)
            .height(20)
            .backgroundColor(PRIMARY_COLOR)
            .borderRadius(6)
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE_COLOR)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE_COLOR)

      // Main Content
      if (this.completed) {
        this.CompletedView()
      } else {
        this.QuizView()
      }

      // Bottom Bar
      Column() {
        Row() {
          Column({ space: 2 }) {
            Text('Progress')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE_COLOR)
            Progress({ value: this.getProgressValue() * 100, total: 100, type: ProgressType.Linear })
              .width(140)
              .height(6)
              .color(PRIMARY_COLOR)
              .backgroundColor(SURFACE_VARIANT_COLOR)
          }
          .alignItems(HorizontalAlign.Start)

          Row({ space: 4 }) {
            // Review Chip
            Row() {
              Text('Review')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.reviewFlagged ? ON_SECONDARY_COLOR : ON_SURFACE_COLOR)
            }
            .padding({ left: 10, right: 10, top: 6, bottom: 6 })
            .backgroundColor(this.reviewFlagged ? SECONDARY_COLOR : SURFACE_COLOR)
            .borderRadius(6)
            .border({ width: 1, color: OUTLINE_COLOR })
            .onClick(() => {
              this.reviewFlagged = !this.reviewFlagged
            })

            // Next/Finish Button
            Row() {
              Text(this.getNextButtonText())
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(ON_PRIMARY_COLOR)
            }
            .width(140)
            .height(44)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(PRIMARY_COLOR)
            .borderRadius(12)
            .onClick(() => {
              this.handleNext()
            })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .backgroundColor(SURFACE_COLOR)
      .shadow({ radius: 6, color: '#29000000', offsetY: 1.5 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }

  @Builder
  CompletedView() {
    Column({ space: 8 }) {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE_COLOR)

      Row() {
        Text(`Score: ${this.score}/${QUESTIONS.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(PRIMARY_COLOR)
      }
      .width('100%')
      .constraintSize({ minHeight: 120 })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SURFACE_VARIANT_COLOR)
      .borderRadius(12)

      Row() {
        Text('Restart')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SECONDARY_COLOR)
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(SECONDARY_COLOR)
      .borderRadius(12)
      .onClick(() => {
        this.handleRestart()
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
        Column({ space: 6 }) {
          // Question number banner
          Row() {
            Text(`Question ${this.currentIndex + 1}/${QUESTIONS.length}`)
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE_COLOR)
          }
          .width('100%')
          .aspectRatio(2.8)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(SURFACE_VARIANT_COLOR)
          .borderRadius(8)

          // Question title
          Text(QUESTIONS[this.currentIndex].title)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE_COLOR)
            .width('100%')

          // Options
          Column({ space: 4 }) {
            ForEach(QUESTIONS[this.currentIndex].options, (option: string, i: number) => {
              Row() {
                Text(option)
                  .fontSize(this.selectedOption === i ? 14 : 12)
                  .fontWeight(this.selectedOption === i ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selectedOption === i ? ON_PRIMARY_COLOR : ON_SURFACE_COLOR)
              }
              .width('100%')
              .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              .backgroundColor(this.selectedOption === i ? PRIMARY_COLOR : SURFACE_COLOR)
              .borderRadius(8)
              .border({ width: 1, color: OUTLINE_COLOR })
              .onClick(() => {
                this.selectedOption = i
              })
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .constraintSize({ minHeight: 180 })
        .padding(8)
        .backgroundColor(SURFACE_COLOR)
        .borderRadius(12)
        .border({ width: 1, color: OUTLINE_COLOR })
        .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
        .alignItems(HorizontalAlign.Start)

        // Selected + Skip row
        Row() {
          Column({ space: 2 }) {
            Text('Selected')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE_COLOR)
            Text(this.selectedOption >= 0 ? QUESTIONS[this.currentIndex].options[this.selectedOption] : 'None')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE_COLOR)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Text('Skip')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE_COLOR)
          }
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
          .backgroundColor(SURFACE_COLOR)
          .borderRadius(6)
          .border({ width: 1, color: OUTLINE_COLOR })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Bottom padding
        Column().height(24)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .width('100%')
    .scrollBar(BarState.Off)
  }
}