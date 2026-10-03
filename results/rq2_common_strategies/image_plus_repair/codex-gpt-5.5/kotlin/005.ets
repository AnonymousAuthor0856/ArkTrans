interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
}

const QUESTIONS: QuestionUi[] = [
  {
    id: 1,
    title: 'Which planet is known as the Red Planet?',
    options: ['Earth', 'Mars', 'Venus', 'Jupiter'],
    answer: 1
  },
  {
    id: 2,
    title: 'What is the chemical symbol for water?',
    options: ['H2O', 'CO2', 'NaCl', 'O2'],
    answer: 0
  },
  {
    id: 3,
    title: 'Who wrote Hamlet?',
    options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'],
    answer: 2
  },
  {
    id: 4,
    title: 'What is the largest mammal?',
    options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
    answer: 1
  }
]

@Entry
@Component
struct MainPage {
  @State currentIndex: number = 0
  @State selectedIndex: number = -1
  @State score: number = 0
  @State completed: boolean = false
  @State review: boolean = false

  private get currentQuestion(): QuestionUi {
    return QUESTIONS[this.currentIndex]
  }

  private get progress(): number {
    if (this.completed) {
      return 1
    }
    return (this.currentIndex + (this.selectedIndex >= 0 ? 1 : 0)) / QUESTIONS.length
  }

  private selectAnswer(index: number): void {
    this.selectedIndex = index
  }

  private advance(): void {
    if (this.completed) {
      return
    }

    if (this.selectedIndex === this.currentQuestion.answer) {
      this.score += 1
    }

    if (this.currentIndex < QUESTIONS.length - 1) {
      this.currentIndex += 1
      this.selectedIndex = -1
    } else {
      this.completed = true
    }
  }

  private skip(): void {
    if (this.currentIndex < QUESTIONS.length - 1) {
      this.currentIndex += 1
      this.selectedIndex = -1
    } else {
      this.completed = true
    }
  }

  private restart(): void {
    this.currentIndex = 0
    this.selectedIndex = -1
    this.score = 0
    this.completed = false
    this.review = false
  }

  @Builder
  private BrandHeader() {
    Row() {
      Blank()
        .width(40)
        .height(40)
        .borderRadius(12)
        .backgroundColor('#7C3AED')

      Text('Quiz')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .margin({ left: 10 })
    }
    .height(176)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  private OptionButton(option: string, index: number) {
    Button(option)
      .fontSize(this.selectedIndex === index ? 22 : 21)
      .fontColor(this.selectedIndex === index ? '#FFFFFF' : '#0B1220')
      .fontWeight(this.selectedIndex === index ? FontWeight.Medium : FontWeight.Normal)
      .backgroundColor(this.selectedIndex === index ? '#7C3AED' : '#FFFFFF')
      .border({
        width: 2,
        color: this.selectedIndex === index ? '#7C3AED' : '#E2E8F0'
      })
      .borderRadius(16)
      .height(64)
      .padding({ left: 30, right: 30 })
      .alignSelf(ItemAlign.Start)
      .onClick(() => this.selectAnswer(index))
  }

  @Builder
  private QuestionPanel() {
    Column() {
      Row() {
        Text(`Question ${this.currentIndex + 1}/${QUESTIONS.length}`)
          .fontSize(20)
          .fontColor('#0B1220')
      }
      .width('100%')
      .height(234)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')
      .borderRadius(16)

      Text(this.currentQuestion.title)
        .fontSize(36)
        .lineHeight(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
        .width('100%')
        .margin({ top: 18, bottom: 26 })

      Column({ space: 20 }) {
        ForEach(this.currentQuestion.options, (option: string, index: number) => {
          this.OptionButton(option, index)
        }, (option: string) => option)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(22)
    .border({ width: 2, color: '#E2E8F0' })
    .shadow({
      radius: 8,
      color: '#220B1220',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  private SelectionSummary() {
    Row() {
      Column() {
        Text('Selected')
          .fontSize(20)
          .fontColor('#0B1220')
          .alignSelf(ItemAlign.Start)

        Text(this.selectedIndex >= 0 ? this.currentQuestion.options[this.selectedIndex] : 'None')
          .fontSize(27)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .margin({ top: 4 })
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Skip')
        .fontSize(20)
        .fontColor('#0B1220')
        .backgroundColor('#FFFFFF')
        .border({ width: 2, color: '#E2E8F0' })
        .borderRadius(14)
        .height(64)
        .width(102)
        .onClick(() => this.skip())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 32, bottom: 30 })
  }

  @Builder
  private CompletedContent() {
    Column() {
      Text('Quiz Completed')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')

      Row() {
        Text(`Score: ${this.score}/${QUESTIONS.length}`)
          .fontSize(27)
          .fontWeight(FontWeight.Bold)
          .fontColor('#7C3AED')
      }
      .width('100%')
      .height(150)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')
      .borderRadius(16)
      .margin({ top: 24, bottom: 24 })

      Button('Restart')
        .fontSize(21)
        .fontColor('#0F172A')
        .backgroundColor('#22C55E')
        .borderRadius(14)
        .height(58)
        .width('100%')
        .onClick(() => this.restart())
    }
    .width('100%')
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private BottomBar() {
    Column() {
      Row() {
        Column() {
          Text('Progress')
            .fontSize(20)
            .fontColor('#0B1220')
            .alignSelf(ItemAlign.Start)

          Progress({
            value: this.progress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .width(280)
            .height(8)
            .margin({ top: 8 })
            .color('#7C3AED')
            .backgroundColor('#F1F5F9')
        }
        .alignItems(HorizontalAlign.Start)

        Row({ space: 10 }) {
          Button('Review')
            .fontSize(20)
            .fontColor(this.review ? '#0F172A' : '#0B1220')
            .backgroundColor(this.review ? '#22C55E' : '#FFFFFF')
            .border({ width: 2, color: '#E2E8F0' })
            .borderRadius(14)
            .height(64)
            .width(128)
            .onClick(() => this.review = !this.review)

          Button(this.completed ? 'Done' : (this.currentIndex < QUESTIONS.length - 1 ? 'Next' : 'Finish'))
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .backgroundColor('#7C3AED')
            .borderRadius(22)
            .height(88)
            .width(270)
            .onClick(() => this.advance())
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(122)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#F4EEFF')
  }

  build() {
    Column() {
      this.BrandHeader()

      Scroll() {
        Column() {
          if (this.completed) {
            this.CompletedContent()
          } else {
            this.QuestionPanel()
            this.SelectionSummary()
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 14, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FAFAFF')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }
}
