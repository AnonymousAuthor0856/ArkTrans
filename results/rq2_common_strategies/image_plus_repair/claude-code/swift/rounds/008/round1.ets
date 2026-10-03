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

class ColorTokens {
  primary: string = '#6366F1';
  secondary: string = '#EC4899';
  tertiary: string = '#10B981';
  background: string = '#F8FAFC';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F1F5F9';
  outline: string = '#E2E8F0';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onBackground: string = '#0F172A';
  onSurface: string = '#0F172A';
}

class TypographyTokens {
  displaySize: number = 24;
  displayWeight: FontWeight = FontWeight.Bold;
  headlineSize: number = 20;
  headlineWeight: FontWeight = FontWeight.SemiBold;
  titleSize: number = 16;
  titleWeight: FontWeight = FontWeight.Medium;
  bodySize: number = 14;
  bodyWeight: FontWeight = FontWeight.Regular;
  labelSize: number = 12;
  labelWeight: FontWeight = FontWeight.Medium;
  smallSize: number = 10;
  smallWeight: FontWeight = FontWeight.Regular;
}

class ShapeTokens {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

class SpacingTokens {
  xs: number = 2;
  sm: number = 4;
  md: number = 8;
  lg: number = 12;
  xl: number = 16;
  xxl: number = 20;
  xxxl: number = 24;
}

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

class ElevationTokens {
  level1: ShadowSpec = new ShadowSpec(4, 1, 0.15);
  level2: ShadowSpec = new ShadowSpec(8, 2, 0.18);
  level3: ShadowSpec = new ShadowSpec(12, 3, 0.22);
  level4: ShadowSpec = new ShadowSpec(16, 4, 0.25);
}

class HealthDashboardTokens {
  static Colors: ColorTokens = new ColorTokens();
  static Typography: TypographyTokens = new TypographyTokens();
  static Shapes: ShapeTokens = new ShapeTokens();
  static Spacing: SpacingTokens = new SpacingTokens();
  static Elevation: ElevationTokens = new ElevationTokens();
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
      .fontSize(HealthDashboardTokens.Typography.displaySize)
      .fontWeight(HealthDashboardTokens.Typography.displayWeight)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 40, bottom: 20 })
  }

  @Builder
  heroCard() {
    Column({ space: HealthDashboardTokens.Spacing.sm }) {
      Text('Good Morning!')
        .fontSize(HealthDashboardTokens.Typography.titleSize)
        .fontWeight(HealthDashboardTokens.Typography.titleWeight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)

      Text('Ready for your workout?')
        .fontSize(HealthDashboardTokens.Typography.headlineSize)
        .fontWeight(HealthDashboardTokens.Typography.headlineWeight)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)

      Button('Start Workout')
        .fontSize(HealthDashboardTokens.Typography.titleSize)
        .fontWeight(HealthDashboardTokens.Typography.titleWeight)
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
            .fontSize(HealthDashboardTokens.Typography.headlineSize)
            .fontWeight(HealthDashboardTokens.Typography.headlineWeight)
            .fontColor(HealthDashboardTokens.Colors.onSurface)

          Text(metric.title)
            .fontSize(HealthDashboardTokens.Typography.labelSize)
            .fontWeight(HealthDashboardTokens.Typography.labelWeight)
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
        .fontSize(HealthDashboardTokens.Typography.headlineSize)
        .fontWeight(HealthDashboardTokens.Typography.headlineWeight)
        .fontColor(HealthDashboardTokens.Colors.onBackground)

      Blank()

      Text('View All')
        .fontSize(HealthDashboardTokens.Typography.labelSize)
        .fontWeight(HealthDashboardTokens.Typography.labelWeight)
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
          .fontSize(HealthDashboardTokens.Typography.titleSize)
          .fontWeight(HealthDashboardTokens.Typography.titleWeight)
          .fontColor(HealthDashboardTokens.Colors.onSurface)

        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(HealthDashboardTokens.Typography.bodySize)
            .fontWeight(HealthDashboardTokens.Typography.bodyWeight)
            .fontColor(`rgba(15, 23, 42, 0.7)`)

          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.bodySize)
            .fontWeight(HealthDashboardTokens.Typography.bodyWeight)
            .fontColor(`rgba(15, 23, 42, 0.7)`)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .fontSize(HealthDashboardTokens.Typography.smallSize)
        .fontWeight(HealthDashboardTokens.Typography.smallWeight)
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
            .fontSize(HealthDashboardTokens.Typography.labelSize)
            .fontWeight(HealthDashboardTokens.Typography.labelWeight)
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
