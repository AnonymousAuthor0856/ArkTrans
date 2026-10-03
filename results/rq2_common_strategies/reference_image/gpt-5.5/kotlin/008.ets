interface HealthMetric {
  id: number
  title: string
  value: string
  unit: string
  progress: number
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

class AppColors {
  static readonly primary: string = '#6366F1'
  static readonly secondary: string = '#EC4899'
  static readonly tertiary: string = '#10B981'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F1F5F9'
  static readonly outline: string = '#E2E8F0'
  static readonly success: string = '#10B981'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
  static readonly mutedText: string = '#5E6574'
  static readonly navBackground: string = '#F7F6FF'
  static readonly navSelectedTrack: string = '#E9DDFB'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 8
  static readonly lg: number = 12
  static readonly xl: number = 16
  static readonly xxl: number = 20
  static readonly xxxl: number = 24
}

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

@Entry
@Component
struct Index {
  @State private selectedNav: number = 0

  private readonly metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: AppColors.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: AppColors.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: AppColors.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: AppColors.error }
  ]

  private readonly workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: AppColors.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: AppColors.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: AppColors.tertiary }
  ]

  private readonly navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Column() {
          Blank()
            .height(36)

          Text('Health Dashboard')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .textAlign(TextAlign.Center)
            .width('100%')
            .height(36)
        }
        .width('100%')
        .height(88)
        .backgroundColor(AppColors.background)

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            this.HeroCard()

            Text('Today\'s Metrics')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onBackground)
              .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
              .width('100%')

            this.MetricsRow()

            Row() {
              Text('Recent Workouts')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onBackground)

              Text('View All')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)
                .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                .onClick(() => {
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding({ top: 22 })

            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            }, (workout: Workout) => workout.id.toString())
          }
          .width('100%')
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: 104
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.BottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private HeroCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('100%')

      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width('100%')

      Blank()
        .height(4)

      Row() {
        Text('Start Workout')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .height(44)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.onPrimary)
      .borderRadius(AppRadius.medium)
      .onClick(() => {
      })
    }
    .width('100%')
    .padding(AppSpacing.xl)
    .backgroundColor(AppColors.primary)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 12,
      color: '#33000000',
      offsetX: 0,
      offsetY: 3
    })
  }

  @Builder
  private MetricsRow() {
    Row({ space: AppSpacing.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column({ space: AppSpacing.xs }) {
          Blank()
            .width(36)
            .height(36)
            .borderRadius(18)
            .backgroundColor(metric.color)

          Text(metric.value)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .maxLines(1)

          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.mutedText)
            .maxLines(1)
        }
        .height(94)
        .layoutWeight(1)
        .padding(AppSpacing.md)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.medium)
        .shadow({
          radius: 8,
          color: '#30000000',
          offsetX: 0,
          offsetY: 2
        })
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
  }

  @Builder
  private WorkoutCard(workout: Workout) {
    Row({ space: AppSpacing.md }) {
      Blank()
        .width(44)
        .height(44)
        .borderRadius(AppRadius.medium)
        .backgroundColor(workout.iconColor)

      Column({ space: AppSpacing.xs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: AppSpacing.lg }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor(AppColors.mutedText)

          Text(workout.calories)
            .fontSize(14)
            .fontColor(AppColors.mutedText)
        }
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      Row() {
        Text('Start')
          .fontSize(12)
          .fontColor(AppColors.onPrimary)
          .fontWeight(FontWeight.Regular)
      }
      .width(70)
      .height(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppRadius.small)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(60)
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .shadow({
      radius: 4,
      color: '#26000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  private BottomNavigation() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column() {
          if (this.selectedNav === item.id) {
            Row() {
              Blank()
                .width(20)
                .height(20)
                .borderRadius(10)
                .backgroundColor(AppColors.primary)
            }
            .width(60)
            .height(28)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(AppColors.navSelectedTrack)
            .borderRadius(18)
          } else {
            Blank()
              .width(20)
              .height(20)
              .borderRadius(10)
              .backgroundColor(AppColors.outline)
          }

          Text(item.label)
            .fontSize(12)
            .fontWeight(this.selectedNav === item.id ? FontWeight.Bold : FontWeight.Medium)
            .fontColor(this.selectedNav === item.id ? AppColors.onBackground : '#44424A')
            .margin({ top: 8 })
            .maxLines(1)
        }
        .layoutWeight(1)
        .height(74)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .height(82)
    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    .backgroundColor(AppColors.navBackground)
    .shadow({
      radius: 8,
      color: '#14000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}