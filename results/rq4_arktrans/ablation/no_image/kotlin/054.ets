@Entry
@Component
struct Index {
  @State charts: Array<ChartData> = [
    new ChartData(1, "Week 1", 0.7),
    new ChartData(2, "Week 2", 0.9),
    new ChartData(3, "Week 3", 0.5),
    new ChartData(4, "Week 4", 0.8)
  ]
  @State Assignments: number = 0
  @State wTitle: string = ""
  @State wStatus: string = ""
  @State ProgressChart: string = ""
  @State c: number = 0
  @State SubmitNewHW: string = ""
  @State HomeworkSubmit: string = ""

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 14 }) {
        Text('Assignments').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#1E293B')

        Grid() {
          GridItem() {
            Column() {
              Column({ space: 0 }) {
                Stack({ alignContent: Alignment.Center }) {
                  // Placeholder for icon or shape as per skeleton structure
                }.width(40).height(40).backgroundColor('#06B6D4').borderRadius(8)

                Blank().height(6)

                Text(this.wTitle).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E293B')
                Text(this.wStatus).fontSize(12).fontWeight(FontWeight.Normal).fontColor('#1E293B')
              }.alignItems(HorizontalAlign.Center).width('100%').height('100%').padding(10)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          }
        }.columnsTemplate('1fr 1fr').width('100%')

        Text('Progress Chart').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#1E293B')

        List({ space: 6 }) {
          ForEach(this.charts, (item: ChartData) => {
            ListItem() {
              Column() {
                Row({ space: 0 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    // Progress bar fill
                  }.width(`${item.progress * 100}%`).height(24).backgroundColor('#0EA5E9').borderRadius(8)
                }.width('100%').height(24).backgroundColor('#E2E8F0').borderRadius(8)

                Text(`${item.label}: ${Math.round(item.progress * 100)}%`).fontSize(14).fontColor('#1E293B')
              }
            }
          })
        }.width('100%')

        Button() {
          Text('Submit New HW').fontSize(16).fontWeight(FontWeight.Medium)
        }.height(40).width('60%').backgroundColor('#0EA5E9').borderRadius(12)
      }.width('100%').height('100%').padding(14).linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0EA5E9', 0.15], ['#8B5CF6', 0.1]]
      })

      Row() {
        Text('Homework Submit').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#1E293B')
      }.width('100%').height(56).justifyContent(FlexAlign.Center)
    }.width('100%').height('100%')
  }
}

class ChartData {
  id: number;
  label: string;
  progress: number;

  constructor(id: number, label: string, progress: number) {
    this.id = id;
    this.label = label;
    this.progress = progress;
  }
}