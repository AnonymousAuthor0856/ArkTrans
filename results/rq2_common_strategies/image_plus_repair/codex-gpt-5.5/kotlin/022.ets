interface Task {
  name: string;
  progress: number;
}

@Entry
@Component
struct MainPage {
  @State notificationsEnabled: boolean = true;

  private readonly tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ];

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 34, bottom: 82 });

      Row() {
        Text('Notifications')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E1E1E');

        Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
          .selectedColor('#38BDF8')
          .switchPointColor('#38BDF8')
          .width(104)
          .height(52)
          .onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn;
          });
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 48 });

      Column() {
        ForEach(this.tasks, (task: Task) => {
          this.taskCard(task);
        }, (task: Task) => task.name);
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)

      Button('Add Task', { type: ButtonType.Capsule })
        .width('100%')
        .height(104)
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FFFFFF')
        .backgroundColor('#38BDF8')
        .margin({ top: 32, bottom: 54 })
        .onClick(() => {});
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor('#F1F5F9');
  }

  @Builder
  taskCard(task: Task) {
    Column() {
      Text(task.name)
        .fontSize(36)
        .fontWeight(FontWeight.Medium)
        .fontColor('#38BDF8')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 16 });

      Stack() {
        Row()
          .width('100%')
          .height(16)
          .borderRadius(8)
          .backgroundColor('#E2E8F0');

        Row()
          .width(`${task.progress * 100}%`)
          .height(16)
          .borderRadius(8)
          .backgroundColor('#6366F1')
          .alignSelf(ItemAlign.Start);

        Circle()
          .width(8)
          .height(8)
          .fill('#6366F1')
          .position({ right: 0 });
      }
      .width('100%')
      .height(16)
      .alignContent(Alignment.Center)
      .margin({ bottom: 2 });
    }
    .width('100%')
    .height(122)
    .padding({ left: 24, right: 24, top: 24, bottom: 20 })
    .backgroundColor('#FFFFFF')
    .borderRadius(28)
    .shadow({
      radius: 10,
      color: '#26000000',
      offsetX: 0,
      offsetY: 4
    })
    .margin({ bottom: 24 });
  }
}
