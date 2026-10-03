interface HealthMetric {
  title: string
  value: string
  color: string
}

interface Workout {
  name: string
  duration: string
  calories: string
  color: string
}

@Entry
@Component
struct HealthDashboard {
  private readonly primary: string = '#6366F1'
  private readonly pageBg: string = '#F8FAFC'
  private readonly ink: string = '#0F172A'
  private readonly muted: string = '#596273'
  private readonly stroke: string = '#E2E8F0'

  @State private selectedNav: number = 0
  @State private startedWorkout: string = ''

  private readonly metrics: HealthMetric[] = [
    { title: 'Heart', value: '72', color: '#EC4899' },
    { title: 'Steps', value: '842', color: '#6366F1' },
    { title: 'Sleep', value: '7.2', color: '#10B981' },
    { title: 'Calories', value: '420', color: '#EF4444' }
  ]

  private readonly workouts: Workout[] = [
    { name: 'Morning Run', duration: '32 min', calories: '284 kcal', color: '#6366F1' },
    { name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', color: '#EC4899' },
    { name: 'Strength Training', duration: '28 min', calories: '320 kcal', color: '#10B981' }
  ]

  @Builder
  private MetricTile(metric: HealthMetric) {
    Column({ space: 3 }) {
      Blank()
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(metric.color)

      Text(metric.value)
        .fontSize(21)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.ink)
        .lineHeight(26)

      Text(metric.title)
        .fontSize(12)
        .fontColor(this.muted)
        .maxLines(1)
    }
    .width('100%')
    .height(94)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: this.stroke })
    .shadow({ radius: 6, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private WorkoutRow(workout: Workout) {
    Row({ space: 8 }) {
      Blank()
        .width(44)
        .height(44)
        .borderRadius(12)
        .backgroundColor(workout.color)

      Column({ space: 1 }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.ink)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: 12 }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor(this.muted)
          Text(workout.calories)
            .fontSize(14)
            .fontColor(this.muted)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .width(70)
        .height(32)
        .fontSize(12)
        .fontColor('#FFFFFF')
        .backgroundColor(this.primary)
        .borderRadius(8)
        .onClick(() => {
          this.startedWorkout = workout.name
        })
    }
    .width('100%')
    .height(61)
    .padding(8)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: this.stroke })
    .shadow({ radius: 4, color: '#18000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  private BottomNavigation() {
    Column() {
      Row() {
        ForEach(['Dashboard', 'Workouts', 'Nutrition', 'Profile'], (label: string, index: number) => {
          Column({ space: 4 }) {
            Stack() {
              if (this.selectedNav === index) {
                Row() {
                  Blank()
                    .width(20)
                    .height(20)
                    .borderRadius(10)
                    .backgroundColor(this.primary)
                }
                .width(60)
                .height(28)
                .justifyContent(FlexAlign.Center)
                .backgroundColor('#E9DDF8')
                .borderRadius(20)
              } else {
                Blank()
                  .width(20)
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor(this.stroke)
              }
            }
            .width(60)
            .height(28)

            Text(label)
              .fontSize(12)
              .fontColor(this.selectedNav === index ? this.ink : '#454653')
              .maxLines(1)
          }
          .width('25%')
          .height(52)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNav = index
          })
        }, (label: string) => label)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#F2F1FF')
    }
    .width('100%')
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.ink)
      }
      .width('100%')
      .height(88)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(this.pageBg)

      Scroll() {
        Column({ space: 12 }) {
          Column({ space: 4 }) {
            Text('Good Morning!')
              .fontSize(16)
              .fontColor('#FFFFFF')

            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })

            Button('Start Workout')
              .width('100%')
              .height(44)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primary)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .margin({ top: 1 })
              .onClick(() => {
                this.startedWorkout = 'Workout'
              })
          }
          .width('100%')
          .height(127)
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(this.primary)
          .borderRadius(16)
          .shadow({ radius: 10, color: '#38000000', offsetX: 0, offsetY: 3 })

          Text("Today's Metrics")
            .width('100%')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.ink)
            .margin({ left: 4 })

          Row({ space: 8 }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column() {
                this.MetricTile(metric)
              }
              .layoutWeight(1)
            }, (metric: HealthMetric) => metric.title)
          }
          .width('100%')

          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.ink)

            Blank().layoutWeight(1)

            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.primary)
              .onClick(() => {
                this.selectedNav = 1
              })
          }
          .width('100%')
          .height(44)
          .alignItems(VerticalAlign.Center)

          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutRow(workout)
          }, (workout: Workout) => workout.name)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 0, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(this.pageBg)

      this.BottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBg)
  }
}
