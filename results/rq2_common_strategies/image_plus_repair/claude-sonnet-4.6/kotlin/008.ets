import { router } from '@kit.ArkUI'

interface HealthMetric {
  id: number
  title: string
  value: string
  unit: string
  progress: number
  color: ResourceColor
}

interface Workout {
  id: number
  name: string
  duration: string
  calories: string
  iconColor: ResourceColor
}

interface NavItem {
  id: number
  label: string
}

const COLOR_PRIMARY: string = '#FF6366F1'
const COLOR_SECONDARY: string = '#FFEC4899'
const COLOR_TERTIARY: string = '#FF10B981'
const COLOR_BACKGROUND: string = '#FFF8FAFC'
const COLOR_SURFACE: string = '#FFFFFFFF'
const COLOR_OUTLINE: string = '#FFE2E8F0'
const COLOR_ERROR: string = '#FFEF4444'
const COLOR_ON_BACKGROUND: string = '#FF0F172A'
const COLOR_ON_SURFACE: string = '#FF0F172A'
const COLOR_ON_PRIMARY: string = '#FFFFFFFF'

const METRICS: HealthMetric[] = [
  { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: COLOR_SECONDARY },
  { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: COLOR_PRIMARY },
  { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: COLOR_TERTIARY },
  { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: COLOR_ERROR }
]

const WORKOUTS: Workout[] = [
  { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: COLOR_PRIMARY },
  { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: COLOR_SECONDARY },
  { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: COLOR_TERTIARY }
]

const NAV_ITEMS: NavItem[] = [
  { id: 0, label: 'Dashboard' },
  { id: 1, label: 'Workouts' },
  { id: 2, label: 'Nutrition' },
  { id: 3, label: 'Profile' }
]

@Component
struct MetricCard {
  metric: HealthMetric = { id: 0, title: '', value: '', unit: '', progress: 0, color: COLOR_PRIMARY }

  build() {
    Column({ space: 2 }) {
      Circle({ width: 36, height: 36 })
        .fill(this.metric.color)
      Text(this.metric.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)
      Text(this.metric.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B30F172A')
    }
    .padding(8)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#2D000000', offsetX: 0, offsetY: 2 })
    .layoutWeight(1)
  }
}

@Component
struct WorkoutCard {
  workout: Workout = { id: 0, name: '', duration: '', calories: '', iconColor: COLOR_PRIMARY }

  build() {
    Row({ space: 8 }) {
      Column()
        .width(44)
        .height(44)
        .backgroundColor(this.workout.iconColor)
        .borderRadius(12)

      Column({ space: 2 }) {
        Text(this.workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
        Row({ space: 12 }) {
          Text(this.workout.duration)
            .fontSize(14)
            .fontColor('#B30F172A')
          Text(this.workout.calories)
            .fontSize(14)
            .fontColor('#B30F172A')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Start')
        .fontSize(10)
        .fontColor(COLOR_ON_PRIMARY)
        .backgroundColor(COLOR_PRIMARY)
        .borderRadius(8)
        .width(70)
        .height(32)
    }
    .padding(8)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }
}

@Entry
@Component
struct Index {
  @State selectedNav: number = 0

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLOR_ON_BACKGROUND)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(COLOR_BACKGROUND)

      // Scrollable Content
      Scroll() {
        Column({ space: 12 }) {
          // Hero Card
          Column({ space: 4 }) {
            Text('Good Morning!')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_ON_PRIMARY)
            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_PRIMARY)
            Button('Start Workout')
              .width('100%')
              .height(44)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_PRIMARY)
              .backgroundColor(COLOR_ON_PRIMARY)
              .borderRadius(12)
          }
          .padding(16)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(COLOR_PRIMARY)
          .borderRadius(16)
          .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })

          // Metrics Header
          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(COLOR_ON_BACKGROUND)
            .padding({ left: 4 })

          // Metrics Row
          Row({ space: 8 }) {
            ForEach(METRICS, (metric: HealthMetric) => {
              MetricCard({ metric: metric })
            })
          }
          .width('100%')

          // Recent Workouts Header
          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(COLOR_ON_BACKGROUND)
            Button('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLOR_PRIMARY)
              .backgroundColor(Color.Transparent)
              .shadow({ radius: 0, color: Color.Transparent, offsetX: 0, offsetY: 0 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Workout Cards
          ForEach(WORKOUTS, (workout: Workout) => {
            WorkoutCard({ workout: workout })
          })

          // Bottom padding
          Column().height(24)
        }
        .padding({ left: 8, right: 8, top: 8 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(COLOR_BACKGROUND)

      // Bottom Navigation
      Row() {
        ForEach(NAV_ITEMS, (item: NavItem) => {
          Column({ space: 4 }) {
            if (this.selectedNav === item.id) {
              Row() {
                Circle({ width: 20, height: 20 })
                  .fill(COLOR_PRIMARY)
              }
              .width(44)
              .height(28)
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#1A6366F1')
              .borderRadius(14)
            } else {
              Circle({ width: 20, height: 20 })
                .fill(COLOR_OUTLINE)
            }
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? COLOR_PRIMARY : COLOR_ON_SURFACE)
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
      .backgroundColor(COLOR_SURFACE)
      .shadow({ radius: 8, color: '#2D000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}