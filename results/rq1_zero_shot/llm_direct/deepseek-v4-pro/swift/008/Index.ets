@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0

  private metrics: Array<HealthMetric> = [
    new HealthMetric(1, 'Heart', '72', 'bpm', '#EC4899'),
    new HealthMetric(2, 'Steps', '842', 'steps', '#6366F1'),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', '#10B981'),
    new HealthMetric(4, 'Calories', '420', 'kcal', '#EF4444')
  ]

  private workouts: Array<Workout> = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', '#6366F1'),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', '#EC4899'),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', '#10B981')
  ]

  private navItems: Array<NavItem> = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ]

  private bottomBarHeight: number = 72

  @Builder
  TopBar() {
    Text('Health Dashboard')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor('#0F172A')
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 20, bottom: 8 })
  }

  @Builder
  HeroCard() {
    Column({ space: 4 }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#FFFFFF')
      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#6366F1')
        .backgroundColor('#FFFFFF')
        .width('100%')
        .height(44)
        .borderRadius(12)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor('#6366F1')
    .borderRadius(16)
    .shadow({ radius: 12, color: 'rgba(0, 0, 0, 0.22)', offsetY: 3 })
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontColor('#0F172A')
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: 4, right: 4 })
  }

  @Builder
  MetricsRow() {
    Row({ space: 8 }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column({ space: 2 }) {
          Circle()
            .fill(metric.color)
            .width(36)
            .height(36)
          Text(metric.value)
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0F172A')
          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(15, 23, 42, 0.7)')
        }
        .alignItems(HorizontalAlign.Start)
        .padding(8)
        .layoutWeight(1)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 2 })
      })
    }
    .width('100%')
  }

  @Builder
  RecentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#0F172A')
      Blank()
      Button('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#6366F1')
        .backgroundColor(Color.Transparent)
        .padding({ right: 20 })
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: 8 }) {
      Rect()
        .fill(workout.iconColor)
        .width(44)
        .height(44)
        .borderRadius(12)

      Column({ space: 2 }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
        Row({ space: 12 }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('rgba(15, 23, 42, 0.7)')
          Text(workout.calories)
            .fontSize(14)
            .fontColor('rgba(15, 23, 42, 0.7)')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Start')
        .fontSize(10)
        .fontColor('#FFFFFF')
        .backgroundColor('#6366F1')
        .width(70)
        .height(32)
        .borderRadius(8)
    }
    .padding(12)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.15)', offsetY: 1 })
  }

  @Builder
  BottomNavigation() {
    Row({ space: 8 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          this.selectedNav = item.id
        }
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .height(50)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .type(ButtonType.Normal)
        .borderRadius(0)
        .padding(0)
        .margin(0)
        .stateEffect(false)
        .responseRegion({ _ => ({ x: 0, y: 0, width: '100%', height: '100%' }) })
        .onClick(() => {
          this.selectedNav = item.id
        })
        .child(
          Column({ space: 2 }) {
            Circle()
              .fill(this.selectedNav === item.id ? '#6366F1' : '#E2E8F0')
              .width(20)
              .height(20)
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        )
      })
    }
    .padding({ top: 4, bottom: 4, left: 8, right: 8 })
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.18)', offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        this.TopBar()
          .padding({ top: 40, bottom: 20 })

        Scroll() {
          Column({ space: 12 }) {
            this.HeroCard()
            this.SectionTitle("Today's Metrics")
            this.MetricsRow()
            this.RecentWorkoutsHeader()
            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            })
          }
          .padding({ left: 8, right: 8, bottom: this.bottomBarHeight + 12 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')

      this.BottomNavigation()
        .padding({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
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