@Entry
@Component
struct QuizRootView {
  @State selected: number = -1
  @State reviewed: boolean = false
  @State progress: number = 0.25

  private options: string[] = ['Earth', 'Mars', 'Venus', 'Jupiter']

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FAFAFF')

      Column({ space: 0 }) {
        // Top App Bar
        Row({ space: 4 }) {
          Blank().width(20).height(20).backgroundColor('#7C3AED').borderRadius(6)
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
        }
        .width('100%')
        .padding({ top: 24, bottom: 16 })
        .padding({ left: 8, right: 8 })

        // Scrollable content
        List() {
          // Card with question and options
          ListItem() {
            Column({ space: 8 }) {
              // Image placeholder
              Stack() {
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
                .fontWeight(FontWeight.Bold)
                .fontColor('#0B1220')

              // Options
              ForEach(this.options, (option: string, index: number) => {
                Button() {
                  Row() {
                    Text(option)
                      .fontSize(this.selected === index ? 14 : 12)
                      .fontWeight(this.selected === index ? FontWeight.Medium : FontWeight.Regular)
                      .fontColor(this.selected === index ? '#FFFFFF' : '#0B1220')
                  }
                  .padding({ top: 8, bottom: 8, left: 16, right: 16 })
                  .width('100%')
                }
                .backgroundColor(this.selected === index ? '#7C3AED' : '#FFFFFF')
                .borderRadius(8)
                .border({ width: 1, color: '#E2E8F0' })
                .onClick(() => { this.selected = index })
              })
            }
            .padding(8)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#E2E8F0' })
            .shadow({ radius: 3, color: '#14000000' })
          }

          // Selected + Skip row
          ListItem() {
            Row() {
              Column({ space: 2 }) {
                Text('Selected')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                Text(this.selected !== -1 ? this.options[this.selected] : 'None')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
              }
              Blank()
              Button() {
                Text('Skip')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                  .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(6)
              .border({ width: 1, color: '#E2E8F0' })
              .onClick(() => {})
            }
          }

          // Bottom spacer
          ListItem() {
            Column().height(120)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#FAFAFF')
      }

      // Bottom overlay bar
      Column() {
        Blank()
        Column({ space: 0 }) {
          Divider().height(1).color('#E2E8F0')
          Row() {
            Column({ space: 2 }) {
              Text('Progress')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
                .width(140)
                .height(6)
                .color('#7C3AED')
            }
            Blank()
            Button() {
              Text('Review')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.reviewed ? '#0F172A' : '#0B1220')
                .padding({ left: 14, right: 14, top: 10, bottom: 10 })
            }
            .backgroundColor(this.reviewed ? '#22C55E' : '#FFFFFF')
            .borderRadius(6)
            .border({ width: 1, color: '#E2E8F0' })
            .onClick(() => { this.reviewed = !this.reviewed })

            Button() {
              Text('Next')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .width(140)
                .height(44)
            }
            .backgroundColor('#7C3AED')
            .borderRadius(12)
            .width(140)
            .height(44)
            .onClick(() => {})
          }
          .padding({ left: 8, right: 8, top: 8, bottom: 8 })
          .backgroundColor('#FAFAFF')
        }
      }
    }
    .width('100%')
    .height('100%')
  }
}