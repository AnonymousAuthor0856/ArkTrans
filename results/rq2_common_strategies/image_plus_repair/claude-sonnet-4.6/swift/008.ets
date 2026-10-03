// Color tokens
const ColorPrimary: string = '#6366F1';
const ColorSecondary: string = '#EC4899';
const ColorTertiary: string = '#10B981';
const ColorBackground: string = '#F8FAFC';
const ColorSurface: string = '#FFFFFF';
const ColorOutline: string = '#E2E8F0';
const ColorError: string = '#EF4444';
const ColorOnPrimary: string = '#FFFFFF';
const ColorOnBackground: string = '#0F172A';
const ColorOnSurface: string = '#0F172A';

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
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', color: ColorSecondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', color: ColorPrimary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', color: ColorTertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', color: ColorError },
  ];

  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: ColorPrimary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: ColorSecondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: ColorTertiary },
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
      .fontColor(ColorOnBackground)
      .width('100%')
      .textAlign(TextAlign.Center)
      .padding({ top: 20, bottom: 8 })
  }

  @Builder
  HeroCard() {
    Column({ space: 4 }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorOnPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorOnPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Button('Start Workout')
        .width('100%')
        .height(44)
        .backgroundColor(ColorOnPrimary)
        .fontColor(ColorPrimary)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .borderRadius(12)
        .margin({ top: 8 })
    }
    .padding(16)
    .width('100%')
    .backgroundColor(ColorPrimary)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
    .shadow({ radius: 12, color: '#00000038', offsetX: 0, offsetY: 3 })
  }

  @Builder
  SectionTitle(title: string) {
    Text(title)
      .fontSize(14)
      .fontColor(ColorOnBackground)
      .width('100%')
      .textAlign(TextAlign.Start)
      .padding({ left: 4 })
  }

  @Builder
  MetricsRow() {
    Row({ space: 8 }) {
      ForEach(this.metrics, (metric: HealthMetric) => {
        Column({ space: 2 }) {
          Circle()
            .fill(metric.color)
            .width(36)
            .height(36)

          Text(metric.value)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(ColorOnSurface)

          Text(metric.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#660F172A')
        }
        .padding(8)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .backgroundColor(ColorSurface)
        .borderRadius(12)
        .shadow({ radius: 8, color: '#0000002E', offsetX: 0, offsetY: 2 })
      })
    }
    .width('100%')
  }

  @Builder
  RecentWorkoutsHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorOnBackground)

      Blank()

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorPrimary)
        .padding({ right: 20 })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  WorkoutCard(workout: Workout) {
    Row({ space: 8 }) {
      Column()
        .width(44)
        .height(44)
        .backgroundColor(workout.iconColor)
        .borderRadius(12)

      Column({ space: 2 }) {
        Text(workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorOnSurface)
          .textAlign(TextAlign.Start)
          .width('100%')

        Row({ space: 12 }) {
          Text(workout.duration)
            .fontSize(14)
            .fontColor('#660F172A')

          Text(workout.calories)
            .fontSize(14)
            .fontColor('#660F172A')
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .width(70)
        .height(32)
        .backgroundColor(ColorPrimary)
        .fontColor(ColorOnPrimary)
        .fontSize(10)
        .borderRadius(8)
    }
    .padding(12)
    .width('100%')
    .backgroundColor(ColorSurface)
    .borderRadius(12)
    .shadow({ radius: 4, color: '#00000026', offsetX: 0, offsetY: 1 })
  }

  @Builder
  BottomNavigation() {
    Row({ space: 8 }) {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 2 }) {
          Circle()
            .fill(this.selectedNav === item.id ? ColorPrimary : ColorOutline)
            .width(20)
            .height(20)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      })
    }
    .padding({ top: 4, bottom: 4, left: 8, right: 8 })
    .width('100%')
    .backgroundColor(ColorSurface)
    .borderRadius(16)
    .shadow({ radius: 8, color: '#0000002E', offsetX: 0, offsetY: 2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: 12 }) {
            this.HeroCard()

            this.SectionTitle("Today's Metrics")

            this.MetricsRow()

            this.RecentWorkoutsHeader()

            ForEach(this.workouts, (workout: Workout) => {
              this.WorkoutCard(workout)
            })

            Column().height(80)
          }
          .padding({ left: 8, right: 8, bottom: 12 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ColorBackground)

      Column() {
        this.BottomNavigation()
      }
      .padding({ left: 8, right: 8, bottom: 8 })
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}