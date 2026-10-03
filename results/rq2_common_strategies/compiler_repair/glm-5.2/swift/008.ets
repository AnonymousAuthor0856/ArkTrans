// Index.ets

// Design Tokens
interface Colors {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface TypographyItem {
  size: number;
  weight: FontWeight;
}

interface Typography {
  display: TypographyItem;
  headline: TypographyItem;
  title: TypographyItem;
  body: TypographyItem;
  label: TypographyItem;
  small: TypographyItem;
}

interface Shapes {
  small: number;
  medium: number;
  large: number;
}

interface Spacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
  color: ResourceColor;
}

interface Elevation {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
  level4: ShadowSpec;
}

class HealthDashboardTokens {
  static readonly Colors: Colors = {
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
  };

  static readonly Typography: Typography = {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
    small: { size: 10, weight: FontWeight.Normal },
  };

  static readonly Shapes: Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing: Spacing = {
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    xxl: 20,
    xxxl: 24,
  };

  static readonly Elevation: Elevation = {
    level1: { radius: 4, y: 1, opacity: 0.15, color: '#00000026' },
    level2: { radius: 8, y: 2, opacity: 0.18, color: '#0000002E' },
    level3: { radius: 12, y: 3, opacity: 0.22, color: '#00000038' },
    level4: { radius: 16, y: 4, opacity: 0.25, color: '#00000040' },
  };
}

// Models
interface HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  color: ResourceColor;
}

interface Workout {
  id: number;
  name: string;
  duration: string;
  calories: string;
  iconColor: ResourceColor;
}

interface NavItem {
  id: number;
  label: string;
}

