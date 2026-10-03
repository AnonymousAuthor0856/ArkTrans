// Color tokens
const ColorPrimary: string = '#38BDF8';
const ColorSecondary: string = '#6366F1';
const ColorBackground: string = '#F1F5F9';
const ColorSurface: string = '#FFFFFF';
const ColorSurfaceVariant: string = '#E2E8F0';
const ColorOnPrimary: string = '#FFFFFF';
const ColorOnSurface: string = '#1E1E1E';

interface TaskItem {
  id: string;
  name: string;
  progress: number;
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
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // Top App Bar
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorOnSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 48, bottom: 16 })
        .backgroundColor(ColorBackground)

      // Main content area with gradient background
      Column({ space: 16 }) {
        // Notifications toggle row
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnSurface)

          Blank()

          this.CustomSwitch()
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        // Task list
        Scroll() {
          Column({ space: 12 }) {
            ForEach(this.tasks, (task: TaskItem) => {
              this.TaskCard(task)
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
          .fontColor(ColorOnPrimary)
          .width('100%')
          .height(52)
          .backgroundColor(ColorPrimary)
          .borderRadius(16)
          .onClick(() => {
            console.log('Add Task button tapped!');
          })
      }
      .padding(16)
      .layoutWeight(1)
      .width('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CCffffff', 0.0],
          [ColorBackground, 0.5],
          ['#CCffffff', 1.0],
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorBackground)
  }

  @Builder
  CustomSwitch() {
    Stack() {
      Row()
        .width(51)
        .height(31)
        .borderRadius(15.5)
        .backgroundColor(this.notificationsEnabled ? ColorPrimary : ColorSurfaceVariant)

      Row()
        .width(27)
        .height(27)
        .borderRadius(13.5)
        .backgroundColor(this.notificationsEnabled ? ColorPrimary : ColorSurface)
        .shadow({ radius: 2, color: '#33000000', offsetX: 0, offsetY: 1 })
        .position({
          x: this.notificationsEnabled ? 22 : 2,
          y: 2
        })
        .animation({
          duration: 200,
          curve: Curve.EaseInOut
        })
    }
    .width(51)
    .height(31)
    .onClick(() => {
      this.notificationsEnabled = !this.notificationsEnabled;
    })
  }

  @Builder
  TaskCard(task: TaskItem) {
    Column({ space: 8 }) {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorPrimary)
        .width('100%')

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(8)
          .borderRadius(4)
          .backgroundColor(ColorSurfaceVariant)

        Row()
          .width(`${task.progress * 100}%`)
          .height(8)
          .borderRadius(4)
          .backgroundColor(ColorSecondary)
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
  }
}