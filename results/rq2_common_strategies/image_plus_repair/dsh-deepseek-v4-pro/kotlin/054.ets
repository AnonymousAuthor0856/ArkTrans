interface Homework {
  id: number;
  title: string;
  status: string;
}

interface ChartData {
  id: number;
  label: string;
  progress: number;
}

@Entry
@Component
struct Index {
  @State works: Homework[] = [
    { id: 1, title: "Linear Algebra HW1", status: "Submitted" },
    { id: 2, title: "Data Structures HW2", status: "Pending" },
    { id: 3, title: "Algorithm HW3", status: "Graded" },
    { id: 4, title: "Probability HW4", status: "Pending" }
  ];

  @State charts: ChartData[] = [
    { id: 1, label: "Week 1", progress: 0.7 },
    { id: 2, label: "Week 2", progress: 0.9 },
    { id: 3, label: "Week 3", progress: 0.5 },
    { id: 4, label: "Week 4", progress: 0.8 }
  ];

  @Builder
  HomeworkCard(w: Homework) {
    Column() {
      Row()
        .width(40)
        .height(40)
        .backgroundColor('#06B6D4')
        .borderRadius(6)
        .margin({ bottom: 6 })

      Text(w.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')

      Text(w.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1E293B')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(10)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#D1D5DB' })
    .borderRadius(10)
  }

  @Builder
  ProgressRow(c: ChartData) {
    Column() {
      Row() {
        Row()
          .width(`${Math.floor(c.progress * 100)}%`)
          .height('100%')
          .backgroundColor('#0EA5E9')
          .borderRadius(6)
      }
      .width('100%')
      .height(24)
      .backgroundColor('#E2E8F0')
      .borderRadius(6)

      Text(`${c.label}: ${Math.floor(c.progress * 100)}%`)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor('#1E293B')
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
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column({ space: 14 }) {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                this.HomeworkCard(w)
              }
            }, (w: Homework) => w.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')
          .aspectRatio(1)

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          Column({ space: 6 }) {
            ForEach(this.charts, (c: ChartData) => {
              this.ProgressRow(c)
            }, (c: ChartData) => c.id.toString())
          }
          .width('100%')

          Button() {
            Text('Submit New HW')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .type(ButtonType.Normal)
          .width('60%')
          .height(40)
          .backgroundColor('#6366F1')
          .borderRadius(14)
          .onClick(() => {})
        }
        .width('100%')
        .padding(14)
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
