class AppColors {
  static primary: string = '#C08552'
  static secondary: string = '#9BB1C8'
  static tertiary: string = '#E6CFAF'
  static background: string = '#F3EFE6'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E7DDCF'
  static outline: string = '#D4C5B6'
  static success: string = '#6BB187'
  static warning: string = '#E2A458'
  static error: string = '#D66B5D'
  static onPrimary: string = '#2A1C13'
  static onSecondary: string = '#15202B'
  static onTertiary: string = '#2C1F10'
  static onBackground: string = '#261E19'
  static onSurface: string = '#2E251D'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 32
  static xxxl: number = 48
}

class AppShapes {
  static small: number = 12
  static medium: number = 16
  static large: number = 20
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
struct StudyFocusApp {
  @State selectedTabIndex: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

  private indexes: number[] = [0, 1, 2, 3]

  private modules: StudyModule[] = [
    new StudyModule('Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('Material Memory', 54, 'Tactile journaling'),
    new StudyModule('Morph Lab', 83, 'Color blending'),
    new StudyModule('Studio Review', 28, 'Peer critique')
  ]

  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m')
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Back')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width(80)
        .textAlign(TextAlign.Start)

      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .width(80)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(56)
    .padding({ left: 32, right: 32 })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  TabItem(index: number) {
    Column({ space: 8 }) {
      Text(this.modules[index].name.replace(' ', '\n'))
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .height(40)
        .width('100%')

      Blank()
        .height(2)
        .width('100%')
        .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : '#00FFFFFF')
    }
    .width(90)
    .height(58)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      this.selectedTabIndex = index
    })
  }

  @Builder
  TabRow() {
    Scroll() {
      Row() {
        ForEach(this.indexes, (index: number) => {
          this.TabItem(index)
        }, (index: number) => index.toString())
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
    .height(66)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  TaskCard(task: TaskItem) {
    Column({ space: AppSpacing.xs }) {
      Text(task.title)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(task.duration)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('#99E7DDCF')
    .borderRadius(AppShapes.small)
  }

  @Builder
  FocusBoard() {
    Column({ space: AppSpacing.sm }) {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      ForEach(this.tasks, (task: TaskItem) => {
        this.TaskCard(task)
      }, (task: TaskItem) => task.title)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  ReflectionCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(this.focusNote)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .lineHeight(18)
        .padding(AppSpacing.md)
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)

      Text('Shuffle note')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique'
        })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  DualPane() {
    Row({ space: AppSpacing.md }) {
      this.FocusBoard()
        .width('48%')

      this.ReflectionCard()
        .width('48%')
    }
    .alignItems(VerticalAlign.Top)
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text('12:40 Studio')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .opacity(0.8)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Text('Launch session')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 4,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            this.TabRow()

            ModuleCard({ module: this.modules[this.selectedTabIndex] })
              .height(220)
              .width('100%')
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            this.DualPane()

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ top: AppSpacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct ModuleCard {
  module: StudyModule = new StudyModule('', 0, '')

  @Builder
  ProgressBar() {
    Row() {
      Blank()
        .height(12)
        .width(`${this.module.progress}%`)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
    }
    .width('100%')
    .height(12)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.small)
    .clip(true)
  }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Text(this.module.summary)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .opacity(0.8)
        .width('100%')

      Divider()
        .vertical(false)
        .color(AppColors.outline)
        .strokeWidth(1)
        .padding({ top: 4, bottom: 4 })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()
          .layoutWeight(1)

        Text(`${this.module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      this.ProgressBar()

      Blank()
        .height(8)

      Text('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}