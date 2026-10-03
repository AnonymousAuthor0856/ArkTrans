@Entry
@Component
struct QuizRootView {
  @State private selected: number = -1;
  @State private reviewed: boolean = false;
  @State private progress: number = 0.25;

  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];

  @Builder
  AssistChip(label: string, isOn: boolean) {
    Button(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(isOn ? '#0F172A' : '#0B1220')
      .backgroundColor(isOn ? '#22C55E' : '#FFFFFF')
      .border({ width: 1, color: '#E2E8F0', radius: 6 })
      .borderRadius(6)
      .height(36)
      .padding({ left: 14, right: 14 })
  }

  @Builder
  OptionButton(option: string, index: number) {
    Button(option)
      .fontSize(this.selected === index ? 14 : 12)
      .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selected === index ? '#FFFFFF' : '#0B1220')
      .backgroundColor(this.selected === index ? '#7C3AED' : '#FFFFFF')
      .border({ width: 1, color: '#E2E8F0', radius: 8 })
      .borderRadius(8)
      .width('100%')
      .height(40)
      .padding({ left: 16, right: 16 })
      .margin({ top: 6, bottom: 6 })
      .onClick(() => {
        this.selected = index;
      })
  }

  @Builder
  QuestionCard() {
    Column() {
      Stack() {
        Rect()
          .width('100%')
          .height(120)
          .fill('#F1F5F9')
          .radius(8)
        Text('Question 1/4')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
      }
      .width('100%')

      Text('Which planet is known as the Red Planet?')
        .fontSize(18)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#0B1220')
        .width('100%')
        .margin({ top: 8 })

      Column() {
        ForEach(this.options, (option: string, index: number) => {
          this.OptionButton(option, index)
        }, (option: string) => option)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(8)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E2E8F0', radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 3, color: '#14000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Progress')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width(140)
            .height(6)
            .radius(3)
            .fill('#F1F5F9')
          Rect()
            .width(140 * this.progress)
            .height(6)
            .radius(3)
            .fill('#7C3AED')
          Circle()
            .width(6)
            .height(6)
            .fill('#7C3AED')
            .margin({ left: 140 * this.progress - 3 })
        }
        .width(140)
        .height(6)
        .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Review')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.reviewed ? '#0F172A' : '#0B1220')
        .backgroundColor(this.reviewed ? '#22C55E' : '#FFFFFF')
        .border({ width: 1, color: '#E2E8F0', radius: 6 })
        .borderRadius(6)
        .height(36)
        .padding({ left: 14, right: 14 })
        .onClick(() => {
          this.reviewed = !this.reviewed;
        })

      Button('Next')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#7C3AED')
        .width(140)
        .height(44)
        .borderRadius(12)
        .margin({ left: 8 })
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    .backgroundColor('#A6FAFAFF')
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .fill('#7C3AED')
            .radius(6)
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0B1220')
            .margin({ left: 4 })
        }
        .justifyContent(FlexAlign.Center)
        .padding({ left: 8, right: 8, top: 24, bottom: 16 })

        Scroll() {
          Column() {
            this.QuestionCard()
              .margin({ left: 8, right: 8 })

            Row() {
              Column() {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              this.AssistChip('Skip', false)
            }
            .width('100%')
            .padding({ left: 8, right: 8 })
            .margin({ top: 8 })

            Blank().height(120)
          }
          .width('100%')
          .padding({ top: 6, bottom: 6 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FAFAFF')

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }
}
