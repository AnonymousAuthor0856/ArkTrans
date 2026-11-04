class HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  progress: number;
  color: string;

  constructor(id: number, title: string, value: string, unit: string, progress: number, color: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.unit = unit;
    this.progress = progress;
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

class HealthColors {
  static primary: string = '#6366F1';
  static secondary: string = '#EC4899';
  static tertiary: string = '#10B981';
  static background: string = '#F8FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F1F5F9';
  static outline: string = '#E2E8F0';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#0F172A';
}

@Entry
@Component
struct Index {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, HealthColors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, HealthColors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, HealthColors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, HealthColors.error)
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HealthColors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HealthColors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HealthColors.tertiary)
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  @Builder
  HeroCard() {
    Column({ space: 4 }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthColors.onPrimary)
        .lineHeight(22)
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthColors.onPrimary)
        .lineHeight(26)
      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthColors.primary)
        .backgroundColor(HealthColors.onPrimary)
        .borderRadius(12)
        .width('100%')
        .height(44)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(HealthColors.primary)
    .borderRadius(16)
    .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })
  }

  @Builder
  MetricCard(metric: HealthMetric) {
    Column({ space: 2 }) {
      Blank()
        .width(36)
        .height(36)
        .backgroundColor(metric.color)
        .borderRadius(36)
      Text(metric.value)
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthColors.onSurface)
        .lineHeight(26)
      Text(metric.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B30F172A')
        .lineHeight(16)
    }
    .layoutWeight(1)
    .padding(8)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(HealthColors.surface)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  WorkoutRow(workout: Workout) {
    Row({ space: 8 }) {
      Blank()
        .width(44)
        .height(44)
        .backgroundColor(workout.iconColor)
        .borderRadius(12)
      Column({ space: 2 }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HealthColors.onSurface)
          .lineHeight(22)
        Row({ space: 12 }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#B30F172A')
            .lineHeight(20)
          Text(workout.calories)
            .fontSize(14)
            .fontColor('#B30F172A')
            .lineHeight(20)
        }
      }
      .layoutWeight(1)

      Button('Start')
        .fontSize(10)
        .fontColor(HealthColors.onPrimary)
        .backgroundColor(HealthColors.primary)
        .borderRadius(8)
        .height(32)
        .width(70)
    }
    .width('100%')
    .padding(8)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(HealthColors.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  NavButton(item: NavItem) {
    Column({ space: 2 }) {
      Blank()
        .width(20)
        .height(20)
        .backgroundColor(this.selectedNav === item.id ? HealthColors.primary : HealthColors.outline)
        .borderRadius(20)
      Text(item.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthColors.onSurface)
        .lineHeight(16)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedNav = item.id;
    })
  }

  build() {
    Column() {
      Text('Health Dashboard')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(HealthColors.onSurface)
        .lineHeight(30)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)

      Scroll() {
        Column({ space: 12 }) {
          this.HeroCard()

          Text('Today\'s Metrics')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthColors.onSurface)
            .lineHeight(26)
            .width('100%')
            .padding({ left: 4, right: 4 })

          Row({ space: 8 }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              this.MetricCard(metric)
            }, (metric: HealthMetric) => metric.id.toString())
          }
          .width('100%')

          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthColors.onSurface)
              .lineHeight(26)
            Button('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthColors.primary)
              .backgroundColor('#00FFFFFF')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutRow(workout)
          }, (workout: Workout) => workout.id.toString())
        }
        .width('100%')
        .padding({ left: 8, right: 8, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          this.NavButton(item)
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .backgroundColor(HealthColors.surface)
      .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthColors.background)
  }
}
