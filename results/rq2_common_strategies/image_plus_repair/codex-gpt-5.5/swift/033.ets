@Entry
@Component
struct BillCalendar {
  @State spending: number = 500
  private goal: number = 1000

  build() {
    Column() {
      Row() {
        Text('Bill Calendar')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F0F9FF')

      Scroll() {
        Column({ space: 16 }) {
          Stack({ alignContent: Alignment.TopStart }) {
            Column()
              .width('100%')
              .height(160)
              .backgroundColor('#FDFEFE')
              .borderRadius(20)
              .shadow({
                radius: 8,
                color: '#2E000000',
                offsetX: 0,
                offsetY: 4
              })

            Column() {
              Text('Current Spending')
                .fontSize(18)
                .fontColor('#06B6D4')

              Blank()
                .layoutWeight(1)

              Text(`$${Math.floor(this.spending)} / $${this.goal}`)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F172A')

              Blank()
                .layoutWeight(1)

              Stack({ alignContent: Alignment.Start }) {
                Row()
                  .width('100%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor('#E0F2FE')
                Row()
                  .width(`${Math.max(0, Math.min(100, this.spending / this.goal * 100))}%`)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor('#06B6D4')
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .height(160)
            .padding(16)
          }
          .width('100%')
          .height(160)

          Text('Adjust Spending')
            .width('100%')
            .textAlign(TextAlign.Center)
            .fontSize(18)
            .fontColor('#0F172A')

          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .height(32)
            .blockColor('#FFFFFF')
            .trackColor('#CBD5E1')
            .selectedColor('#06B6D4')
            .onChange((value: number) => {
              this.spending = value
            })

          Button('Reset')
            .width('100%')
            .height(48)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#8B5CF6')
            .borderRadius(12)
            .onClick(() => {
              this.spending = 0
            })
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        angle: 180,
        colors: [
          ['#4D3B82F6', 0],
          ['#F0F9FF', 0.55],
          ['#3306B6D4', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F9FF')
  }
}
