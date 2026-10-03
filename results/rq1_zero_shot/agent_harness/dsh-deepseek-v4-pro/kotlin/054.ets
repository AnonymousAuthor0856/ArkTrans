const Colors = {
  primary: '#0EA5E9',
  secondary: '#6366F1',
  tertiary: '#06B6D4',
  background: '#F1F5F9',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#D1D5DB',
  success: '#10B981',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0F172A',
  onBackground: '#1E293B',
  onSurface: '#1E293B'
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

@Entry
@Component
struct Index {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]
  private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(14)

      Scroll() {
        Column({ space: 14 }) {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          Grid() {
            ForEach(this.works, (w: Homework) => {
              Column() {
                Stack().width(40).height(40).backgroundColor(Colors.tertiary).borderRadius(6)
                Blank().height(6)
                Text(w.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text(w.status)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .padding(10)
              .aspectRatio(1)
              .backgroundColor(Colors.surface)
              .borderRadius(10)
              .border({ width: 1, color: Colors.outline })
            }, (w: Homework) => w.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          ForEach(this.charts, (c: ChartData) => {
            Column({ space: 2 }) {
              Row() {
                Stack()
                  .width(Math.round(c.progress * 100) + '%')
                  .height('100%')
                  .backgroundColor(Colors.primary)
                  .borderRadius(6)
              }
              .width('100%')
              .height(24)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(6)
              Text(c.label + ': ' + Math.round(c.progress * 100) + '%')
                .fontSize(12)
                .fontColor(Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
          }, (c: ChartData) => c.id.toString())

          Button('Submit New HW', { type: ButtonType.Normal })
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .borderRadius(14)
            .width('60%')
            .height(40)
        }
        .width('100%')
        .padding(14)
      }
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
