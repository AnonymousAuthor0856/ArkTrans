// Health Dashboard - ArkTS implementation

@Observed
class HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  progress: number;
  color: ResourceColor;

  constructor(id: number, title: string, value: string, unit: string, progress: number, color: ResourceColor) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.unit = unit;
    this.progress = progress;
    this.color = color;
  }
}

@Observed
class Workout {
  id: number;
  name: string;
  duration: string;
  calories: string;
  iconColor: ResourceColor;

  constructor(id: number, name: string, duration: string, calories: string, iconColor: ResourceColor) {
    this.id = id;
    this.name = name;
    this.duration = duration;
    this.calories = calories;
    this.iconColor = iconColor;
  }
}

@Observed
class NavItem {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, '#EC4899'),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, '#6366F1'),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, '#10B981'),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, '#EF4444')
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', '#6366F1'),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', '#EC4899')
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  build() {
    Stack() {
      Column() {
        // Top title
        Text('Health Dashboard')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ top: 16, bottom: 24 })

        Scroll() {
          Column({ space: 24 }) {
            // Hero Card
            Column({ space: 8 }) {
              Text('Good Morning!')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
                .width('100%')

              Text('Ready for your workout?')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .width('100%')
                .margin({ bottom: 8 })

              Button('Start Workout')
                .fontSize(24)
                .fontColor('#6366F1')
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .width('100%')
                .height(64)
            }
            .width('100%')
            .padding(20)
            .backgroundColor('#6366F1')
            .borderRadius(24)
            .shadow({ radius: 16, color: 'rgba(0, 0, 0, 0.2)', offsetY: 8 })

            // Today's Metrics Section
            Text('Today\'s Metrics')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')
              .width('100%')

            // Metric Cards Row
            Row({ space: 8 }) {
              ForEach(this.metrics, (metric: HealthMetric) => {
                Column({ space: 4 }) {
                  Circle({ width: 60, height: 60 })
                    .fill(metric.color)

                  Text(metric.value)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#0F172A')

                  Text(metric.title)
                    .fontSize(18)
                    .fontColor('#475569')
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center)
                .padding(12)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.15)', offsetY: 4 })
              }, (metric: HealthMetric) => metric.id.toString())
            }
            .width('100%')

            // Recent Workouts Header
            Row() {
              Text('Recent Workouts')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F172A')
                .layoutWeight(1)

              Text('View All')
                .fontSize(18)
                .fontColor('#6366F1')
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Workout Cards
            Column({ space: 16 }) {
              ForEach(this.workouts, (workout: Workout) => {
                Row({ space: 12 }) {
                  // Icon
                  Row() {}
                    .width(64)
                    .height(64)
                    .backgroundColor(workout.iconColor)
                    .borderRadius(20)

                  // Info
                  Column({ space: 4 }) {
                    Text(workout.name)
                      .fontSize(24)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0F172A')
                      .width('100%')

                    Row({ space: 20 }) {
                      Text(workout.duration)
                        .fontSize(20)
                        .fontColor('#64748B')

                      Text(workout.calories)
                        .fontSize(20)
                        .fontColor('#64748B')
                    }
                    .width('100%')
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)

                  // Star Button
                  Button('Star')
                    .fontSize(18)
                    .fontColor('#FFFFFF')
                    .backgroundColor('#6366F1')
                    .borderRadius(16)
                    .height(48)
                    .padding({ left: 24, right: 24 })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#FFFFFF')
                .borderRadius(20)
                .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.1)', offsetY: 2 })
                .alignItems(VerticalAlign.Center)
              }, (workout: Workout) => workout.id.toString())
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)

        // Bottom Navigation
        Row() {
          ForEach(this.navItems, (item: NavItem) => {
            Column({ space: 4 }) {
              Circle({ width: 28, height: 28 })
                .fill(this.selectedNav === item.id ? '#6366F1' : '#E2E8F0')

              Text(item.label)
                .fontSize(14)
                .fontColor(this.selectedNav === item.id ? '#0F172A' : '#475569')
                .fontWeight(this.selectedNav === item.id ? FontWeight.Medium : FontWeight.Normal)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.selectedNav = item.id;
            })
          }, (item: NavItem) => item.id.toString())
        }
        .width('100%')
        .height(80)
        .backgroundColor('#F8FAFC')
        .padding({ left: 8, right: 8, bottom: 8, top: 8 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
  }
}
