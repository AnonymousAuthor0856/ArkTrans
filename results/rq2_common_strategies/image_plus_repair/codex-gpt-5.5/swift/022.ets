class ProjectTask {
  name: string
  progress: number

  constructor(name: string, progress: number) {
    this.name = name
    this.progress = progress
  }
}

@Entry
@Component
struct ProjectTimeline {
  @State notificationsEnabled: boolean = true
  private tasks: ProjectTask[] = [
    new ProjectTask('Design Phase', 0.8),
    new ProjectTask('Development', 0.5),
    new ProjectTask('Testing', 0.3),
    new ProjectTask('Documentation', 0.6),
    new ProjectTask('Deployment', 0.2)
  ]

  @Builder
  notificationSwitch() {
    Stack({ alignContent: this.notificationsEnabled ? Alignment.End : Alignment.Start }) {
      Row()
        .width(51)
        .height(31)
        .borderRadius(16)
        .backgroundColor(this.notificationsEnabled ? '#38BDF8' : '#E2E8F0')

      Circle()
        .width(27)
        .height(27)
        .fill(this.notificationsEnabled ? '#38BDF8' : '#FFFFFF')
        .shadow({
          radius: 1,
          color: '#33000000',
          offsetX: 0,
          offsetY: 1
        })
        .margin(2)
    }
    .width(51)
    .height(31)
    .onClick(() => {
      this.notificationsEnabled = !this.notificationsEnabled
    })
  }

  @Builder
  progressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor('#E2E8F0')

      Row()
        .width(`${progress * 100}%`)
        .height(8)
        .borderRadius(4)
        .backgroundColor('#6366F1')
    }
    .width('100%')
    .height(8)
  }

  @Builder
  taskCard(task: ProjectTask) {
    Column({ space: 8 }) {
      Text(task.name)
        .fontSize(18)
        .fontColor('#38BDF8')
        .fontWeight(FontWeight.Medium)
        .width('100%')
        .textAlign(TextAlign.Start)

      this.progressBar(task.progress)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height(61)
    .padding({
      left: 12,
      right: 12,
      top: 12,
      bottom: 12
    })
    .borderRadius(16)
    .backgroundColor('#FDFDFD')
    .shadow({
      radius: 8,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  build() {
    Column() {
      Row() {
        Text('Project Timeline')
          .fontSize(26)
          .fontColor('#1E1E1E')
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F1F5F9')

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontColor('#1E1E1E')
            .fontWeight(FontWeight.Medium)

          Blank()

          this.notificationSwitch()
        }
        .width('100%')
        .height(47)
        .alignItems(VerticalAlign.Center)

        Column({ space: 12 }) {
          ForEach(this.tasks, (task: ProjectTask) => {
            this.taskCard(task)
          }, (task: ProjectTask) => task.name)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Blank()

        Button('Add Task', { type: ButtonType.Normal })
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontColor('#FFFFFF')
          .backgroundColor('#38BDF8')
          .borderRadius(16)
          .onClick(() => {
            console.info('Add Task button tapped')
          })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({
        left: 16,
        right: 16,
        top: 20,
        bottom: 16
      })
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
  }
}
