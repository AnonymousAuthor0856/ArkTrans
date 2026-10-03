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

class AppColors {
  static readonly primary: string = '#C08552'
  static readonly secondary: string = '#9BB1C8'
  static readonly tertiary: string = '#E6CFAF'
  static readonly background: string = '#F3EFE6'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E7DDCF'
  static readonly outline: string = '#D4C5B6'
  static readonly success: string = '#6BB187'
  static readonly warning: string = '#E2A458'
  static readonly error: string = '#D66B5D'
  static readonly onPrimary: string = '#2A1C13'
  static readonly onSecondary: string = '#15202B'
  static readonly onTertiary: string = '#2C1F10'
  static readonly onBackground: string = '#261E19'
  static readonly onSurface: string = '#2E251D'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
  static readonly xxxl: number = 48
}

class AppRadius {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
}

@Entry
@Component
struct Index {
  @State selectedIndex: number = 0
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

  @Builder
  TopBar() {
    Row() {
      Button() {
        Text('Back')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)

      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button() {
        Text('Share')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .height(64)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(16)

        Text('12:40 Studio')
          .fontSize(14)
          .fontColor('rgba(46,37,29,0.8)')
          .lineHeight(20)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .space(AppSpacing.xs)

      Button() {
        Text('Launch session')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .borderRadius(AppRadius.medium)
      .backgroundColor(AppColors.primary)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 4 })
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column() {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(28)

      Text(module.summary)
        .fontSize(14)
        .fontColor('rgba(46,37,29,0.8)')
        .lineHeight(20)

      Divider()
        .color(AppColors.outline)
        .strokeWidth(1)
        .margin({ top: AppSpacing.xs, bottom: AppSpacing.xs })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(16)

        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .lineHeight(24)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.small)

        Row()
          .width(`${module.progress}%`)
          .height(12)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppRadius.small)
      }
      .width('100%')
      .height(12)

      Button() {
        Text('Review outline')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .borderRadius(AppRadius.medium)
      .backgroundColor(AppColors.primary)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .width('100%')
    .height(220)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .space(AppSpacing.sm)
  }

  @Builder
  FocusBoard() {
    Column() {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)

      ForEach(this.tasks, (task: TaskItem) => {
        Column() {
          Text(task.title)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .lineHeight(20)

          Text(task.duration)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .lineHeight(16)
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .backgroundColor('rgba(231,221,207,0.6)')
        .borderRadius(AppRadius.small)
        .alignItems(HorizontalAlign.Start)
        .space(AppSpacing.xs)
      })

      Button() {
        Text('Add checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .borderRadius(AppRadius.medium)
      .backgroundColor(AppColors.primary)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .alignItems(HorizontalAlign.Start)
    .space(AppSpacing.sm)
  }

  @Builder
  ReflectionPane() {
    Column() {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)

      Text(this.focusNote)
        .width('100%')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .lineHeight(20)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.medium)

      Button() {
        Text('Shuffle note')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .borderRadius(AppRadius.medium)
      .backgroundColor(AppColors.primary)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .onClick(() => {
        this.focusNote = 'Blend high and low tones before next critique'
      })
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppRadius.large)
    .alignItems(HorizontalAlign.Start)
    .space(AppSpacing.sm)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          Row() {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              Text(module.name)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedIndex === index ? AppColors.primary : AppColors.onSurface)
                .textAlign(TextAlign.Center)
                .layoutWeight(1)
                .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
                .backgroundColor(AppColors.surface)
                .onClick(() => {
                  this.selectedIndex = index
                })
            })
          }
          .width('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(AppRadius.small)

          Swiper() {
            ForEach(this.modules, (module: StudyModule) => {
              this.ModuleCard(module)
            })
          }
          .width('100%')
          .height(220)
          .index(this.selectedIndex)
          .indicator(true)
          .loop(false)
          .onChange((index: number) => {
            this.selectedIndex = index
          })

          Row() {
            this.FocusBoard()
            this.ReflectionPane()
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)
          .justifyContent(FlexAlign.SpaceBetween)
          .space(AppSpacing.md)
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.lg })
        .space(AppSpacing.lg)
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}