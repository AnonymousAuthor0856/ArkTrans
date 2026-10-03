// HealthDashboardTokens.ets
export class HealthDashboardTokens {
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
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
    small: { size: 10, weight: FontWeight.Normal }
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

// Data Models
export class HealthMetric {
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

export class Workout {
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

export class NavItem {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

// Main View Component
@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', HealthDashboardTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', HealthDashboardTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', HealthDashboardTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', HealthDashboardTokens.Colors.error)
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HealthDashboardTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HealthDashboardTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HealthDashboardTokens.Colors.tertiary)
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  private bottomBarHeight: number = 72;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(HealthDashboardTokens.Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Text('Health Dashboard')
          .fontSize(HealthDashboardTokens.Typography.display.size)
          .fontWeight(HealthDashboardTokens.Typography.display.weight)
          .fontColor(HealthDashboardTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 40, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            // Hero Card
            this.HeroCard()

            // Section Title
            Text("Today's Metrics")
              .fontSize(HealthDashboardTokens.Typography.body.size)
              .fontColor(HealthDashboardTokens.Colors.onBackground)
              .width('100%')
              .padding({ left: HealthDashboardTokens.Spacing.sm, right: HealthDashboardTokens.Spacing.sm })

            // Metrics Row
            Row({ space: HealthDashboardTokens.Spacing.md }) {
              ForEach(this.metrics, (metric: HealthMetric) => {
                this.MetricCard(metric)
              })
            }
            .width('100%')

            // Recent Workouts Header
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
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 })

            // Workout Cards
            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            })
          }
          .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md, bottom: this.bottomBarHeight + HealthDashboardTokens.Spacing.lg })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')

      // Bottom Navigation
      this.BottomNavigation()
        .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md, bottom: HealthDashboardTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HeroCard() {
    Column({ space: HealthDashboardTokens.Spacing.sm }) {
      Text('Good Morning!')
        .fontSize(HealthDashboardTokens.Typography.title.size)
        .fontWeight(HealthDashboardTokens.Typography.title.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .textAlign(TextAlign.Start)
        .width('100%')

      Text('Ready for your workout?')
        .fontSize(HealthDashboardTokens.Typography.headline.size)
        .fontWeight(HealthDashboardTokens.Typography.headline.weight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .textAlign(TextAlign.Start)
        .width('100%')

      Button('Start Workout') {
        // Action
      }
      .height(44)
      .width('100%')
      .fontSize(HealthDashboardTokens.Typography.title.size)
      .fontWeight(HealthDashboardTokens.Typography.title.weight)
      .fontColor(HealthDashboardTokens.Colors.primary)
      .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
      .borderRadius(HealthDashboardTokens.Shapes.medium)
      .margin({ top: HealthDashboardTokens.Spacing.sm })
    }
    .padding(HealthDashboardTokens.Spacing.xl)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level3.radius,
      color: `rgba(0,0,0,${HealthDashboardTokens.Elevation.level3.opacity})`,
      offsetY: HealthDashboardTokens.Elevation.level3.y
    })
  }

  @Builder
  MetricCard(metric: HealthMetric) {
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
        .fontColor(HealthDashboardTokens.Colors.onSurface)
        .opacity(0.7)
    }
    .padding(HealthDashboardTokens.Spacing.md)
    .layoutWeight(1)
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${HealthDashboardTokens.Elevation.level2.opacity})`,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      // Icon Placeholder
      Column()
        .width(44)
        .height(44)
        .backgroundColor(workout.iconColor)
        .borderRadius(HealthDashboardTokens.Shapes.medium)

      // Text Details
      Column({ space: HealthDashboardTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(HealthDashboardTokens.Typography.title.size)
          .fontWeight(HealthDashboardTokens.Typography.title.weight)
          .fontColor(HealthDashboardTokens.Colors.onSurface)
        
        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
            .opacity(0.7)
          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
            .opacity(0.7)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Start Button
      Button('Start') {
        // Action
      }
      .width(70)
      .height(32)
      .fontSize(HealthDashboardTokens.Typography.small.size)
      .fontColor(HealthDashboardTokens.Colors.onPrimary)
      .backgroundColor(HealthDashboardTokens.Colors.primary)
      .borderRadius(HealthDashboardTokens.Shapes.small)
    }
    .padding(HealthDashboardTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level1.radius,
      color: `rgba(0,0,0,${HealthDashboardTokens.Elevation.level1.opacity})`,
      offsetY: HealthDashboardTokens.Elevation.level1.y
    })
  }

  @Builder
  BottomNavigation() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: HealthDashboardTokens.Spacing.xs }) {
          Circle({ width: 20, height: 20 })
            .fill(this.selectedNav === item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
          
          Text(item.label)
            .fontSize(HealthDashboardTokens.Typography.label.size)
            .fontWeight(HealthDashboardTokens.Typography.label.weight)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      })
    }
    .padding({ top: HealthDashboardTokens.Spacing.sm, bottom: HealthDashboardTokens.Spacing.sm, left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: `rgba(0,0,0,${HealthDashboardTokens.Elevation.level2.opacity})`,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }
}