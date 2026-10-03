import { Component, State } from '@ohos/kit.ArkUI';

// AppTokens
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
    onSurface: '#0F172A'
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

  static readonly ElevationMapping = {
    level1: { elevation: 1, radius: 4, dy: 1, opacity: 0.15 },
    level2: { elevation: 3, radius: 8, dy: 2, opacity: 0.18 },
    level3: { elevation: 6, radius: 12, dy: 3, opacity: 0.22 },
    level4: { elevation: 8, radius: 16, dy: 4, opacity: 0.25 }
  };
}

// Data models
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

@Entry
@Component
struct RootScreen {
  @State selectedNav: number = 0;
  @State metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, AppTokens.Colors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, AppTokens.Colors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, AppTokens.Colors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, AppTokens.Colors.error)
  ];
  @State workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', AppTokens.Colors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', AppTokens.Colors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', AppTokens.Colors.tertiary)
  ];
  @State navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  @Builder
  MetricCard(metric: HealthMetric) {
    Column({ space: AppTokens.Spacing.xs }) {
      Row() {
        Circle()
          .width(36)
          .height(36)
          .fill(metric.color)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Text(metric.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)

      Text(metric.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B30F172A')
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: AppTokens.Spacing.md }) {
      Row() {
        Circle()
          .width(44)
          .height(44)
          .fill(workout.iconColor)
      }
      .width(44)
      .height(44)
      .borderRadius(12)
      .backgroundColor(workout.iconColor)

      Column({ space: AppTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Row({ space: AppTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#B30F172A')
          Text(workout.calories)
            .fontSize(14)
            .fontColor('#B30F172A')
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .height(32)
        .width(70)
        .fontSize(10)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(12)
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }

  @Builder
  NavigationBarBuilder() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 4 }) {
          Circle()
            .width(20)
            .height(20)
            .fill(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 8, bottom: 8 })
        .onClick(() => {
          this.selectedNav = item.id;
        })
      })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: -AppTokens.ElevationMapping.level2.dy
    })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 8 })
      .justifyContent(FlexAlign.Center)

      // Main content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Hero Card
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Good Morning!')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)

            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onPrimary)

            Button('Start Workout')
              .width('100%')
              .height(44)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
              .backgroundColor(AppTokens.Colors.onPrimary)
              .borderRadius(12)
          }
          .width('100%')
          .padding(AppTokens.Spacing.xl)
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(16)
          .shadow({
            radius: AppTokens.ElevationMapping.level3.radius,
            color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level3.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level3.dy
          })

          // Today's Metrics title
          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

          // Metrics Row
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              this.MetricCard(metric)
            })
          }
          .width('100%')

          // Recent Workouts header
          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onBackground)

            Blank()
              .layoutWeight(1)

            Button('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
              .backgroundColor(Color.Transparent)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          // Workout list
          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutCard(workout)
          })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)

      // Bottom Navigation Bar
      this.NavigationBarBuilder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}