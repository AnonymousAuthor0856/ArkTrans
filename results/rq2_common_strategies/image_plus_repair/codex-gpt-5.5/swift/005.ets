const PRIMARY: string = '#7C3AED'
const BACKGROUND: string = '#FAFAFF'
const SURFACE: string = '#FFFFFF'
const SURFACE_VARIANT: string = '#F1F5F9'
const OUTLINE: string = '#E2E8F0'
const TEXT: string = '#0B1220'

@Entry
@Component
struct QuizPage {
  @State selected: number = -1
  @State reviewed: boolean = false

  private readonly options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 8 }) {
          Row({ space: 8 }) {
            Row()
              .width(40)
              .height(40)
              .borderRadius(12)
              .backgroundColor(PRIMARY)

            Text('Quiz')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT)
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .padding({ top: 24, bottom: 16 })

          Column({ space: 16 }) {
            Stack() {
              Row()
                .width('100%')
                .height(240)
                .borderRadius(16)
                .backgroundColor(SURFACE_VARIANT)

              Text('Question 1/4')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(TEXT)
            }
            .width('100%')

            Text('Which planet is known as the\nRed Planet?')
              .width('100%')
              .fontSize(36)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT)
              .lineHeight(44)

            Column({ space: 8 }) {
              ForEach(this.options, (option: string, index: number) => {
                Button({ type: ButtonType.Normal }) {
                  Text(option)
                    .fontSize(this.selected === index ? 22 : 20)
                    .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                    .fontColor(this.selected === index ? SURFACE : TEXT)
                }
                .width(index === 3 ? 144 : 124)
                .height(62)
                .alignSelf(ItemAlign.Start)
                .borderRadius(16)
                .backgroundColor(this.selected === index ? PRIMARY : SURFACE)
                .border({ width: 1, color: OUTLINE })
                .shadow({
                  radius: 8,
                  color: '#180B1220',
                  offsetX: 0,
                  offsetY: 2
                })
                .onClick(() => {
                  this.selected = index
                })
              })
            }
            .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(16)
          .margin({ left: 16, right: 16 })
          .borderRadius(20)
          .backgroundColor(SURFACE)
          .border({ width: 1, color: OUTLINE })
          .shadow({
            radius: 8,
            color: '#180B1220',
            offsetX: 0,
            offsetY: 2
          })

          Row() {
            Column({ space: 2 }) {
              Text('Selected')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor(TEXT)

              Text(this.selected >= 0 ? this.options[this.selected] : 'None')
                .fontSize(26)
                .fontColor(TEXT)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
              .layoutWeight(1)

            Button({ type: ButtonType.Normal }) {
              Text('Skip')
                .fontSize(20)
                .fontColor(TEXT)
            }
            .width(100)
            .height(64)
            .borderRadius(12)
            .backgroundColor(SURFACE)
            .border({ width: 1, color: OUTLINE })
            .onClick(() => {
              this.selected = -1
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 128 })
        }
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')

      Row() {
        Column({ space: 4 }) {
          Text('Progress')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT)

          Stack() {
            Row()
              .width(280)
              .height(12)
              .borderRadius(6)
              .backgroundColor(SURFACE_VARIANT)

            Row()
              .width(70)
              .height(12)
              .borderRadius(6)
              .backgroundColor(PRIMARY)

            Row()
              .width(12)
              .height(12)
              .borderRadius(6)
              .backgroundColor(PRIMARY)
              .translate({ x: 64 })
          }
          .width(280)
          .height(12)
          .alignContent(Alignment.Start)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Button({ type: ButtonType.Normal }) {
          Text('Review')
            .fontSize(20)
            .fontColor(TEXT)
        }
        .width(126)
        .height(64)
        .borderRadius(12)
        .backgroundColor(SURFACE)
        .border({ width: 1, color: OUTLINE })
        .onClick(() => {
          this.reviewed = !this.reviewed
        })

        Button({ type: ButtonType.Normal }) {
          Text('Next')
            .fontSize(28)
            .fontColor(SURFACE)
        }
        .width(280)
        .height(88)
        .margin({ left: 16 })
        .borderRadius(28)
        .backgroundColor(PRIMARY)
        .onClick(() => {
          this.selected = -1
          this.reviewed = false
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 12 })
      .backgroundColor('#F7F7FC')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
