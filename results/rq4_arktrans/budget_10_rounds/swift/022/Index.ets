@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true

  build() {
    Stack() {
      Column() {
        // Header Section
        Text('Project Timeline')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 4, bottom: 12 })
          .backgroundColor('#F1F5F9')

        // Main Content Area
        Column() {
          // Notifications Row
          Row() {
            Text('Notifications')
              .fontSize(18)
              .fontColor('#1E1E1E')
            
            Blank()
            
            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn
              })
              .selectedColor('#38BDF8')
          }
          .width('100%')
          .margin({ bottom: 16 })

          // Scrollable List
          Scroll() {
            Column({ space: 16 }) {
              ForEach([
                { name: 'Design Phase', progress: 0.7 },
                { name: 'Development', progress: 0.4 },
                { name: 'Testing', progress: 0.2 },
                { name: 'Documentation', progress: 0.5 },
                { name: 'Deployment', progress: 0.1 }
              ], (item: TaskItem) => {
                Column() {
                  Text(item.name)
                    .fontSize(18)
                    .fontColor('#38BDF8')
                    .margin({ bottom: 8 })
                  
                  Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
                    .width('100%')
                    .height(8)
                    .color('#6366F1')
                    .backgroundColor('#E2E8F0')
                }
                .width('100%')
                .padding(16)
                .borderRadius(16)
                .backgroundColor('#FFFFFF')
                .shadow({ radius: 8, color: '#1A000000', offsetY: 2 })
              })
            }
            .width('100%')
            .padding({ bottom: 80 }) // Space for button
          }
          .layoutWeight(1)

          // Add Task Button
          Button() {
            Text('Add Task')
              .fontSize(18)
              .fontColor('#FFFFFF')
              .width('100%')
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(52)
          .backgroundColor('#38BDF8')
          .borderRadius(26)
          .margin({ top: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#FFFFFF', 0], ['#F1F5F9', 1]]
        })
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%')
  }
}

interface TaskItem {
  name: string;
  progress: number;
}