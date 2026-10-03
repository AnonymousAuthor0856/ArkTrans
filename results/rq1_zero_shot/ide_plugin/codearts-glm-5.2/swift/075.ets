class AppTokens {
  static readonly Colors = {
    primary: '#FFC08552',
    secondary: '#FF9BB1C8',
    tertiary: '#FFE6CFAF',
    background: '#FFF3EFE6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE7DDCF',
    outline: '#FFD4C5B6',
    success: '#FF6BB187',
    warning: '#FFE2A458',
    error: '#FFD66B5D',
    onPrimary: '#FF2A1C13',
    onSecondary: '#FF15202B',
    onTertiary: '#FF2C1F10',
    onBackground: '#FF261E19',
    onSurface: '#FF2E251D',
    onSurface80: '#CC2E251D',
    surfaceVariant60: '#99E7DDCF',
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48,
  }
  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20,
  }
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
    new StudyModule('Studio Review', 28, 'Peer critique'),
  ]
  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m'),
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Back')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Study Focus Split')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Share')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
        }
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)

        Scroll() {
          Column() {
            Scroll() {
              Row() {
                ForEach(this.modules, (mod: StudyModule, index: number) => {
                  Column() {
                    Text(mod.name.replace(' ', '\n'))
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40)

                    Column() {
                      Blank()
                    }
                    .width('100%')
                    .height(2)
                    .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : '#00000000')
                    .margin({ top: 8 })
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            ModuleCard({
              modName: this.modules[this.selectedTabIndex].name,
              modProgress: this.modules[this.selectedTabIndex].progress,
              modSummary: this.modules[this.selectedTabIndex].summary
            })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .margin({ top: AppTokens.Spacing.lg })

            Row() {
              Column() {
                Text('Focus board')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)

                ForEach(this.tasks, (task: TaskItem) => {
                  Row() {
                    Column() {
                      Text(task.title)
                        .fontSize(14)
                        .fontColor(AppTokens.Colors.onSurface)
                      Text(task.duration)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppTokens.Colors.secondary)
                        .margin({ top: AppTokens.Spacing.xs })
                    }
                    .alignItems(HorizontalAlign.Start)
                    Blank()
                  }
                  .padding(AppTokens.Spacing.sm)
                  .backgroundColor(AppTokens.Colors.surfaceVariant60)
                  .borderRadius(AppTokens.Shapes.small)
                  .margin({ top: AppTokens.Spacing.sm })
                })
              }
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text('Reflection')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)

                Text(this.focusNote)
                  .fontSize(14)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding(AppTokens.Spacing.md)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.medium)
                  .margin({ top: AppTokens.Spacing.sm })

                Text('Shuffle note')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#B3000000')
                  .textAlign(TextAlign.Center)
                  .padding({ top: 12, bottom: 12 })
                  .width('100%')
                  .backgroundColor(AppTokens.Colors.primary)
                  .borderRadius(AppTokens.Shapes.medium)
                  .margin({ top: AppTokens.Spacing.sm })
                  .onClick(() => {
                    this.focusNote = 'Blend high and low tones before next critique'
                  })
              }
              .padding(AppTokens.Spacing.md)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ top: AppTokens.Spacing.lg })

            Blank().height(100)
          }
          .padding({ top: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Row() {
          Column() {
            Text('Next checkpoint')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text('12:40 Studio')
              .fontSize(14)
              .fontColor(AppTokens.Colors.onSurface80)
              .margin({ top: AppTokens.Spacing.xs })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('Launch session')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3000000')
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetY: -2 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ModuleCard {
  @Prop modName: string = ''
  @Prop modProgress: number = 0
  @Prop modSummary: string = ''

  build() {
    Column() {
      Text(this.modName)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.modSummary)
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface80)
        .margin({ top: AppTokens.Spacing.sm })

      Column() {
        Blank()
      }
      .width('100%')
      .height(1)
      .backgroundColor(AppTokens.Colors.outline)
      .margin({ top: 4, bottom: 4 })

      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(`${this.modProgress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }

      Stack() {
        Column() {
          Blank()
        }
        .width('100%')
        .height(12)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)

        Column() {
          Blank()
        }
        .width(`${this.modProgress}%`)
        .height(12)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.small)
      }
      .alignContent(Alignment.Start)
      .width('100%')
      .height(12)
      .margin({ top: AppTokens.Spacing.sm })

      Text('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3000000')
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start)
  }
}