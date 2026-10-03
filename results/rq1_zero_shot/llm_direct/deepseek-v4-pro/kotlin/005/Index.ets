@Entry
@Component
struct EducationQuiz {
  @State currentIndex: number = 0
  @State selectedOption: number = -1
  @State score: number = 0
  @State isCompleted: boolean = false
  @State reviewFlag: boolean = false
  @State questions: QuestionUi[] = [
    { id: 1, title: "Which planet is known as the Red Planet?", options: ["Earth", "Mars", "Venus", "Jupiter"], answer: 1 },
    { id: 2, title: "What is the chemical symbol for water?", options: ["H2O", "CO2", "NaCl", "O2"], answer: 0 },
    { id: 3, title: "Who wrote Hamlet?", options: ["Charles Dickens", "Mark Twain", "William Shakespeare", "Jane Austen"], answer: 2 },
    { id: 4, title: "What is the largest mammal?", options: ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"], answer: 1 }
  ]

  @Builder
  TopBar() {
    Row() {
      Row({ space: 4 }) {
        Rect()
          .width(20)
          .height(20)
          .radius(6)
          .fill('#7C3AED')
        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: 2 }) {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Progress({ value: this.isCompleted ? 100 : (this.currentIndex + (this.selectedOption >= 0 ? 1 : 0)) * 100 / this.questions.length, total: 100 })
          .width(140)
          .height(6)
          .color('#7C3AED')
          .backgroundColor('#F1F5F9')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row({ space: 4 }) {
        Button() {
          Text(this.reviewFlag ? 'Review ✓' : 'Review')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.reviewFlag ? '#0F172A' : '#0B1220')
        }
        .height(32)
        .padding({ left: 8, right: 8 })
        .backgroundColor(this.reviewFlag ? '#22C55E' : '#FFFFFF')
        .border({ width: 1, color: '#E2E8F0', radius: 6 })
        .onClick(() => {
          this.reviewFlag = !this.reviewFlag
        })

        Button() {
          Text(this.currentIndex < this.questions.length - 1 ? 'Next' : (this.isCompleted ? 'Done' : 'Finish'))
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .height(44)
        .width(140)
        .backgroundColor('#7C3AED')
        .borderRadius(12)
        .onClick(() => {
          if (!this.isCompleted) {
            if (this.selectedOption === this.questions[this.currentIndex].answer) {
              this.score += 1
            }
            if (this.currentIndex < this.questions.length - 1) {
              this.currentIndex += 1
              this.selectedOption = -1
            } else {
              this.isCompleted = true
            }
          }
        })
      }
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }

  @Builder
  CompletionScreen() {
    Column({ space: 8 }) {
      Text('Quiz Completed')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')

      Row() {
        Text(`Score: ${this.score}/${this.questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#7C3AED')
      }
      .width('100%')
      .constraintSize({ minHeight: 120 })
      .backgroundColor('#F1F5F9')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)

      Button() {
        Text('Restart')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(44)
      .backgroundColor('#22C55E')
      .borderRadius(12)
      .onClick(() => {
        this.currentIndex = 0
        this.selectedOption = -1
        this.score = 0
        this.isCompleted = false
      })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 8, right: 8, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  QuestionCard() {
    Column({ space: 6 }) {
      Row() {
        Text(`Question ${this.currentIndex + 1}/${this.questions.length}`)
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor('#F1F5F9')
      .borderRadius(8)
      .justifyContent(FlexAlign.Center)

      Text(this.questions[this.currentIndex].title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')

      ForEach(this.questions[this.currentIndex].options, (option: string, idx: number) => {
        Row() {
          Text(option)
            .fontSize(this.selectedOption === idx ? 14 : 12)
            .fontWeight(this.selectedOption === idx ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selectedOption === idx ? '#FFFFFF' : '#0B1220')
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor(this.selectedOption === idx ? '#7C3AED' : '#FFFFFF')
        .border({ width: 1, color: '#E2E8F0', radius: 8 })
        .onClick(() => {
          this.selectedOption = idx
        })
      }, (option: string, idx: number) => `${idx}_${option}`)
    }
    .width('100%')
    .padding(8)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E2E8F0', radius: 12 })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
  }

  @Builder
  SelectedRow() {
    Row() {
      Column({ space: 2 }) {
        Text('Selected')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Text(this.selectedOption >= 0 ? this.questions[this.currentIndex].options[this.selectedOption] : 'None')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button() {
        Text('Skip')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
      .height(32)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E2E8F0', radius: 6 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      if (this.isCompleted) {
        this.CompletionScreen()
      } else {
        Scroll() {
          Column({ space: 8 }) {
            this.QuestionCard()
            this.SelectedRow()
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }
}

interface QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number
}