class Homework {
  id: number
  title: string
  status: string

  constructor(id: number, title: string, status: string) {
    this.id = id
    this.title = title
    this.status = status
  }
}

class ChartData {
  id: number
  label: string
  progress: number

  constructor(id: number, label: string, progress: number) {
    this.id = id
    this.label = label
    this.progress = progress
  }
}

@Entry
@Component
struct Index {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ]
  @State charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8)
  ]

  @Builder
  AssignmentCard(homework: Homework) {
    Column() {
      Rect()
        .width(40)
        .height(40)
        .radius(6)
        .fill('#06B6D4')
      Text(homework.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 6 })
      Text(homework.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
        .margin({ top: 6 })
    }
    .width('100%')
    .aspectRatio(1)
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#D1D5DB', radius: 10 })
  }

  @Builder
  ChartProgressBar(chartData: ChartData) {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Rect()
          .width('100%')
          .height(24)
          .radius(6)
          .fill('#E2E8F0')
        Rect()
          .width(`${Math.max(0, Math.min(100, chartData.progress * 100))}%`)
          .height(24)
          .radius(6)
          .fill('#0EA5E9')
      }
      .width('100%')
      .height(24)
      Text(`${chartData.label}: ${Math.round(chartData.progress * 100)}%`)
        .fontSize(12)
        .fontColor('#1E293B')
        .width('100%')
        .margin({ top: 4 })
    }
    .width('100%')
  }

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
      }
      .width('100%')
      .padding({ top: 14, bottom: 14 })
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column() {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .width('100%')

          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                this.AssignmentCard(work)
              }
            }, (work: Homework) => work.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')
          .margin({ top: 14, bottom: 14 })

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .width('100%')

          Column() {
            ForEach(this.charts, (chart: ChartData) => {
              Column() {
                this.ChartProgressBar(chart)
              }
              .margin({ bottom: 6 })
            }, (chart: ChartData) => chart.id.toString())
          }
          .width('100%')
          .margin({ top: 14 })

          Row() {
            Blank()
            Button('Submit New HW')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .width('60%')
              .height(40)
              .backgroundColor('#6366F1')
              .borderRadius(14)
            Blank()
          }
          .width('100%')
          .margin({ top: 14 })
        }
        .width('100%')
        .padding(14)
        .linearGradient({
          angle: 180,
          colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
