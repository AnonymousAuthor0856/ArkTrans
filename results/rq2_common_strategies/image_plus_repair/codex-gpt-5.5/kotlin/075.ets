interface StudyModule {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}

interface ColorPalette {
  primary: string
  secondary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  text: string
  mutedText: string
}

@Entry
@Component
struct StudyFocusSplit {
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

  private readonly colors: ColorPalette = {
    primary: '#C08552',
    secondary: '#9BB1C8',
    background: '#F3EFE6',
    surface: '#FFFFFF',
    surfaceVariant: '#E7DDCF',
    outline: '#D4C5B6',
    text: '#2E251D',
    mutedText: '#625A53'
  }

  build() {
    Column() {
      this.buildTopBar()
      this.buildBody()
      this.buildBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }

  @Builder
  private buildTopBar() {
    Row() {
      Button('Back', { type: ButtonType.Normal })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.text)
        .backgroundColor(Color.Transparent)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .onClick(() => {
          this.selectedTab = 0
        })

      Text('Study Focus Split')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.text)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Button('Share', { type: ButtonType.Normal })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.secondary)
        .backgroundColor(Color.Transparent)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .onClick(() => {
          this.focusNote = 'Share your next study milestone with the studio'
        })
    }
    .width('100%')
    .height(88)
    .padding({ left: 32, right: 32 })
    .backgroundColor(this.colors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private buildBody() {
    Scroll() {
      Column({ space: 16 }) {
        this.buildTabs()
        this.buildModuleCard()
        this.buildFocusColumns()
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 16, bottom: 24 })
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  @Builder
  private buildTabs() {
    Column() {
      Row() {
        ForEach(this.modules, (module: StudyModule, index: number) => {
          Column() {
            Text(module.name)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index ? this.colors.primary : this.colors.text)
              .maxLines(2)
              .textAlign(TextAlign.Center)
              .lineHeight(24)
          }
          .layoutWeight(1)
          .height(132)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.selectedTab = index
          })
        }, (module: StudyModule) => module.name)
      }
      .width('100%')

      Row() {
        ForEach(this.modules, (_module: StudyModule, index: number) => {
          Row()
            .layoutWeight(1)
            .height(4)
            .backgroundColor(this.selectedTab === index ? this.colors.primary : Color.Transparent)
        }, (_module: StudyModule, index: number) => `${index}`)
      }
      .width('100%')
      .backgroundColor(this.colors.outline)
    }
    .width('100%')
    .backgroundColor(this.colors.surface)
  }

  @Builder
  private buildModuleCard() {
    Column({ space: 12 }) {
      Text(this.modules[this.selectedTab].name)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.text)
        .width('100%')

      Text(this.modules[this.selectedTab].summary)
        .fontSize(21)
        .fontColor(this.colors.mutedText)
        .width('100%')

      Divider()
        .color(this.colors.outline)
        .strokeWidth(1)
        .width('100%')

      Row() {
        Text('Progress')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.text)
        Text(`${this.modules[this.selectedTab].progress}%`)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .backgroundColor(this.colors.surfaceVariant)
          .borderRadius(8)

        Row()
          .width(`${this.modules[this.selectedTab].progress}%`)
          .height(12)
          .backgroundColor(this.colors.primary)
          .borderRadius(8)
      }
      .width('100%')
      .height(12)

      Button('Review outline', { type: ButtonType.Normal })
        .fontSize(17)
        .fontColor('#241A12')
        .backgroundColor(this.colors.primary)
        .borderRadius(28)
        .width(252)
        .height(80)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(32)
    .backgroundColor(this.colors.surface)
    .borderRadius(40)
  }

  @Builder
  private buildFocusColumns() {
    Row({ space: 24 }) {
      Column({ space: 14 }) {
        Text('Focus board')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.text)
          .width('100%')

        ForEach(this.tasks, (task: TaskItem) => {
          Column({ space: 4 }) {
            Text(task.title)
              .fontSize(17)
              .fontColor(this.colors.text)
              .width('100%')
            Text(task.duration)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.secondary)
              .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#F0EAE1')
          .borderRadius(20)
        }, (task: TaskItem) => task.title)

        Button('Add checkpoint', { type: ButtonType.Normal })
          .fontSize(16)
          .fontColor('#241A12')
          .backgroundColor(this.colors.primary)
          .borderRadius(24)
          .width('100%')
          .height(54)
      }
      .layoutWeight(1)
      .padding(24)
      .backgroundColor(this.colors.surface)
      .borderRadius(40)

      Column({ space: 14 }) {
        Text('Reflection')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.text)
          .width('100%')

        Text(this.focusNote)
          .fontSize(18)
          .fontColor(this.colors.text)
          .lineHeight(28)
          .width('100%')
          .padding(24)
          .backgroundColor(this.colors.surface)
          .borderRadius(30)

        Button('Shuffle note', { type: ButtonType.Normal })
          .fontSize(16)
          .fontColor('#241A12')
          .backgroundColor(this.colors.primary)
          .borderRadius(24)
          .width('100%')
          .height(54)
          .onClick(() => {
            this.focusNote = 'Blend high and low tones before next critique'
          })
      }
      .layoutWeight(1)
      .padding(24)
      .backgroundColor(this.colors.surfaceVariant)
      .borderRadius(40)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  private buildBottomBar() {
    Row() {
      Column({ space: 4 }) {
        Text('Next checkpoint')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.text)
        Text('12:40 Studio')
          .fontSize(18)
          .fontColor(this.colors.mutedText)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Launch session', { type: ButtonType.Normal })
        .fontSize(17)
        .fontColor('#241A12')
        .backgroundColor(this.colors.primary)
        .borderRadius(28)
        .width(262)
        .height(80)
        .onClick(() => {
          this.focusNote = 'Session launched: begin with the current checkpoint'
        })
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 16, bottom: 16 })
    .backgroundColor('#FFFCF8')
    .shadow({
      radius: 10,
      color: '#22000000',
      offsetY: -2
    })
  }
}
