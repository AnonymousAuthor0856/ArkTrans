class HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  color: string;

  constructor(id: number, title: string, value: string, unit: string, color: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.unit = unit;
    this.color = color;
  }
}

class Workout {
  id: number;
  name: string;
  duration: string;
  calories: string;
  iconColor: string;

  constructor(id: number, name: string, duration: string, calories: string, iconColor: string) {
    this.id = id;
    this.name = name;
    this.duration = duration;
    this.calories = calories;
    this.iconColor = iconColor;
  }
}

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
struct HealthDashboardAppView {
  @State private selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', '#EC4899'),
    new HealthMetric(2, 'Steps', '842', 'steps', '#6366F1'),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', '#10B981'),
    new HealthMetric(4, 'Calories', '420', 'kcal', '#EF4444')
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', '#6366F1'),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', '#EC4899'),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', '#10B981')
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  @Builder
  HeroCard() {
    Column() {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#FFFFFF')
        .margin({ top: 4 })
      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#6366F1')
        .backgroundColor('#FFFFFF')
        .width('100%')
        .height(44)
        .borderRadius(12)
        .margin({ top: 4 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#6366F1')
    .borderRadius(16)
    .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })
  }

  @Builder
  MetricCard(metric: HealthMetric) {
    Row() {
      Column() {
        Circle()
          .width(36)
          .height(36)
          .fill(metric.color)
        Text(metric.value)
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0F172A')
          .margin({ top: 2 })
        Text(metric.title)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B30F172A')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Center)
      Blank()
    }
    .padding(8)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  MetricsRow() {
    Row() {
      ForEach(this.metrics, (metric: HealthMetric) => {
        this.MetricCard(metric)
          .layoutWeight(1)
          .margin({ right: 8 })
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row() {
      Rect()
        .width(44)
        .height(44)
        .radius(12)
        .fill(workout.iconColor)
      Column() {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0F172A')
        Row() {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#B30F172A')
          Text(workout.calories)
            .fontSize(14)
            .fontColor('#B30F172A')
            .margin({ left: 12 })
        }
        .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 8 })

      Button('Start')
        .fontSize(10)
        .fontColor('#FFFFFF')
        .backgroundColor('#6366F1')
        .width(70)
        .height(32)
        .borderRadius(8)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomNavigation() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column() {
            Circle()
              .width(20)
              .height(20)
              .fill(this.selectedNav === item.id ? '#6366F1' : '#E2E8F0')
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
              .margin({ top: 2 })
          }
          .width('100%')
        }
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 60, bottom: 28 })

        Scroll() {
          Column() {
            this.HeroCard()
            Text("Today's Metrics")
              .fontSize(14)
              .fontColor('#0F172A')
              .width('100%')
              .margin({ top: 12 })
              .padding({ left: 4 })
            this.MetricsRow()
              .margin({ top: 12 })
            Row() {
              Text('Recent Workouts')
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#0F172A')
                .layoutWeight(1)
              Button('View All')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#6366F1')
                .backgroundColor(Color.Transparent)
                .padding({ right: 20 })
            }
            .width('100%')
            .margin({ top: 22, bottom: 10 })

            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
                .margin({ bottom: 12 })
            }, (workout: Workout) => workout.id.toString())

            Blank().height(84)
          }
          .width('100%')
          .padding({ left: 8, right: 8, bottom: 84 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')

      this.BottomNavigation()
        .margin({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
