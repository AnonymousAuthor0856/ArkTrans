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

class AppColors {
  static readonly primary: string = '#0EA5E9'
  static readonly secondary: string = '#6366F1'
  static readonly tertiary: string = '#06B6D4'
  static readonly background: string = '#F1F5F9'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#D1D5DB'
  static readonly onBackground: string = '#1E293B'
  static readonly onSurface: string = '#1E293B'
  static readonly onSecondary: string = '#FFFFFF'
}

class AppTypography {
  static readonly display: number = 26
  static readonly headline: number = 18
  static readonly title: number = 14
  static readonly body: number = 12
  static readonly label: number = 11
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
}

@Component
struct AssignmentCard {
  @Prop homework: Homework

  build() {
    Column() {
      Row()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.small)

      Blank()
        .layoutWeight(1)

      Text(this.homework.title)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.homework.status)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .aspectRatio(1)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }
}

@Component
struct ChartProgressBar {
  @Prop chartData: ChartData

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width(`${this.chartData.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .clip(true)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ]

  @State private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(AppTypography.display)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({
        top: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .width('100%')
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)

          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                AssignmentCard({ homework: work })
              }
            }, (work: Homework) => work.id.toString())
          }
          .width('100%')
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .margin({ bottom: AppSpacing.lg })

          Text('Progress Chart')
            .width('100%')
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (chart: ChartData) => {
              ChartProgressBar({ chartData: chart })
            }, (chart: ChartData) => chart.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          Button('Submit New HW')
            .width('60%')
            .height(40)
            .fontSize(AppTypography.title)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .margin({ top: AppSpacing.lg })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
