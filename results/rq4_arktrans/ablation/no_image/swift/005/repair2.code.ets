@Entry
@Component
struct Index {
  @State progress: number = 0.5
  @State selected: number[] = []
  @State reviewed: boolean = false

  private options: string[] = ['Mars', 'Venus', 'Jupiter', 'Saturn']

  build() {
    Stack() {
      Column() {
        Row({ space: 12 }) {
          Rect().width(20).height(20).fill('#7C3AED')
          Text('Quiz').fontColor('#0B1220').fontSize(24)
        }.padding({ left: 24, right: 24, top: 24, bottom: 16 }).alignItems(VerticalAlign.Top)

        Scroll() {
          Column() {
            Column() {
              Rect().height(120).fill('#F1F5F9')
                .overlay(Text('Question 1/4').fontColor('#0B1220').fontSize(10))
              
              Text('Which planet is known as the Red Planet?').fontColor('#0B1220').fontSize(18)
              
              Column({ space: 12 }) {
                ForEach(this.options.map((_, i) => i), (index: number) => {
                  Button() {
                    Text(this.options[index])
                      .fontColor(this.selected.includes(index) ? '#FFFFFF' : '#0B1220')
                      .backgroundColor(this.selected.includes(index) ? '#7C3AED' : '#F1F5F9')
                      .borderRadius(8)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .padding(16)
                  }
                  .onClick(() => {
                    if (this.selected.includes(index)) {
                      this.selected = this.selected.filter(i => i !== index)
                    } else {
                      this.selected.push(index)
                    }
                  })
                  .type(ButtonType.Normal)
                  .width('100%')
                }, (index: number) => index.toString())
              }
            }
            .padding({ left: 24, right: 24, top: 24, bottom: 24 })
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 3, color: '#14000000', offsetY: 1 })
            .margin({ top: 24, bottom: 24 })

            Row() {
              Column({ space: 4 }) {
                Text('Selected').fontColor('#0B1220').fontSize(10)
                Text(this.selected.length > 0 
                  ? this.selected.map(i => this.options[i]).join(', ') 
                  : 'None')
                  .fontColor('#0B1220')
                  .fontSize(16)
              }
              Blank()
              Button() {
                Text(this.reviewed ? 'Reviewed' : 'Review')
                  .fontColor(this.reviewed ? '#FFFFFF' : '#0B1220')
                  .fontSize(10)
                  .padding({ left: 14, right: 14, top: 10, bottom: 10 })
              }
              .onClick(() => {
                this.reviewed = !this.reviewed
              })
              .backgroundColor(this.reviewed ? '#7C3AED' : '#FFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#E2E8F0' })
              .type(ButtonType.Normal)
            }.padding({ left: 24, right: 24 })
          }
          .padding({ top: 16, bottom: 120 })
        }
      }

      Row() {
        Column({ space: 4 }) {
          Text('Progress').fontColor('#0B1220').fontSize(10)
          Stack({ alignContent: Alignment.Start }) {
            Rect().height(6).fill('#F1F5F9').borderRadius(3)
            Rect()
              .width(`${Math.max(0, Math.min(1, this.progress)) * 100}%`)
              .height(6)
              .fill('#7C3AED')
              .borderRadius(3)
            Circle()
              .width(6)
              .height(6)
              .fill('#7C3AED')
              .position({ x: `${Math.max(0, Math.min(1, this.progress)) * 100}%`, y: '50%' })
              .translate({ x: -3 })
          }
          .width('100%')
        }
        Blank()
        
        // AssistChip equivalent
        Button() {
          Text('Review')
            .fontColor(this.reviewed ? '#FFFFFF' : '#0B1220')
            .fontSize(10)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        }
        .onClick(() => {
          this.reviewed = !this.reviewed
        })
        .backgroundColor(this.reviewed ? '#7C3AED' : '#F1F5F9')
        .borderRadius(16)
        .type(ButtonType.Normal)

        Button() {
          Text('Next')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }
        .backgroundColor('#7C3AED')
        .borderRadius(24)
        .type(ButtonType.Normal)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .backgroundColor('#0B12200A')
      .position({ x: 0, y: '100%' })
      .translate({ y: -60 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}