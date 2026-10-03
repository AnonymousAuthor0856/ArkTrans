import { router } from '@kit.ArkUI'

interface HomeworkItem {
  id: number
  title: string
  status: string
}

interface ChartItem {
  id: number
  label: string
  progress: number
}

@Entry
@Component
struct Index {
  private works: HomeworkItem[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]

  private charts: ChartItem[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E293B')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column({ space: 14 }) {
          // Assignments Section
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .width('100%')

          // 2-column grid for homework cards
          Grid() {
            ForEach(this.works, (w: HomeworkItem) => {
              GridItem() {
                Column({ space: 6 }) {
                  Row()
                    .width(40)
                    .height(40)
                    .backgroundColor('#06B6D4')
                    .borderRadius(6)

                  Text(w.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E293B')
                    .textAlign(TextAlign.Center)

                  Text(w.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1E293B')
                    .textAlign(TextAlign.Center)
                }
                .width('100%')
                .aspectRatio(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor('#FFFFFF')
                .borderRadius(10)
                .border({ width: 1, color: '#D1D5DB' })
                .padding(10)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')

          // Progress Chart Section
          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')
            .width('100%')

          Column({ space: 6 }) {
            ForEach(this.charts, (c: ChartItem) => {
              Column({ space: 4 }) {
                Stack({ alignContent: Alignment.Start }) {
                  Row()
                    .width('100%')
                    .height(24)
                    .backgroundColor('#E2E8F0')
                    .borderRadius(6)

                  Row()
                    .width(`${c.progress * 100}%`)
                    .height(24)
                    .backgroundColor('#0EA5E9')
                    .borderRadius(6)
                }
                .width('100%')
                .height(24)

                Text(`${c.label}: ${Math.floor(c.progress * 100)}%`)
                  .fontSize(12)
                  .fontColor('#1E293B')
                  .width('100%')
              }
              .width('100%')
            })
          }
          .width('100%')

          // Submit Button
          Button('Submit New HW')
            .width('60%')
            .height(40)
            .borderRadius(14)
            .backgroundColor('#6366F1')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .alignSelf(ItemAlign.Center)
        }
        .padding(14)
        .width('100%')
      }
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0x260EA5E9, 0.0],
          [0x1A6366F1, 1.0]
        ]
      })
      .backgroundColor('#F1F5F9')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}