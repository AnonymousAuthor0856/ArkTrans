interface ColorPalette {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  outline: string
  error: string
  text: string
  muted: string
}

const COLORS: ColorPalette = {
  primary: '#6366F1',
  secondary: '#EC4899',
  tertiary: '#10B981',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  outline: '#E2E8F0',
  error: '#EF4444',
  text: '#0F172A',
  muted: '#5B6475'
}

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
  @State selectedNav: number = 0

  private metrics: HealthMetric[] = [
    { title: 'Heart', value: '72', color: COLORS.secondary },
    { title: 'Steps', value: '842', color: COLORS.primary },
    { title: 'Sleep', value: '7.2', color: COLORS.tertiary },
    { title: 'Calories', value: '420', color: COLORS.error }
  ]

  private workouts: Workout[] = [
    { name: 'Morning Run', duration: '32 min', calories: '284 kcal', color: COLORS.primary },
    { name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', color: COLORS.secondary },
    { name: 'Strength Training', duration: '28 min', calories: '320 kcal', color: COLORS.tertiary }
  ]

  private navItems: string[] = ['Dashboard', 'Workouts', 'Nutrition', 'Profile']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Health Dashboard')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.text)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 40, bottom: 20 })

        Scroll() {
          Column({ space: 12 }) {
            this.heroCard()

            Text("Today's Metrics")
              .fontSize(20)
              .fontColor(COLORS.text)
              .width('100%')
              .margin({ left: 4, top: 8 })

            Row({ space: 8 }) {
              ForEach(this.metrics, (metric: HealthMetric) => {
                this.metricCard(metric)
              })
            }
            .width('100%')

            Row() {
              Text('Recent Workouts')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLORS.text)

              Blank()

              Text('View All')
                .fontSize(16)
                .fontColor(COLORS.primary)
                .margin({ right: 20 })
            }
            .width('100%')
            .margin({ top: 10, bottom: 8 })

            ForEach(this.workouts, (workout: Workout) => {
              this.workoutCard(workout)
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 92 })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      this.bottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  heroCard() {
    Column({ space: 4 }) {
      Text('Good Morning!')
        .fontSize(22)
        .fontColor(Color.White)
        .width('100%')

      Text('Ready for your workout?')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .width('100%')
        .margin({ bottom: 8 })

      Button('Start Workout')
        .fontSize(20)
        .fontColor(COLORS.primary)
        .backgroundColor(Color.White)
        .height(56)
        .width('100%')
        .borderRadius(20)
        .onClick(() => {})
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(16)
    .backgroundColor(COLORS.primary)
    .borderRadius(24)
    .shadow({ radius: 12, color: '#38000000', offsetY: 3 })
  }

  @Builder
  metricCard(metric: HealthMetric) {
    Column({ space: 2 }) {
      Circle()
        .width(72)
        .height(72)
        .fill(metric.color)
        .margin({ bottom: 2 })

      Text(metric.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.text)

      Text(metric.title)
        .fontSize(17)
        .fontColor(COLORS.muted)
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .height(190)
    .padding({ left: 16, top: 16 })
    .backgroundColor(COLORS.surface)
    .borderRadius(20)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
  }

  @Builder
  workoutCard(workout: Workout) {
    Row({ space: 16 }) {
      Blank()
        .width(88)
        .height(88)
        .backgroundColor(workout.color)
        .borderRadius(20)

      Column({ space: 2 }) {
        Text(workout.name)
          .fontSize(24)
          .fontColor(COLORS.text)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Row({ space: 20 }) {
          Text(workout.duration)
            .fontSize(20)
            .fontColor(COLORS.muted)

          Text(workout.calories)
            .fontSize(20)
            .fontColor(COLORS.muted)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Start')
        .fontSize(16)
        .fontColor(Color.White)
        .backgroundColor(COLORS.primary)
        .width(140)
        .height(64)
        .borderRadius(16)
        .onClick(() => {})
    }
    .width('100%')
    .height(136)
    .padding(16)
    .backgroundColor(COLORS.surface)
    .borderRadius(20)
    .shadow({ radius: 6, color: '#26000000', offsetY: 1 })
  }

  @Builder
  bottomNavigation() {
    Row({ space: 8 }) {
      ForEach(this.navItems, (label: string, index: number) => {
        Button() {
          Column({ space: 4 }) {
            Circle()
              .width(20)
              .height(20)
              .fill(this.selectedNav === index ? COLORS.primary : COLORS.outline)

            Text(label)
              .fontSize(17)
              .fontColor(COLORS.text)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .height(72)
        .backgroundColor(Color.Transparent)
        .stateStyles({
          pressed: {
            opacity: 0.75
          }
        })
        .onClick(() => {
          this.selectedNav = index
        })
      })
    }
    .width('100%')
    .height(88)
    .padding({ left: 8, right: 8, top: 8, bottom: 8 })
    .backgroundColor(COLORS.surface)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
    .margin({ left: 16, right: 16, bottom: 16 })
  }
}
