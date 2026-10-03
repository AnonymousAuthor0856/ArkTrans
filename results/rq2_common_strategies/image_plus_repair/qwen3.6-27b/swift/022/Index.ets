// entry/src/main/ets/viewpages/MainPage.ets

@Entry
@Component
struct ProjectTimeline {
  // State variables
  @State notificationsEnabled: boolean = true;
  @State tasks: TaskItem[] = [
    new TaskItem("Design Phase", 0.8),
    new TaskItem("Development", 0.5),
    new TaskItem("Testing", 0.3),
    new TaskItem("Documentation", 0.6),
    new TaskItem("Deployment", 0.2)
  ];

  build() {
    Column() {
      // Header Section
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 40, bottom: 20 }) // Adjusted for status bar space simulation

      // Main Content Area
      Column() {
        // Notifications Row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          
          Blank()

          // Custom Switch Component wrapped in a clickable container
          Stack() {
            this.CustomSwitch(this.notificationsEnabled)
          }
          .hitTestBehavior(HitTestMode.Transparent)
          .gesture(
            TapGesture()
              .onAction(() => {
                this.notificationsEnabled = !this.notificationsEnabled;
              })
          )
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        // Task List
        List({ space: 12 }) {
          ForEach(this.tasks, (task: TaskItem) => {
            ListItem() {
              Column() {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#38BDF8') // Primary Color
                  .margin({ bottom: 8 })
                
                // Progress Bar
                Row() {
                  // Background Track
                  Row()
                    .height(8)
                    .width('100%')
                    .backgroundColor('#E2E8F0') // Surface Variant
                    .borderRadius(4)
                  
                  // Foreground Progress
                  Row()
                    .height(8)
                    .width(`${task.progress * 100}%`)
                    .backgroundColor('#6366F1') // Secondary Color
                    .borderRadius(4)
                }
                .width('100%')
                .clip(true)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .borderRadius(16)
              .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.08)', offsetY: 4 })
            }
          }, (item: TaskItem) => item.name)
        }
        .width('100%')
        .layoutWeight(1) // Takes up remaining space
        .padding({ left: 16, right: 16 })
        .listDirection(Axis.Vertical)
        .divider({ strokeWidth: 0 }) // Remove default dividers

        // Add Task Button
        Button('Add Task')
          .type(ButtonType.Capsule)
          .backgroundColor('#38BDF8') // Primary Color
          .fontColor(Color.White)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .height(52)
          .width('100%')
          .margin({ top: 24, bottom: 24 })
          .onClick(() => {
            console.info('Add Task clicked');
          })

      }
      .width('100%')
      .backgroundColor('#F1F5F9') // Background Color
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }

  // Helper component for the custom switch to match the visual style
  @Builder
  CustomSwitch(isOn: boolean) {
    Row() {
      if (isOn) {
        Circle()
          .width(27)
          .height(27)
          .backgroundColor(Color.White)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
          .position({ x: 22, y: 2 }) // Position thumb to the right
      } else {
        Circle()
          .width(27)
          .height(27)
          .backgroundColor(Color.White)
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
          .position({ x: 2, y: 2 }) // Position thumb to the left
      }
    }
    .width(51)
    .height(31)
    .borderRadius(16)
    .backgroundColor(isOn ? '#38BDF8' : '#E2E8F0') // Primary or SurfaceVariant
  }
}

// Data Model Class
class TaskItem {
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.name = name;
    this.progress = progress;
  }
}