import { Window } from '@kit.ArkUI'

// --- Data Models ---
interface HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  progress: number;
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

// --- Design Tokens (Converted to ArkTS constants) ---
const AppTokens = {
  Colors: {
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
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
    xxl: 20,
    xxxl: 24
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  }
};

@Entry
@Component
struct RootScreen {
  @State selectedNav: number = 0;
  
  // Mock Data
  private metrics: HealthMetric[] = [
    { id: 1, title: "Heart", value: "72", unit: "bpm", progress: 0.6, color: Color.Pink },
    { id: 2, title: "Steps", value: "842", unit: "steps", progress: 0.8, color: Color.Blue },
    { id: 3, title: "Sleep", value: "7.2", unit: "hours", progress: 0.9, color: Color.Green },
    { id: 4, title: "Calories", value: "420", unit: "kcal", progress: 0.4, color: Color.Red }
  ];

  private workouts: Workout[] = [
    { id: 1, name: "Morning Run", duration: "32 min", calories: "284 kcal", iconColor: Color.Blue },
    { id: 2, name: "Yoga Flow", duration: "45 min", calories: "156 kcal", iconColor: Color.Pink },
    { id: 3, name: "Strength Training", duration: "28 min", calories: "320 kcal", iconColor: Color.Green }
  ];

  private navItems: NavItem[] = [
    { id: 0, label: "Dashboard" },
    { id: 1, label: "Workouts" },
    { id: 2, label: "Nutrition" },
    { id: 3, label: "Profile" }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Health Dashboard")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .letterSpacing(-0.25)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)

      // Main Content Scrollable Area
      Scroll() {
        Column() {
          // Hero Card
          Column() {
            Text("Good Morning!")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
            
            Text("Ready for your workout?")
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onPrimary)
              .margin({ top: AppTokens.Spacing.sm })

            Button("Start Workout")
              .backgroundColor(AppTokens.Colors.onPrimary)
              .fontColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(44)
              .width('100%')
              .margin({ top: AppTokens.Spacing.lg })
              .onClick(() => {
                // Action
              })
          }
          .width('100%')
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: 12, color: 'rgba(0,0,0,0.22)', offsetY: 3 })

          // Metrics Section Title
          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md, left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })

          // Metrics Grid
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column() {
                Circle()
                  .width(36)
                  .height(36)
                  .fillColor(metric.color)
                
                Text(metric.value)
                  .fontSize(20)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs })
                
                Text(metric.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#B30F172A') // Approximate alpha 0.7 of onSurface
                  .margin({ top: AppTokens.Spacing.xs })
              }
              .width('23%') // 4 items with gap
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.medium)
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 2 })
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Recent Workouts Header
          Row() {
            Text("Recent Workouts")
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onBackground)
            
            Blank()
            
            Text("View All")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
              .onClick(() => {})
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.md })

          // Workouts List
          ForEach(this.workouts, (workout: Workout) => {
            Row() {
              // Icon Box
              Rectangle()
                .width(44)
                .height(44)
                .fillColor(workout.iconColor)
                .borderRadius(AppTokens.Shapes.medium)

              // Details
              Column() {
                Text(workout.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                
                Row() {
                  Text(workout.duration)
                    .fontSize(14)
                    .fontColor('#B30F172A')
                  
                  Text(workout.calories)
                    .fontSize(14)
                    .fontColor('#B30F172A')
                    .margin({ left: AppTokens.Spacing.lg })
                }
                .margin({ top: AppTokens.Spacing.xs })
              }
              .layoutWeight(1)
              .margin({ left: AppTokens.Spacing.md })

              // Start Button
              Button("Start")
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .borderRadius(AppTokens.Shapes.small)
                .height(32)
                .width(70)
                .fontSize(10)
                .onClick(() => {})
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.15)', offsetY: 1 })
            .margin({ bottom: AppTokens.Spacing.md })
          })
          
          // Bottom padding for navigation bar
          Blank().height(80)
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Circle()
              .width(20)
              .height(20)
              .fillColor(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNav = item.id;
          })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}