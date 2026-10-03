@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;
  private tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ];

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 24, bottom: 24 })

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF1E1E1E')
            .layoutWeight(1)

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .selectedColor('#FF38BDF8')
        }
        .width('100%')
        .padding({ bottom: 16, top: 8 })

      }
      .width('100%')
      .padding({ left: 16, right: 16 })

      List({ space: 12 }) {
        ForEach(this.tasks, (task: Task, index: number) => {
          ListItem() {
            this.TaskCard(task)
          }
        }, (task: Task) => task.name)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      Button('Add Task')
        .width('100%')
        .height(52)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFFFF')
        .backgroundColor('#FF38BDF8')
        .borderRadius(24)
        .margin({ left: 16, right: 16, top: 16, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#FFF1F5F9', 0.0],
        ['#FFFFFFFF', 0.5],
        ['#FFF1F5F9', 1.0]
      ]
    })
  }

  @Builder
  TaskCard(task: Task) {
    Column() {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FF38BDF8')
        .width('100%')

      Stack() {
        Row()
          .width('100%')
          .height(8)
          .backgroundColor('#FFE2E8F0')
          .borderRadius(4)

        Row()
          .width(task.progress * 100 + '%')
          .height(8)
          .backgroundColor('#FF6366F1')
          .borderRadius(4)
          .alignSelf(ItemAlign.Start)

        Circle({ width: 8, height: 8 })
          .fill('#FF6366F1')
          .position({ x: task.progress * 100 + '%', y: 0 })
          .translate({ x: -4, y: 0 })
      }
      .width('100%')
      .height(8)
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('rgba(255, 255, 255, 0.7)')
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetY: 2
    })
  }
}

interface Task {
  name: string;
  progress: number;
}
