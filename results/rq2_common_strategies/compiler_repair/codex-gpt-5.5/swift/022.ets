class TimelineTask {
  name: string
  progress: number

  constructor(name: string, progress: number) {
    this.name = name
    this.progress = progress
  }
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true

  private cPrimary: string = '#38BDF8'
  private cSecondary: string = '#6366F1'
  private cTertiary: string = '#A5B4FC'
  private cBackground: string = '#F1F5F9'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E2E8F0'
  private cOutline: string = '#D1D5DB'
  private cText: string = '#1E1E1E'
  private tasks: TimelineTask[] = [
    new TimelineTask('Design Phase', 0.8),
    new TimelineTask('Development', 0.5),
    new TimelineTask('Testing', 0.3),
    new TimelineTask('Documentation', 0.6),
    new TimelineTask('Deployment', 0.2)
  ]

  @Builder
  ProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(8)
        .radius(4)
        .fill(this.cSurfaceVariant)
      Rect()
        .width((progress * 100).toString() + '%')
        .height(8)
        .radius(4)
        .fill(this.cSecondary)
    }
    .width('100%')
    .height(8)
  }

  @Builder
  TaskCard(task: TimelineTask) {
    Column() {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cPrimary)
        .width('100%')
        .margin({ bottom: 8 })
      this.ProgressBar(task.progress)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .margin({ bottom: 12 })
  }

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cText)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 24, bottom: 16 })
        .backgroundColor(this.cBackground)

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .onChange((value: boolean) => {
              this.notificationsEnabled = value
            })
        }
        .width('100%')
        .margin({ bottom: 16 })

        Scroll() {
          Column() {
            ForEach(this.tasks, (task: TimelineTask) => {
              this.TaskCard(task)
            }, (task: TimelineTask) => task.name)
          }
        }
        .layoutWeight(1)

        Button('Add Task')
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .backgroundColor(this.cPrimary)
          .borderRadius(16)
          .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
