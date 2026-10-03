class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF6366F1',
    tertiary: '#FF06B6D4',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF10B981',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF1E293B',
    onSurface: '#FF1E293B',
  }
  static readonly Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }
  static readonly Spacing = {
    xs: 2,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  }
}

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

class ChartData {
  id: number
  label: string
  progress: number

  constructor(id: number, label: string, progress: number) {
    this.id = id
    this.label = label
    this.progress = progress
  }
}

@Component
struct AssignmentCard {
  @Prop title: string
  @Prop status: string

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Column()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small)

      Text(this.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.status)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .justifyContent(FlexAlign.Center)
  }
}

@Component
struct ChartProgressBar {
  @Prop label: string
  @Prop progress: number

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Column()
          .width(`${this.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)

      Text(`${this.label}: ${Math.round(this.progress * 100)}%`)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 2 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending'),
  ]
  private charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8),
  ]

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Text('Assignments')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Row({ space: AppTokens.Spacing.md }) {
            AssignmentCard({ title: this.works[0].title, status: this.works[0].status })
              .layoutWeight(1)
            AssignmentCard({ title: this.works[1].title, status: this.works[1].status })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: AppTokens.Spacing.md }) {
            AssignmentCard({ title: this.works[2].title, status: this.works[2].status })
              .layoutWeight(1)
            AssignmentCard({ title: this.works[3].title, status: this.works[3].status })
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          Text('Progress Chart')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ label: c.label, progress: c.progress })
            })
          }

          Row() {
            Button('Submit New HW')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('60%')
              .height(40)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}