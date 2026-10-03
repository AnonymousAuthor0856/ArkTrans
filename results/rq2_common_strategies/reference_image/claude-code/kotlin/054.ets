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

  private colors = {
    primary: '#0EA5E9',
    secondary: '#6366F1',
    tertiary: '#06B6D4',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#D1D5DB',
    onBackground: '#1E293B',
    onSurface: '#1E293B'
  }

  build() {
    Column() {
      Text('Homework Submit')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 14, bottom: 14 })
        .backgroundColor(this.colors.surface)

      Scroll() {
        Column() {
          Column({ space: 10 }) {
            Text('Assignments')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.colors.onBackground)
              .margin({ top: 14, left: 14, right: 14 })

            Grid() {
              ForEach(this.works, (item: Homework) => {
                GridItem() {
                  Column() {
                    Rect()
                      .width(40)
                      .height(40)
                      .fill(this.colors.tertiary)
                      .borderRadius(6)
                      .margin({ bottom: 6 })
                    Text(item.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.colors.onSurface)
                      .textAlign(TextAlign.Center)
                    Text(item.status)
                      .fontSize(11)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.colors.onSurface)
                      .textAlign(TextAlign.Center)
                  }
                  .width('100%')
                  .height('100%')
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                  .padding(10)
                  .backgroundColor(this.colors.surface)
                  .borderRadius(10)
                  .border({ width: 1, color: this.colors.outline, radius: 10 })
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
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.colors.onBackground)
              .margin({ top: 14, left: 14, right: 14 })

            Column({ space: 6 }) {
              ForEach(this.charts, (item: ChartData) => {
                Column() {
                  Stack({ alignContent: Alignment.Start }) {
                    Rect()
                      .width('100%')
                      .height(24)
                      .fill(this.colors.surfaceVariant)
                      .borderRadius(6)
                    Rect()
                      .width(item.progress * 100 + '%')
                      .height(24)
                      .fill(this.colors.primary)
                      .borderRadius(6)
                  }
                  .width('100%')
                  .height(24)
                  Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
                    .fontSize(12)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(this.colors.onSurface)
                    .margin({ top: 2 })
                }
              }, (item: ChartData) => item.id.toString())
            }
            .padding({ left: 14, right: 14 })
          }

          Button('Submit New HW')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor(this.colors.secondary)
            .borderRadius(14)
            .height(40)
            .width('60%')
            .margin({ top: 14, bottom: 20 })
            .onClick(() => {})
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [this.colors.secondary, 0.1],
        [this.colors.primary, 0.15]
      ]
    })
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
