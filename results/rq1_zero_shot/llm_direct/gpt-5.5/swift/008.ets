class TypographySpec {
  size: number;
  weight: number;

  constructor(size: number, weight: number) {
    this.size = size;
    this.weight = weight;
  }
}

class ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
  color: ResourceColor;

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius;
    this.y = y;
    this.opacity = opacity;
    this.color = `rgba(0, 0, 0, ${opacity})`;
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
    onSurface: '#0F172A',
    onSurface70: 'rgba(15, 23, 42, 0.7)'
  };

  static readonly Typography = {
    display: new TypographySpec(24, 700),
    headline: new TypographySpec(20, 600),
    title: new TypographySpec(16, 500),
    body: new TypographySpec(14, 400),
    label: new TypographySpec(12, 500),
    small: new TypographySpec(10, 400)
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
    level1: new ShadowSpec(4, 1, 0.15),
    level2: new ShadowSpec(8, 2, 0.18),
    level3: new ShadowSpec(12, 3, 0.22),
    level4: new ShadowSpec(16, 4, 0.25)
  };
}

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

  private readonly metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', HealthDashboardTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', HealthDashboardTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', HealthDashboardTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', HealthDashboardTokens.Colors.error)
  ];

  private readonly workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HealthDashboardTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HealthDashboardTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HealthDashboardTokens.Colors.tertiary)
  ];

  private readonly navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  private readonly bottomBarHeight: number = 72;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        this.TopBar()
          .padding({ top: 40, bottom: 20 })

        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            this.HeroCard()
            this.SectionTitle('Today\'s Metrics')
            this.MetricsRow()

            this.RecentWorkoutsHeader()
              .padding({ top: 10, bottom: 10 })

            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            }, (workout: Workout) => workout.id.toString())
          }
          .width('100%')
          .padding({
            left: HealthDashboardTokens.Spacing.md,
            right: HealthDashboardTokens.Spacing.md,
            bottom: this.bottomBarHeight + HealthDashboardTokens.Spacing.lg
          })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      this.BottomNavigation()
        .margin({
          left: HealthDashboardTokens.Spacing.md,
          right: HealthDashboardTokens.Spacing.md,
          bottom: HealthDashboardTokens.Spacing.md
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthDashboardTokens.Colors.background)
  }

  @Builder
  private TopBar() {
    Text('Health Dashboard')
      .fontSize(HealthDashboardTokens.Typography.display.size)
      .fontWeight(HealthDashboardTokens.Typography.display.weight)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({
        top: HealthDashboardTokens.Spacing.xxl,
        bottom: HealthDashboardTokens.Spacing.md
      })
  }

  @Builder
  private HeroCard() {
    Column({ space: HealthDashboardTokens.Spacing.sm }) {
      Text('Good Morning!')
        .fontSize(HealthDashboardTokens.Typography.title.size)
        .fontWeight(HealthDashboardTokens.Typography.title.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)

      Text('Ready for your workout?')
        .fontSize(HealthDashboardTokens.Typography.headline.size)
        .fontWeight(HealthDashboardTokens.Typography.headline.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)

      Row() {
        Text('Start Workout')
          .fontSize(HealthDashboardTokens.Typography.title.size)
          .fontWeight(HealthDashboardTokens.Typography.title.weight)
          .fontColor(HealthDashboardTokens.Colors.primary)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .height(44)
      .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
      .borderRadius(HealthDashboardTokens.Shapes.medium)
      .onClick(() => {
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(HealthDashboardTokens.Spacing.xl)
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level3.radius,
      color: HealthDashboardTokens.Elevation.level3.color,
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level3.y
    })
  }

  @Builder
  private SectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(400)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: HealthDashboardTokens.Spacing.sm, right: HealthDashboardTokens.Spacing.sm })
  }

  @Builder
  private MetricsRow() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Row() {
          Column({ space: HealthDashboardTokens.Spacing.xs }) {
            Circle()
              .fill(metric.color)
              .width(36)
              .height(36)

            Text(metric.value)
              .fontSize(HealthDashboardTokens.Typography.headline.size)
              .fontWeight(HealthDashboardTokens.Typography.headline.weight)
              .fontColor(HealthDashboardTokens.Colors.onSurface)

            Text(metric.title)
              .fontSize(HealthDashboardTokens.Typography.label.size)
              .fontWeight(HealthDashboardTokens.Typography.label.weight)
              .fontColor(HealthDashboardTokens.Colors.onSurface70)
          }

          Blank()
        }
        .padding(HealthDashboardTokens.Spacing.md)
        .layoutWeight(1)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({
          radius: HealthDashboardTokens.Elevation.level2.radius,
          color: HealthDashboardTokens.Elevation.level2.color,
          offsetX: 0,
          offsetY: HealthDashboardTokens.Elevation.level2.y
        })
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
  }

  @Builder
  private RecentWorkoutsHeader() {
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
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private WorkoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      Rect()
        .fill(workout.iconColor)
        .width(44)
        .height(44)
        .borderRadius(HealthDashboardTokens.Shapes.medium)

      Column({ space: HealthDashboardTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(HealthDashboardTokens.Typography.title.size)
          .fontWeight(HealthDashboardTokens.Typography.title.weight)
          .fontColor(HealthDashboardTokens.Colors.onSurface)

        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .fontColor(HealthDashboardTokens.Colors.onSurface70)

          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .fontColor(HealthDashboardTokens.Colors.onSurface70)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        Text('Start')
          .fontSize(HealthDashboardTokens.Typography.small.size)
          .fontWeight(HealthDashboardTokens.Typography.small.weight)
          .fontColor(HealthDashboardTokens.Colors.onPrimary)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .width(70)
      .height(32)
      .backgroundColor(HealthDashboardTokens.Colors.primary)
      .borderRadius(HealthDashboardTokens.Shapes.small)
      .onClick(() => {
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(HealthDashboardTokens.Spacing.lg)
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level1.radius,
      color: HealthDashboardTokens.Elevation.level1.color,
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level1.y
    })
  }

  @Builder
  private BottomNavigation() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: HealthDashboardTokens.Spacing.xs }) {
          Circle()
            .fill(this.selectedNav === item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
            .width(20)
            .height(20)

          Text(item.label)
            .fontSize(HealthDashboardTokens.Typography.label.size)
            .fontWeight(HealthDashboardTokens.Typography.label.weight)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({
      top: HealthDashboardTokens.Spacing.sm,
      bottom: HealthDashboardTokens.Spacing.sm,
      left: HealthDashboardTokens.Spacing.md,
      right: HealthDashboardTokens.Spacing.md
    })
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: HealthDashboardTokens.Elevation.level2.color,
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }
}