@Entry
@Component
struct Index {
  @State selected: number = -1
  @State completed: boolean = false
  @State score: number = 0
  @State index: number = 0

  // Mock data to match the screenshot content
  private questions: Question[] = [
    {
      title: "Which planet is known as the Red Planet?",
      options: ["Earth", "Mars", "Venus", "Jupiter"]
    }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        // Header Area (Top App Bar equivalent)
        Row({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
            // Placeholder for icon if needed, or just spacing
          }.width(20).height(20).backgroundColor('#7C3AED').borderRadius(4)
          
          Text('Quiz')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 20 })

        // Main Content Card
        Column({ space: 6 }) {
          // Question Counter Box
          Stack({ alignContent: Alignment.Center }) {
            Text(`Question ${this.index + 1}/${this.questions.length}`)
              .fontSize(14)
              .fontColor('#0B1220')
          }
          .width('100%')
          .height(120)
          .backgroundColor('#F1F5F9')
          .borderRadius(12)

          // Question Title
          Text(this.questions[this.index].title)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .margin({ top: 8 })

          // Options List
          Column({ space: 4 }) {
            ForEach(this.questions[this.index].options, (option: string, i: number) => {
              Button() {
                Text(option)
                  .fontSize(16)
                  .fontColor(this.selected === i ? '#FFFFFF' : '#0B1220')
              }
              .width('auto')
              .height(44)
              .backgroundColor(this.selected === i ? '#7C3AED' : '#FFFFFF')
              .borderWidth(1)
              .borderColor('#E2E8F0')
              .borderRadius(12)
              .onClick(() => {
                this.selected = i
              })
            }, (item: string) => item)
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })
        .margin({ top: 10 })

        // Selection Info & Skip
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Selected')
              .fontSize(12)
              .fontColor('#0B1220')
            
            Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : "None")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text('Skip')
              .fontSize(14)
              .fontColor('#0B1220')
          }
          .backgroundColor('#FFFFFF')
          .borderWidth(1)
          .borderColor('#E2E8F0')
          .borderRadius(8)
          .height(36)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        Blank() // Spacer to push footer down
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FAFAFF')

      // Footer / Bottom Bar
      Column() {
        Row({ space: 0 }) {
          Column({ space: 2 }) {
            Text('Progress')
              .fontSize(12)
              .fontColor('#0B1220')
            
            Progress({ value: this.completed ? 100 : ((this.index + (this.selected >= 0 ? 1 : 0)) / this.questions.length) * 100, total: 100, type: ProgressType.Linear })
              .width(140)
              .height(6)
              .color('#7C3AED')
              .trackColor('#F1F5F9')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Row({ space: 4 }) {
            Button() {
              Text('Review')
                .fontSize(14)
                .fontColor('#0B1220')
            }
            .backgroundColor('#FFFFFF')
            .borderWidth(1)
            .borderColor('#E2E8F0')
            .borderRadius(8)
            .height(36)

            Button() {
              Text(this.index < this.questions.length - 1 ? "Next" : (this.completed ? "Done" : "Finish"))
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .backgroundColor('#7C3AED')
            .borderRadius(12)
            .height(44)
            .width(140)
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: '100%' }) // Position at bottom
      .translate({ y: -60 }) // Adjust height roughly
    }
    .width('100%')
    .height('100%')
  }
}

interface Question {
  title: string;
  options: string[];
}