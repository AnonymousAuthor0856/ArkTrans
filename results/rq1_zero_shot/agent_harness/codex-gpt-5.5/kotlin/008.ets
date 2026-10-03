const NAME: string = '011_HealthDashboard_en';
const UI_TYPE: string = 'Health Fitness Dashboard';
const STYLE_THEME: string = 'Vibrant Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

class AppColors {
  static readonly primary: string = '#6366F1';
  static readonly secondary: string = '#EC4899';
  static readonly tertiary: string = '#10B981';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#10B981';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 8;
  static readonly lg: number = 12;
  static readonly xl: number = 16;
  static readonly xxl: number = 20;
  static readonly xxxl: number = 24;
}

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
struct MainActivity {
  @State selectedNav: number = 0;
  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, AppColors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, AppColors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, AppColors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, AppColors.error)
  ];
  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', AppColors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', AppColors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', AppColors.tertiary)
  ];
  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  @Builder
  Header(): void {
    Text('Health Dashboard')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onBackground)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(Color.Transparent);
  }

  @Builder
  HeroCard(): void {
    Column({ space: AppSpacing.sm }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary);
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onPrimary);
      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .backgroundColor(AppColors.onPrimary)
        .borderRadius(12)
        .width('100%')
        .height(44);
    }
    .width('100%')
    .padding(AppSpacing.xl)
    .backgroundColor(AppColors.primary)
    .borderRadius(16)
    .shadow({ radius: 12, color: '#38000000', offsetY: 3 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  MetricTile(metric: HealthMetric): void {
    Column({ space: AppSpacing.xs }) {
      Circle().width(36).height(36).fill(metric.color);
      Text(metric.value)
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);
      Text(metric.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B30F172A');
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  MetricsRow(): void {
    Row({ space: AppSpacing.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        this.MetricTile(metric);
      }, (metric: HealthMetric) => metric.id.toString())
    }
    .width('100%');
  }

  @Builder
  WorkoutsHeader(): void {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onBackground);
      Blank();
      Button('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .backgroundColor(Color.Transparent);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  WorkoutRow(workout: Workout): void {
    Row({ space: AppSpacing.md }) {
      Rect().width(44).height(44).fill(workout.iconColor).radius(12);
      Column({ space: AppSpacing.xs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Row({ space: AppSpacing.lg }) {
          Text(workout.duration).fontSize(14).fontColor('#B30F172A');
          Text(workout.calories).fontSize(14).fontColor('#B30F172A');
        }
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);
      Button('Start')
        .fontSize(10)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width(70)
        .height(32);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BottomNav(): void {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: AppSpacing.xs }) {
          Circle()
            .width(20)
            .height(20)
            .fill(this.selectedNav === item.id ? AppColors.primary : AppColors.outline);
          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
        }
        .layoutWeight(1)
        .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        });
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#2E000000', offsetY: -2 });
  }

  build() {
    Column() {
      this.Header();
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.HeroCard();
          Text('Today\'s Metrics')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .padding({ left: AppSpacing.sm, right: AppSpacing.sm });
          this.MetricsRow();
          this.WorkoutsHeader();
          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutRow(workout);
          }, (workout: Workout) => workout.id.toString())
        }
        .width('100%')
        .padding({ left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.xxxl });
      }
      .layoutWeight(1);
      this.BottomNav();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
