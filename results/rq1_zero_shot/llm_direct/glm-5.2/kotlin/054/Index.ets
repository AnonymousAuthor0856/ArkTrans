// 079_HomeworkSubmit_en.ets
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
struct RootScreen {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ];

  private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ];

  build() {
    Column() {
      // Top App Bar
      Text('Homework Submit')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E293B')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      // Content
      Scroll() {
        Column() {
          // Background Gradient
          Column() {
            Text('Assignments')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
              .margin({ bottom: 10 })

            // Grid (2 columns)
            Grid() {
              ForEach(this.works, (w: Homework) => {
                GridItem() {
                  Column() {
                    Box()
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
                  .aspectRatio(1)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(10)
                  .border({ width: 1, color: '#D1D5DB' })
                  .padding(10)
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .rowsGap(10)
            .columnsGap(10)
            .padding({ bottom: 14 })

            Text('Progress Chart')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
              .margin({ bottom: 6 })

            // Progress Bars
            ForEach(this.charts, (c: ChartData) => {
              Column() {
                Row() {
                  Box()
                    .width(`${c.progress * 100}%`)
                    .height(24)
                    .backgroundColor('#0EA5E9')
                    .borderRadius(6)
                }
                .width('100%')
                .height(24)
                .backgroundColor('#E2E8F0')
                .borderRadius(6)

                Text(`${c.label}: ${Math.floor(c.progress * 100)}%`)
                  .fontSize(12)
                  .fontColor('#1E293B')
                  .margin({ top: 2 })
              }
              .margin({ bottom: 6 })
            })

            // Submit Button
            Button('Submit New HW')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#6366F1')
              .borderRadius(14)
              .width('60%')
              .height(40)
              .margin({ top: 14 })
          }
          .width('100%')
          .padding(14)
          .linearGradient({
            angle: 90,
            colors: [['#0EA5E926', 0.0], ['#6366F11A', 1.0]]
          })
        }
      }
      .layoutWeight(1)
      .backgroundColor('#F1F5F9')
    }
    .height('100%')
    .width('100%')
  }
}