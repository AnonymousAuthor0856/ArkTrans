// HealthDashboard.ets

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

  private metrics: HealthMetric[] = [
    { id: 1, title: "Heart", value: "72", unit: "bpm", color: '#EC4899' },
    { id: 2, title: "Steps", value: "842", unit: "steps", color: '#6366F1' },
    { id: 3, title: "Sleep", value: "7.2", unit: "hours", color: '#10B981' },
    { id: 4, title: "Calories", value: "420", unit: "kcal", color: '#EF4444' }
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
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Text("Health Dashboard")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 40, bottom: 20 })

        Scroll() {
          Column() {
            // Hero Card
            Column({ space: 4 }) {
              Text("Good Morning!")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
              
              Text("Ready for your workout?")
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#FFFFFF')

              Button("Start Workout") {
                // Action
              }
              .backgroundColor('#FFFFFF')
              .fontColor('#6366F1')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(12)
              .height(44)
              .margin({ top: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(16)
            .backgroundColor('#6366F1')
            .borderRadius(16)
            .shadow({ radius: 12, color: 'rgba(0,0,0,0.22)', offsetY: 3 })
            .margin({ bottom: 12 })

            // Section Title
            Text("Today's Metrics")
              .fontSize(14)
              .fontColor('#0F172A')
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ left: 4, right: 4, bottom: 8 })

            // Metrics Row
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
              ForEach(this.metrics, (metric: HealthMetric) => {
                Column({ space: 2 }) {
                  Circle()
                    .fill(metric.color as string)
                    .width(36)
                    .height(36)
                  
                  Text(metric.value)
                    .fontSize(20)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor('#0F172A')
                  
                  Text(metric.title)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0F172A')
                    .opacity(0.7)
                }
                .width('23%')
                .justifyContent(FlexAlign.Start)
                .alignItems(HorizontalAlign.Start)
                .padding(8)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 2 })
              }, (item: HealthMetric) => item.id.toString())
            }
            .width('100%')
            .margin({ bottom: 12 })

            // Recent Workouts Header
            Row() {
              Text("Recent Workouts")
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#0F172A')
              
              Blank()
              
              Button("View All") {
                // Action
              }
              .fontColor('#6366F1')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(Color.Transparent)
              .margin({ right: 20 })
            }
            .width('100%')
            .margin({ top: 10, bottom: 10 })

            // Workouts List
            ForEach(this.workouts, (workout: Workout) => {
              Row({ space: 8 }) {
                // Icon Box
                Rectangle()
                  .fill(workout.iconColor as string)
                  .width(44)
                  .height(44)
                  .borderRadius(12)

                // Info
                Column({ space: 2 }) {
                  Text(workout.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0F172A')
                  
                  Row({ space: 12 }) {
                    Text(workout.duration)
                      .fontSize(14)
                      .fontColor('#0F172A')
                      .opacity(0.7)
                    
                    Text(workout.calories)
                      .fontSize(14)
                      .fontColor('#0F172A')
                      .opacity(0.7)
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)
                .justifyContent(FlexAlign.Center)

                // Start Button
                Button("Start") {
                  // Action
                }
                .width(70)
                .height(32)
                .fontSize(10)
                .backgroundColor('#6366F1')
                .fontColor('#FFFFFF')
                .borderRadius(8)
              }
              .width('100%')
              .padding(12)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.15)', offsetY: 1 })
              .margin({ bottom: 12 })
            }, (item: Workout) => item.id.toString())
            
            // Spacer for bottom bar
            Column().height(80)
          }
          .padding({ left: 8, right: 8 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')

      // Bottom Navigation
      Row({ space: 8 }) {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: 2 }) {
            Circle()
              .fill(this.selectedNav === item.id ? '#6366F1' : '#E2E8F0')
              .width(20)
              .height(20)
            
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
          .onClick(() => {
            this.selectedNav = item.id
          })
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 2 })
      .margin({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}