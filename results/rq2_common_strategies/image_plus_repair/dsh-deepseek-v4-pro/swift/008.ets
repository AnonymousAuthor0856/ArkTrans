// Original Swift: import SwiftUI
// SwiftUI import is not required in ArkTS (HarmonyOS ArkUI provides the equivalent declarative UI).

// enum HealthDashboardTokens { enum Colors { ... } ... }
// Swift nested enums with `static let` constants become ArkTS interfaces + object literals.

interface ColorTokens {
  readonly primary: string;
  readonly secondary: string;
  readonly tertiary: string;
  readonly background: string;
  readonly surface: string;
  readonly surfaceVariant: string;
  readonly outline: string;
  readonly error: string;
  readonly onPrimary: string;
  readonly onBackground: string;
  readonly onSurface: string;
}

interface TypographyEntry {
  readonly size: number;
  readonly weight: number;
}

interface TypographyTokens {
  readonly display: TypographyEntry;
  readonly headline: TypographyEntry;
  readonly title: TypographyEntry;
  readonly body: TypographyEntry;
  readonly label: TypographyEntry;
  readonly small: TypographyEntry;
}

interface ShapeTokens {
  readonly small: number;
  readonly medium: number;
  readonly large: number;
}

interface SpacingTokens {
  readonly xs: number;
  readonly sm: number;
  readonly md: number;
  readonly lg: number;
  readonly xl: number;
  readonly xxl: number;
  readonly xxxl: number;
}

// struct ShadowSpec { let radius; let y; let opacity }
class ShadowSpec {
  radius: number;
  y: number;
  opacity: number;

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius;
    this.y = y;
    this.opacity = opacity;
  }
}

interface ElevationTokens {
  readonly level1: ShadowSpec;
  readonly level2: ShadowSpec;
  readonly level3: ShadowSpec;
  readonly level4: ShadowSpec;
}

class HealthDashboardTokens {
  static readonly Colors: ColorTokens = {
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

  static readonly Typography: TypographyTokens = {
    display: { size: 24, weight: 700 },
    headline: { size: 20, weight: 600 },
    title: { size: 16, weight: 500 },
    body: { size: 14, weight: 400 },
    label: { size: 12, weight: 500 },
    small: { size: 10, weight: 400 }
  };

  static readonly Shapes: ShapeTokens = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing: SpacingTokens = {
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    xxl: 20,
    xxxl: 24
  };

  static readonly Elevation: ElevationTokens = {
    level1: new ShadowSpec(4, 1, 0.15),
    level2: new ShadowSpec(8, 2, 0.18),
    level3: new ShadowSpec(12, 3, 0.22),
    level4: new ShadowSpec(16, 4, 0.25)
  };
}

// Color.black.opacity(x) -> ARGB hex string with the given alpha.
function shadowColor(opacity: number): string {
  const alpha: number = Math.round(opacity * 255);
  let hex: string = alpha.toString(16).toUpperCase();
  if (hex.length < 2) {
    hex = '0' + hex;
  }
  return '#' + hex + '000000';
}

// struct HealthMetric: Identifiable { let id; let title; let value; let unit; let color }
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

// struct Workout: Identifiable { ... }
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

// struct NavItem: Identifiable { ... }
class NavItem {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

// struct HealthDashboardAppView: View  ->  @Entry @Component struct
@Entry
@Component
struct HealthDashboardAppView {
  // @State private var selectedNav: Int = 0
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
      Column({ space: 0 }) {
        this.topBar()
        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            this.heroCard()
            this.sectionTitle("Today's Metrics")
            this.metricsRow()
            this.recentWorkoutsHeader()
            ForEach(this.workouts, (workout: Workout) => {
              this.workoutCard(workout)
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
        .width('100%')
      }
      .width('100%')
      .height('100%')

      this.bottomNavigation()
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
      .padding({
        top: 40 + HealthDashboardTokens.Spacing.xxl,
        bottom: 20 + HealthDashboardTokens.Spacing.md
      })
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

      Button() {
        Text('Start Workout')
          .fontSize(HealthDashboardTokens.Typography.title.size)
          .fontWeight(HealthDashboardTokens.Typography.title.weight)
          .fontColor(HealthDashboardTokens.Colors.primary)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(44)
      .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
      .borderRadius(HealthDashboardTokens.Shapes.medium)
      .onClick(() => {})
    }
    .alignItems(HorizontalAlign.Start)
    .padding(HealthDashboardTokens.Spacing.xl)
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level3.radius,
      color: shadowColor(HealthDashboardTokens.Elevation.level3.opacity),
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
              .fontColor('#B30F172A')
          }
          Blank()
        }
        .justifyContent(FlexAlign.Start)
        .padding(HealthDashboardTokens.Spacing.md)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({
          radius: HealthDashboardTokens.Elevation.level2.radius,
          color: shadowColor(HealthDashboardTokens.Elevation.level2.opacity),
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

      Button() {
        Text('View All')
          .fontSize(HealthDashboardTokens.Typography.label.size)
          .fontWeight(HealthDashboardTokens.Typography.label.weight)
          .fontColor(HealthDashboardTokens.Colors.primary)
          .padding({ right: 20 })
      }
      .onClick(() => {})
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  workoutCard(workout: Workout) {
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
            .fontColor('#B30F172A')
          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .fontColor('#B30F172A')
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text('Start')
          .fontSize(HealthDashboardTokens.Typography.small.size)
          .fontWeight(HealthDashboardTokens.Typography.small.weight)
          .fontColor(HealthDashboardTokens.Colors.onPrimary)
          .width('100%')
          .height('100%')
          .textAlign(TextAlign.Center)
      }
      .width(70)
      .height(32)
      .backgroundColor(HealthDashboardTokens.Colors.primary)
      .borderRadius(HealthDashboardTokens.Shapes.small)
      .onClick(() => {})
    }
    .width('100%')
    .padding(HealthDashboardTokens.Spacing.lg)
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level1.radius,
      color: shadowColor(HealthDashboardTokens.Elevation.level1.opacity),
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level1.y
    })
  }

  @Builder
  bottomNavigation() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: HealthDashboardTokens.Spacing.xs }) {
            Circle()
              .fill(this.selectedNav == item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
              .width(20)
              .height(20)

            Text(item.label)
              .fontSize(HealthDashboardTokens.Typography.label.size)
              .fontWeight(HealthDashboardTokens.Typography.label.weight)
              .fontColor(HealthDashboardTokens.Colors.onSurface)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNav = item.id
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({
      top: HealthDashboardTokens.Spacing.sm,
      bottom: HealthDashboardTokens.Spacing.sm + HealthDashboardTokens.Spacing.md,
      left: HealthDashboardTokens.Spacing.md + HealthDashboardTokens.Spacing.md,
      right: HealthDashboardTokens.Spacing.md + HealthDashboardTokens.Spacing.md
    })
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: shadowColor(HealthDashboardTokens.Elevation.level2.opacity),
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }
}
