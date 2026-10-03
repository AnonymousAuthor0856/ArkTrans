// AppTokens - Design System Tokens
class AppColors {
  static readonly primary: string = '#FF0EA5E9'
  static readonly secondary: string = '#FF6366F1'
  static readonly tertiary: string = '#FF06B6D4'
  static readonly background: string = '#FFF1F5F9'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFE2E8F0'
  static readonly outline: string = '#FFD1D5DB'
  static readonly success: string = '#FF10B981'
  static readonly warning: string = '#FFF59E0B'
  static readonly error: string = '#FFEF4444'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onTertiary: string = '#FF0F172A'
  static readonly onBackground: string = '#FF1E293B'
  static readonly onSurface: string = '#FF1E293B'
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

// Data Models
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

// AssignmentCard Component
@Component
struct AssignmentCard {
  @Prop homework: Homework = { id: 0, title: '', status: '' }

  build() {
    Column() {
      // Colored square
      Row()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.small)

      Blank()
        .height(AppSpacing.sm)

      Text(this.homework.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(this.homework.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline })
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

// ChartProgressBar Component
@Component
struct ChartProgressBar {
  @Prop chartData: ChartData = { id: 0, label: '', progress: 0 }

  build() {
    Column() {
      // Progress bar track and fill
      Stack({ alignContent: Alignment.Start }) {
        // Background track
        Row()
          .width('100%')
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        // Progress fill
        Row()
          .width(`${this.chartData.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(24)

      // Label text
      Text(`${this.chartData.label}: ${Math.round(this.chartData.progress * 100)}%`)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// Root Screen
@Entry
@Component
struct HomeworkSubmitPage {
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
    Stack() {
      // Overall background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      Column() {
        // Top App Bar
        Row() {
          Text('Homework Submit')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.surface)
        .justifyContent(FlexAlign.Center)

        // Main scrollable content
        Scroll() {
          Column() {
            // Assignments Section
            Text('Assignments')
              .fontSize(18)
              .fontWeight(600)
              .fontColor(AppColors.onBackground)
              .margin({ bottom: AppSpacing.lg })

            // Assignment Grid (2 columns)
            Grid() {
              ForEach(this.works, (w: Homework) => {
                GridItem() {
                  AssignmentCard({ homework: w })
                }
                .aspectRatio(1)
              }, (w: Homework) => w.id.toString())
            }
            .columnsTemplate('1fr 1fr')
            .rowsGap(AppSpacing.md)
            .columnsGap(AppSpacing.md)
            .width('100%')
            .margin({ bottom: AppSpacing.lg })

            // Progress Chart Section
            Text('Progress Chart')
              .fontSize(18)
              .fontWeight(600)
              .fontColor(AppColors.onBackground)
              .margin({ bottom: AppSpacing.lg })

            // Progress bars list
            Column() {
              ForEach(this.charts, (c: ChartData) => {
                ChartProgressBar({ chartData: c })
              }, (c: ChartData) => c.id.toString())
            }
            .width('100%')
            .margin({ bottom: AppSpacing.sm })

            // Submit Button
            Button('Submit New HW')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(AppShapes.large)
              .height(40)
              .width('60%')
              .margin({ top: AppSpacing.lg })
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
