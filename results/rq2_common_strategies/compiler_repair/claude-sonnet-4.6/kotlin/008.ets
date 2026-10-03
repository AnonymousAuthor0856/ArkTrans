import { router } from '@kit.ArkUI'

class HealthMetric {
  id: number = 0
  title: string = ''
  value: string = ''
  unit: string = ''
  progress: number = 0
  color: string = ''
}

class Workout {
  id: number = 0
  name: string = ''
  duration: string = ''
  calories: string = ''
  iconColor: string = ''
}

class NavItem {
  id: number = 0
  label: string = ''
}

@Entry
@Component
struct Index {
  @State selectedNav: number = 0

  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: '#FFEC4899' },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: '#FF6366F1' },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: '#FF10B981' },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: '#FFEF4444' }
  ]

  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: '#FF6366F1' },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: '#FFEC4899' },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: '#FF10B981' }
  ]

  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  @Builder
  MetricCard(metric: HealthMetric) {
    Column({ space: 4 }) {
      Stack() {
      }
      .width(36)
      .height(36)
      .borderRadius(18)
      .backgroundColor(metric.color)

      Text(metric.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF0F172A')

      Text(metric.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#990F172A')
    }
    .padding(8)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
    .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 2 })
    .layoutWeight(1)
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: 8 }) {
      Stack() {
      }
      .width(44)
      .height(44)
      .borderRadius(12)
      .backgroundColor(workout.iconColor)

      Column({ space: 2 }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF0F172A')

        Row({ space: 12 }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#990F172A')

          Text(workout.calories)
            .fontSize(14)
            .fontColor('#990F172A')
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .fontSize(10)
        .fontColor('#FFFFFFFF')
        .backgroundColor('#FF6366F1')
        .borderRadius(8)
        .width(70)
        .height(32)
    }
    .padding(8)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFF8FAFC')

      // Content
      Scroll() {
        Column({ space: 12 }) {
          // Hero Card
          Column({ space: 4 }) {
            Text('Good Morning!')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFFFF')

            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFFFF')

            Button('Start Workout')
              .width('100%')
              .height(44)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF6366F1')
              .backgroundColor('#FFFFFFFF')
              .borderRadius(12)
          }
          .padding(16)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .backgroundColor('#FF6366F1')
          .borderRadius(16)
          .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })

          // Metrics Title
          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF0F172A')
            .padding({ left: 4 })

          // Metrics Row
          Row({ space: 8 }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              this.MetricCard(metric)
            })
          }
          .width('100%')

          // Recent Workouts Header
          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FF0F172A')

            Button('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF6366F1')
              .backgroundColor(Color.Transparent)
              .shadow({ radius: 0, color: Color.Transparent, offsetX: 0, offsetY: 0 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Workout Cards
          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutCard(workout)
          })

          Blank().height(24)
        }
        .padding({ left: 8, right: 8, top: 8, bottom: 8 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FFF8FAFC')

      // Bottom Navigation
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: 4 }) {
            Stack() {
            }
            .width(20)
            .height(20)
            .borderRadius(10)
            .backgroundColor(this.selectedNav === item.id ? '#FF6366F1' : '#FFE2E8F0')

            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? '#FF6366F1' : '#FF94A3B8')
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
          .padding({ top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedNav = item.id
          })
        })
      }
      .width('100%')
      .height(64)
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
  }
}