import { router } from '@kit.ArkUI';

// Design Tokens
namespace HealthDashboardTokens {
  export namespace Colors {
    export const primary: string = '#6366F1';
    export const secondary: string = '#EC4899';
    export const tertiary: string = '#10B981';
    export const background: string = '#F8FAFC';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#F1F5F9';
    export const outline: string = '#E2E8F0';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onBackground: string = '#0F172A';
    export const onSurface: string = '#0F172A';
    export const onSurfaceMuted: string = '#0F172A99';
  }

  export namespace Typography {
    export const displaySize: number = 24;
    export const headlineSize: number = 20;
    export const titleSize: number = 16;
    export const bodySize: number = 14;
    export const labelSize: number = 12;
    export const smallSize: number = 10;
  }

  export namespace Shapes {
    export const small: number = 8;
    export const medium: number = 12;
    export const large: number = 16;
  }

  export namespace Spacing {
    export const xs: number = 2;
    export const sm: number = 4;
    export const md: number = 8;
    export const lg: number = 12;
    export const xl: number = 16;
    export const xxl: number = 20;
    export const xxxl: number = 24;
  }
}

interface HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  color: string;
}

interface Workout {
  id: number;
  name: string;
  duration: string;
  calories: string;
  iconColor: string;
}

interface NavItem {
  id: number;
  label: string;
}

const metrics: HealthMetric[] = [
  { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: HealthDashboardTokens.Colors.secondary },
  { id: 2, title: 'Steps', value: '842', unit: 'steps', color: HealthDashboardTokens.Colors.primary },
  { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: HealthDashboardTokens.Colors.tertiary },
  { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: HealthDashboardTokens.Colors.error },
];

const workouts: Workout[] = [
  { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: HealthDashboardTokens.Colors.primary },
  { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: HealthDashboardTokens.Colors.secondary },
  { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: HealthDashboardTokens.Colors.tertiary },
];

const navItems: NavItem[] = [
  { id: 0, label: 'Dashboard' },
  { id: 1, label: 'Workouts' },
  { id: 2, label: 'Nutrition' },
  { id: 3, label: 'Profile' },
];

@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(HealthDashboardTokens.Colors.background)

      // Main content
      Column() {
        // Top Bar
        Text('Health Dashboard')
          .fontSize(HealthDashboardTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(HealthDashboardTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({
            top: HealthDashboardTokens.Spacing.xxl,
            bottom: HealthDashboardTokens.Spacing.md,
          })
          .margin({ top: 40, bottom: 20 })

        // Scrollable content
        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            // Hero Card
            this.HeroCard()

            // Section Title
            Text("Today's Metrics")
              .fontSize(14)
              .fontColor(HealthDashboardTokens.Colors.onBackground)
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ left: HealthDashboardTokens.Spacing.sm })

            // Metrics Row
            this.MetricsRow()

            // Recent Workouts Header
            this.RecentWorkoutsHeader()

            // Workout Cards
            ForEach(workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            }, (workout: Workout) => workout.id.toString())

            // Bottom padding
            Column().height(88)
          }
          .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)

      // Bottom Navigation
      this.BottomNavigation()
        .margin({
          left: HealthDashboardTokens.Spacing.md,
          right: HealthDashboardTokens.Spacing.md,
          bottom: HealthDashboardTokens.Spacing.md,
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HeroCard() {
    Column({ space: HealthDashboardTokens.Spacing.sm }) {
      Text('Good Morning!')
        .fontSize(HealthDashboardTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('Ready for your workout?')
        .fontSize(HealthDashboardTokens.Typography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Button('Start Workout')
        .fontSize(HealthDashboardTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .width('100%')
        .height(44)
    }
    .padding(HealthDashboardTokens.Spacing.xl)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: 12,
      color: '#00000038',
      offsetX: 0,
      offsetY: 3,
    })
  }

  @Builder
  MetricsRow() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(metrics, (metric: HealthMetric) => {
        Row() {
          Column({ space: HealthDashboardTokens.Spacing.xs }) {
            Circle()
              .fill(metric.color)
              .width(36)
              .height(36)

            Text(metric.value)
              .fontSize(HealthDashboardTokens.Typography.headlineSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.onSurface)

            Text(metric.title)
              .fontSize(HealthDashboardTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(HealthDashboardTokens.Colors.onSurfaceMuted)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()
        }
        .padding(HealthDashboardTokens.Spacing.md)
        .layoutWeight(1)
        .alignItems(VerticalAlign.Top)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({
          radius: 8,
          color: '#0000002E',
          offsetX: 0,
          offsetY: 2,
        })
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  RecentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(HealthDashboardTokens.Typography.headlineSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.onBackground)

      Blank()

      Text('View All')
        .fontSize(HealthDashboardTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .padding({ right: 20 })
        .onClick(() => {})
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      // Icon placeholder
      Column()
        .width(44)
        .height(44)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .backgroundColor(workout.iconColor)

      // Info
      Column({ space: HealthDashboardTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(HealthDashboardTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(HealthDashboardTokens.Colors.onSurface)
          .textAlign(TextAlign.Start)
          .width('100%')

        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(HealthDashboardTokens.Typography.bodySize)
            .fontColor(HealthDashboardTokens.Colors.onSurfaceMuted)

          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.bodySize)
            .fontColor(HealthDashboardTokens.Colors.onSurfaceMuted)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Start Button
      Button('Start')
        .fontSize(HealthDashboardTokens.Typography.smallSize)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .backgroundColor(HealthDashboardTokens.Colors.primary)
        .borderRadius(HealthDashboardTokens.Shapes.small)
        .width(70)
        .height(32)
        .onClick(() => {})
    }
    .padding(HealthDashboardTokens.Spacing.lg)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: 4,
      color: '#00000026',
      offsetX: 0,
      offsetY: 1,
    })
  }

  @Builder
  BottomNavigation() {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      ForEach(navItems, (item: NavItem) => {
        Column({ space: HealthDashboardTokens.Spacing.xs }) {
          Circle()
            .fill(this.selectedNav === item.id
              ? HealthDashboardTokens.Colors.primary
              : HealthDashboardTokens.Colors.outline)
            .width(20)
            .height(20)

          Text(item.label)
            .fontSize(HealthDashboardTokens.Typography.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .padding({
      top: HealthDashboardTokens.Spacing.sm,
      bottom: HealthDashboardTokens.Spacing.sm,
      left: HealthDashboardTokens.Spacing.md,
      right: HealthDashboardTokens.Spacing.md,
    })
    .width('100%')
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: 8,
      color: '#0000002E',
      offsetX: 0,
      offsetY: 2,
    })
  }
}