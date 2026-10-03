@Entry
@Component
struct Index {
  @State selectedNav: number = 0

  // Mock data interfaces to satisfy type safety rules
  interface MetricItem {
    value: string;
    title: string;
    color: string;
  }

  interface WorkoutItem {
    name: string;
    duration: string;
    calories: string;
    iconColor: string;
  }

  interface NavItem {
    id: number;
    label: string;
  }

  // Mock data arrays
  private metrics: MetricItem[] = [
    { value: '120', title: 'Steps', color: '#E3F2FD' },
    { value: '85', title: 'HR', color: '#FFEBEE' },
    { value: '7h', title: 'Sleep', color: '#E8F5E9' }
  ];

  private workouts: WorkoutItem[] = [
    { name: 'Morning Run', duration: '30 min', calories: '320 kcal', iconColor: '#FFF3E0' },
    { name: 'Yoga Flow', duration: '45 min', calories: '180 kcal', iconColor: '#F3E5F5' }
  ];

  private navItems: NavItem[] = [
    { id: 0, label: 'Home' },
    { id: 1, label: 'Stats' },
    { id: 2, label: 'Profile' }
  ];

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (LazyColumn equivalent) ===
      List({ space: 12 }) {
        // === Card: Good Morning ===
        ListItem() {
          Column() {
            Column({ space: 4 }) {
              Text('Good Morning!')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
              
              Text('Ready for your workout?')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
              
              Button() {
                Text('Start Workout')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1A237E') // onPrimary approx
              }
              .width('100%')
              .height(44)
              .backgroundColor('#FFFFFF') // containerColor = onPrimary
              .borderRadius(8)
              .borderWidth(0)
            }
            .padding(16)
          }
          .width('100%')
          .backgroundColor('#1A237E') // Primary Color
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        }

        // === Text: Today's Metrics ===
        ListItem() {
          Text("Today's Metrics")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .padding({ left: 8, right: 8 })
        }

        // === Row: Metrics Grid ===
        ListItem() {
          Row({ space: 8 }) {
            ForEach(this.metrics, (item: MetricItem) => {
              Column() {
                Column({ space: 2 }) {
                  // Box with background color
                  Stack({ alignContent: Alignment.Center }) {
                    Circle()
                      .width(36)
                      .height(36)
                      .fill(item.color)
                  }
                  
                  Text(item.value)
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#0F172A')
                  
                  Text(item.title)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0F172A')
                }
                .alignItems(HorizontalAlign.Center)
                .padding(8)
              }
              .layoutWeight(1)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            })
          }
          .width('100%')
        }

        // === Row: Recent Workouts Header ===
        ListItem() {
          Row() {
            Text('Recent Workouts')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0F172A')
            
            Blank()
            
            Button() {
              Text('View All')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1A237E') // Primary
            }
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }

        // === Card: Recent Workouts List ===
        ForEach(this.workouts, (workout: WorkoutItem) => {
          ListItem() {
            Column() {
              Row({ space: 8 }) {
                // Icon Box
                Stack({ alignContent: Alignment.Center }) {
                  Rect()
                    .width(44)
                    .height(44)
                    .fill(workout.iconColor)
                    .borderRadius(8)
                }
                
                // Info Column
                Column({ space: 2 }) {
                  Text(workout.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0F172A')
                  
                  Row({ space: 12 }) {
                    Text(workout.duration)
                      .fontSize(14)
                      .fontColor('#0F172A')
                    
                    Text(workout.calories)
                      .fontSize(14)
                      .fontColor('#0F172A')
                  }
                }
                .layoutWeight(1)
                
                // Start Button
                Button() {
                  Text('Start')
                    .fontSize(12)
                    .fontColor('#FFFFFF')
                }
                .height(32)
                .width(70)
                .backgroundColor('#1A237E') // Primary
                .borderRadius(4)
              }
              .alignItems(VerticalAlign.Center)
              .padding(8)
            }
            .width('100%')
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          }
        })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 8, right: 8, bottom: 80 }) // Bottom padding for NavBar

      // === Top App Bar ===
      Row() {
        Text('Health Dashboard')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })

      // === Navigation Bar ===
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(20)
                .height(20)
                .fill(this.selectedNav === item.id ? '#1A237E' : '#9CA3AF')
            }
            
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? '#1A237E' : '#9CA3AF')
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedNav = item.id
          })
        })
      }
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -60 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}