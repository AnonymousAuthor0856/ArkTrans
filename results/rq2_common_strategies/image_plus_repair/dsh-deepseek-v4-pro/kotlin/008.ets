// 008.kt -> 008.ets (Health Fitness Dashboard)
const PRIMARY: string = '#6366F1';
const SECONDARY: string = '#EC4899';
const TERTIARY: string = '#10B981';
const BACKGROUND: string = '#F8FAFC';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#F1F5F9';
const OUTLINE: string = '#E2E8F0';
const SUCCESS: string = '#10B981';
const WARNING: string = '#F59E0B';
const ERROR: string = '#EF4444';
const ON_PRIMARY: string = '#FFFFFF';
const ON_SECONDARY: string = '#FFFFFF';
const ON_TERTIARY: string = '#FFFFFF';
const ON_BACKGROUND: string = '#0F172A';
const ON_SURFACE: string = '#0F172A';

const SP_XS: number = 2;
const SP_SM: number = 4;
const SP_MD: number = 8;
const SP_LG: number = 12;
const SP_XL: number = 16;
const SP_XXL: number = 20;
const SP_XXXL: number = 24;

const SHAPE_SMALL: number = 8;
const SHAPE_MEDIUM: number = 12;
const SHAPE_LARGE: number = 16;

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
struct HealthDashboard {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, SECONDARY),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, PRIMARY),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, TERTIARY),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, ERROR)
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', PRIMARY),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', SECONDARY),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', TERTIARY)
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  build() {
    Column() {
      // CenterAlignedTopAppBar (transparent container)
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_BACKGROUND)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Content
      Scroll() {
        Column({ space: SP_LG }) {
          // Hero card
          Column({ space: SP_SM }) {
            Text('Good Morning!')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_PRIMARY)
            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_PRIMARY)
            Button() {
              Text('Start Workout')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(PRIMARY)
            }
            .width('100%')
            .height(44)
            .backgroundColor(ON_PRIMARY)
            .borderRadius(SHAPE_MEDIUM)
            .onClick(() => {})
          }
          .width('100%')
          .padding(SP_XL)
          .backgroundColor(PRIMARY)
          .borderRadius(SHAPE_LARGE)
          .shadow({ radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 })

          // Today's Metrics header
          Text('Today\'s Metrics')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_BACKGROUND)
            .padding({ left: SP_SM, right: SP_SM })

          // Metrics row
          Row({ space: SP_MD }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column({ space: SP_XS }) {
                Column() {}
                .width(36)
                .height(36)
                .backgroundColor(metric.color)
                .borderRadius(18)
                Text(metric.value)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Text(metric.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#B30F172A')
              }
              .layoutWeight(1)
              .padding(SP_MD)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(SURFACE)
              .borderRadius(SHAPE_MEDIUM)
              .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 })
            }, (metric: HealthMetric) => metric.id.toString())
          }
          .width('100%')

          // Recent Workouts header
          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_BACKGROUND)
            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(PRIMARY)
              .onClick(() => {})
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          // Workout cards
          ForEach(this.workouts, (workout: Workout) => {
            Row({ space: SP_MD }) {
              Column() {}
              .width(44)
              .height(44)
              .backgroundColor(workout.iconColor)
              .borderRadius(SHAPE_MEDIUM)
              Column({ space: SP_XS }) {
                Text(workout.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ON_SURFACE)
                Row({ space: SP_LG }) {
                  Text(workout.duration)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#B30F172A')
                  Text(workout.calories)
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor('#B30F172A')
                }
              }
              .layoutWeight(1)
              Button() {
                Text('Start')
                  .fontSize(10)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(ON_PRIMARY)
              }
              .width(70)
              .height(32)
              .backgroundColor(PRIMARY)
              .borderRadius(SHAPE_SMALL)
              .onClick(() => {})
            }
            .width('100%')
            .padding(SP_MD)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(SURFACE)
            .borderRadius(SHAPE_MEDIUM)
            .shadow({ radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 })
          }, (workout: Workout) => workout.id.toString())
        }
        .width('100%')
        .padding({ left: SP_MD, right: SP_MD, bottom: SP_XXXL })
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom navigation bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: SP_XS }) {
            Column() {}
            .width(20)
            .height(20)
            .backgroundColor(this.selectedNav === item.id ? PRIMARY : OUTLINE)
            .borderRadius(10)
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(ON_SURFACE)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .padding({ top: SP_MD, bottom: SP_MD })
          .onClick(() => { this.selectedNav = item.id; })
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .backgroundColor(SURFACE)
      .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
