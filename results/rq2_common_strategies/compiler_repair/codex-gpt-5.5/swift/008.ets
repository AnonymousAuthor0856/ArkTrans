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
struct Index {
  @State selectedNav: number = 0

  private cPrimary: string = '#6366F1'
  private cSecondary: string = '#EC4899'
  private cTertiary: string = '#10B981'
  private cBg: string = '#F8FAFC'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#F1F5F9'
  private cLine: string = '#E2E8F0'
  private cError: string = '#EF4444'
  private cText: string = '#0F172A'
  private cMuted: string = '#B30F172A'
  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', '#EC4899'),
    new HealthMetric(2, 'Steps', '842', 'steps', '#6366F1'),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', '#10B981'),
    new HealthMetric(4, 'Calories', '420', 'kcal', '#EF4444')
  ]
  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', '#6366F1'),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', '#EC4899'),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', '#10B981')
  ]
  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ]

  @Builder
  HeroCard() {
    Column() {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.White)
        .width('100%')
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('100%')
        .margin({ top: 4, bottom: 12 })
      Button('Start Workout')
        .width('100%')
        .height(44)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cPrimary)
        .backgroundColor(Color.White)
        .borderRadius(12)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.cPrimary)
    .borderRadius(16)
    .shadow({ radius: 12, color: '#38000000', offsetY: 3 })
  }

  @Builder
  MetricTile(metric: HealthMetric) {
    Column() {
      Circle()
        .width(36)
        .height(36)
        .fill(metric.color)
      Text(metric.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cText)
        .margin({ top: 4 })
      Text(metric.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cMuted)
        .margin({ top: 2 })
    }
    .padding(8)
    .backgroundColor(this.cSurface)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row() {
      Rect()
        .width(44)
        .height(44)
        .radius(12)
        .fill(workout.iconColor)
        .margin({ right: 8 })
      Column() {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .width('100%')
        Row() {
          Text(workout.duration)
            .fontSize(14)
            .fontColor(this.cMuted)
            .margin({ right: 12 })
          Text(workout.calories)
            .fontSize(14)
            .fontColor(this.cMuted)
        }
        .width('100%')
        .margin({ top: 2 })
      }
      .layoutWeight(1)
      Button('Start')
        .width(70)
        .height(32)
        .fontSize(10)
        .fontColor(Color.White)
        .backgroundColor(this.cPrimary)
        .borderRadius(8)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(this.cSurface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
    .margin({ bottom: 12 })
  }

  @Builder
  NavButton(item: NavItem) {
    Button() {
      Column() {
        Circle()
          .width(20)
          .height(20)
          .fill(this.selectedNav === item.id ? this.cPrimary : this.cLine)
        Text(item.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cText)
          .margin({ top: 2 })
      }
      .width('100%')
    }
    .layoutWeight(1)
    .height(56)
    .backgroundColor(Color.Transparent)
    .onClick(() => {
      this.selectedNav = item.id
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 60, bottom: 20 })

        Scroll() {
          Column() {
            this.HeroCard()
              
            Text('Today\'s Metrics')
              .fontSize(14)
              .fontColor(this.cText)
              .width('100%')
              .margin({ left: 4, top: 12, bottom: 12 })

            Row() {
              ForEach(this.metrics, (metric: HealthMetric) => {
                this.MetricTile(metric)
              }, (metric: HealthMetric) => metric.id.toString())
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Text('Recent Workouts')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.cText)
              Blank()
              Button('View All')
                .height(32)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.cPrimary)
                .backgroundColor(Color.Transparent)
                .padding({ right: 20 })
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 })

            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            }, (workout: Workout) => workout.id.toString())

            Blank().height(88)
          }
          .padding({ left: 8, right: 8, bottom: 84 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cBg)

      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          this.NavButton(item)
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .backgroundColor(this.cSurface)
      .borderRadius(16)
      .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
      .margin({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBg)
  }
}
