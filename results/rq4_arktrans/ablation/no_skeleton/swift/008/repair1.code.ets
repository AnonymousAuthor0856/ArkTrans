@Entry
@Component
struct HealthDashboardAppView {
  @State selectedNav: number = 0

  interface MetricItem {
    id: number;
    title: string;
    value: string;
    unit: string;
    color: string;
  }

  private readonly metrics: Array<MetricItem> = [
    { id: 1, title: "Heart", value: "72", unit: "bpm", color: '#EC4899' },
    { id: 2, title: "Steps", value: "842", unit: "steps", color: '#6366F1' },
    { id: 3, title: "Sleep", value: "7.2", unit: "hours", color: '#10B981' },
    { id: 4, title: "Calories", value: "420", unit: "kcal", color: '#EF4444' }
  ]

  interface WorkoutItem {
    id: number;
    name: string;
    duration: string;
    calories: string;
    iconColor: string;
  }

  private readonly workouts: Array<WorkoutItem> = [
    { id: 1, name: "Morning Run", duration: "32 min", calories: "284 kcal", iconColor: '#6366F1' },
    { id: 2, name: "Yoga Flow", duration: "45 min", calories: "156 kcal", iconColor: '#EC4899' },
    { id: 3, name: "Strength Training", duration: "28 min", calories: "320 kcal", iconColor: '#10B981' }
  ]

  interface NavItem {
    id: number;
    label: string;
  }

  private readonly navItems: Array<NavItem> = [
    { id: 0, label: "Dashboard" },
    { id: 1, label: "Workouts" },
    { id: 2, label: "Nutrition" },
    { id: 3, label: "Profile" }
  ]

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

        // Scrollable Content
        Scroll() {
          Column({ space: 12 }) {
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

              Button({ type: ButtonType.Capsule, stateEffect: true }) {
                Text("Start Workout")
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#6366F1')
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .height(44)
              .width('100%')
            }
            .padding(16)
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .backgroundColor('#6366F1')
            .borderRadius(16)
            .shadow({ radius: 12, color: 'rgba(0,0,0,0.22)', offsetY: 3 })

            // Section Title
            Text("Today's Metrics")
              .fontSize(14)
              .fontColor('#0F172A')
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ left: 4, right: 4 })

            // Metrics Row
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
              ForEach(this.metrics, (metric: MetricItem) => {
                Flex({ alignItems: ItemAlign.Start }) {
                  Column({ space: 2 }) {
                    Circle()
                      .width(36)
                      .height(36)
                      .fill(metric.color)
                    
                    Text(metric.value)
                      .fontSize(20)
                      .fontWeight(FontWeight.SemiBold)
                      .fontColor('#0F172A')
                    
                    Text(metric.title)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('rgba(15, 23, 42, 0.7)')
                  }
                  Blank().layoutWeight(1)
                }
                .padding(8)
                .width('23%')
                .justifyContent(FlexAlign.Start)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 2 })
              }, (item: MetricItem) => item.id.toString())
            }
            .width('100%')

            // Recent Workouts Header
            Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
              Text("Recent Workouts")
                .fontSize(20)
                .fontWeight(FontWeight.SemiBold)
                .fontColor('#0F172A')
              
              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text("View All")
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#6366F1')
              }
              .backgroundColor(Color.Transparent)
              .padding({ right: 20 })
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 })

            // Workouts List
            ForEach(this.workouts, (workout: WorkoutItem) => {
              Flex({ alignItems: ItemAlign.Center }) {
                // Icon Box
                Rect()
                  .width(44)
                  .height(44)
                  .borderRadius(12)
                  .fill(workout.iconColor)

                // Text Info
                Column({ space: 2 }) {
                  Text(workout.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0F172A')
                  
                  Flex({ alignItems: ItemAlign.Center }) {
                    Text(workout.duration)
                      .fontSize(14)
                      .fontColor('rgba(15, 23, 42, 0.7)')
                    
                    Text(workout.calories)
                      .fontSize(14)
                      .fontColor('rgba(15, 23, 42, 0.7)')
                      .margin({ left: 12 })
                  }
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                // Start Button
                Button({ type: ButtonType.Capsule, stateEffect: true }) {
                  Text("Start")
                    .fontSize(10)
                    .fontColor('#FFFFFF')
                }
                .backgroundColor('#6366F1')
                .borderRadius(8)
                .width(70)
                .height(32)
              }
              .padding(12)
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.15)', offsetY: 1 })
              .margin({ bottom: 12 })
            }, (item: WorkoutItem) => item.id.toString())
            
            // Spacer for bottom nav
            Blank().height(92)
          }
          .padding({ left: 8, right: 8 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')

      // Bottom Navigation
      Flex({ justifyContent: FlexAlign.SpaceAround, alignItems: ItemAlign.Center }) {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: 2 }) {
            Circle()
              .width(20)
              .height(20)
              .fill(this.selectedNav === item.id ? '#6366F1' : '#E2E8F0')
            
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
          }
          .onClick(() => {
            this.selectedNav = item.id
          })
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .padding({ top: 4, bottom: 4, left: 8, right: 8 })
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 2 })
      .margin({ left: 8, right: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
  }
}