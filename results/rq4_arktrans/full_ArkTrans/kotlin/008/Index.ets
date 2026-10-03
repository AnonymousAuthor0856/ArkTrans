@Entry
@Component
struct Index {
  @State selectedNav: number = 0

  // Mock Data based on screenshot
  private metrics = [
    { value: '72', title: 'Heart', color: '#EC4899' },
    { value: '842', title: 'Steps', color: '#6366F1' },
    { value: '7.2', title: 'Sleep', color: '#10B981' },
    { value: '420', title: 'Calories', color: '#EF4444' }
  ]

  private workouts = [
    { name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: '#6366F1' },
    { name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: '#EC4899' }
  ]

  private navItems = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List({ space: 12 }) {
        // === Card (Hero) ===
        ListItem() {
          Column({ space: 4 }) {
            Text('Good Morning!')
              .fontSize(18)
              .fontColor('#FFFFFF')
            
            Text('Ready for your workout?')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
            
            Button('Start Workout')
              .width('100%')
              .height(44)
              .backgroundColor('#FFFFFF')
              .fontColor('#6366F1')
              .borderRadius(12)
              .fontWeight(FontWeight.Medium)
          }
          .padding(16)
          .width('100%')
          .backgroundColor('#6366F1')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
        }

        // === Section Title ===
        ListItem() {
          Text("Today's Metrics")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .margin({ left: 4 })
        }

        // === Metrics Row ===
        ListItem() {
          Row({ space: 8 }) {
            ForEach(this.metrics, (metric: any) => {
              Column({ space: 2 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle({ width: 36, height: 36 })
                    .fill(metric.color)
                }
                
                Text(metric.value)
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0F172A')
                
                Text(metric.title)
                  .fontSize(14)
                  .fontColor('#64748B')
              }
              .alignItems(HorizontalAlign.Center)
              .justifyContent(FlexAlign.Center)
              .width('25%')
              .height(110)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }, (item: any) => item.value)
          }
          .width('100%')
        }

        // === Recent Workouts Header ===
        ListItem() {
          Row() {
            Text('Recent Workouts')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')
              .layoutWeight(1)
              .margin({ left: 4 })
            
            Text('View All')
              .fontSize(14)
              .fontColor('#6366F1')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }

        // === Workouts List ===
        ForEach(this.workouts, (workout: any) => {
          ListItem() {
            Row({ space: 8 }) {
              // Icon Box
              Stack({ alignContent: Alignment.Center }) {
                Rect({ width: 44, height: 44 })
                  .fill(workout.iconColor)
                  .borderRadius(12)
              }
              
              // Info
              Column({ space: 2 }) {
                Text(workout.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                
                Row({ space: 12 }) {
                  Text(workout.duration)
                    .fontSize(14)
                    .fontColor('#64748B')
                  
                  Text(workout.calories)
                    .fontSize(14)
                    .fontColor('#64748B')
                }
              }
              .layoutWeight(1)
              
              // Action Button
              Button('Star')
                .width(70)
                .height(32)
                .backgroundColor('#6366F1')
                .fontColor('#FFFFFF')
                .borderRadius(8)
                .fontSize(12)
            }
            .alignItems(VerticalAlign.Center)
            .padding(8)
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
          }
        }, (item: any) => item.name)
        
        // Bottom Spacer for scrolling
        ListItem() {
          Blank().height(80)
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .backgroundColor('#F8FAFC')

      // === Top App Bar ===
      Column() {
        Text('Health Dashboard')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.End)
      .padding({ bottom: 10 })

      // === Navigation Bar ===
      Row({ space: 0 }) {
        ForEach(this.navItems, (item: any) => {
          Column({ space: 4 }) {
            Stack({ alignContent: Alignment.Center }) {
              if (this.selectedNav === item.id) {
                Capsule({ width: 56, height: 32 })
                  .fill('#E0E7FF')
              }
              
              Circle({ width: 20, height: 20 })
                .fill(this.selectedNav === item.id ? '#6366F1' : '#CBD5E1')
            }
            
            Text(item.label)
              .fontSize(14)
              .fontColor(this.selectedNav === item.id ? '#0F172A' : '#64748B')
              .fontWeight(this.selectedNav === item.id ? FontWeight.Medium : FontWeight.Normal)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedNav = item.id
          })
        }, (item: any) => item.label)
      }
      .width('100%')
      .height(70)
      .position({ x: 0, y: '100%' })
      .translate({ y: -30 })
      .backgroundColor('#F8FAFC')
      .borderRadius(20)
      .margin({ left: 16, right: 16 })
      .shadow({ radius: 10, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}