import { Alignment, FlexAlign, VerticalAlign, HorizontalAlign, FontWeight } from '@kit.ArkUI';

interface QuestionOption {
  text: string;
  idx: number;
}

interface QuestionItem {
  title: string;
  options: Array<string>;
}

@Entry
@Component
struct Index {
  @State selected: number = -1
  @State completed: boolean = false
  @State score: number = 0
  @State index: number = 0
  @State syncProgress: number = 0.3

  private questions: Array<QuestionItem> = [
    { title: "What is ArkTS?", options: ["A language", "A framework"] },
    { title: "What is Compose?", options: ["UI Toolkit", "Database"] }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        Text('Quiz Completed')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')

        Blank().height(8)

        Stack({ alignContent: Alignment.Center }) {
          Text(`Score: ${this.score}/${this.questions.length}`)
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#7C3AED')
        }
        .width('100%')
        .height(120)
        .backgroundColor('#F1F5F9')
        .borderRadius(16)

        Blank().height(8)

        Button() {
          Text('Restart')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height(44)
        .backgroundColor('#7C3AED')
        .fontColor('#FFFFFF')
        .borderRadius(16)
        .onClick(() => {
          this.index = 0
          this.selected = -1
          this.score = 0
          this.completed = false
        })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding({ left: 8, right: 8, top: 12, bottom: 12 })

      List({ space: 8 }) {
        ListItem() {
          Column() {
            Column({ space: 6 }) {
              Stack({ alignContent: Alignment.Center }) {
                Text(`Question ${this.index + 1}/${this.questions.length}`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor('#F1F5F9')
              .borderRadius(8)

              Text(this.questions[this.index].title)
                .fontSize(28)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')

              Column({ space: 4 }) {
                ForEach(this.questions[this.index].options.map((opt, i) => ({ text: opt, idx: i } as QuestionOption)), (item: QuestionOption) => {
                  Button() {
                    Text(item.text)
                      .fontSize(item.idx === this.selected ? 16 : 14)
                      .fontWeight(item.idx === this.selected ? FontWeight.Medium : FontWeight.Normal)
                      .fontColor(item.idx === this.selected ? '#FFFFFF' : '#0B1220')
                  }
                  .width('100%')
                  .backgroundColor(item.idx === this.selected ? '#7C3AED' : '#FFFFFF')
                  .borderRadius(8)
                  .borderWidth(1)
                  .borderColor('#E0E0E0')
                  .onClick(() => {
                    this.selected = item.idx
                  })
                })
              }
              .alignItems(HorizontalAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(8)
          }
          .width('100%')
          .height(180)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        }

        ListItem() {
          Row({ space: 0 }) {
            Column({ space: 2 }) {
              Text('Selected')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              
              Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : "None")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .alignItems(HorizontalAlign.Start)

            Button() {
              Text('Skip')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .onClick(() => {})
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })

      Column() {
        Row({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
          }
          .width(20)
          .height(20)
          .backgroundColor('#7C3AED')
          .borderRadius(4)

          Text('Quiz')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
        }
        .alignItems(VerticalAlign.Center)
        
        Divider().color('#E0E0E0').margin({ top: 10, bottom: 10 })

        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Progress')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
            
            Progress({
              value: this.completed ? 1 : (this.index + (this.selected >= 0 ? 1 : 0)) / this.questions.length,
              total: 1,
              type: ProgressType.Linear
            })
            .width(140)
            .height(6)
            .color('#7C3AED')
            .trackColor('#F1F5F9')
          }
          .alignItems(HorizontalAlign.Start)

          Row({ space: 4 }) {
            Button() {
              Text('Review')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .onClick(() => {})

            Button() {
              Text(this.index < this.questions.length - 1 ? "Next" : (!this.completed ? "Finish" : "Done"))
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .height(44)
            .width(140)
            .backgroundColor('#7C3AED')
            .borderRadius(16)
            .onClick(() => {})
          }
          .alignItems(VerticalAlign.Center)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }
}