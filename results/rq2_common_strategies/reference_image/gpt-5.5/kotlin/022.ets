class TaskModel {
  name: string = ''
  progress: number = 0

  constructor(name: string, progress: number) {
    this.name = name
    this.progress = progress
  }
}

class AppColors {
  static readonly primary: string = '#38BDF8'
  static readonly secondary: string = '#6366F1'
  static readonly tertiary: string = '#A5B4FC'
  static readonly background: string = '#F1F5F9'
  static readonly surface: string = '#FFFFFF'
  static readonly glassSurface: string = '#B3FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#D1D5DB'
  static readonly onSurface: string = '#1E1E1E'
  static readonly onPrimary: string = '#FFFFFF'
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true

  private tasks: TaskModel[] = [
    new TaskModel('Design Phase', 0.8),
    new TaskModel('Development', 0.5),
    new TaskModel('Testing', 0.3),
    new TaskModel('Documentation', 0.6),
    new TaskModel('Deployment', 0.2)
  ]

  @Builder
  private ProgressBar(progress: number) {
    Row() {
      Row() {
      }
      .height(8)
      .layoutWeight(progress)
      .borderRadius(4)
      .backgroundColor(AppColors.secondary)

      Row() {
      }
      .height(8)
      .layoutWeight(1 - progress)
      .borderRadius(4)
      .backgroundColor(AppColors.surfaceVariant)
      .margin({ left: 4 })

      Row() {
      }
      .width(8)
      .height(8)
      .borderRadius(4)
      .backgroundColor(AppColors.secondary)
      .margin({ left: 4 })
    }
    .width('100%')
    .height(10)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private TaskCard(task: TaskModel) {
    Column({ space: 8 }) {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      this.ProgressBar(task.progress)
    }
    .width('100%')
    .padding(12)
    .borderRadius(16)
    .backgroundColor(AppColors.glassSurface)
    .shadow({
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column() {
      Column() {
        Text('Project Timeline')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      Column({ space: 16 }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Row() {
          }
          .width(52)
          .height(32)
          .borderRadius(16)
          .backgroundColor(this.notificationsEnabled ? AppColors.primary : AppColors.surfaceVariant)
          .onClick(() => {
            this.notificationsEnabled = !this.notificationsEnabled
          })
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Column({ space: 12 }) {
          ForEach(this.tasks, (task: TaskModel) => {
            this.TaskCard(task)
          }, (task: TaskModel) => task.name)
        }
        .width('100%')

        Button() {
          Text('Add Task')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width('100%')
        .height(52)
        .borderRadius(16)
        .backgroundColor(AppColors.primary)
        .stateEffect(true)
        .margin({ top: 18 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: 16,
        right: 16,
        top: 16,
        bottom: 16
      })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CCFFFFFF', 0.0],
          [AppColors.background, 0.5],
          ['#CCFFFFFF', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}