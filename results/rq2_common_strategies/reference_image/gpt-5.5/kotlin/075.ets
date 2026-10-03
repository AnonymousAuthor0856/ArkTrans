const Colors = {
  primary: '#C08552',
  secondary: '#9BB1C8',
  tertiary: '#E6CFAF',
  background: '#F3EFE6',
  surface: '#FFFFFF',
  surfaceVariant: '#E7DDCF',
  outline: '#D4C5B6',
  success: '#6BB187',
  warning: '#E2A458',
  error: '#D66B5D',
  onPrimary: '#2A1C13',
  onSecondary: '#15202B',
  onTertiary: '#2C1F10',
  onBackground: '#261E19',
  onSurface: '#2E251D'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 48
}

const Shape = {
  small: 12,
  medium: 16,
  large: 20
}

class StudyModule {
  name: string
  progress: number
  summary: string

  constructor(name: string, progress: number, summary: string) {
    this.name = name
    this.progress = progress
    this.summary = summary
  }
}

class TaskItem {
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.title = title
    this.duration = duration
  }
}

@Entry
@Component
struct Index {
  @State currentPage: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  private modules: StudyModule[] = [
    new StudyModule('Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('Material Memory', 54, 'Tactile journaling'),
    new StudyModule('Morph Lab', 83, 'Color blending'),
    new StudyModule('Studio Review', 28, 'Peer critique')
  ]

  private tabLabels: string[] = [
    'Clay\nResonan\nce',
    'Material\nMemory',
    'Morph\nLab',
    'Studio\nReview'
  ]

  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m')
  ]

  build() {
    Column() {
      this.TopAppBar()

      Scroll() {
        Column({ space: Spacing.lg }) {
          this.StudyTabs()
          this.ModulePager()
          this.FocusSplitPane()
        }
        .width('100%')
        .padding({
          left: Spacing.lg,
          right: Spacing.lg,
          top: Spacing.md,
          bottom: Spacing.xl
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  TopAppBar() {
    Row() {
      Text('Back')
        .width(120)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Start)
        .onClick(() => {
        })

      Text('Study Focus Split')
        .layoutWeight(1)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)

      Text('Share')
        .width(120)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.secondary)
        .textAlign(TextAlign.End)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(120)
    .padding({
      left: Spacing.lg,
      right: Spacing.lg,
      top: Spacing.xxl,
      bottom: Spacing.md
    })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
  }

  @Builder
  StudyTabs() {
    Column() {
      Row() {
        ForEach(this.modules, (item: StudyModule, index: number) => {
          Column() {
            Text(this.tabLabels[index])
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .lineHeight(16)
              .fontColor(this.currentPage === index ? Colors.primary : Colors.onSurface)
              .textAlign(TextAlign.Start)
              .width('100%')
              .maxLines(3)

            Blank()
              .layoutWeight(1)

            Blank()
              .width('100%')
              .height(4)
              .backgroundColor(this.currentPage === index ? Colors.primary : 'rgba(0,0,0,0)')
          }
          .width('25%')
          .height('100%')
          .padding({
            left: Spacing.lg,
            right: Spacing.md,
            top: Spacing.xl
          })
          .onClick(() => {
            this.currentPage = index
          })
        }, (item: StudyModule) => item.name)
      }
      .width('100%')
      .height(128)

      Divider()
        .width('100%')
        .strokeWidth(1)
        .color(Colors.outline)
    }
    .width('100%')
    .height(132)
    .backgroundColor(Colors.surface)
  }

  @Builder
  ModulePager() {
    Swiper() {
      ForEach(this.modules, (item: StudyModule) => {
        Column({ space: Spacing.sm }) {
          Text(item.name)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .lineHeight(28)
            .fontColor(Colors.onSurface)

          Text(item.summary)
            .fontSize(14)
            .lineHeight(20)
            .fontColor('#CC2E251D')

          Divider()
            .width('100%')
            .strokeWidth(1)
            .color(Colors.outline)

          Row() {
            Text('Progress')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)

            Text(`${item.progress}%`)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Stack({ alignContent: Alignment.Start }) {
            Blank()
              .width('100%')
              .height(12)
              .borderRadius(Shape.small)
              .backgroundColor(Colors.surfaceVariant)

            Blank()
              .width(`${item.progress}%`)
              .height(12)
              .borderRadius(Shape.small)
              .backgroundColor(Colors.primary)
          }
          .width('100%')
          .height(12)

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Review outline')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onPrimary)
          }
          .width(252)
          .height(80)
          .borderRadius(Shape.medium)
          .backgroundColor(Colors.primary)
          .margin({ top: Spacing.md })
          .onClick(() => {
          })
        }
        .width('100%')
        .height(392)
        .padding(Spacing.lg)
        .borderRadius(Shape.large)
        .backgroundColor(Colors.surface)
      }, (item: StudyModule) => item.name)
    }
    .width('100%')
    .height(392)
    .index(this.currentPage)
    .indicator(false)
    .loop(false)
    .duration(250)
    .onChange((index: number) => {
      this.currentPage = index
    })
  }

  @Builder
  FocusSplitPane() {
    Row({ space: Spacing.md }) {
      Column({ space: Spacing.sm }) {
        Text('Focus board')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .lineHeight(24)
          .fontColor(Colors.onSurface)

        ForEach(this.tasks, (task: TaskItem) => {
          Column({ space: Spacing.xs }) {
            Text(task.title)
              .fontSize(14)
              .lineHeight(20)
              .fontColor(Colors.onSurface)
              .maxLines(2)

            Text(task.duration)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)
          }
          .width('100%')
          .padding(Spacing.sm)
          .borderRadius(Shape.small)
          .backgroundColor('#F0E9DF')
        }, (task: TaskItem) => task.title)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Add checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
        }
        .width('100%')
        .height(56)
        .borderRadius(Shape.medium)
        .backgroundColor(Colors.primary)
        .onClick(() => {
        })
      }
      .layoutWeight(1)
      .padding(Spacing.md)
      .borderRadius(Shape.large)
      .backgroundColor(Colors.surface)

      Column({ space: Spacing.sm }) {
        Text('Reflection')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .lineHeight(24)
          .fontColor(Colors.onSurface)

        Text(this.focusNote)
          .width('100%')
          .padding(Spacing.md)
          .fontSize(14)
          .lineHeight(20)
          .fontColor(Colors.onSurface)
          .borderRadius(Shape.medium)
          .backgroundColor(Colors.surface)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Shuffle note')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
        }
        .width('100%')
        .height(80)
        .borderRadius(Shape.medium)
        .backgroundColor(Colors.primary)
        .margin({ top: Spacing.md })
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique'
        })
      }
      .layoutWeight(1)
      .padding(Spacing.md)
      .borderRadius(Shape.large)
      .backgroundColor(Colors.surfaceVariant)
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: Spacing.xs }) {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Text('12:40 Studio')
          .fontSize(14)
          .lineHeight(20)
          .fontColor('#CC2E251D')
      }
      .layoutWeight(1)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
      }
      .width(262)
      .height(80)
      .borderRadius(Shape.medium)
      .backgroundColor(Colors.primary)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(130)
    .padding({
      left: Spacing.lg,
      right: Spacing.lg,
      top: Spacing.md,
      bottom: Spacing.md
    })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Colors.surface)
  }
}