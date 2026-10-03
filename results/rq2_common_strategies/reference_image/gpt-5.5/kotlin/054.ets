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
  static readonly success: string = '#10B981'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#0F172A'
  static readonly onBackground: string = '#1E293B'
  static readonly onSurface: string = '#1E293B'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
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

  @State private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ]

  @Builder
  AssignmentCard(item: Homework) {
    Column() {
      Blank()
        .width(40)
        .height(40)
        .borderRadius(6)
        .backgroundColor(AppColors.tertiary)

      Text(item.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .margin({ top: AppSpacing.sm })

      Text(item.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }

  @Builder
  ProgressItem(item: ChartData) {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(24)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(6)

        Row()
          .width(`${Math.round(item.progress * 100)}%`)
          .height(24)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
      }
      .width('100%')
      .height(24)

      Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface)
        .margin({ top: 6 })
        .width('100%')
    }
    .width('100%')
    .margin({ bottom: AppSpacing.sm })
  }

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(128)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column() {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .margin({ bottom: AppSpacing.lg })

          Grid() {
            ForEach(this.works, (item: Homework) => {
              GridItem() {
                this.AssignmentCard(item)
              }
            }, (item: Homework) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .width('100%')
          .height(662)
          .margin({ bottom: AppSpacing.xxl })

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .margin({ bottom: AppSpacing.lg })

          Column() {
            ForEach(this.charts, (item: ChartData) => {
              this.ProgressItem(item)
            }, (item: ChartData) => item.id.toString())
          }
          .width('100%')

          Button('Submit New HW')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .width('60%')
            .height(40)
            .backgroundColor(AppColors.secondary)
            .borderRadius(14)
            .margin({ top: AppSpacing.lg, bottom: AppSpacing.xxl })
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#260EA5E9', 0.0],
          ['#1A6366F1', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}