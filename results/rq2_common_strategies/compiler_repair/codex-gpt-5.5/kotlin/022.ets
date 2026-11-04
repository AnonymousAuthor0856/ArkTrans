class TimelineTask {
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.name = name;
    this.progress = progress;
  }
}

class TimelineColors {
  static primary: string = '#38BDF8';
  static secondary: string = '#6366F1';
  static background: string = '#F1F5F9';
  static surface: string = '#FFFFFF';
  static translucentSurface: string = '#B3FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#D1D5DB';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;

  private tasks: TimelineTask[] = [
    new TimelineTask('Design Phase', 80),
    new TimelineTask('Development', 50),
    new TimelineTask('Testing', 30),
    new TimelineTask('Documentation', 60),
    new TimelineTask('Deployment', 20)
  ];

  @Builder
  TaskCard(task: TimelineTask) {
    Column() {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(TimelineColors.primary)
        .lineHeight(24)
        .width('100%')
      Progress({ value: task.progress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(TimelineColors.secondary)
        .backgroundColor(TimelineColors.surfaceVariant)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(TimelineColors.translucentSurface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(TimelineColors.onSurface)
        .lineHeight(32)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(TimelineColors.onSurface)
            .lineHeight(24)
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(TimelineColors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column() {
            ForEach(this.tasks, (task: TimelineTask) => {
              this.TaskCard(task)
            }, (task: TimelineTask) => task.name)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 16 })

        Button('Add Task')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(TimelineColors.onPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(TimelineColors.primary)
          .borderRadius(16)
          .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[TimelineColors.translucentSurface, 0.0], [TimelineColors.background, 0.5], [TimelineColors.translucentSurface, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(TimelineColors.background)
  }
}
