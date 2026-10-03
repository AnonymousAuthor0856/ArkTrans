import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// Token Definitions
interface ColorTokens {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
  small: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ElevationToken {
  radius: number;
  y: number;
  opacity: number;
}

interface ElevationTokens {
  level1: ElevationToken;
  level2: ElevationToken;
  level3: ElevationToken;
  level4: ElevationToken;
}

const HealthDashboardTokens = {
  Colors: {
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
  } as ColorTokens,
  Typography: {
    display: { size: 24, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
    small: { size: 10, weight: FontWeight.Normal }
  } as TypographyTokens,
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  } as ShapeTokens,
  Spacing: {
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    xxl: 20,
    xxxl: 24
  } as SpacingTokens,
  Elevation: {
    level1: { radius: 4, y: 1, opacity: 0.15 },
    level2: { radius: 8, y: 2, opacity: 0.18 },
    level3: { radius: 12, y: 3, opacity: 0.22 },
    level4: { radius: 16, y: 4, opacity: 0.25 }
  } as ElevationTokens
};

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

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Text("Health Dashboard")
          .fontSize(HealthDashboardTokens.Typography.display.size)
          .fontWeight(HealthDashboardTokens.Typography.display.weight)
          .foregroundColor(HealthDashboardTokens.Colors.onBackground)
          .width('100%')
          .padding({ top: HealthDashboardTokens.Spacing.xxl + 40, bottom: HealthDashboardTokens.Spacing.md })

        // Scrollable Content
        Scroll() {
          Column() {
            // Hero Card
            this.heroCard()

            // Section Title
            Text("Today's Metrics")
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .foregroundColor(HealthDashboardTokens.Colors.onBackground)
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ left: HealthDashboardTokens.Spacing.sm, right: HealthDashboardTokens.Spacing.sm, top: HealthDashboardTokens.Spacing.lg, bottom: HealthDashboardTokens.Spacing.sm })

            // Metrics Row
            this.metricsRow()

            // Recent Workouts Header
            Row() {
              Text("Recent Workouts")
                .fontSize(HealthDashboardTokens.Typography.headline.size)
                .fontWeight(HealthDashboardTokens.Typography.headline.weight)
                .foregroundColor(HealthDashboardTokens.Colors.onBackground)
              
              Flex({ justifyContent: FlexAlign.End }) {
                Button("View All")
                  .fontSize(HealthDashboardTokens.Typography.label.size)
                  .fontWeight(HealthDashboardTokens.Typography.label.weight)
                  .backgroundColor(Color.Transparent)
                  .borderWidth(0)
                  .foregroundColor(HealthDashboardTokens.Colors.primary)
                  .padding({ right: 20 })
              }
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 })

            // Workouts List
            ForEach(this.workouts, (workout: Workout) => {
              this.workoutCard(workout)
            })

            // Bottom padding for navigation bar
            Blank().height(80)
          }
          .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(HealthDashboardTokens.Colors.background)

      // Bottom Navigation
      this.bottomNavigation()
        .margin({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md, bottom: HealthDashboardTokens.Spacing.md })
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarType: window.StatusBarType.Hide })
  }

  @Builder
  heroCard() {
    Column({ space: HealthDashboardTokens.Spacing.sm }) {
      Text("Good Morning!")
        .fontSize(HealthDashboardTokens.Typography.title.size)
        .fontWeight(HealthDashboardTokens.Typography.title.weight)
        .foregroundColor(HealthDashboardTokens.Colors.onPrimary)
      
      Text("Ready for your workout?")
        .fontSize(HealthDashboardTokens.Typography.headline.size)
        .fontWeight(HealthDashboardTokens.Typography.headline.weight)
        .foregroundColor(HealthDashboardTokens.Colors.onPrimary)

      Button("Start Workout")
        .fontSize(HealthDashboardTokens.Typography.title.size)
        .fontWeight(HealthDashboardTokens.Typography.title.weight)
        .width('100%')
        .height(44)
        .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .foregroundColor(HealthDashboardTokens.Colors.primary)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(HealthDashboardTokens.Spacing.xl)
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level3.radius,
      color: Color.Black.withOpacity(HealthDashboardTokens.Elevation.level3.opacity),
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level3.y
    })
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
              .foregroundColor(HealthDashboardTokens.Colors.onSurface)
            
            Text(metric.title)
              .fontSize(HealthDashboardTokens.Typography.label.size)
              .fontWeight(HealthDashboardTokens.Typography.label.weight)
              .foregroundColor(Color.Black.withOpacity(0.7))
          }
          
          Blank()
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .padding(HealthDashboardTokens.Spacing.md)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({
          radius: HealthDashboardTokens.Elevation.level2.radius,
          color: Color.Black.withOpacity(HealthDashboardTokens.Elevation.level2.opacity),
          offsetX: 0,
          offsetY: HealthDashboardTokens.Elevation.level2.y
        })
      })
    }
  }

  @Builder
  workoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      // Icon Placeholder
      Rect()
        .fill(workout.iconColor)
        .width(44)
        .height(44)
        .borderRadius(HealthDashboardTokens.Shapes.medium)

      // Details
      Column({ space: HealthDashboardTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(HealthDashboardTokens.Typography.title.size)
          .fontWeight(HealthDashboardTokens.Typography.title.weight)
          .foregroundColor(HealthDashboardTokens.Colors.onSurface)
        
        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .foregroundColor(Color.Black.withOpacity(0.7))
          
          Text(workout.calories)
            .fontSize(HealthDashboardTokens.Typography.body.size)
            .fontWeight(HealthDashboardTokens.Typography.body.weight)
            .foregroundColor(Color.Black.withOpacity(0.7))
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Start Button
      Button("Start")
        .fontSize(HealthDashboardTokens.Typography.small.size)
        .fontWeight(HealthDashboardTokens.Typography.small.weight)
        .width(70)
        .height(32)
        .backgroundColor(HealthDashboardTokens.Colors.primary)
        .borderRadius(HealthDashboardTokens.Shapes.small)
        .foregroundColor(HealthDashboardTokens.Colors.onPrimary)
    }
    .width('100%')
    .padding(HealthDashboardTokens.Spacing.lg)
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level1.radius,
      color: Color.Black.withOpacity(HealthDashboardTokens.Elevation.level1.opacity),
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
              .fill(this.selectedNav === item.id ? HealthDashboardTokens.Colors.primary : HealthDashboardTokens.Colors.outline)
              .width(20)
              .height(20)
            
            Text(item.label)
              .fontSize(HealthDashboardTokens.Typography.label.size)
              .fontWeight(HealthDashboardTokens.Typography.label.weight)
              .foregroundColor(HealthDashboardTokens.Colors.onSurface)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .onClick(() => {
          this.selectedNav = item.id
        })
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .layoutWeight(1)
      })
    }
    .width('100%')
    .padding({ top: HealthDashboardTokens.Spacing.sm, bottom: HealthDashboardTokens.Spacing.sm, left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: Color.Black.withOpacity(HealthDashboardTokens.Elevation.level2.opacity),
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }
}