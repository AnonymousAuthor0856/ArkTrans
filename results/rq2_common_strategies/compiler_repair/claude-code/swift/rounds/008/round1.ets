import prompt from '@ohos.prompt';

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

class HealthDashboardTokens {
  static primary: ResourceColor = '#6366F1';
  static secondary: ResourceColor = '#EC4899';
  static tertiary: ResourceColor = '#10B981';
  static background: ResourceColor = '#F8FAFC';
  static surface: ResourceColor = '#FFFFFF';
  static surfaceVariant: ResourceColor = '#F1F5F9';
  static outline: ResourceColor = '#E2E8F0';
  static error: ResourceColor = '#EF4444';
  static onPrimary: ResourceColor = '#FFFFFF';
  static onBackground: ResourceColor = '#0F172A';
  static onSurface: ResourceColor = '#0F172A';

  static shapeSmall: number = 8;
  static shapeMedium: number = 12;
  static shapeLarge: number = 16;

  static spacingXs: number = 2;
  static spacingSm: number = 4;
  static spacingMd: number = 8;
  static spacingLg: number = 12;
  static spacingXl: number = 16;
  static spacingXxl: number = 20;
  static spacingXxxl: number = 24;

  static elevationLevel1: ShadowSpec = new ShadowSpec(4, 1, 0.15);
  static elevationLevel2: ShadowSpec = new ShadowSpec(8, 2, 0.18);
  static elevationLevel3: ShadowSpec = new ShadowSpec(12, 3, 0.22);
  static elevationLevel4: ShadowSpec = new ShadowSpec(16, 4, 0.25);
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
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: HealthDashboardTokens.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', color: HealthDashboardTokens.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: HealthDashboardTokens.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: HealthDashboardTokens.error }
  ];
  @State workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: HealthDashboardTokens.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: HealthDashboardTokens.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: HealthDashboardTokens.tertiary }
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
      .fontColor(HealthDashboardTokens.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: HealthDashboardTokens.spacingXxl, bottom: HealthDashboardTokens.spacingMd })
  }

  @Builder
  heroCard() {
    Column() {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.onPrimary)
        .margin({ bottom: HealthDashboardTokens.spacingSm })
        .width('100%')
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(HealthDashboardTokens.onPrimary)
        .margin({ bottom: HealthDashboardTokens.spacingMd })
        .width('100%')
      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .height(44)
        .backgroundColor(HealthDashboardTokens.onPrimary)
        .fontColor(HealthDashboardTokens.primary)
        .borderRadius(HealthDashboardTokens.shapeMedium)
        .onClick(() => {
          prompt.showToast({ message: 'Start Workout' });
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(HealthDashboardTokens.spacingXl)
    .backgroundColor(HealthDashboardTokens.primary)
    .borderRadius(HealthDashboardTokens.shapeLarge)
    .shadow({
      radius: HealthDashboardTokens.elevationLevel3.radius,
      color: 'rgba(0, 0, 0, 0.22)',
      offsetX: 0,
      offsetY: HealthDashboardTokens.elevationLevel3.y
    })
  }

  @Builder
  sectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(HealthDashboardTokens.onBackground)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: HealthDashboardTokens.spacingSm, right: HealthDashboardTokens.spacingSm })
  }

  @Builder
  metricsRow() {
    Row({ space: HealthDashboardTokens.spacingMd }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column({ space: HealthDashboardTokens.spacingXs }) {
          Circle({ width: 36, height: 36 })
            .fill(metric.color)
          Text(metric.value)
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(HealthDashboardTokens.onSurface)
          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthDashboardTokens.onSurface)
            .opacity(0.7)
        }
        .width('100%')
        .padding(HealthDashboardTokens.spacingMd)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(HealthDashboardTokens.surface)
        .borderRadius(HealthDashboardTokens.shapeMedium)
        .shadow({
          radius: HealthDashboardTokens.elevationLevel2.radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: HealthDashboardTokens.elevationLevel2.y
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
        .fontColor(HealthDashboardTokens.onBackground)
      Blank()
      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(HealthDashboardTokens.primary)
        .padding({ right: 20 })
        .onClick(() => {
          prompt.showToast({ message: 'View All' });
        })
    }
    .width('100%')
  }

  @Builder
  workoutCard(workout: Workout) {
    Row({ space: HealthDashboardTokens.spacingMd }) {
      RoundedRect({ width: 44, height: 44, radius: HealthDashboardTokens.shapeMedium })
        .fill(workout.iconColor)
      Column({ space: HealthDashboardTokens.spacingXs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HealthDashboardTokens.onSurface)
        Row({ space: HealthDashboardTokens.spacingLg }) {
          Text(workout.duration)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(HealthDashboardTokens.onSurface)
            .opacity(0.7)
          Text(workout.calories)
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(HealthDashboardTokens.onSurface)
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
        .backgroundColor(HealthDashboardTokens.primary)
        .fontColor(HealthDashboardTokens.onPrimary)
        .borderRadius(HealthDashboardTokens.shapeSmall)
        .onClick(() => {
          prompt.showToast({ message: 'Start ' + workout.name });
        })
    }
    .width('100%')
    .padding(HealthDashboardTokens.spacingLg)
    .backgroundColor(HealthDashboardTokens.surface)
    .borderRadius(HealthDashboardTokens.shapeMedium)
    .shadow({
      radius: HealthDashboardTokens.elevationLevel1.radius,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: HealthDashboardTokens.elevationLevel1.y
    })
  }

  @Builder
  bottomNavigation() {
    Row({ space: HealthDashboardTokens.spacingMd }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: HealthDashboardTokens.spacingXs }) {
          Circle({ width: 20, height: 20 })
            .fill(this.selectedNav === item.id
              ? HealthDashboardTokens.primary
              : HealthDashboardTokens.outline)
          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(HealthDashboardTokens.onSurface)
        }
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({
      top: HealthDashboardTokens.spacingSm,
      bottom: HealthDashboardTokens.spacingSm,
      left: HealthDashboardTokens.spacingMd,
      right: HealthDashboardTokens.spacingMd
    })
    .backgroundColor(HealthDashboardTokens.surface)
    .borderRadius(HealthDashboardTokens.shapeLarge)
    .shadow({
      radius: HealthDashboardTokens.elevationLevel2.radius,
      color: 'rgba(0, 0, 0, 0.18)',
      offsetX: 0,
      offsetY: HealthDashboardTokens.elevationLevel2.y
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        this.topBar()
          .margin({ top: 40, bottom: 20 })

        Scroll() {
          Column({ space: HealthDashboardTokens.spacingLg }) {
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
          .padding({ left: HealthDashboardTokens.spacingMd, right: HealthDashboardTokens.spacingMd })
          .padding({ bottom: this.bottomBarHeight + HealthDashboardTokens.spacingLg })
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
            left: HealthDashboardTokens.spacingMd,
            right: HealthDashboardTokens.spacingMd,
            bottom: HealthDashboardTokens.spacingMd
          })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HealthDashboardTokens.background)
  }
}
