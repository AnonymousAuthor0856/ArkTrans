@Entry
@Component
struct QuizRootView {
  @State selected: number = -1;
  @State reviewed: boolean = false;
  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter'];
  private progress: number = 0.25;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top App Bar
        Row({ space: 4 }) {
          Column()
            .width(20)
            .height(20)
            .borderRadius(6)
            .backgroundColor('#7C3AED')

          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 24, bottom: 16, left: 8, right: 8 })

        Scroll() {
          Column({ space: 8 }) {
            // Card
            Column({ space: 8 }) {
              // Question image placeholder
              Stack() {
                Column()
                  .width('100%')
                  .height(120)
                  .borderRadius(8)
                  .backgroundColor('#F1F5F9')

                Text('Question 1/4')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
              }
              .width('100%')
              .height(120)

              Text('Which planet is known as the Red Planet?')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .width('100%')
                .textAlign(TextAlign.Start)

              // Options
              Column({ space: 4 }) {
                ForEach(this.options, (option: string, i: number) => {
                  Button() {
                    Text(option)
                      .fontSize(this.selected === i ? 14 : 12)
                      .fontWeight(this.selected === i ? FontWeight.Medium : FontWeight.Normal)
                      .fontColor(this.selected === i ? '#FFFFFF' : '#0B1220')
                      .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                  }
                  .width('auto')
                  .backgroundColor(this.selected === i ? '#7C3AED' : '#FFFFFF')
                  .borderRadius(8)
                  .borderWidth(1)
                  .borderColor('#E2E8F0')
                  .margin({ top: 6, bottom: 6 })
                  .onClick(() => {
                    this.selected = i;
                  })
                  .buttonStyle(ButtonStyleMode.NORMAL)
                }, (option: string) => option)
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')
            }
            .alignItems(HorizontalAlign.Start)
            .padding(8)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .borderWidth(1)
            .borderColor('#E2E8F0')
            .shadow({
              radius: 3,
              color: '#14000000',
              offsetX: 0,
              offsetY: 1
            })
            .margin({ left: 8, right: 8 })
            .width('calc(100% - 16vp)')

            // Selected + Skip row
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

              // Skip chip
              Button() {
                Text('Skip')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .padding({ top: 10, bottom: 10, left: 14, right: 14 })
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .borderWidth(1)
              .borderColor('#E2E8F0')
              .buttonStyle(ButtonStyleMode.NORMAL)
            }
            .width('100%')
            .padding({ left: 8, right: 8 })
          }
          .padding({ top: 6, bottom: 120 })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FAFAFF')

      // Bottom Bar
      Column() {
        Divider()
          .color('#E2E8F0')
          .strokeWidth(1)

        Row() {
          // Progress section
          Column({ space: 2 }) {
            Text('Progress')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')

            Stack({ alignContent: Alignment.Start }) {
              // Background track
              Column()
                .width(140)
                .height(6)
                .borderRadius(3)
                .backgroundColor('#F1F5F9')

              // Progress fill
              Column()
                .width(140 * this.progress)
                .height(6)
                .borderRadius(3)
                .backgroundColor('#7C3AED')

              // Dot marker
              Column()
                .width(6)
                .height(6)
                .borderRadius(3)
                .backgroundColor('#7C3AED')
                .margin({ left: 140 * this.progress - 3 })
            }
            .width(140)
            .height(6)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          // Review chip
          Button() {
            Text('Review')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.reviewed ? '#0F172A' : '#0B1220')
              .padding({ top: 10, bottom: 10, left: 14, right: 14 })
          }
          .backgroundColor(this.reviewed ? '#22C55E' : '#FFFFFF')
          .borderRadius(6)
          .borderWidth(1)
          .borderColor('#E2E8F0')
          .margin({ right: 8 })
          .onClick(() => {
            this.reviewed = !this.reviewed;
          })
          .buttonStyle(ButtonStyleMode.NORMAL)

          // Next button
          Button() {
            Text('Next')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .width(140)
          .height(44)
          .backgroundColor('#7C3AED')
          .borderRadius(12)
          .buttonStyle(ButtonStyleMode.NORMAL)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor('#FAFAFF')
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}