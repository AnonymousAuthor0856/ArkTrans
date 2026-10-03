import promptAction from '@ohos.promptAction';

@Observed
class HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  color: ResourceColor;

  constructor(id: number, title: string, value: string, unit: string, color: ResourceColor) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.unit = unit;
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

class HealthDashboardTokens {
  static readonly Colors = {
    primary: '#6366F1',
    secondary: '#EC4899',
    tertiary: '#10B981',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  };

  static readonly Typography = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
    small: { size: 10, weight: FontWeight.Regular }
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    xxl: 20,
    xxxl: 24
  };

  static readonly Elevation = {
    level1: { radius: 4, y: 1, opacity: 0.15 },
    level2: { radius: 8, y: 2, opacity: 0.18 },
    level3: { radius: 12, y: 3, opacity: 0.22 },
    level4: { radius: 16, y: 4, opacity: 0.25 }
  };
}

@Entry
@Component
struct HealthDashboardPage {
  @State selectedNav: number = 0;
  @State metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', HealthDashboardTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', HealthDashboardTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', HealthDashboardTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', HealthDashboardTokens.Colors.error)
  ];
  @State workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HealthDashboardTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HealthDashboardTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HealthDashboardTokens.Colors.tertiary)
  ];
  @State navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];
  private readonly bottomBarHeight: number = 72;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()
        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            this.heroCard()
            this.sectionTitle('Today\'s Metrics')
            this.metricsRow()
            this.recentWorkoutsHeader()
              .margin({ top: 10, bottom: 10 })
            ForEach(this.workouts, (workout: Workout) => {
              this.workoutCard(workout)
            }, (workout: Workout) => workout.id.toString())
          }
          .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
          .padding({ bottom: this.bottomBarHeight + HealthDashboardTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(HealthDashboardTokens.Colors.background)

      this.bottomNavigation()
        .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
        .padding({ bottom: HealthDashboardTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthDashboardTokens.Colors.background)
  }

  @Builder
  topBar() {
    Text('Health Dashboard')
      .fontSize(HealthDashboardTokens.Typography.display.size)
      .fontWeight(HealthDashboardTokens.Typography.display.weight)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 40, bottom: 20 })
  }

  @Builder
  heroCard() {
    Column({ space: HealthDashboardTokens.Spacing.sm }) {
      Text('Good Morning!')
        .fontSize(HealthDashboardTokens.Typography.title.size)
        .fontWeight(HealthDashboardTokens.Typography.title.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)

      Text('Ready for your workout?')
        .fontSize(HealthDashboardTokens.Typography.headline.size)
        .fontWeight(HealthDashboardTokens.Typography.headline.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)

      Button('Start Workout')
        .fontSize(HealthDashboardTokens.Typography.title.size)
        .fontWeight(HealthDashboardTokens.Typography.title.weight)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .height(44)
        .width('100%')
        .margin({ top: HealthDashboardTokens.Spacing.xs })
        .onClick(() => {
          promptAction.showToast({ message: 'Start Workout' });
        })
    }
    .padding(HealthDashboardTokens.Spacing.xl)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level3.radius,
      color: `rgba(0, 0, 0, ${HealthDashboardTokens.Elevation.level3.opacity})`,
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level3.y
    })
  }

  @Builder
  sectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: HealthDashboardTokens.Spacing.sm, right: HealthDashboardTokens.Spacing.sm })
  }

  @Builder
  metricsRow() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column({ space: HealthDashboardTokens.Spacing.xs }) {
          Circle({ width: 36, height: 36 })
            .fill(metric.color)

          Text(metric.value)
            .fontSize(HealthDashboardTokens.Typography.headline.size)
            .fontWeight(HealthDashboardTokens.Typography.headline.weight)
            .fontColor(HealthDashboardTokens.Colors.onSurface)

          Text(metric.title)
            .fontSize(HealthDashboardTokens.Typography.label.size)
            .fontWeight(HealthDashboardTokens.Typography.label.weight)
            .fontColor(`rgba(15, 23, 42, 0.7)`)
        }
        .padding(HealthDashboardTokens.Spacing.md)
        .width('25%')
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({
          radius: HealthDashboardTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${HealthDashboardTokens.Elevation.level2.opacity})`,
          offsetX: 0,
          offsetY: HealthDashboardTokens.Elevation.level2.y
        })
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
  }

  @Builder
  recentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(HealthDashboardTokens.Typography.headline.size)
        .fontWeight(HealthDashboardTokens.Typography.headline.weight)
        .fontColor(HealthDashboardTokens.Colors.onBackground)

      Blank()

      Text('View All')
        .fontSize(HealthDashboardTokens.Typography.label.size)
        .fontWeight(HealthDashboardTokens.Typography.label.weight)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .padding({ right: 20 })
        .onClick(() => {
          promptAction.showToast({ message: 'View All' });
        })
    }
    .width('100%')
  }

  @Builder
  workoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      RoundedRect({
        width: 44,
        height: 44,
        radius: HealthDashboardTokens.Shapes.medium
      })
        .fill(workout.iconColor)

      Column({ space: HealthDashboardTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(HealthDashboardTokens.Typography.title.size)
          .fontWeight(HealthDashboardTokens.Typography.title.weight)
          .fontColor(HealthDashboardTokens.Colors.onSurface)

        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .fontColor(`rgba(15, 23, 42, 0.7)`)

          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .fontColor(`rgba(15, 23, 42, 0.7)`)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .fontSize(HealthDashboardTokens.Typography.small.size)
        .fontWeight(HealthDashboardTokens.Typography.small.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .backgroundColor(HealthDashboardTokens.Colors.primary)
        .borderRadius(HealthDashboardTokens.Shapes.small)
        .width(70)
        .height(32)
        .onClick(() => {
          promptAction.showToast({ message: `Start ${workout.name}` });
        })
    }
    .padding(HealthDashboardTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level1.radius,
      color: `rgba(0, 0, 0, ${HealthDashboardTokens.Elevation.level1.opacity})`,
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level1.y
    })
  }

  @Builder
  bottomNavigation() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: HealthDashboardTokens.Spacing.xs }) {
          Circle({ width: 20, height: 20 })
            .fill(this.selectedNav === item.id
              ? HealthDashboardTokens.Colors.primary
              : HealthDashboardTokens.Colors.outline)

          Text(item.label)
            .fontSize(HealthDashboardTokens.Typography.label.size)
            .fontWeight(HealthDashboardTokens.Typography.label.weight)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .padding({
      top: HealthDashboardTokens.Spacing.sm,
      bottom: HealthDashboardTokens.Spacing.sm,
      left: HealthDashboardTokens.Spacing.md,
      right: HealthDashboardTokens.Spacing.md
    })
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: `rgba(0, 0, 0, ${HealthDashboardTokens.Elevation.level2.opacity})`,
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }
}
