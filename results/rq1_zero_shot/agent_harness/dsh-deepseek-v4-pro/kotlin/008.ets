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
  onSurface: '#0F172A'
}

const Spacing = {
  xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 20, xxxl: 24
}

@Entry
@Component
struct Index {
  @State selectedNav: number = 0
  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: Colors.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: Colors.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: Colors.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: Colors.error }
  ]
  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: Colors.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: Colors.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: Colors.tertiary }
  ]
  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  build() {
    Column() {
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column({ space: Spacing.lg }) {
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
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
              .backgroundColor(Colors.onPrimary)
              .borderRadius(12)
              .width('100%')
              .height(44)
          }
          .width('100%')
          .backgroundColor(Colors.primary)
          .borderRadius(16)
          .padding(Spacing.xl)
          .shadow({ radius: 8, color: '#2E000000', offsetY: 3 })

          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .padding({ left: Spacing.sm, right: Spacing.sm })

          Row({ space: Spacing.md }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column({ space: Spacing.xs }) {
                Blank()
                  .width(36)
                  .height(36)
                  .backgroundColor(metric.color)
                  .borderRadius(36)
                Text(metric.value)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Colors.onSurface)
                Text(metric.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                  .opacity(0.7)
              }
              .layoutWeight(1)
              .backgroundColor(Colors.surface)
              .borderRadius(12)
              .padding(Spacing.md)
              .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
            }, (metric: HealthMetric) => metric.id.toString())
          }
          .width('100%')

          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onBackground)
            Button('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
              .backgroundColor('#00000000')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.workouts, (workout: Workout) => {
            Row({ space: Spacing.md }) {
              Blank()
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
                    .fontColor(Colors.onSurface)
                    .opacity(0.7)
                  Text(workout.calories)
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                    .opacity(0.7)
                }
                .alignItems(VerticalAlign.Center)
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Button('Start')
                .fontSize(10)
                .fontColor(Colors.onPrimary)
                .backgroundColor(Colors.primary)
                .borderRadius(8)
                .height(32)
                .width(70)
            }
            .width('100%')
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .padding(Spacing.md)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
            .alignItems(VerticalAlign.Center)
          }, (workout: Workout) => workout.id.toString())
        }
        .width('100%')
        .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.md, bottom: Spacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)

      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: Spacing.xs }) {
            Blank()
              .width(20)
              .height(20)
              .backgroundColor(this.selectedNav === item.id ? Colors.primary : Colors.outline)
              .borderRadius(20)
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
          }
          .layoutWeight(1)
          .onClick(() => { this.selectedNav = item.id })
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .padding(Spacing.sm)
      .shadow({ radius: 8, color: '#2E000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
