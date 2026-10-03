// src/main/ets/entryability/EntryAbility.ets
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // Ability creation logic
  }

  onDestroy(): void {
    // Ability destruction logic
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        return;
      }
    });
  }
}

// src/main/ets/pages/Index.ets
@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  @State selectedOption: number = -1
  @State score: number = 0
  @State isCompleted: boolean = false
  @State isReviewFlagged: boolean = false

  private questions: QuestionUi[] = [
    new QuestionUi(1, "Which planet is known as the Red Planet?", ["Earth", "Mars", "Venus", "Jupiter"], 1),
    new QuestionUi(2, "What is the chemical symbol for water?", ["H2O", "CO2", "NaCl", "O2"], 0),
    new QuestionUi(3, "Who wrote Hamlet?", ["Charles Dickens", "Mark Twain", "William Shakespeare", "Jane Austen"], 2),
    new QuestionUi(4, "What is the largest mammal?", ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"], 1)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // === Top Bar ===
        Row() {
          // Icon placeholder
          Row() {
            Text("Quiz")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
          }
          .width(20)
          .height(20)
          .backgroundColor('#7C3AED')
          .borderRadius(6)
          
          Text("Quiz")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .margin({ left: 4 })
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .padding({ top: 20 }) // Simulating status bar padding

        // === Main Content Area ===
        if (this.isCompleted) {
          this.CompletedView()
        } else {
          this.QuizView()
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FAFAFF')

      // === Bottom Bar ===
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  CompletedView() {
    Column() {
      Text("Quiz Completed")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#0B1220')
      
      Blank().height(8)

      Row() {
        Text(`Score: ${this.score}/${this.questions.length}`)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#7C3AED')
      }
      .width('100%')
      .height(120)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F1F5F9')
      .borderRadius(12)
      .margin({ left: 8, right: 8 })

      Blank().height(8)

      Button("Restart")
        .width('100%')
        .height(44)
        .backgroundColor('#22C55E')
        .fontColor('#0F172A')
        .borderRadius(12)
        .margin({ left: 8, right: 8 })
        .onClick(() => {
          this.currentIndex = 0
          this.selectedOption = -1
          this.score = 0
          this.isCompleted = false
        })
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding({ left: 8, right: 8, top: 12, bottom: 12 })
  }

  @Builder
  QuizView() {
    Column() {
      // Question Card
      Column() {
        // Aspect Ratio Box
        Row() {
          Text(`Question ${this.currentIndex + 1}/${this.questions.length}`)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
        }
        .width('100%')
        .aspectRatio(2.8)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#F1F5F9')
        .borderRadius(8)

        Text(this.questions[this.currentIndex].title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .margin({ top: 6 })

        // Options
        Column() {
          ForEach(this.questions[this.currentIndex].options, (option: string, index: number) => {
            this.OptionChip(option, index)
          })
        }
        .margin({ top: 6 })
        .width('100%')
      }
      .width('100%')
      .padding(8)
      .backgroundColor('#FFFFFF')
      .borderRadius(12)
      .border({ width: 1, color: '#E2E8F0' })
      .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetY: 1 })
      .margin({ left: 8, right: 8, top: 12 })

      // Selected Info & Skip
      Row() {
        Column() {
          Text("Selected")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          
          Text(this.selectedOption >= 0 ? this.questions[this.currentIndex].options[this.selectedOption] : "None")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
        }
        
        Blank()

        Button("Skip")
          .backgroundColor('#FFFFFF')
          .fontColor('#0B1220')
          .border({ width: 1, color: '#E2E8F0' })
          .borderRadius(6)
          .height(32)
      }
      .width('100%')
      .margin({ left: 8, right: 8, top: 8 })
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ bottom: 24 }) // Space for bottom bar
  }

  @Builder
  OptionChip(text: string, index: number) {
    Button(text)
      .width('auto')
      .height(40)
      .backgroundColor(this.selectedOption === index ? '#7C3AED' : '#FFFFFF')
      .fontColor(this.selectedOption === index ? '#FFFFFF' : '#0B1220')
      .fontSize(this.selectedOption === index ? 14 : 12)
      .fontWeight(this.selectedOption === index ? FontWeight.Medium : FontWeight.Normal)
      .border({ width: 1, color: '#E2E8F0' })
      .borderRadius(8)
      .margin({ bottom: 4 })
      .onClick(() => {
        this.selectedOption = index
      })
  }

  @Builder
  BottomBar() {
    Row() {
      // Progress Section
      Column() {
        Text("Progress")
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        
        Progress({
          value: this.isCompleted ? 100 : ((this.currentIndex + (this.selectedOption >= 0 ? 1 : 0)) / this.questions.length) * 100,
          total: 100,
          type: ProgressType.Linear
        })
        .width(140)
        .height(6)
        .color('#7C3AED')
        .trackColor('#F1F5F9')
        .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Review Chip
      Button("Review")
        .backgroundColor(this.isReviewFlagged ? '#22C55E' : '#FFFFFF')
        .fontColor(this.isReviewFlagged ? '#0F172A' : '#0B1220')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .border({ width: 1, color: '#E2E8F0' })
        .borderRadius(6)
        .height(32)
        .margin({ right: 4 })
        .onClick(() => {
          this.isReviewFlagged = !this.isReviewFlagged
        })

      // Next/Finish/Done Button
      Button(this.currentIndex < this.questions.length - 1 ? "Next" : (!this.isCompleted ? "Finish" : "Done"))
        .width(140)
        .height(44)
        .backgroundColor('#7C3AED')
        .fontColor('#FFFFFF')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
        .onClick(() => {
          if (!this.isCompleted) {
            if (this.selectedOption === this.questions[this.currentIndex].answer) {
              this.score++
            }
            if (this.currentIndex < this.questions.length - 1) {
              this.currentIndex++
              this.selectedOption = -1
            } else {
              this.isCompleted = true
            }
          }
        })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.16)', offsetY: 1.5 })
  }
}

class QuestionUi {
  id: number
  title: string
  options: string[]
  answer: number

  constructor(id: number, title: string, options: string[], answer: number) {
    this.id = id
    this.title = title
    this.options = options
    this.answer = answer
  }
}