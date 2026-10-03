// Health Dashboard UI (SwiftUI -> ArkTS).

interface HealthColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  error: string;
  onPrimary: string;
  onBackground: string;
  onSurface: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface HealthTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
  small: FontSpec;
}

interface HealthSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface HealthShapes {
  small: number;
  medium: number;
  large: number;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

interface HealthElevation {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
  level4: ShadowSpec;
}

class HealthDashboardTokens {
  static readonly Colors: HealthColors = {
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

  static readonly Typography: HealthTypography = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Semibold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
    small: { size: 10, weight: FontWeight.Regular }
  };

  static readonly Shapes: HealthShapes = {
    small: 8, medium: 12, large: 16
  };

  static readonly Spacing: HealthSpacing = {
    xs: 2, sm: 4, md: 8, lg: 12, xl: 16, xxl: 20, xxxl: 24
  };

  static readonly Elevation: HealthElevation = {
    level1: { radius: 4, y: 1, opacity: 0.15 },
    level2: { radius: 8, y: 2, opacity: 0.18 },
    level3: { radius: 12, y: 3, opacity: 0.22 },
    level4: { radius: 16, y: 4, opacity: 0.25 }
  };
}

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
  @State selectedNav: number = 0;

  metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', HealthDashboardTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', HealthDashboardTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', HealthDashboardTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', HealthDashboardTokens.Colors.error)
  ];

  workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HealthDashboardTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HealthDashboardTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HealthDashboardTokens.Colors.tertiary)
  ];

  navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  bottomBarHeight: number = 72;

  @Builder
  topBar() {
    Text('Health Dashboard')
      .fontSize(HealthDashboardTokens.Typography.display.size)
      .fontWeight(HealthDashboardTokens.Typography.display.weight)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 40 + HealthDashboardTokens.Spacing.xxl, bottom: 20 + HealthDashboardTokens.Spacing.md })
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
        .width('100%')
        .height(44)
        .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .onClick(() => {})
    }
    .alignItems(HorizontalAlign.Start)
    .padding(HealthDashboardTokens.Spacing.xl)
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({ radius: HealthDashboardTokens.Elevation.level3.radius, color: 'rgba(0,0,0,' + HealthDashboardTokens.Elevation.level3.opacity + ')', offsetX: 0, offsetY: HealthDashboardTokens.Elevation.level3.y })
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
        Row() {
          Column({ space: HealthDashboardTokens.Spacing.xs }) {
            Circle()
              .width(36)
              .height(36)
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
          Blank()
        }
        .layoutWeight(1)
        .padding(HealthDashboardTokens.Spacing.md)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({ radius: HealthDashboardTokens.Elevation.level2.radius, color: 'rgba(0,0,0,' + HealthDashboardTokens.Elevation.level2.opacity + ')', offsetX: 0, offsetY: HealthDashboardTokens.Elevation.level2.y })
      }, (metric: HealthMetric) => metric.id.toString())
    }
  }

  @Builder
  recentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(HealthDashboardTokens.Typography.headline.size)
        .fontWeight(HealthDashboardTokens.Typography.headline.weight)
        .fontColor(HealthDashboardTokens.Colors.onBackground)
      Blank()
      Button('View All')
        .fontSize(HealthDashboardTokens.Typography.label.size)
        .fontWeight(HealthDashboardTokens.Typography.label.weight)
        .padding({ right: 20 })
        .fontColor(HealthDashboardTokens.Colors.primary)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  bottomNavigation() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: HealthDashboardTokens.Spacing.xs }) {
            Circle()
              .width(20)
              .height(20)
              .fill(this.selectedNav === item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
            Text(item.label)
              .fontSize(HealthDashboardTokens.Typography.label.size)
              .fontWeight(HealthDashboardTokens.Typography.label.weight)
              .fontColor(HealthDashboardTokens.Colors.onSurface)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .onClick(() => { this.selectedNav = item.id; })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({ top: HealthDashboardTokens.Spacing.sm, bottom: HealthDashboardTokens.Spacing.sm, left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({ radius: HealthDashboardTokens.Elevation.level2.radius, color: 'rgba(0,0,0,' + HealthDashboardTokens.Elevation.level2.opacity + ')', offsetX: 0, offsetY: HealthDashboardTokens.Elevation.level2.y })
    .margin({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md, bottom: HealthDashboardTokens.Spacing.md })
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(HealthDashboardTokens.Colors.background)

      Column({ space: 0 }) {
        this.topBar()

        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            this.heroCard()
            this.sectionTitle("Today's Metrics")
            this.metricsRow()
            this.recentWorkoutsHeader()
            ForEach(this.workouts, (workout: Workout) => {
              Row({ space: HealthDashboardTokens.Spacing.md }) {
                Row()
                  .width(44)
                  .height(44)
                  .backgroundColor(workout.iconColor)
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
                      .fontColor(HealthDashboardTokens.Colors.onSurface)
                      .opacity(0.7)
                    Text(workout.calories)
                      .fontSize(HealthDashboardTokens.Typography.body.size)
                      .fontWeight(HealthDashboardTokens.Typography.body.weight)
                      .fontColor(HealthDashboardTokens.Colors.onSurface)
                      .opacity(0.7)
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Button('Start')
                  .fontSize(HealthDashboardTokens.Typography.small.size)
                  .fontWeight(HealthDashboardTokens.Typography.small.weight)
                  .width(70)
                  .height(32)
                  .backgroundColor(HealthDashboardTokens.Colors.primary)
                  .fontColor(HealthDashboardTokens.Colors.onPrimary)
                  .borderRadius(HealthDashboardTokens.Shapes.small)
                  .onClick(() => {})
              }
              .padding(HealthDashboardTokens.Spacing.lg)
              .width('100%')
              .backgroundColor(HealthDashboardTokens.Colors.surface)
              .borderRadius(HealthDashboardTokens.Shapes.medium)
              .shadow({ radius: HealthDashboardTokens.Elevation.level1.radius, color: 'rgba(0,0,0,' + HealthDashboardTokens.Elevation.level1.opacity + ')', offsetX: 0, offsetY: HealthDashboardTokens.Elevation.level1.y })
            }, (workout: Workout) => workout.id.toString())
          }
          .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md, bottom: this.bottomBarHeight + HealthDashboardTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.bottomNavigation()
      }
      .width('100%')
      .height('100%')
    }
  }
}
