// HealthDashboard - ArkTS Conversion

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

@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    { id: 1, title: "Heart", value: "72", unit: "bpm", progress: 0.6, color: '#EC4899' },
    { id: 2, title: "Steps", value: "842", unit: "steps", progress: 0.8, color: '#6366F1' },
    { id: 3, title: "Sleep", value: "7.2", unit: "hours", progress: 0.9, color: '#10B981' },
    { id: 4, title: "Calories", value: "420", unit: "kcal", progress: 0.4, color: '#EF4444' }
  ];

  private workouts: Workout[] = [
    { id: 1, name: "Morning Run", duration: "32 min", calories: "284 kcal", iconColor: '#6366F1' },
    { id: 2, name: "Yoga Flow", duration: "45 min", calories: "156 kcal", iconColor: '#EC4899' },
    { id: 3, name: "Strength Training", duration: "28 min", calories: "320 kcal", iconColor: '#10B981' }
  ];

  private navItems: NavItem[] = [
    { id: 0, label: "Dashboard" },
    { id: 1, label: "Workouts" },
    { id: 2, label: "Nutrition" },
    { id: 3, label: "Profile" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Health Dashboard")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.Center)

      // Content List
      Scroll() {
        Column() {
          // Hero Card
          Column() {
            Text("Good Morning!")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .margin({ bottom: 4 })
            Text("Ready for your workout?")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ bottom: 12 })
            Button("Start Workout")
              .type(ButtonType.Capsule)
              .width('100%')
              .height(44)
              .backgroundColor('#FFFFFF')
              .fontColor('#6366F1')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .padding(16)
          .borderRadius(16)
          .backgroundColor('#6366F1')
          .margin({ bottom: 12 })

          // Today's Metrics Title
          Row() {
            Text("Today's Metrics")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')
          }
          .width('100%')
          .padding({ left: 4, bottom: 8 })

          // Metrics Grid
          Row() {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column() {
                Circle({ width: 36, height: 36 })
                  .fill(metric.color)
                  .margin({ bottom: 2 })
                Text(metric.value)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0F172A')
                Text(metric.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#64748B')
              }
              .layoutWeight(1)
              .padding(8)
              .borderRadius(12)
              .backgroundColor('#FFFFFF')
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: 2 })
            })
          }
          .width('100%')
          .margin({ bottom: 12 })

          // Recent Workouts Title
          Row() {
            Text("Recent Workouts")
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')
              .layoutWeight(1)
            Text("View All")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#6366F1')
          }
          .width('100%')
          .padding({ left: 4, right: 4, bottom: 8 })

          // Workouts List
          ForEach(this.workouts, (workout: Workout) => {
            Row() {
              Row() {
                Text("")
                  .width(44)
                  .height(44)
                  .borderRadius(12)
                  .backgroundColor(workout.iconColor)
              }
              .margin({ right: 8 })

              Column() {
                Text(workout.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .margin({ bottom: 2 })
                Row() {
                  Text(workout.duration)
                    .fontSize(14)
                    .fontColor('#64748B')
                    .margin({ right: 12 })
                  Text(workout.calories)
                    .fontSize(14)
                    .fontColor('#64748B')
                }
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button("Start")
                .type(ButtonType.Normal)
                .height(32)
                .width(70)
                .borderRadius(8)
                .backgroundColor('#6366F1')
                .fontColor('#FFFFFF')
                .fontSize(10)
            }
            .width('100%')
            .padding(8)
            .borderRadius(12)
            .backgroundColor('#FFFFFF')
            .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
            .margin({ bottom: 8 })
          })
        }
        .width('100%')
        .padding({ left: 8, right: 8, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Circle({ width: 20, height: 20 })
              .fill(this.selectedNav === item.id ? '#6366F1' : '#E2E8F0')
              .margin({ bottom: 4 })
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? '#6366F1' : '#64748B')
          }
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.selectedNav = item.id;
          })
        })
      }
      .width('100%')
      .height(64)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}