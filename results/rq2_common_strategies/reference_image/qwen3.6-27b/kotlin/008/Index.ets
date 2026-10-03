import { window } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

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
  Radius: {
    small: 8,
    medium: 12,
    large: 16
  }
};

// --- Data Models ---

interface HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  progress: number;
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

// --- Main Entry ---

@Entry
@Component
struct RootScreen {
  @State selectedNav: number = 0;

  // Mock Data
  private metrics: HealthMetric[] = [
    { id: 1, title: "Heart", value: "72", unit: "bpm", progress: 0.6, color: AppTokens.Colors.secondary },
    { id: 2, title: "Steps", value: "842", unit: "steps", progress: 0.8, color: AppTokens.Colors.primary },
    { id: 3, title: "Sleep", value: "7.2", unit: "hours", progress: 0.9, color: AppTokens.Colors.tertiary },
    { id: 4, title: "Calories", value: "420", unit: "kcal", progress: 0.4, color: AppTokens.Colors.error }
  ];

  private workouts: Workout[] = [
    { id: 1, name: "Morning Run", duration: "32 min", calories: "284 kcal", iconColor: AppTokens.Colors.primary },
    { id: 2, name: "Yoga Flow", duration: "45 min", calories: "156 kcal", iconColor: AppTokens.Colors.secondary },
    { id: 3, name: "Strength Training", duration: "28 min", calories: "320 kcal", iconColor: AppTokens.Colors.tertiary }
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
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 40, bottom: 20 }) // Simulating status bar padding

      // Scrollable Content
      Scroll() {
        Column() {
          this.HeaderCard()
          
          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding({ left: AppTokens.Spacing.sm })

          this.MetricsGrid()

          Row() {
            Text("Recent Workouts")
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onBackground)
              .layoutWeight(1)
            
            Text("View All")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
              .onClick(() => {})
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })

          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutItem(workout)
          })
          
          // Bottom padding for navigation bar
          Blank().height(80) 
        }
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation
      this.BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  HeaderCard() {
    Column() {
      Text("Good Morning!")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
      
      Text("Ready for your workout?")
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppTokens.Colors.onPrimary)
        .margin({ top: AppTokens.Spacing.xs })

      Button("Start Workout")
        .backgroundColor(AppTokens.Colors.onPrimary)
        .fontColor(AppTokens.Colors.primary)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppTokens.Radius.medium)
        .height(44)
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.xl)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Radius.large)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
  }

  @Builder
  MetricsGrid() {
    Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column() {
          Circle({ width: 36, height: 36 })
            .fill(metric.color)
          
          Text(metric.value)
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.xs })
          
          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#64748B') // Slightly lighter text for labels
        }
        .width('23%') // 4 items per row with spacing
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.medium)
        .shadow({ radius: 8, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
        .alignItems(HorizontalAlign.Center)
      })
    }
    .width('100%')
  }

  @Builder
  WorkoutItem(workout: Workout) {
    Row() {
      // Icon Box
      Rectangle()
        .width(44)
        .height(44)
        .fill(workout.iconColor)
        .borderRadius(AppTokens.Radius.medium)

      Column() {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        
        Row() {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#64748B')
          
          Text(workout.calories)
            .fontSize(14)
            .fontColor('#64748B')
            .margin({ left: AppTokens.Spacing.lg })
        }
        .margin({ top: AppTokens.Spacing.xs })
      }
      .layoutWeight(1)
      .margin({ left: AppTokens.Spacing.md })

      Button("Star")
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .fontSize(10)
        .borderRadius(AppTokens.Radius.small)
        .height(32)
        .width(70)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
    .margin({ bottom: AppTokens.Spacing.md })
  }

  @Builder
  BottomNavBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column() {
          // Indicator Dot
          Circle({ width: 20, height: 20 })
            .fill(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.outline)
          
          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNav === item.id ? AppTokens.Colors.onBackground : '#64748B')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      })
    }
    .width('100%')
    .height(60)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
  }
}