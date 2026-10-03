interface HealthMetric {
  id: number
  title: string
  value: string
  unit: string
  color: string
}

interface Workout {
  id: number
  name: string
  duration: string
  calories: string
  iconColor: string
}

interface NavItem {
  id: number
  label: string
}

class HealthDashboardTokens {
  static readonly primary: string = '#6366F1'
  static readonly secondary: string = '#EC4899'
  static readonly tertiary: string = '#10B981'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F1F5F9'
  static readonly outline: string = '#E2E8F0'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
  static readonly onSurface70: string = '#B30F172A'

  static readonly shapeSmall: number = 8
  static readonly shapeMedium: number = 12
  static readonly shapeLarge: number = 16

  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 8
  static readonly lg: number = 12
  static readonly xl: number = 16
  static readonly xxl: number = 20
  static readonly xxxl: number = 24
}

@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0

  private readonly metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: HealthDashboardTokens.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', color: HealthDashboardTokens.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: HealthDashboardTokens.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: HealthDashboardTokens.error }
  ]

  private readonly workouts: Workout[] = [
    {
      id: 1,
      name: 'Morning Run',
      duration: '32 min',
      calories: '284 kcal',
      iconColor: HealthDashboardTokens.primary
    },
    {
      id: 2,
      name: 'Yoga Flow',
      duration: '45 min',
      calories: '156 kcal',
      iconColor: HealthDashboardTokens.secondary
    },
    {
      id: 3,
      name: 'Strength Training',
      duration: '28 min',
      calories: '320 kcal',
      iconColor: HealthDashboardTokens.tertiary
    }
  ]

  private readonly navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  @Builder
  topBar() {
    Text('Health Dashboard')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor(HealthDashboardTokens.onBackground)
      .textAlign(TextAlign.Center)
      .width('100%')
      .padding({
        top: 60,
        bottom: 28
      })
  }

  @Builder
  heroCard() {
    Column({ space: HealthDashboardTokens.sm }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.onPrimary)

      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(HealthDashboardTokens.onPrimary)

      Text('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(44)
        .backgroundColor(HealthDashboardTokens.onPrimary)
        .borderRadius(HealthDashboardTokens.shapeMedium)
        .margin({ top: HealthDashboardTokens.md })
        .onClick(() => {
        })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(HealthDashboardTokens.xl)
    .backgroundColor(HealthDashboardTokens.primary)
    .borderRadius(HealthDashboardTokens.shapeLarge)
    .shadow({
      radius: 12,
      color: '#38000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  sectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(FontWeight.Normal)
      .fontColor(HealthDashboardTokens.onBackground)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: HealthDashboardTokens.sm, right: HealthDashboardTokens.sm })
  }

  @Builder
  metricsRow() {
    Row({ space: HealthDashboardTokens.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Row() {
          Column({ space: HealthDashboardTokens.xs }) {
            Stack()
              .width(36)
              .height(36)
              .borderRadius(18)
              .backgroundColor(metric.color)

            Text(metric.value)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(HealthDashboardTokens.onSurface)

            Text(metric.title)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.onSurface70)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()
        }
        .height(112)
        .layoutWeight(1)
        .padding(HealthDashboardTokens.md)
        .backgroundColor(HealthDashboardTokens.surface)
        .borderRadius(HealthDashboardTokens.shapeMedium)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 2
        })
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
  }

  @Builder
  recentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(HealthDashboardTokens.onBackground)

      Blank()

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.primary)
        .padding({ right: 20 })
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  workoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.md }) {
      Stack()
        .width(44)
        .height(44)
        .borderRadius(HealthDashboardTokens.shapeMedium)
        .backgroundColor(workout.iconColor)

      Column({ space: HealthDashboardTokens.xs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HealthDashboardTokens.onSurface)

        Row({ space: HealthDashboardTokens.lg }) {
          Text(workout.duration)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(HealthDashboardTokens.onSurface70)

          Text(workout.calories)
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(HealthDashboardTokens.onSurface70)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('Start')
        .fontSize(10)
        .fontWeight(FontWeight.Normal)
        .fontColor(HealthDashboardTokens.onPrimary)
        .textAlign(TextAlign.Center)
        .width(70)
        .height(32)
        .backgroundColor(HealthDashboardTokens.primary)
        .borderRadius(HealthDashboardTokens.shapeSmall)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(HealthDashboardTokens.lg)
    .backgroundColor(HealthDashboardTokens.surface)
    .borderRadius(HealthDashboardTokens.shapeMedium)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  bottomNavigation() {
    Row({ space: HealthDashboardTokens.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: HealthDashboardTokens.xs }) {
          Stack()
            .width(20)
            .height(20)
            .borderRadius(10)
            .backgroundColor(this.selectedNav === item.id ? HealthDashboardTokens.primary : HealthDashboardTokens.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthDashboardTokens.onSurface)
            .textAlign(TextAlign.Center)
            .maxLines(1)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({
      top: HealthDashboardTokens.sm,
      bottom: HealthDashboardTokens.sm,
      left: HealthDashboardTokens.md,
      right: HealthDashboardTokens.md
    })
    .backgroundColor(HealthDashboardTokens.surface)
    .borderRadius(HealthDashboardTokens.shapeLarge)
    .shadow({
      radius: 8,
      color: '#2E000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()

        Scroll() {
          Column({ space: HealthDashboardTokens.lg }) {
            this.heroCard()
            this.sectionTitle('Today\'s Metrics')
            this.metricsRow()
            this.recentWorkoutsHeader()

            ForEach(this.workouts, (workout: Workout) => {
              this.workoutCard(workout)
            }, (workout: Workout) => workout.id.toString())
          }
          .width('100%')
          .padding({
            left: HealthDashboardTokens.md,
            right: HealthDashboardTokens.md,
            bottom: 84
          })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(HealthDashboardTokens.background)

      Column() {
        this.bottomNavigation()
      }
      .width('100%')
      .padding({
        left: HealthDashboardTokens.md,
        right: HealthDashboardTokens.md,
        bottom: HealthDashboardTokens.md
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthDashboardTokens.background)
  }
}