@Entry
@Component
struct HomeworkSubmit {
  @State works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]
  @State charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    Column() {
      Text('Homework Submit')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 14, bottom: 14 })
        .backgroundColor('#FFFFFF')

      Scroll() {
        Column({ space: 14 }) {
          Column({ space: 10 }) {
            Text('Assignments')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
              .margin({ top: 14, left: 14, right: 14 })

            Grid() {
              ForEach(this.works, (item: Homework) => {
                GridItem() {
                                  Column() {
                    Stack()
                      .width(40)
                      .height(40)
                      .backgroundColor('#06B6D4')
                      .borderRadius(6)
                      .margin({ bottom: 6 })

                    Text(item.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1E293B')
                      .textAlign(TextAlign.Center)
                    Text(item.status)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1E293B')
                      .textAlign(TextAlign.Center)
                  }
                  .width('100%')
                  .height('100%')
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .padding(10)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .border({ width: 1, color: '#D1D5DB', radius: 10 })
                }
              }, (item: Homework) => item.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(10)
            .rowsGap(10)
            .height(360)
            .padding({ left: 14, right: 14 })
          }

          Column({ space: 6 }) {
            Text('Progress Chart')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
              .margin({ left: 14, right: 14 })

            Column({ space: 6 }) {
              ForEach(this.charts, (item: ChartData) => {
                Column({ space: 2 }) {
                  Stack({ alignContent: Alignment.Start }) {
                    Stack()
                      .width('100%')
                      .height(24)
                      .backgroundColor('#E2E8F0')
                      .borderRadius(6)
                    Stack()
                      .width(item.progress * 100 + '%')
                      .height(24)
                      .backgroundColor('#0EA5E9')
                      .borderRadius(6)
                  }
                  .width('100%')
                  .height(24)

                  Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#1E293B')
                }
              }, (item: ChartData) => item.id.toString())
            }
            .padding({ left: 14, right: 14, bottom: 14 })
          }
        }
        .width('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['rgba(14, 165, 233, 0.15)', 0.0],
            ['rgba(99, 102, 241, 0.1)', 1.0]
          ]
        })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

interface Homework {
  id: number
  title: string
  status: string
}

interface ChartData {
  id: number
  label: string
  progress: number
}
