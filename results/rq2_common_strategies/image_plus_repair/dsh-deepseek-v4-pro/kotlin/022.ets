interface Task {
  name: string;
  progress: number;
}

@Entry
@Component
struct RootScreen {
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
      Row() {
        Text('Project Timeline')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')

      Column({ space: 16 }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor('#38BDF8')
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        List({ space: 12 }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              Column({ space: 8 }) {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#38BDF8')
                Progress({ value: task.progress * 100, total: 100, type: ProgressType.Linear })
                  .width('100%')
                  .height(8)
                  .color('#6366F1')
                  .backgroundColor('#E2E8F0')
              }
              .width('100%')
              .padding(12)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .borderRadius(16)
            .backgroundColor('#B3FFFFFF')
          }, (task: Task) => task.name)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Auto)

        Button('Add Task')
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#38BDF8')
          .borderRadius(16)
          .onClick(() => {
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#CCFFFFFF', 0.0], ['#F1F5F9', 0.5], ['#CCFFFFFF', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
