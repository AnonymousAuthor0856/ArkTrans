interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

const Colors: ColorTokens = {
  primary: '#FF38BDF8',
  secondary: '#FF6366F1',
  tertiary: '#FFA5B4FC',
  background: '#FFF1F5F9',
  surface: '#FFFFFFFF',
  surfaceVariant: '#FFE2E8F0',
  outline: '#FFD1D5DB',
  success: '#FF22C55E',
  warning: '#FFF59E0B',
  error: '#FFEF4444',
  onPrimary: '#FFFFFFFF',
  onSecondary: '#FF1E1E1E',
  onTertiary: '#FF1E1E1E',
  onBackground: '#FF1E1E1E',
  onSurface: '#FF1E1E1E',
}

interface TaskItem {
  id: string
  name: string
  progress: number
}

@Entry
@Component
struct RootScreen {
  @State tasks: TaskItem[] = [
    { id: '1', name: 'Design Phase', progress: 0.8 },
    { id: '2', name: 'Development', progress: 0.5 },
    { id: '3', name: 'Testing', progress: 0.3 },
    { id: '4', name: 'Documentation', progress: 0.6 },
    { id: '5', name: 'Deployment', progress: 0.2 },
  ]
  @State notificationsEnabled: boolean = true

  build() {
    Column() {
      // Top App Bar
      Column() {
        Text('Project Timeline')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 48, bottom: 16 })
      }
      .width('100%')
      .backgroundColor(Colors.background)

      // Main content area with gradient background
      Column({ space: 16 }) {
        // Notifications toggle row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Blank()

          // Custom Toggle Switch
          Stack() {
            // Track
            Row() {
            }
            .width(51)
            .height(31)
            .borderRadius(15.5)
            .backgroundColor(this.notificationsEnabled ? Colors.primary : Colors.surfaceVariant)

            // Thumb
            Row() {
            }
            .width(27)
            .height(27)
            .borderRadius(13.5)
            .backgroundColor(this.notificationsEnabled ? Colors.primary : Colors.surface)
            .shadow({ radius: 2, color: '#33000000', offsetX: 0, offsetY: 1 })
            .position({
              x: this.notificationsEnabled ? 51 - 27 - 2 : 2,
              y: 2
            })
            .animation({ duration: 200, curve: Curve.EaseInOut })
          }
          .width(51)
          .height(31)
          .onClick(() => {
            this.notificationsEnabled = !this.notificationsEnabled
          })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Task list
        Scroll() {
          Column({ space: 12 }) {
            ForEach(this.tasks, (task: TaskItem) => {
              Column({ space: 8 }) {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.primary)
                  .width('100%')
                  .textAlign(TextAlign.Start)

                // Custom Progress Bar
                Stack({ alignContent: Alignment.Start }) {
                  // Track
                  Row() {
                  }
                  .width('100%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(Colors.surfaceVariant)

                  // Progress
                  Row() {
                  }
                  .width(`${task.progress * 100}%`)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(Colors.secondary)
                }
                .width('100%')
                .height(8)
              }
              .padding(12)
              .width('100%')
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#B3FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
            }, (task: TaskItem) => task.id)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Add Task Button
        Button('Add Task')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(Colors.primary)
          .borderRadius(16)
          .onClick(() => {
            console.log('Add Task button tapped!')
          })
      }
      .padding(16)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CCF8FAFC', 0.0],
          ['#FFF1F5F9', 0.5],
          ['#CCF8FAFC', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}