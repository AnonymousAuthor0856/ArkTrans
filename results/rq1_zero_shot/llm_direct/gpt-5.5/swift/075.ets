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

class AppTypography {
  static readonly displaySize: number = 30
  static readonly headlineSize: number = 22
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12

  static readonly displayWeight: FontWeight = FontWeight.Medium
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelWeight: FontWeight = FontWeight.Medium
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

class AppShapes {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
}

class StudyModule {
  id: string
  name: string
  progress: number
  summary: string

  constructor(name: string, progress: number, summary: string) {
    this.id = name
    this.name = name
    this.progress = progress
    this.summary = summary
  }
}

class TaskItem {
  id: string
  title: string
  duration: string

  constructor(title: string, duration: string) {
    this.id = title
    this.title = title
    this.duration = duration
  }
}

@Builder
function EmptyBuilder() {
}

@Entry
@Component
struct ContentView {
  build() {
    StudyFocusSplitScreen()
  }
}

@Component
struct StudyFocusSplitScreen {
  @State private selectedTabIndex: number = 0
  @State private focusNote: string = 'Focus on tone shifts across clay gradients'

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

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text('Back')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .fontColor(AppColors.onSurface)
          }
          .backgroundColor('#00000000')
          .padding(0)

          Blank()

          Text('Study Focus Split')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface)

          Blank()

          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text('Share')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .fontColor(AppColors.secondary)
          }
          .backgroundColor('#00000000')
          .padding(0)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            Scroll() {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(module.name.split(' ').join('\n'))
                      .fontSize(AppTypography.labelSize)
                      .fontWeight(AppTypography.labelWeight)
                      .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40)

                    Row()
                      .height(2)
                      .width('100%')
                      .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : '#00000000')
                  }
                  .width(90)
                  .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
                  .onClick(() => {
                    this.selectedTabIndex = index
                  })
                }, (module: StudyModule) => module.id)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .backgroundColor(AppColors.surface)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            Swiper() {
              ForEach(this.modules, (module: StudyModule) => {
                ModuleCard({ module: module })
                  .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              }, (module: StudyModule) => module.id)
            }
            .index(this.selectedTabIndex)
            .indicator(false)
            .loop(false)
            .height(220)
            .onChange((index: number) => {
              this.selectedTabIndex = index
            })

            Row({ space: AppSpacing.md }) {
              CardView({ backgroundColor: AppColors.surface }) {
                Column({ space: AppSpacing.sm }) {
                  Text('Focus board')
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(AppTypography.titleWeight)
                    .fontColor(AppColors.onSurface)
                    .width('100%')

                  ForEach(this.tasks, (task: TaskItem) => {
                    Row() {
                      Column({ space: AppSpacing.xs }) {
                        Text(task.title)
                          .fontSize(AppTypography.bodySize)
                          .fontWeight(AppTypography.bodyWeight)
                          .fontColor(AppColors.onSurface)

                        Text(task.duration)
                          .fontSize(AppTypography.labelSize)
                          .fontWeight(AppTypography.labelWeight)
                          .fontColor(AppColors.secondary)
                      }
                      .alignItems(HorizontalAlign.Start)

                      Blank()
                    }
                    .width('100%')
                    .padding(AppSpacing.sm)
                    .backgroundColor('#99E7DDCF')
                    .borderRadius(AppShapes.small)
                  }, (task: TaskItem) => task.id)

                  Blank()
                    .height(8)
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .padding(AppSpacing.md)
              }
              .layoutWeight(1)

              CardView({ backgroundColor: AppColors.surfaceVariant }) {
                Column({ space: AppSpacing.sm }) {
                  Text('Reflection')
                    .fontSize(AppTypography.titleSize)
                    .fontWeight(AppTypography.titleWeight)
                    .fontColor(AppColors.onSurface)
                    .width('100%')

                  Text(this.focusNote)
                    .fontSize(AppTypography.bodySize)
                    .fontWeight(AppTypography.bodyWeight)
                    .fontColor(AppColors.onSurface)
                    .width('100%')
                    .padding(AppSpacing.md)
                    .backgroundColor(AppColors.surface)
                    .borderRadius(AppShapes.medium)

                  Button({ type: ButtonType.Normal, stateEffect: true }) {
                    Text('Shuffle note')
                      .fontSize(AppTypography.labelSize)
                      .fontWeight(AppTypography.labelWeight)
                      .fontColor('#B3000000')
                      .width('100%')
                      .textAlign(TextAlign.Center)
                      .padding({ top: 12, bottom: 12 })
                  }
                  .width('100%')
                  .backgroundColor(AppColors.primary)
                  .borderRadius(AppShapes.medium)
                  .onClick(() => {
                    this.focusNote = 'Blend high and low tones before next critique'
                  })
                }
                .width('100%')
                .alignItems(HorizontalAlign.Start)
                .padding(AppSpacing.md)
              }
              .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

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

        Row() {
          Column({ space: AppSpacing.xs }) {
            Text('Next checkpoint')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .fontColor(AppColors.onSurface)

            Text('12:40 Studio')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor('#CC2E251D')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Launch session')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .fontColor('#B3000000')
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          }
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
          color: '#1A000000',
          radius: 4,
          offsetX: 0,
          offsetY: -2
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct ModuleCard {
  module: StudyModule = new StudyModule('', 0, '')

  build() {
    CardView({ backgroundColor: AppColors.surface }) {
      Column({ space: AppSpacing.sm }) {
        Text(this.module.name)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(AppTypography.headlineWeight)
          .fontColor(AppColors.onSurface)

        Text(this.module.summary)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor('#CC2E251D')

        Divider()
          .color(AppColors.outline)
          .strokeWidth(1)
          .padding({ top: 4, bottom: 4 })

        Row() {
          Text('Progress')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onSurface)

          Blank()

          Text(`${this.module.progress}%`)
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.primary)
        }
        .width('100%')

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .height(12)
            .width('100%')
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          Row()
            .height(12)
            .width(`${this.module.progress}%`)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(12)

        Blank()
          .height(8)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Review outline')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor('#B3000000')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Start)
      .padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct CardView {
  backgroundColor: string = AppColors.surface
  @BuilderParam content: () => void = EmptyBuilder

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(this.backgroundColor)
    .borderRadius(AppShapes.large)
    .shadow({
      color: '#0D000000',
      radius: 4,
      offsetX: 0,
      offsetY: 2
    })
  }
}