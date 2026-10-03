```ts
import { Task } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  private tasks: Array<{ name: string, progress: number }> = [
    { name: "Design Phase", progress: 0.8 },
    { name: "Development", progress: 0.5 },
    { name: "Testing", progress: 0.3 },
    { name: "Documentation", progress: 0.6 },
    { name: "Deployment", progress: 0.2 }
  ];

  @Builder
  TaskCard(task: { name: string, progress: number }) {
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
    .backgroundColor('#B3FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Project Timeline')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
      .backgroundColor('#F1F5F9')

      // Main content
      Column({ space: 16 }) {
        // Notifications row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
            .selectedColor('#38BDF8')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Task list
        List({ space: 12 }) {
          ForEach(this.tasks, (task: { name: string, progress: number }) => {
            ListItem() {
              this.TaskCard(task)
            }
          }, (task: { name: string, progress: number }) => task.name)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Add Task button
        Button('Add Task')
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#38BDF8')
          .borderRadius(16)
      }
      .width('100%')
      .height('100%')
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