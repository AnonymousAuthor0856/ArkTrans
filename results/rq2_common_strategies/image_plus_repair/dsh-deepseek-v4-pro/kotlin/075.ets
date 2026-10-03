interface StudyModule {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'
  private modules: StudyModule[] = [
    { name: 'Clay Resonance', progress: 72, summary: 'Acoustic prototypes' },
    { name: 'Material Memory', progress: 54, summary: 'Tactile journaling' },
    { name: 'Morph Lab', progress: 83, summary: 'Color blending' },
    { name: 'Studio Review', progress: 28, summary: 'Peer critique' }
  ]
  private tasks: TaskItem[] = [
    { title: 'Research layering', duration: '45m' },
    { title: 'Feedback sync', duration: '30m' },
    { title: 'Practice recall', duration: '20m' }
  ]

  @Builder
  TabLabel(name: string, index: number) {
    Text(name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(index === this.selectedTab ? '#C08552' : '#2E251D')
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column({ space: 8 }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2E251D')
      Text(module.summary)
        .fontSize(14)
        .fontColor('#CC2E251D')
      Divider()
        .color('#D4C5B6')
      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E251D')
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#C08552')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .backgroundColor('#E7DDCF')
          .borderRadius(12)
        Row()
          .width(`${module.progress}%`)
          .height(12)
          .backgroundColor('#C08552')
          .borderRadius(12)
      }
      .width('100%')
      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C13')
        .backgroundColor('#C08552')
        .borderRadius(16)
        .onClick(() => {})
    }
    .width('100%')
    .height(220)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
  }

  @Builder
  FocusBoardCard() {
    Column({ space: 8 }) {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2E251D')
      ForEach(this.tasks, (task: TaskItem) => {
        Column({ space: 4 }) {
          Text(task.title)
            .fontSize(14)
            .fontColor('#2E251D')
          Text(task.duration)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#9BB1C8')
        }
        .width('100%')
        .padding(8)
        .backgroundColor('#99E7DDCF')
        .borderRadius(12)
      }, (task: TaskItem) => task.title)
      Button('Add checkpoint')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C13')
        .backgroundColor('#C08552')
        .borderRadius(16)
        .onClick(() => {})
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
  }

  @Builder
  ReflectionCard() {
    Column({ space: 8 }) {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2E251D')
      Text(this.focusNote)
        .fontSize(14)
        .fontColor('#2E251D')
        .padding(12)
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
      Button('Shuffle note')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#2A1C13')
        .backgroundColor('#C08552')
        .borderRadius(16)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique'
        })
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor('#E7DDCF')
    .borderRadius(20)
  }

  build() {
    Column() {
      Row() {
        Text('Back')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E251D')
          .onClick(() => {})
        Text('Study Focus Split')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E251D')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#9BB1C8')
          .onClick(() => {})
      }
      .width('100%')
      .height(64)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      Scroll() {
        Column({ space: 16 }) {
          Tabs({ barPosition: BarPosition.Start, index: this.selectedTab }) {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              TabContent() {
                this.ModuleCard(module)
              }
              .tabBar(this.TabLabel(module.name, index))
            }, (module: StudyModule) => module.name)
          }
          .barHeight(48)
          .barMode(BarMode.Fixed)
          .vertical(false)
          .height(268)
          .onChange((index: number) => {
            this.selectedTab = index
          })

          Row({ space: 12 }) {
            this.FocusBoardCard()
            this.ReflectionCard()
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: 4 }) {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2E251D')
          Text('12:40 Studio')
            .fontSize(14)
            .fontColor('#CC2E251D')
        }
        Button('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2A1C13')
          .backgroundColor('#C08552')
          .borderRadius(16)
          .height(40)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F3EFE6')
  }
}
