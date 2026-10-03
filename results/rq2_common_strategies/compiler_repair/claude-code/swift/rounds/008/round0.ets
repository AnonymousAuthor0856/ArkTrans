import prompt from '@ohos.prompt';

class HealthDashboardTokens {
  static Colors = class {
    static primary: ResourceColor = Color.rgb(99, 102, 241);
    static secondary: ResourceColor = Color.rgb(236, 72, 153);
    static tertiary: ResourceColor = Color.rgb(16, 185, 129);
    static background: ResourceColor = Color.rgb(248, 250, 252);
    static surface: ResourceColor = Color.White;
    static surfaceVariant: ResourceColor = Color.rgb(241, 245, 249);
    static outline: ResourceColor = Color.rgb(226, 232, 240);
    static error: ResourceColor = Color.rgb(239, 68, 68);
    static onPrimary: ResourceColor = Color.White;
    static onBackground: ResourceColor = Color.rgb(15, 23, 42);
    static onSurface: ResourceColor = Color.rgb(15, 23, 42);
  };

  static Shapes = class {
    static small: number = 8;
    static medium: number = 12;
    static large: number = 16;
  };

  static Spacing = class {
    static xs: number = 2;
    static sm: number = 4;
    static md: number = 8;
    static lg: number = 12;
    static xl: number = 16;
    static xxl: number = 20;
    static xxxl: number = 24;
  };

  static Elevation = class {
    static level1 = { radius: 4, y: 1, opacity: 0.15 };
    static level2 = { radius: 8, y: 2, opacity: 0.18 };
    static level3 = { radius: 12, y: 3, opacity: 0.22 };
    static level4 = { radius: 16, y: 4, opacity: 0.25 };
  };
}

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
  @State metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: HealthDashboardTokens.Colors.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', color: HealthDashboardTokens.Colors.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: HealthDashboardTokens.Colors.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: HealthDashboardTokens.Colors.error }
  ];
  @State workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: HealthDashboardTokens.Colors.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: HealthDashboardTokens.Colors.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: HealthDashboardTokens.Colors.tertiary }
  ];
  @State navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ];
  private bottomBarHeight: number = 72;

  @Builder
  topBar() {
    Text('Health Dashboard')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor(HealthDashboardTokens.Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: HealthDashboardTokens.Spacing.xxl, bottom: HealthDashboardTokens.Spacing.md })
  }

  @Builder
  heroCard() {
    Column() {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .margin({ bottom: HealthDashboardTokens.Spacing.sm })
        .width('100%')
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .margin({ bottom: HealthDashboardTokens.Spacing.md })
        .width('100%')
      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .height(44)
        .backgroundColor(HealthDashboardTokens.Colors.onPrimary)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .onClick(() => {
          prompt.showToast({ message: 'Start Workout' });
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(HealthDashboardTokens.Spacing.xl)
    .backgroundColor(HealthDashboardTokens.Colors.primary)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level3.radius,
      color: 'rgba(0, 0, 0, ' + HealthDashboardTokens.Elevation.level3.opacity.toString() + ')',
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level3.y
    })
  }

  @Builder
  sectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
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
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
            .opacity(0.7)
        }
        .width('100%')
        .padding(HealthDashboardTokens.Spacing.md)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(HealthDashboardTokens.Colors.surface)
        .borderRadius(HealthDashboardTokens.Shapes.medium)
        .shadow({
          radius: HealthDashboardTokens.Elevation.level2.radius,
          color: 'rgba(0, 0, 0, ' + HealthDashboardTokens.Elevation.level2.opacity.toString() + ')',
          offsetX: 0,
          offsetY: HealthDashboardTokens.Elevation.level2.y
        })
        .layoutWeight(1)
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%')
  }

  @Builder
  recentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(HealthDashboardTokens.Colors.onBackground)
      Blank()
      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.Colors.primary)
        .padding({ right: 20 })
        .onClick(() => {
          prompt.showToast({ message: 'View All' });
        })
    }
    .width('100%')
  }

  @Builder
  workoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.Spacing.md }) {
      RoundedRect({ width: 44, height: 44, radius: HealthDashboardTokens.Shapes.medium })
        .fill(workout.iconColor)
      Column({ space: HealthDashboardTokens.Spacing.xs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HealthDashboardTokens.Colors.onSurface)
        Row({ space: HealthDashboardTokens.Spacing.lg }) {
          Text(workout.duration)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
            .opacity(0.7)
          Text(workout.calories)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
            .opacity(0.7)
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Button('Start')
        .fontSize(10)
        .fontWeight(FontWeight.Regular)
        .width(70)
        .height(32)
        .backgroundColor(HealthDashboardTokens.Colors.primary)
        .fontColor(HealthDashboardTokens.Colors.onPrimary)
        .borderRadius(HealthDashboardTokens.Shapes.small)
        .onClick(() => {
          prompt.showToast({ message: 'Start ' + workout.name });
        })
    }
    .width('100%')
    .padding(HealthDashboardTokens.Spacing.lg)
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.medium)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level1.radius,
      color: 'rgba(0, 0, 0, ' + HealthDashboardTokens.Elevation.level1.opacity.toString() + ')',
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
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthDashboardTokens.Colors.onSurface)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({
      top: HealthDashboardTokens.Spacing.sm,
      bottom: HealthDashboardTokens.Spacing.sm,
      left: HealthDashboardTokens.Spacing.md,
      right: HealthDashboardTokens.Spacing.md
    })
    .backgroundColor(HealthDashboardTokens.Colors.surface)
    .borderRadius(HealthDashboardTokens.Shapes.large)
    .shadow({
      radius: HealthDashboardTokens.Elevation.level2.radius,
      color: 'rgba(0, 0, 0, ' + HealthDashboardTokens.Elevation.level2.opacity.toString() + ')',
      offsetX: 0,
      offsetY: HealthDashboardTokens.Elevation.level2.y
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        this.topBar()
          .margin({ top: 40, bottom: 20 })

        Scroll() {
          Column({ space: HealthDashboardTokens.Spacing.lg }) {
            this.heroCard()
            this.sectionTitle("Today's Metrics")
            this.metricsRow()
            this.recentWorkoutsHeader()
              .margin({ top: 10, bottom: 10 })
            ForEach(this.workouts, (workout: Workout) => {
              this.workoutCard(workout)
            }, (workout: Workout) => workout.id.toString())
          }
          .width('100%')
          .padding({ left: HealthDashboardTokens.Spacing.md, right: HealthDashboardTokens.Spacing.md })
          .padding({ bottom: this.bottomBarHeight + HealthDashboardTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        this.bottomNavigation()
          .margin({
            left: HealthDashboardTokens.Spacing.md,
            right: HealthDashboardTokens.Spacing.md,
            bottom: HealthDashboardTokens.Spacing.md
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthDashboardTokens.Colors.background)
  }
}
