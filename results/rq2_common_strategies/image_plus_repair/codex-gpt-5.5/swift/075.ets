interface StudyModule {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}

interface AppColors {
  primary: string
  secondary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  text: string
  mutedText: string
}

const COLORS: AppColors = {
  primary: '#C08552',
  secondary: '#9BB1C8',
  background: '#F3EFE6',
  surface: '#FFFFFF',
  surfaceVariant: '#E7DDCF',
  outline: '#D4C5B6',
  text: '#2E251D',
  mutedText: '#625950'
}

@Entry
@Component
struct StudyFocusSplit {
  @State selectedTabIndex: number = 0
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

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()
        Scroll() {
          Column({ space: 16 }) {
            this.tabRow()
            this.moduleCard(this.modules[this.selectedTabIndex])
            this.lowerPanes()
            Blank().height(96)
          }
          .padding({ top: 12, bottom: 16 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(COLORS.background)

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }

  @Builder
  topBar() {
    Row() {
      Text('Back')
        .fontSize(16)
        .fontColor(COLORS.text)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {})

      Blank().layoutWeight(1)

      Text('Study Focus Split')
        .fontSize(30)
        .fontColor(COLORS.text)
        .fontWeight(FontWeight.Bold)

      Blank().layoutWeight(1)

      Text('Share')
        .fontSize(16)
        .fontColor(COLORS.secondary)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {})
    }
    .width('100%')
    .height(107)
    .padding({ left: 32, right: 32 })
    .backgroundColor(COLORS.surface)
  }

  @Builder
  tabRow() {
    Row() {
      ForEach(this.modules, (module: StudyModule, index: number) => {
        Column({ space: 8 }) {
          Text(module.name.replace(' ', '\n'))
            .fontSize(18)
            .fontColor(this.selectedTabIndex === index ? COLORS.primary : COLORS.text)
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Center)
            .maxLines(2)
            .lineHeight(24)
            .height(48)
            .width('100%')

          Divider()
            .height(3)
            .color(this.selectedTabIndex === index ? COLORS.primary : '#00000000')
        }
        .width('25%')
        .padding({ top: 8, bottom: 8 })
        .onClick(() => {
          this.selectedTabIndex = index
        })
      }, (module: StudyModule) => module.name)
    }
    .width('100%')
    .padding({ left: 32, right: 32 })
    .backgroundColor(COLORS.surface)
  }

  @Builder
  moduleCard(module: StudyModule) {
    Column({ space: 12 }) {
      Text(module.name)
        .fontSize(30)
        .fontColor(COLORS.text)
        .fontWeight(FontWeight.Bold)

      Text(module.summary)
        .fontSize(22)
        .fontColor(COLORS.mutedText)

      Divider()
        .color(COLORS.outline)
        .height(1)
        .margin({ top: 12, bottom: 12 })

      Row() {
        Text('Progress')
          .fontSize(24)
          .fontColor(COLORS.text)
          .fontWeight(FontWeight.Medium)

        Blank().layoutWeight(1)

        Text(`${module.progress}%`)
          .fontSize(34)
          .fontColor(COLORS.primary)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')

      Stack({ alignContent: Alignment.Start }) {
        Row().width('100%').height(24).borderRadius(14).backgroundColor('#E5DCCD')
        Row()
          .width(`${module.progress}%`)
          .height(24)
          .borderRadius(14)
          .backgroundColor(COLORS.primary)
      }
      .width('100%')

      Blank().height(16)

      Button('Review outline', { type: ButtonType.Normal })
        .fontSize(24)
        .fontColor('#241A12')
        .fontWeight(FontWeight.Medium)
        .width(264)
        .height(76)
        .borderRadius(38)
        .backgroundColor(COLORS.primary)
        .onClick(() => {})
    }
    .width('calc(100% - 64vp)')
    .padding(32)
    .backgroundColor(COLORS.surface)
    .borderRadius(40)
    .shadow({ radius: 10, color: '#180F0815', offsetY: 4, offsetX: 0 })
  }

  @Builder
  lowerPanes() {
    Row({ space: 24 }) {
      Column({ space: 12 }) {
        Text('Focus board')
          .fontSize(30)
          .fontColor(COLORS.text)
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        ForEach(this.tasks, (task: TaskItem) => {
          Column({ space: 4 }) {
            Text(task.title)
              .fontSize(22)
              .fontColor(COLORS.text)
              .alignSelf(ItemAlign.Start)
              .maxLines(1)
            Text(task.duration)
              .fontSize(20)
              .fontColor(COLORS.secondary)
              .alignSelf(ItemAlign.Start)
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#EFE9E0')
          .borderRadius(22)
        }, (task: TaskItem) => task.title)
      }
      .width('50%')
      .padding(24)
      .backgroundColor(COLORS.surface)
      .borderRadius(40)

      Column({ space: 16 }) {
        Text('Reflection')
          .fontSize(30)
          .fontColor(COLORS.text)
          .fontWeight(FontWeight.Bold)
          .alignSelf(ItemAlign.Start)

        Text(this.focusNote)
          .fontSize(22)
          .fontColor(COLORS.text)
          .lineHeight(28)
          .width('100%')
          .padding(24)
          .backgroundColor(COLORS.surface)
          .borderRadius(32)

        Button('Shuffle note', { type: ButtonType.Normal })
          .fontSize(22)
          .fontColor('#241A12')
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(76)
          .borderRadius(38)
          .backgroundColor(COLORS.primary)
          .onClick(() => {
            this.focusNote = 'Blend high and low tones before next critique'
          })
      }
      .width('50%')
      .padding(24)
      .backgroundColor(COLORS.surfaceVariant)
      .borderRadius(40)
    }
    .width('calc(100% - 64vp)')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  bottomBar() {
    Row() {
      Column({ space: 4 }) {
        Text('Next checkpoint')
          .fontSize(20)
          .fontColor(COLORS.text)
          .fontWeight(FontWeight.Medium)
        Text('12:40 Studio')
          .fontSize(22)
          .fontColor(COLORS.mutedText)
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Button('Launch session', { type: ButtonType.Normal })
        .fontSize(22)
        .fontColor('#241A12')
        .fontWeight(FontWeight.Medium)
        .width(275)
        .height(78)
        .borderRadius(39)
        .backgroundColor(COLORS.primary)
        .onClick(() => {})
    }
    .width('100%')
    .height(110)
    .padding({ left: 32, right: 32, top: 12, bottom: 12 })
    .backgroundColor(COLORS.surface)
    .shadow({ radius: 12, color: '#00000018', offsetY: -3, offsetX: 0 })
  }
}
