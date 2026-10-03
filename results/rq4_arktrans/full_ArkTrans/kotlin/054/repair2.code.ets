interface ChartData {
  id: number;
  label: string;
  progress: number;
}

interface AssignmentItem {
  title: string;
  status: string;
}

@Entry
@Component
struct Index {
  @State charts: Array<ChartData> = [
    { id: 1, label: "Week 1", progress: 0.7 },
    { id: 2, label: "Week 2", progress: 0.9 },
    { id: 3, label: "Week 3", progress: 0.5 },
    { id: 4, label: "Week 4", progress: 0.8 }
  ]
  @State assignments: string = "Assignments"
  @State wTitle: string = ""
  @State wStatus: string = ""
  @State progressChart: string = "Progress Chart"
  @State c: number = 0
  @State submitNewHw: string = "Submit New HW"
  @State homeworkSubmit: string = "Homework Submit"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 14 }) {
        Text(this.assignments).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1E293B')

        Grid() {
          ForEach([
            { title: "Linear Algebra HW1", status: "Submitted" },
            { title: "Data Structures HW2", status: "Pending" },
            { title: "Algorithm HW3", status: "Graded" },
            { title: "Probability HW4", status: "Pending" }
          ], (item: AssignmentItem) => {
            GridItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Row() {
                    Image($r('app.media.startIcon')).width(40).height(40)
                  }.backgroundColor('#06B6D4').borderRadius(8)
                }
                Blank().height(6)
                Text(item.title).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E293B')
                Text(item.status).fontSize(14).fontColor('#1E293B')
              }.alignItems(HorizontalAlign.Center).width('100%').height('100%').padding(10)
            }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
          })
        }.columnsTemplate('1fr 1fr').rowsGap(10).columnsGap(10)

        Text(this.progressChart).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#1E293B')

        List({ space: 6 }) {
          ForEach(this.charts, (chart: ChartData) => {
            ListItem() {
              Row() {
                Stack({ alignContent: Alignment.Start }) {
                  Row() {
                    Text(`${chart.label}: ${Math.round(chart.progress * 100)}%`).fontSize(16).fontColor('#1E293B')
                  }.width(`${chart.progress * 100}%`).backgroundColor('#0EA5E9').borderRadius(4)
                }.width('100%').height(24).backgroundColor('#E2E8F0').borderRadius(4)
              }.width('100%')
            }
          })
        }.width('100%')

        Button() {
          Text(this.submitNewHw).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
        }.height(40).width('60%').backgroundColor('#0EA5E9').borderRadius(20)
      }.width('100%').height('100%').padding(14).backgroundColor('#F1F5F9')

      NavigationBarPosition.Top
      TopAppBar({ title: this.homeworkSubmit }) {
        // Empty content for leading/trailing if needed
      }
    }.width('100%').height('100%')
  }
}