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

interface ChartData {
  id: number
  label: string
  progress: number
}

class AppColors {
  static readonly primary: ResourceColor = '#0EA5E9'
  static readonly secondary: ResourceColor = '#6366F1'
  static readonly tertiary: ResourceColor = '#06B6D4'
  static readonly background: ResourceColor = '#F1F5F9'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#E2E8F0'
  static readonly outline: ResourceColor = '#D1D5DB'
  static readonly onBackground: ResourceColor = '#1E293B'
  static readonly onSurface: ResourceColor = '#1E293B'
  static readonly onSecondary: ResourceColor = '#FFFFFF'
}

@Component
struct AssignmentCard {
  item: Homework = new Homework(0, '', '')

  build() {
    Column() {
      Blank()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(6)

      Text(this.item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .width('100%')
        .margin({ top: 6 })

      Text(this.item.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .width('100%')
    }
    .width('100%')
    .aspectRatio(1)
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: 10
    })
  }
}

@Entry
@Component
struct HomeworkSubmitPage {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ]

  @State charts: ChartData[] = [
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
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: 14 }) {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                AssignmentCard({ item: work })
              }
            }, (work: Homework) => work.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .height(330)
          .width('100%')

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .margin({ top: 16 })

          Column({ space: 6 }) {
            ForEach(this.charts, (chart: ChartData) => {
              Column() {
                Blank()
                  .width('100%')
                  .height(24)
                  .backgroundColor(AppColors.surfaceVariant)
                  .borderRadius(6)

                Text(chart.label + ': ' + Math.round(chart.progress * 100).toString() + '%')
                  .fontSize(12)
                  .fontWeight(FontWeight.Regular)
                  .fontColor(AppColors.onSurface)
                  .width('100%')
                  .margin({ top: 6 })
              }
              .width('100%')
            }, (chart: ChartData) => chart.id.toString())
          }
          .width('100%')

          Button('Submit New HW')
            .height(40)
            .width('60%')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(14)
            .alignSelf(ItemAlign.Center)
            .margin({ top: 8, bottom: 20 })
            .onClick(() => {
            })
        }
        .width('100%')
        .padding(14)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[0x260EA5E9, 0.0], [0x1A6366F1, 1.0]]
      })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.surface)
  }
}
