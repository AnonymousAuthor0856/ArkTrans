const AppColors = {
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
  onSurface: '#2E251D',
  onSurfaceAlpha80: '#CC2E251D',
  surfaceVariantAlpha60: '#99E7DDCF',
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 48,
}

const AppShapes = {
  small: 12,
  medium: 16,
  large: 20,
}

class StudyModule {
  name: string = ''
  progress: number = 0
  summary: string = ''
  constructor(name: string, progress: number, summary: string) {
    this.name = name
    this.progress = progress
    this.summary = summary
  }
}

class TaskItem {
  title: string = ''
  duration: string = ''
  constructor(title: string, duration: string) {
    this.title = title
    this.duration = duration
  }
}

@Entry
@Component
struct RootScreen {
  @State focusNote: string = 'Focus on tone shifts across clay gradients'
  @State currentTab: number = 0
  private modules: StudyModule[] = [
    new StudyModule('Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('Material Memory', 54, 'Tactile journaling'),
    new StudyModule('Morph Lab', 83, 'Color blending'),
    new StudyModule('Studio Review', 28, 'Peer critique'),
  ]
  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m'),
  ]

  @Builder
  TabBarBuilder(module: StudyModule, index: number) {
    Text(module.name)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.currentTab === index ? AppColors.primary : AppColors.onSurface)
  }

  @Builder
  ModuleCardBuilder(module: StudyModule) {
    Column() {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text(module.summary)
        .fontSize(14)
        .fontColor(AppColors.onSurfaceAlpha80)
        .margin({ top: AppSpacing.sm })

      Column() {}
        .width('100%')
        .height(1)
        .backgroundColor(AppColors.outline)
        .margin({ top: AppSpacing.sm })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: AppSpacing.sm })

      Stack() {
        Row() {}
          .width(`${module.progress}%`)
          .height('100%')
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(12)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .alignContent(Alignment.Start)
      .margin({ top: AppSpacing.xs })

      Button('Review outline') {
        Text('Review outline')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .height(40)
        .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
  }

  @Builder
  TaskItemBuilder(task: TaskItem) {
    Column() {
      Text(task.title)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
      Text(task.duration)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .backgroundColor(AppColors.surfaceVariantAlpha60)
    .borderRadius(AppShapes.small)
    .padding(AppSpacing.sm)
    .alignItems(HorizontalAlign.Start)
    .margin({ top: AppSpacing.sm })
  }

  build() {
    Column() {
      Row() {
        Text('Back')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

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
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column() {
          Tabs({ barPosition: BarPosition.Start }) {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              TabContent() {
                this.ModuleCardBuilder(module)
              }
                .tabBar(this.TabBarBuilder(module, index))
            }, (module: StudyModule) => module.name)
          }
          .width('100%')
          .height(280)
          .barBackgroundColor(AppColors.surface)
          .onChange((index: number) => {
            this.currentTab = index
          })

          Row() {
            Column() {
              Text('Focus board')
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              ForEach(this.tasks, (task: TaskItem) => {
                this.TaskItemBuilder(task)
              }, (task: TaskItem) => task.title)

              Button('Add checkpoint') {
                Text('Add checkpoint')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
                .type(ButtonType.Normal)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.medium)
                .height(40)
                .margin({ top: AppSpacing.sm })
            }
            .layoutWeight(1)
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)
            .alignItems(HorizontalAlign.Start)

            Column() {
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
                .borderRadius(AppShapes.medium)
                .margin({ top: AppSpacing.sm })

              Button('Shuffle note') {
                Text('Shuffle note')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
                .type(ButtonType.Normal)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.medium)
                .height(40)
                .margin({ top: AppSpacing.sm })
                .onClick(() => {
                  this.focusNote = 'Blend high and low tones before next critique'
                })
            }
            .layoutWeight(1)
            .padding(AppSpacing.md)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.large)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .margin({ top: AppSpacing.lg })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Column() {
          Text('Next checkpoint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('12:40 Studio')
            .fontSize(14)
            .fontColor(AppColors.onSurfaceAlpha80)
            .margin({ top: AppSpacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Launch session') {
          Text('Launch session')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .height(40)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}