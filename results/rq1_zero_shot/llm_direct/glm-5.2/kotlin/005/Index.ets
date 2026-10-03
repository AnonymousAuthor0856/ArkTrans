// 008_EducationQuiz_en.ets
import { LengthMetrics, Modifier, Animateable } from '@ohos/arkui';

interface QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;
}

const questions: QuestionUi[] = [
  { id: 1, title: "Which planet is known as the Red Planet?", options: ["Earth", "Mars", "Venus", "Jupiter"], answer: 1 },
  { id: 2, title: "What is the chemical symbol for water?", options: ["H2O", "CO2", "NaCl", "O2"], answer: 0 },
  { id: 3, title: "Who wrote Hamlet?", options: ["Charles Dickens", "Mark Twain", "William Shakespeare", "Jane Austen"], answer: 2 },
  { id: 4, title: "What is the largest mammal?", options: ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"], answer: 1 }
];

@Entry
@Component
struct RootScreen {
  @State index: number = 0;
  @State selected: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State flags: string[] = [];

  get progress(): number {
    if (this.completed) return 1;
    return (this.index + (this.selected >= 0 ? 1 : 0)) / questions.length;
  }

  get buttonText(): string {
    if (this.index < questions.length - 1) return "Next";
    if (!this.completed) return "Finish";
    return "Done";
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Box()
            .width(20)
            .height(20)
            .backgroundColor("#7C3AED")
            .borderRadius(6)
            .margin({ right: 4 })
          Text("Quiz")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor("#0B1220")
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor("#FFFFFF")

      if (this.completed) {
        // Completion Screen
        Column() {
          Text("Quiz Completed")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor("#0B1220")
            .margin({ bottom: 8 })

          Box() {
            Text(`Score: ${this.score}/${questions.length}`)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor("#7C3AED")
          }
          .width('100%')
          .height(120)
          .backgroundColor("#F1F5F9")
          .borderRadius(12)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 8 })

          Button("Restart")
            .width('100%')
            .height(44)
            .backgroundColor("#22C55E")
            .fontColor("#0F172A")
            .borderRadius(12)
            .onClick(() => {
              this.index = 0;
              this.selected = -1;
              this.score = 0;
              this.completed = false;
            })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 8, right: 8, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      } else {
        // Quiz Content
        Scroll() {
          Column() {
            // Question Card
            Column() {
              // Image Placeholder
              Box() {
                Text(`Question ${this.index + 1}/${questions.length}`)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0B1220")
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor("#F1F5F9")
              .borderRadius(8)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .margin({ bottom: 6 })

              Text(questions[this.index].title)
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor("#0B1220")
                .margin({ bottom: 4 })

              // Options
              ForEach(questions[this.index].options, (option: string, i: number) => {
                Text(option)
                  .fontSize(this.selected === i ? 14 : 12)
                  .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
                  .fontColor(this.selected === i ? "#FFFFFF" : "#0B1220")
                  .width('100%')
                  .padding({ top: 8, bottom: 8, left: 12, right: 12 })
                  .backgroundColor(this.selected === i ? "#7C3AED" : "#FFFFFF")
                  .borderRadius(8)
                  .border({ width: 1, color: "#E2E8F0" })
                  .margin({ bottom: 4 })
                  .onClick(() => {
                    this.selected = i;
                  })
              })
            }
            .width('100%')
            .padding(8)
            .backgroundColor("#FFFFFF")
            .borderRadius(12)
            .border({ width: 1, color: "#E2E8F0" })
            .margin({ bottom: 8 })

            // Selected Row
            Row() {
              Column() {
                Text("Selected")
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0B1220")
                Text(this.selected >= 0 ? questions[this.index].options[this.selected] : "None")
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor("#0B1220")
              }
              .alignItems(HorizontalAlign.Start)

              Text("Skip")
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
                .padding({ top: 6, bottom: 6, left: 12, right: 12 })
                .backgroundColor("#FFFFFF")
                .borderRadius(6)
                .border({ width: 1, color: "#E2E8F0" })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding({ left: 8, right: 8, top: 6, bottom: 24 })
        }
        .layoutWeight(1)
      }

      // Bottom Bar
      Row() {
        Column() {
          Text("Progress")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor("#0B1220")
          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Box()
              .width('100%')
              .height(6)
              .backgroundColor("#F1F5F9")
              .borderRadius(3)
            // Indicator
            Box()
              .width(`${this.progress * 100}%`)
              .height(6)
              .backgroundColor("#7C3AED")
              .borderRadius(3)
          }
          .width(140)
          .height(6)
          .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          // Review Chip
          Text("Review")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.flags.includes("Review") ? "#0F172A" : "#0B1220")
            .padding({ top: 6, bottom: 6, left: 12, right: 12 })
            .backgroundColor(this.flags.includes("Review") ? "#22C55E" : "#FFFFFF")
            .borderRadius(6)
            .border({ width: 1, color: "#E2E8F0" })
            .onClick(() => {
              if (this.flags.includes("Review")) {
                this.flags = this.flags.filter(f => f !== "Review");
              } else {
                this.flags.push("Review");
              }
            })

          // Next/Finish Button
          Button(this.buttonText)
            .width(140)
            .height(44)
            .backgroundColor("#7C3AED")
            .fontColor("#FFFFFF")
            .borderRadius(12)
            .onClick(() => {
              if (!this.completed) {
                if (this.selected === questions[this.index].answer) {
                  this.score++;
                }
                if (this.index < questions.length - 1) {
                  this.index++;
                  this.selected = -1;
                } else {
                  this.completed = true;
                }
              }
            })
        }
        .justifyContent(FlexAlign.End)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor("#FFFFFF")
      .border({ width: 1, color: "#E2E8F0" })
    }
    .width('100%')
    .height('100%')
    .backgroundColor("#FAFAFF")
  }
}