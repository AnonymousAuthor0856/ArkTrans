@Entry
@Component
struct HealthDashboardAppView {
  @State private selectedNav: number = 0

  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: '#EC4899' },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', color: '#6366F1' },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: '#10B981' },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: '#EF4444' }
  ]

  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: '#6366F1' },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: '#EC4899' },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: '#10B981' }
  ]

  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  private bottomBarHeight: number = 72

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F8FAFC')

      // Main content
      Column({ space: 0 }) {
        // Top bar
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 40, bottom: 20 })

        // Scrollable list
        List({ space: 12 }) {
          // Hero card
          ListItem() {
            HeroCard()
          }

          // Section title
          ListItem() {
            Text("Today's Metrics")
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor('#0F172A')
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ left: 4 })
          }

          // Metrics row
          ListItem() {
            Row({ space: 8 }) {
              ForEach(this.metrics, (metric: HealthMetric) => {
                MetricCard({ metric: metric })
              })
            }
            .width('100%')
          }

          // Recent workouts header
          ListItem() {
            Row() {
              Text('Recent Workouts')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0F172A')
              Blank()
              Button({ type: ButtonType.Normal }) {
                Text('View All')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#6366F1')
              }
              .padding({ right: 20 })
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 })
          }

          // Workout cards
          ForEach(this.workouts, (workout: Workout) => {
            ListItem() {
              WorkoutCard({ workout: workout })
            }
          })

          // Bottom spacer
          ListItem() {
            Column()
              .height(this.bottomBarHeight + 12)
          }
        }
        .padding({ left: 8, right: 8 })
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')

      // Bottom navigation
      Column() {
        Row({ space: 8 }) {
          ForEach(this.navItems, (item: NavItem) => {
            Button({ type: ButtonType.Normal }) {
              Column({ space: 2 }) {
                Image('')
                  .width(20)
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor(this.selectedNav == item.id ? '#6366F1' : '#E2E8F0')
                Text(item.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
              }
              .width('100%')
            }
            .onClick(() => { this.selectedNav = item.id })
          })
        }
        .padding({ top: 4, bottom: 4 })
        .padding({ left: 8, right: 8 })
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
      }
      .width('100%')
      .padding({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
  }
}

@Builder
function HeroCard() {
  Column({ space: 4 }) {
    Text('Good Morning!')
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor('#FFFFFF')
    Text('Ready for your workout?')
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor('#FFFFFF')
    Button({ type: ButtonType.Normal }) {
      Text('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#6366F1')
    }
    .width('100%')
    .height(44)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
  .padding(16)
  .width('100%')
  .backgroundColor('#6366F1')
  .borderRadius(16)
  .shadow({ radius: 12, color: '#38000000', offsetY: 3 })
}

@Builder
function MetricCard(param: MetricCardParam) {
  Column({ space: 2 }) {
    Image('')
      .width(36)
      .height(36)
      .borderRadius(18)
      .backgroundColor(param.metric.color)
    Text(param.metric.value)
      .fontSize(20)
      .fontWeight(FontWeight.Medium)
      .fontColor('#0F172A')
    Text(param.metric.title)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#0F172A')
      .opacity(0.7)
  }
  .padding(8)
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
}

@Builder
function WorkoutCard(param: WorkoutCardParam) {
  Row({ space: 8 }) {
    Image('')
      .width(44)
      .height(44)
      .borderRadius(12)
      .backgroundColor(param.workout.iconColor)

    Column({ space: 2 }) {
      Text(param.workout.name)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0F172A')
      Row({ space: 12 }) {
        Text(param.workout.duration)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#0F172A')
          .opacity(0.7)
        Text(param.workout.calories)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#0F172A')
          .opacity(0.7)
      }
    }
    .layoutWeight(1)

    Button({ type: ButtonType.Normal }) {
      Text('Start')
        .fontSize(10)
        .fontWeight(FontWeight.Regular)
        .fontColor('#FFFFFF')
    }
    .width(70)
    .height(32)
    .backgroundColor('#6366F1')
    .borderRadius(8)
  }
  .padding(12)
  .backgroundColor('#FFFFFF')
  .borderRadius(12)
  .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
}

interface MetricCardParam {
  metric: HealthMetric
}

interface WorkoutCardParam {
  workout: Workout
}

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