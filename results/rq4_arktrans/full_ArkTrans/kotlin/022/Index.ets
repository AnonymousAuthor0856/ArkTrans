interface Task {
  name: string;
  progress: number;
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true
  @State tasks: Array<Task> = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.4 },
    { name: 'Testing', progress: 0.25 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.15 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Row({ space: 0 }) {
          Text('Notifications')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn
            })
        }.alignItems(VerticalAlign.Center).width('100%')

        List({ space: 12 }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              Column({ space: 8 }) {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#38BDF8')
                
                Progress({ 
                  value: task.progress * 100, 
                  total: 100, 
                  type: ProgressType.Linear 
                })
                  .width('100%')
                  .height(8)
                  .color('#6366F1')
                  .backgroundColor('#E2E8F0')
              }
              .width('100%')
              .padding(12)
            }
            .shadow({ radius: 4, color: '#1A000000' })
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .width('100%')
          }, (item: Task) => item.name)
        }.width('100%')

        Button() {
          Text('Add Task')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .height(52)
        .backgroundColor('#38BDF8')
        .borderRadius(26)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 90,
        colors: [['#F1F5F9', 0], ['#FFFFFF', 0.5], ['#F1F5F9', 1]]
      })

      Text('Project Timeline')
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .position({ x: 0, y: 0 })
        .width('100%')
        .height(60)
        .margin({ bottom: 16 })
    }
    .width('100%')
    .height('100%')
  }
}