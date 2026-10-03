import { LengthMetrics } from '@kit.ArkUI'

class HomeworkItem {
  id: number = 0
  title: string = ''
  status: string = ''
}

class ChartItem {
  id: number = 0
  label: string = ''
  progress: number = 0
}

const primaryColor: string = '#0EA5E9'
const secondaryColor: string = '#6366F1'
const tertiaryColor: string = '#06B6D4'
const backgroundColor: string = '#F1F5F9'
const surfaceColor: string = '#FFFFFF'
const surfaceVariantColor: string = '#E2E8F0'
const outlineColor: string = '#D1D5DB'
const onBackgroundColor: string = '#1E293B'
const onSurfaceColor: string = '#1E293B'
const onSecondaryColor: string = '#FFFFFF'

@Entry
@Component
struct Index {
  @State works: HomeworkItem[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]
  @State charts: ChartItem[] = [
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
          .fontColor(onBackgroundColor)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(surfaceColor)

      // Main Content
      Scroll() {
        Column({ space: 14 }) {
          // Assignments Section
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(onBackgroundColor)
            .width('100%')

          // Grid of homework items
          Grid() {
            ForEach(this.works, (w: HomeworkItem) => {
              GridItem() {
                Column({ space: 6 }) {
                  Row()
                    .width(40)
                    .height(40)
                    .backgroundColor(tertiaryColor)
                    .borderRadius(6)

                  Text(w.title)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(onSurfaceColor)
                    .textAlign(TextAlign.Center)
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Text(w.status)
                    .fontSize(11)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(onSurfaceColor)
                    .textAlign(TextAlign.Center)
                }
                .width('100%')
                .aspectRatio(1)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .padding(10)
                .backgroundColor(surfaceColor)
                .borderRadius(10)
                .border({ width: 1, color: outlineColor, radius: 10 })
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
            .fontColor(onBackgroundColor)
            .width('100%')

          Column({ space: 6 }) {
            ForEach(this.charts, (c: ChartItem) => {
              Column({ space: 2 }) {
                Stack({ alignContent: Alignment.Start }) {
                  Row()
                    .width('100%')
                    .height(24)
                    .backgroundColor(surfaceVariantColor)
                    .borderRadius(6)

                  Row()
                    .width(`${c.progress * 100}%`)
                    .height(24)
                    .backgroundColor(primaryColor)
                    .borderRadius(6)
                }
                .width('100%')
                .height(24)

                Text(`${c.label}: ${Math.floor(c.progress * 100)}%`)
                  .fontSize(12)
                  .fontColor(onSurfaceColor)
                  .width('100%')
              }
            })
          }
          .width('100%')

          // Submit Button
          Button('Submit New HW')
            .width('60%')
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSecondaryColor)
            .backgroundColor(secondaryColor)
            .borderRadius(14)
            .alignSelf(ItemAlign.Center)
        }
        .padding(14)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
      .backgroundColor(backgroundColor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}