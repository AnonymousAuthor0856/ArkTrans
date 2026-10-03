class HealthDashboardTokens {
  static readonly Colors = {
    primary: '#FF6366F1',
    secondary: '#FFEC4899',
    tertiary: '#FF10B981',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF0F172A',
    onSurface70: '#B30F172A'
  }

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    xxl: 20,
    xxxl: 24
  }
}

class HealthMetric {
  id: number
  title: string
  value: string
  unit: string
  color: string

  constructor(id: number, title: string, value: string, unit: string, color: string) {
    this.id = id
    this.title = title
    this.value = value
    this.unit = unit
    this.color = color
  }
}

class Workout {
  id: number
  name: string
  duration: string
  calories: string
  iconColor: string

  constructor(id: number, name: string, duration: string, calories: string, iconColor: string) {
    this.id = id
    this.name = name
    this.duration = duration
    this.calories = calories
    this.iconColor = iconColor
  }
}

class NavItem {
  id: number
  label: string

  constructor(id: number, label: string) {
    this.id = id
    this.label = label
  }
}

@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', HealthDashboardTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', HealthDashboardTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', HealthDashboardTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', HealthDashboardTokens.Colors.error)
  ]

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HealthDashboardTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HealthDashboardTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HealthDashboardTokens.Colors.tertiary)
  ]

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ]

  build() {
    Column() {
      Text('Health Dashboard')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(HealthDashboardTokens.Colors.onBackground)
        .width('100%')
        .padding({ top: 60, bottom: 28 })

      Scroll() {
        Column() {
          Column() {
            Text('Good Morning!')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.onPrimary)
            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.onPrimary)
              .margin({ top: 4 })
            Text('Start Workout')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.primary)
              .width('100%')
              .height(44)
              .textAlign(TextAlign.Center)
              .borderRadius(12)
              .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .padding(16)
          .borderRadius(16)
          .backgroundColor(HealthDashboardTokens.Colors.primary)
          .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })

          Text("Today's Metrics")
            .fontSize(14)
            .fontColor(HealthDashboardTokens.Colors.onBackground)
            .width('100%')
            .margin({ top: 12, left: 4, right: 4 })

          Row() {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column() {
                Row()
                  .width(36)
                  .height(36)
                  .borderRadius(18)
                  .backgroundColor(metric.color)
                Text(metric.value)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(HealthDashboardTokens.Colors.onSurface)
                  .margin({ top: 2 })
                Text(metric.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(HealthDashboardTokens.Colors.onSurface70)
              }
              .padding(8)
              .borderRadius(12)
              .backgroundColor(HealthDashboardTokens.Colors.surface)
              .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
              .alignItems(HorizontalAlign.Center)
              .layoutWeight(1)
            })
          }
          .width('100%')

          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.onBackground)
              .layoutWeight(1)
            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.primary)
              .margin({ right: 20 })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 20, bottom: 10 })

          ForEach(this.workouts, (workout: Workout) => {
            Row() {
              Row()
                .width(44)
                .height(44)
                .borderRadius(12)
                .backgroundColor(workout.iconColor)

              Column() {
                Text(workout.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(HealthDashboardTokens.Colors.onSurface)
                Row() {
                  Text(workout.duration)
                    .fontSize(14)
                    .fontColor(HealthDashboardTokens.Colors.onSurface70)
                  Text(workout.calories)
                    .fontSize(14)
                    .fontColor(HealthDashboardTokens.Colors.onSurface70)
                    .margin({ left: 12 })
                }
                .margin({ top: 2 })
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              .margin({ left: 8 })

              Text('Start')
                .fontSize(10)
                .fontColor(HealthDashboardTokens.Colors.onPrimary)
                .width(70)
                .height(32)
                .textAlign(TextAlign.Center)
                .borderRadius(8)
                .backgroundColor(HealthDashboardTokens.Colors.primary)
            }
            .width('100%')
            .padding(12)
            .borderRadius(12)
            .backgroundColor(HealthDashboardTokens.Colors.surface)
            .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 12 })
          })
        }
        .padding({ left: 8, right: 8, bottom: 100 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Row()
              .width(20)
              .height(20)
              .borderRadius(10)
              .backgroundColor(this.selectedNav === item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.onSurface)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1)
          .onClick(() => {
            this.selectedNav = item.id
          })
        })
      }
      .width('100%')
      .padding({ top: 4, bottom: 4, left: 8, right: 8 })
      .borderRadius(16)
      .backgroundColor(HealthDashboardTokens.Colors.surface)
      .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
      .margin({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthDashboardTokens.Colors.background)
  }
}