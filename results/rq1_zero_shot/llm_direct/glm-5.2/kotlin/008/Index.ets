// 011_HealthDashboard_en.ts
// ArkTS conversion of the Kotlin Compose Health Dashboard UI

// --- Design Tokens ---
class AppTokens {
  static readonly Colors = {
    primary: '#6366F1',
    secondary: '#EC4899',
    tertiary: '#10B981',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#10B981',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#0F172A',
    onSurface70: 'rgba(15, 23, 42, 0.7)'
  };

  static readonly Typography = {
    display: { fontSize: 24, fontWeight: FontWeight.Bold, lineHeight: 30 },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium, lineHeight: 26 },
    title: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22 },
    body: { fontSize: 14, fontWeight: FontWeight.Normal, lineHeight: 20 },
    label: { fontSize: 12, fontWeight: FontWeight.Medium, lineHeight: 16 },
    small: { fontSize: 10, fontWeight: FontWeight.Normal, lineHeight: 14 }
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
    level1: 1,
    level2: 3,
    level3: 6,
    level4: 8
  };
}

// --- Data Models ---
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

// --- State Management ---
@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, AppTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, AppTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, AppTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, AppTokens.Colors.error)
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', AppTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', AppTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', AppTokens.Colors.tertiary)
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Health Dashboard')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .justifyContent(FlexAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Hero Card
          Column() {
            Text('Good Morning!')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ bottom: AppTokens.Spacing.sm })

            Text('Ready for your workout?')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ bottom: AppTokens.Spacing.lg })

            Button('Start Workout')
              .width('100%')
              .height(44)
              .backgroundColor(AppTokens.Colors.onPrimary)
              .fontColor(AppTokens.Colors.primary)
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .borderRadius(AppTokens.Shapes.medium)
          }
          .width('100%')
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ bottom: AppTokens.Spacing.lg })
          .shadow({ radius: AppTokens.Elevation.level3, color: 'rgba(0,0,0,0.12)', offsetY: 2 })

          // Section Title
          Text("Today's Metrics")
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.md, left: AppTokens.Spacing.sm })

          // Metrics Row
          Row() {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column() {
                Circle({ width: 36, height: 36 })
                  .fill(metric.color)
                  .margin({ bottom: AppTokens.Spacing.xs })

                Text(metric.value)
                  .fontSize(AppTokens.Typography.headline.fontSize)
                  .fontWeight(AppTokens.Typography.headline.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                Text(metric.title)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface70)
              }
              .layoutWeight(1)
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .shadow({ radius: AppTokens.Elevation.level2, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
              .margin({ right: AppTokens.Spacing.md })
            })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Recent Workouts Header
          Row() {
            Text('Recent Workouts')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onBackground)
              .layoutWeight(1)

            Text('View All')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
          .margin({ bottom: AppTokens.Spacing.md })

          // Workout List
          ForEach(this.workouts, (workout: Workout) => {
            Row() {
              // Icon Box
              Column() {
                Text('')
              }
              .width(44)
              .height(44)
              .backgroundColor(workout.iconColor)
              .borderRadius(AppTokens.Shapes.medium)
              .margin({ right: AppTokens.Spacing.md })

              // Workout Info
              Column() {
                Text(workout.name)
                  .fontSize(AppTokens.Typography.title.fontSize)
                  .fontWeight(AppTokens.Typography.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ bottom: AppTokens.Spacing.xs })

                Row() {
                  Text(workout.duration)
                    .fontSize(AppTokens.Typography.body.fontSize)
                    .fontColor(AppTokens.Colors.onSurface70)
                    .margin({ right: AppTokens.Spacing.lg })

                  Text(workout.calories)
                    .fontSize(AppTokens.Typography.body.fontSize)
                    .fontColor(AppTokens.Colors.onSurface70)
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Start Button
              Button('Start')
                .height(32)
                .width(70)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(AppTokens.Typography.small.fontSize)
                .borderRadius(AppTokens.Shapes.small)
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .margin({ bottom: AppTokens.Spacing.md })
            .shadow({ radius: AppTokens.Elevation.level1, color: 'rgba(0,0,0,0.08)', offsetY: 1 })
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Circle({ width: 20, height: 20 })
              .fill(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.outline)
              .margin({ bottom: AppTokens.Spacing.xs })

            Text(item.label)
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.onSurface70)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedNav = item.id;
          })
        })
      }
      .width('100%')
      .height(72)
      .backgroundColor(AppTokens.Colors.surface)
      .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .shadow({ radius: AppTokens.Elevation.level2, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}