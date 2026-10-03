import { LengthMetrics } from '@kit.ArkUI'

// Color tokens
const Colors = {
  primary: '#6366F1',
  secondary: '#EC4899',
  tertiary: '#10B981',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#F1F5F9',
  outline: '#E2E8F0',
  success: '#10B981',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#0F172A',
}

// Spacing tokens
const Spacing = {
  xs: 2,
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  xxl: 20,
  xxxl: 24,
}

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

@Entry
@Component
struct RootScreen {
  @State selectedNav: number = 0
  @State metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: Colors.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: Colors.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: Colors.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: Colors.error },
  ]
  @State workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: Colors.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: Colors.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: Colors.tertiary },
  ]
  @State navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' },
  ]

  @Builder
  WelcomeCard() {
    Card() {
      Column({ space: Spacing.sm }) {
        Text('Good Morning!')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
        Text('Ready for your workout?')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onPrimary)
        Button('Start Workout')
          .width('100%')
          .height(44)
          .backgroundColor(Colors.onPrimary)
          .fontColor(Colors.primary)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(12)
      }
      .padding(Spacing.xl)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor(Colors.primary)
    .borderRadius(16)
    .shadow({ radius: 12, color: '#33000000', offsetY: 3 })
  }

  @Builder
  MetricsRow() {
    Row({ space: Spacing.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Card() {
          Column({ space: Spacing.xs }) {
            Circle({ width: 36, height: 36 })
              .fill(metric.color)
            Text(metric.value)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)
            Text(metric.title)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#660F172A')
          }
          .padding(Spacing.md)
          .alignItems(HorizontalAlign.Center)
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor(Colors.surface)
        .borderRadius(12)
        .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
      })
    }
    .width('100%')
  }

  @Builder
  WorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)
      Button('View All')
        .backgroundColor(Color.Transparent)
        .fontColor(Colors.primary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .shadow({ radius: 0, color: Color.Transparent, offsetY: 0 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Card() {
      Row({ space: Spacing.md }) {
        Column()
          .width(44)
          .height(44)
          .backgroundColor(workout.iconColor)
          .borderRadius(12)
        Column({ space: Spacing.xs }) {
          Text(workout.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Row({ space: Spacing.lg }) {
            Text(workout.duration)
              .fontSize(14)
              .fontColor('#660F172A')
            Text(workout.calories)
              .fontSize(14)
              .fontColor('#660F172A')
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Button('Start')
          .height(32)
          .width(70)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(10)
          .borderRadius(8)
      }
      .padding(Spacing.md)
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.background)

      // Main Content
      List({ space: Spacing.lg }) {
        ListItem() {
          this.WelcomeCard()
        }

        ListItem() {
          Text('Today\'s Metrics')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .padding({ left: Spacing.sm, right: Spacing.sm })
        }

        ListItem() {
          this.MetricsRow()
        }

        ListItem() {
          this.WorkoutsHeader()
        }

        ForEach(this.workouts, (workout: Workout) => {
          ListItem() {
            this.WorkoutCard(workout)
          }
        })

        ListItem() {
          Column().height(Spacing.xxxl)
        }
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.md, right: Spacing.md })
      .backgroundColor(Colors.background)

      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: 4 }) {
            Circle({ width: 20, height: 20 })
              .fill(this.selectedNav === item.id ? Colors.primary : Colors.outline)
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? Colors.primary : Colors.outline)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .height('100%')
          .onClick(() => {
            this.selectedNav = item.id
          })
        })
      }
      .width('100%')
      .height(64)
      .backgroundColor(Colors.surface)
      .shadow({ radius: 8, color: '#2E000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}