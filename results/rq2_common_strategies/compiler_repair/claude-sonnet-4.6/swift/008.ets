// Design tokens
class ColorsType {
  primary: string = '#6366F1';
  secondary: string = '#EC4899';
  tertiary: string = '#10B981';
  background: string = '#F8FAFC';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F1F5F9';
  outline: string = '#E2E8F0';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onBackground: string = '#0F172A';
  onSurface: string = '#0F172A';
}

class SpacingType {
  xs: number = 2;
  sm: number = 4;
  md: number = 8;
  lg: number = 12;
  xl: number = 16;
  xxl: number = 20;
  xxxl: number = 24;
}

class ShapesType {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

const Colors = new ColorsType();
const Spacing = new SpacingType();
const Shapes = new ShapesType();

class HealthMetric {
  id: number = 0;
  title: string = '';
  value: string = '';
  unit: string = '';
  color: string = '';
}

class Workout {
  id: number = 0;
  name: string = '';
  duration: string = '';
  calories: string = '';
  iconColor: string = '';
}

class NavItem {
  id: number = 0;
  label: string = '';
}

@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: Colors.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', color: Colors.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: Colors.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: Colors.error },
  ];

  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: Colors.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: Colors.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: Colors.tertiary },
  ];

  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' },
  ];

  @Builder
  TopBar() {
    Text('Health Dashboard')
      .fontSize(24)
      .fontWeight(FontWeight.Bold)
      .fontColor(Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: Spacing.xxl, bottom: Spacing.md })
  }

  @Builder
  HeroCard() {
    Column({ space: Spacing.sm }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Button('Start Workout')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.primary)
        .backgroundColor(Colors.onPrimary)
        .borderRadius(Shapes.medium)
        .width('100%')
        .height(44)
        .margin({ top: Spacing.sm })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.xl)
    .width('100%')
    .backgroundColor(Colors.primary)
    .borderRadius(Shapes.large)
    .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontColor(Colors.onBackground)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: Spacing.sm, right: Spacing.sm })
  }

  @Builder
  MetricsRow() {
    Row({ space: Spacing.md }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column({ space: Spacing.xs }) {
          Circle()
            .fill(metric.color)
            .width(36)
            .height(36)

          Text(metric.value)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#800F172A')
        }
        .alignItems(HorizontalAlign.Start)
        .padding(Spacing.md)
        .layoutWeight(1)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.medium)
        .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  RecentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.onBackground)

      Blank()

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.primary)
        .padding({ right: 20 })
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: Spacing.md }) {
      Column()
        .width(44)
        .height(44)
        .backgroundColor(workout.iconColor)
        .borderRadius(Shapes.medium)

      Column({ space: Spacing.xs }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .textAlign(TextAlign.Start)
          .width('100%')

        Row({ space: Spacing.lg }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#800F172A')

          Text(workout.calories)
            .fontSize(14)
            .fontColor('#800F172A')
        }
        .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Start')
        .fontSize(10)
        .fontColor(Colors.onPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(Shapes.small)
        .width(70)
        .height(32)
    }
    .padding(Spacing.lg)
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.medium)
    .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomNavigation() {
    Row({ space: Spacing.md }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: Spacing.xs }) {
          Circle()
            .fill(this.selectedNav === item.id ? Colors.primary : Colors.outline)
            .width(20)
            .height(20)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      })
    }
    .padding({ top: Spacing.sm, bottom: Spacing.sm, left: Spacing.md, right: Spacing.md })
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: Spacing.lg }) {
            this.HeroCard()
            this.SectionTitle("Today's Metrics")
            this.MetricsRow()
            this.RecentWorkoutsHeader()

            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            })
          }
          .padding({ left: Spacing.md, right: Spacing.md, bottom: 88 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      Column() {
        this.BottomNavigation()
      }
      .padding({ left: Spacing.md, right: Spacing.md, bottom: Spacing.md })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}