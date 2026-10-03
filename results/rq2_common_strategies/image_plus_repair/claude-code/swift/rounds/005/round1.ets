@Entry
@Component
struct QuizPage {
  @State selected: number = -1
  @State reviewed: boolean = false
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']
  private progress: number = 0.25

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
        }
        .width(20)
        .height(20)
        .backgroundColor('#7C3AED')
        .borderRadius(6)

        Text('Quiz')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0B1220')
      }
      .margin({ top: 24, bottom: 16 })

      Scroll() {
        Column({ space: 8 }) {
          // Card
          Column() {
            // Question header
            Stack({ alignContent: Alignment.Center }) {
              Text('Question 1/4')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .width('100%')
            .height(120)
            .backgroundColor('#F1F5F9')
            .borderRadius(8)

            Text('Which planet is known as the Red Planet?')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor('#0B1220')
              .margin({ top: 8 })

            // Options
            Column({ space: 4 }) {
              ForEach(this.options, (item: string, index: number) => {
                Button(item)
                  .fontSize(this.selected === index ? 14 : 12)
                  .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                  .fontColor(this.selected === index ? '#FFFFFF' : '#0B1220')
                  .width('auto')
                  .height(40)
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  .backgroundColor(this.selected === index ? '#7C3AED' : '#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#E2E8F0' })
                  .margin({ top: 6, bottom: 6 })
                  .onClick(() => {
                    this.selected = index
                  })
              }, (item: string, index: number) => index.toString())
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 8 })
          }
          .width('100%')
          .padding(8)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .border({ width: 1, color: '#E2E8F0' })
          .shadow({
            radius: 3,
            color: 'rgba(0, 0, 0, 0.08)',
            offsetX: 0,
            offsetY: 1
          })
          .margin({ left: 8, right: 8 })

          // Selected + Skip
          Row() {
            Column({ space: 2 }) {
              Text('Selected')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Skip')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .width('auto')
              .height(36)
              .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#E2E8F0' })
              .onClick(() => {})
          }
          .width('100%')
          .margin({ left: 8, right: 8 })

          // Bottom spacing
          Blank()
            .height(120)
        }
        .width('100%')
        .padding({ top: 6, bottom: 6 })
      }
      .layoutWeight(1)

      // Bottom Bar
      Row() {
        Column({ space: 2 }) {
          Text('Progress')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          Stack({ alignContent: Alignment.Start }) {
            Row() {}
            .width('100%')
            .height(6)
            .backgroundColor('#F1F5F9')
            .borderRadius(3)

            Row() {}
            .width(this.progress * 140)
            .height(6)
            .backgroundColor('#7C3AED')
            .borderRadius(3)
          }
          .width(140)
          .height(6)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Review')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.reviewed ? '#0F172A' : '#0B1220')
          .width('auto')
          .height(40)
          .padding({ left: 14, right: 14, top: 10, bottom: 10 })
          .backgroundColor(this.reviewed ? '#22C55E' : '#FFFFFF')
          .borderRadius(6)
          .border({ width: 1, color: '#E2E8F0' })
          .onClick(() => {
            this.reviewed = !this.reviewed
          })

        Button('Next')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .width(140)
          .height(44)
          .backgroundColor('#7C3AED')
          .borderRadius(12)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      .backgroundColor('rgba(250, 250, 255, 0.65)')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFF')
  }
}
