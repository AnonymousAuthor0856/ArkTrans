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

class AppShape {
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
struct Index {
  @State selectedTabIndex: number = 0
  @State focusNote: string = 'Focus on tone shifts across clay gradients'

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

  private tabLabel(name: string): string {
    if (name === 'Clay Resonance') {
      return 'Clay\nResonance'
    }
    if (name === 'Material Memory') {
      return 'Material\nMemory'
    }
    if (name === 'Morph Lab') {
      return 'Morph\nLab'
    }
    return 'Studio\nReview'
  }

  @Builder
  TopBar() {
    Row() {
      Button('Back')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor('#00000000')

      Blank()
        .layoutWeight(1)

      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Blank()
        .layoutWeight(1)

      Button('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor('#00000000')
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ModuleTab(module: StudyModule, index: number) {
    Column({ space: 8 }) {
      Text(this.tabLabel(module.name))
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .height(40)
        .width(90)
      Rect()
        .width(90)
        .height(2)
        .fill(this.selectedTabIndex === index ? AppColors.primary : '#00000000')
    }
    .width(90)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      this.selectedTabIndex = index
    })
  }

  @Builder
  ProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(12)
        .fill(AppColors.surfaceVariant)
        .radius(AppShape.small)
      Rect()
        .width(progress.toString() + '%')
        .height(12)
        .fill(AppColors.primary)
        .radius(AppShape.small)
    }
    .width('100%')
    .height(12)
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column({ space: AppSpacing.sm }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(module.summary)
        .fontSize(14)
        .fontColor('#CC2E251D')

      Rect()
        .width('100%')
        .height(1)
        .fill(AppColors.outline)
        .margin({ top: 4, bottom: 4 })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
          .layoutWeight(1)
        Text(module.progress.toString() + '%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      this.ProgressBar(module.progress)

      Blank()
        .height(8)

      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
    }
    .width('100%')
    .height(220)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.large)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
  }

  @Builder
  TaskRow(task: TaskItem) {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(task.title)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
        Text(task.duration)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('#99E7DDCF')
    .borderRadius(AppShape.small)
  }

  @Builder
  FocusBoard() {
    Column({ space: AppSpacing.sm }) {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      ForEach(this.tasks, (task: TaskItem) => {
        this.TaskRow(task)
      })
      Blank()
        .height(8)
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.large)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
  }

  @Builder
  ReflectionPane() {
    Column({ space: AppSpacing.sm }) {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(this.focusNote)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShape.medium)

      Button('Shuffle note')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('100%')
        .padding({ top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique'
        })
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShape.large)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
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
          .fontColor('#CC2E251D')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Launch session')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Scroll() {
              Row() {
                ForEach(this.modules, (module: StudyModule, index?: number) => {
                  this.ModuleTab(module, index ? index : 0)
                })
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .backgroundColor(AppColors.surface)
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Column() {
              this.ModuleCard(this.modules[this.selectedTabIndex])
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Row({ space: AppSpacing.md }) {
              this.FocusBoard()
              this.ReflectionPane()
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .alignItems(VerticalAlign.Top)

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ top: AppSpacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
          .layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
