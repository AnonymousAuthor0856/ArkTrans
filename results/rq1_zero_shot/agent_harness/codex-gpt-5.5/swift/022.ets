class TaskItem {
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.name = name;
    this.progress = progress;
  }
}

@Entry
@Component
struct RootScreen {
  @State private notificationsEnabled: boolean = true;

  private tasks: TaskItem[] = [
    new TaskItem('Design Phase', 0.8),
    new TaskItem('Development', 0.5),
    new TaskItem('Testing', 0.3),
    new TaskItem('Documentation', 0.6),
    new TaskItem('Deployment', 0.2)
  ];

  @Builder
  TaskCard(task: TaskItem) {
    Column() {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#38BDF8')
      Progress({ value: task.progress, total: 1, type: ProgressType.Linear })
        .color('#6366F1')
        .backgroundColor('#E2E8F0')
        .width('100%')
        .height(8)
        .margin({ top: 8 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
    .margin({ bottom: 12 })
  }

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 24, bottom: 16 })
        .backgroundColor('#F1F5F9')

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor('#38BDF8')
            .onChange((value: boolean) => {
              this.notificationsEnabled = value;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column() {
            ForEach(this.tasks, (task: TaskItem) => {
              this.TaskCard(task)
            }, (task: TaskItem) => task.name)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .margin({ top: 16 })

        Button('Add Task')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#38BDF8')
          .width('100%')
          .height(52)
          .borderRadius(16)
          .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#F1F5F9')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