@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    { id: 1, title: "Heart", value: "72", unit: "bpm", color: HealthDashboardTokens.Colors.secondary },
    { id: 2, title: "Steps", value: "842", unit: "steps", color: HealthDashboardTokens.Colors.primary },
    { id: 3, title: "Sleep", value: "7.2", unit: "hours", color: HealthDashboardTokens.Colors.tertiary },
    { id: 4, title: "Calories", value: "420", unit: "kcal", color: HealthDashboardTokens.Colors.error }
  ];

  private workouts: Workout[] = [
    { id: 1, name: "Morning Run", duration: "32 min", calories: "284 kcal", iconColor: HealthDashboardTokens.Colors.primary },
    { id: 2, name: "Yoga Flow", duration: "45 min", calories: "156 kcal", iconColor: HealthDashboardTokens.Colors.secondary },
    { id: 3, name: "Strength Training", duration: "28 min", calories: "320 kcal", iconColor: HealthDashboardTokens.Colors.tertiary }
  ];

  private navItems: NavItem[] = [
    { id: 0, label: "Dashboard" },
    { id: 1, label: "Workouts" },
    { id: 2, label: "Nutrition" },
    { id: 3, label: "Profile" }
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
        Text("Health Dashboard")
          .fontSize(HealthDashboardTokens.Typography.display.size)
          .fontWeight(HealthDashboardTokens.Typography.display.weight)
          .fontColor(HealthDashboardTokens.Colors.onBackground)
          .width('100%')
          .padding({ top: 40, bottom: 20 })

        // Scrollable Content
        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            // Hero Card
            Column() {
              Text("Good Morning!")
                .fontSize(HealthDashboardTokens.Typography.title.size)
                .fontWeight(HealthDashboardTokens.Typography.title.weight)
                .fontColor(HealthDashboardTokens.Colors.onPrimary)
                .margin({ bottom: HealthDashboardTokens.Spacing.sm })

              Text("Ready for your workout?")
                .fontSize(HealthDashboardTokens.Typography.headline.size)
                .fontWeight(HealthDashboardTokens.Typography.headline.weight)
                .fontColor(HealthDashboardTokens.Colors.onPrimary)
                .margin({ bottom: HealthDashboardTokens.Spacing.lg })

              Button() {
                Text("Start Workout")
                  .fontSize(HealthDashboardTokens.Typography.title.size)
                  .fontWeight(HealthDashboardTokens.Typography.title.weight)
                  .fontColor(HealthDashboardTokens.Colors.primary)
              }
              .height(44)
              .width('100%')
              .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
              .borderRadius(HealthDashboardTokens.Shapes.medium)
            }
            .alignItems(HorizontalAlign.Start)
            .padding(HealthDashboardTokens.Spacing.xl)
            .width('100%')
            .borderRadius(HealthDashboardTokens.Shapes.large)
            .backgroundColor(HealthDashboardTokens.Colors.primary)
            .shadow({
              radius: HealthDashboardTokens.Elevation.level3.radius,
              color: HealthDashboardTokens.Elevation.level3.color,
              offsetX: 0,
              offsetY: HealthDashboardTokens.Elevation.level3.y
            })

            // Section Title
            Text("Today's Metrics")
              .fontSize(HealthDashboardTokens.Typography.body.size)
              .fontColor(HealthDashboardTokens.Colors.onBackground)
              .width('100%')
              .padding({ left: HealthDashboardTokens.Spacing.sm, right: HealthDashboardTokens.Spacing.sm })

            // Metrics Row
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
                    .fontColor(HealthDashboardTokens.Colors.onSurface)
                    .opacity(0.7)
                }
                .padding(HealthDashboardTokens.Spacing.md)
                .layoutWeight(1)
                .borderRadius(HealthDashboardTokens.Shapes.medium)
                .backgroundColor(HealthDashboardTokens.Colors.surface)
                .shadow({
                  radius: HealthDashboardTokens.Elevation.level2.radius,
                  color: HealthDashboardTokens.Elevation.level2.color,
                  offsetX: 0,
                  offsetY: HealthDashboardTokens.Elevation.level2.y
                })
              })
            }
            .width('100%')

            // Recent Workouts Header
            Row() {
              Text("Recent Workouts")
                .fontSize(HealthDashboardTokens.Typography.headline.size)
                .fontWeight(HealthDashboardTokens.Typography.headline.weight)
                .fontColor(HealthDashboardTokens.Colors.onBackground)
                .layoutWeight(1)

              Button() {
                Text("View All")
                  .fontSize(HealthDashboardTokens.Typography.label.size)
                  .fontWeight(HealthDashboardTokens.Typography.label.weight)
                  .fontColor(HealthDashboardTokens.Colors.primary)
              }
              .backgroundColor(Color.Transparent)
              .padding({ right: 20 })
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 })

            // Workout Cards
            ForEach(this.workouts, (workout: Workout) => {
              Row({ space: HealthDashboardTokens.Spacing.md }) {
                // Icon
                Column()
                  .width(44)
                  .height(44)
                  .borderRadius(HealthDashboardTokens.Shapes.medium)
                  .backgroundColor(workout.iconColor)

                // Details
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
                Button() {
                  Text("Start")
                    .fontSize(HealthDashboardTokens.Typography.small.size)
                    .fontColor(HealthDashboardTokens.Colors.onPrimary)
                }
                .width(70)
                .height(32)
                .backgroundColor(HealthDashboardTokens.Colors.primary)
                .borderRadius(HealthDashboardTokens.Shapes.small)
              }
              .padding(HealthDashboardTokens.Spacing.lg)
              .width('100%')
              .borderRadius(HealthDashboardTokens.Shapes.medium)
              .backgroundColor(HealthDashboardTokens.Colors.surface)
              .shadow({
                radius: HealthDashboardTokens.Elevation.level1.radius,
                color: HealthDashboardTokens.Elevation.level1.color,
                offsetX: 0,
                offsetY: HealthDashboardTokens.Elevation.level1.y
              })
            })
          }
          .padding({
            left: HealthDashboardTokens.Spacing.md,
            right: HealthDashboardTokens.Spacing.md,
            bottom: this.bottomBarHeight + HealthDashboardTokens.Spacing.lg
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .height('100%')

      // Bottom Navigation
      Row({ space: HealthDashboardTokens.Spacing.md }) {
        ForEach(this.navItems, (item: NavItem) => {
          Button() {
            Column({ space: HealthDashboardTokens.Spacing.xs }) {
              Circle({ width: 20, height: 20 })
                .fill(this.selectedNav === item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
              
              Text(item.label)
                .fontSize(HealthDashboardTokens.Typography.label.size)
                .fontWeight(HealthDashboardTokens.Typography.label.weight)
                .fontColor(HealthDashboardTokens.Colors.onSurface)
            }
            .layoutWeight(1)
          }
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.selectedNav = item.id;
          })
        })
      }
      .padding({
        top: HealthDashboardTokens.Spacing.sm,
        bottom: HealthDashboardTokens.Spacing.sm,
        left: HealthDashboardTokens.Spacing.md,
        right: HealthDashboardTokens.Spacing.md
      })
      .width('100%')
      .borderRadius(HealthDashboardTokens.Shapes.large)
      .backgroundColor(HealthDashboardTokens.Colors.surface)
      .shadow({
        radius: HealthDashboardTokens.Elevation.level2.radius,
        color: HealthDashboardTokens.Elevation.level2.color,
        offsetX: 0,
        offsetY: HealthDashboardTokens.Elevation.level2.y
      })
      .margin({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md, bottom: HealthDashboardTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
  }
}