// Index.ets — 011_HealthDashboard_en · Health Fitness Dashboard · Vibrant Gradient
// Baseline 1280x720 (vp), font sizes mapped from sp -> fp

interface HealthMetric {
  id: number;
  title: string;
  value: string;
  color: string;
}

interface Workout {
  id: number;
  name: string;
  duration: string;
  calories: string;
  color: string;
}

interface NavItem {
  id: number;
  label: string;
}

// ---- Design tokens -------------------------------------------------------
const C_PRIMARY: string = '#6366F1';
const C_SECONDARY: string = '#EC4899';
const C_TERTIARY: string = '#10B981';
const C_ERROR: string = '#EF4444';
const C_BACKGROUND: string = '#F8FAFC';
const C_SURFACE: string = '#FFFFFF';
const C_OUTLINE: string = '#E2E8F0';
const C_ON_BACKGROUND: string = '#0F172A';
const C_MUTED: string = '#64748B';
const C_ON_PRIMARY: string = '#FFFFFF';
const C_INDICATOR: string = '#E0E7FF';

// ---- Elevation mapping (elevation / radius / dy / alpha) -----------------
const E1: ShadowOptions = { radius: 4, color: '#260F172A', offsetX: 0, offsetY: 1 };
const E2: ShadowOptions = { radius: 8, color: '#2E0F172A', offsetX: 0, offsetY: 2 };
const E3: ShadowOptions = { radius: 12, color: '#3D0F172A', offsetX: 0, offsetY: 3 };

@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', color: C_SECONDARY },
    { id: 2, title: 'Steps', value: '842', color: C_PRIMARY },
    { id: 3, title: 'Sleep', value: '7.2', color: C_TERTIARY },
    { id: 4, title: 'Calories', value: '420', color: C_ERROR }
  ];

  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', color: C_PRIMARY },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', color: C_SECONDARY },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', color: C_TERTIARY }
  ];

  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ];

  // ---- Top app bar -------------------------------------------------------
  @Builder
  TopBar() {
    Row() {
      Text('Health Dashboard')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_BACKGROUND)
        .letterSpacing(-0.25)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  // ---- Hero card ---------------------------------------------------------
  @Builder
  HeroCard() {
    Column({ space: 4 }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_PRIMARY)
        .width('100%')

      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(C_ON_PRIMARY)
        .width('100%')
        .margin({ bottom: 8 })

      Button('Start Workout')
        .type(ButtonType.Normal)
        .width('100%')
        .height(44)
        .borderRadius(12)
        .backgroundColor(C_SURFACE)
        .fontColor(C_PRIMARY)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(C_PRIMARY)
    .borderRadius(16)
    .shadow(E3)
  }

  // ---- Metric card -------------------------------------------------------
  @Builder
  MetricCard(title: string, value: string, color: string) {
    Column({ space: 2 }) {
      Row()
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(color)
        .margin({ bottom: 4 })

      Text(value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_BACKGROUND)

      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_MUTED)
    }
    .layoutWeight(1)
    .padding(8)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(C_SURFACE)
    .borderRadius(12)
    .shadow(E2)
  }

  // ---- Workout row card --------------------------------------------------
  @Builder
  WorkoutCard(name: string, duration: string, calories: string, color: string) {
    Row({ space: 12 }) {
      Row()
        .width(44)
        .height(44)
        .borderRadius(12)
        .backgroundColor(color)

      Column({ space: 2 }) {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(C_ON_BACKGROUND)
          .width('100%')

        Row({ space: 12 }) {
          Text(duration)
            .fontSize(14)
            .fontColor(C_MUTED)

          Text(calories)
            .fontSize(14)
            .fontColor(C_MUTED)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Button('Start')
        .type(ButtonType.Normal)
        .width(70)
        .height(32)
        .borderRadius(8)
        .backgroundColor(C_PRIMARY)
        .fontColor(C_ON_PRIMARY)
        .fontSize(10)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(C_SURFACE)
    .borderRadius(12)
    .shadow(E1)
  }

  // ---- Bottom navigation -------------------------------------------------
  @Builder
  BottomNav() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 4 }) {
          Row() {
            Row()
              .width(20)
              .height(20)
              .borderRadius(10)
              .backgroundColor(this.selectedNav === item.id ? C_PRIMARY : C_OUTLINE)
          }
          .width(64)
          .height(32)
          .borderRadius(16)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(this.selectedNav === item.id ? C_INDICATOR : Color.Transparent)

          Text(item.label)
            .fontSize(12)
            .fontWeight(this.selectedNav === item.id ? FontWeight.Medium : FontWeight.Normal)
            .fontColor(this.selectedNav === item.id ? C_ON_BACKGROUND : C_MUTED)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .height(72)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(C_SURFACE)
    .shadow({ radius: 12, color: '#1A0F172A', offsetX: 0, offsetY: -3 })
  }

  // ---- Page --------------------------------------------------------------
  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 12 }) {
          this.HeroCard()

          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(C_ON_BACKGROUND)
            .margin({ left: 4 })

          Row({ space: 8 }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              this.MetricCard(metric.title, metric.value, metric.color)
            }, (metric: HealthMetric) => metric.id.toString())
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(C_ON_BACKGROUND)

            Button('View All')
              .type(ButtonType.Normal)
              .height(28)
              .backgroundColor(Color.Transparent)
              .fontColor(C_PRIMARY)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.workouts, (workout: Workout) => {
            this.WorkoutCard(workout.name, workout.duration, workout.calories, workout.color)
          }, (workout: Workout) => workout.id.toString())
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 8, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }
}