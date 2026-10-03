interface Module {
  name: string
  progress: number
  summary: string
}

interface TaskItem {
  title: string
  duration: string
}

interface ColorTokens {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  onSurface: string
  onPrimary: string
}

interface SpacingTokens {
  xs: number
  sm: number
  md: number
  lg: number
  xl: number
  xxl: number
}

@Entry
@Component
struct StudyFocusSplit {
  @State currentTab: number = 0
  @State focusNote: string = "Focus on tone shifts across clay gradients"

  private modules: Module[] = [
    { name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { name: "Morph Lab", progress: 83, summary: "Color blending" },
    { name: "Studio Review", progress: 28, summary: "Peer critique" }
  ]

  private tasks: TaskItem[] = [
    { title: "Research layering", duration: "45m" },
    { title: "Feedback sync", duration: "30m" },
    { title: "Practice recall", duration: "20m" }
  ]

  private colors: ColorTokens = {
    primary: '#C08552',
    secondary: '#9BB1C8',
    tertiary: '#E6CFAF',
    background: '#F3EFE6',
    surface: '#FFFFFF',
    surfaceVariant: '#E7DDCF',
    outline: '#D4C5B6',
    onSurface: '#2E251D',
    onPrimary: '#2A1C13'
  }

  private spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()
        this.TabBar()

        Scroll() {
          Column() {
            this.ModuleCard(this.modules[this.currentTab])

            Row() {
              this.FocusBoardCard()
              this.ReflectionCard()
            }
            .width('100%')
            .margin({ top: this.spacing.lg })

            Blank()
          }
          .width('100%')
          .padding({ left: this.spacing.lg, right: this.spacing.lg, top: this.spacing.md, bottom: this.spacing.md })
        }
        .layoutWeight(1)
        .width('100%')

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.colors.background)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  TopBar() {
    Row() {
      Text("Back")
        .fontSize(14)
        .fontColor(this.colors.onSurface)
        .fontWeight(FontWeight.Medium)

      Text("Study Focus Split")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text("Share")
        .fontSize(14)
        .fontColor(this.colors.secondary)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(56)
    .padding({ left: this.spacing.lg, right: this.spacing.lg })
    .backgroundColor(this.colors.surface)
  }

  @Builder
  TabBar() {
    Row() {
      ForEach(this.modules, (item: Module, index: number) => {
        Column() {
          Text(item.name)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.currentTab === index ? this.colors.primary : this.colors.onSurface)
            .textAlign(TextAlign.Center)
            .maxLines(2)
        }
        .layoutWeight(1)
        .height(72)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.currentTab = index
        })
      }, (item: Module, index: number) => index.toString())
    }
    .width('100%')
    .backgroundColor(this.colors.surface)
    .padding({ left: this.spacing.sm, right: this.spacing.sm })

    // Tab indicator
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(2)
        .backgroundColor(this.colors.surfaceVariant)

      Row()
        .width(`${100 / this.modules.length}%`)
        .height(3)
        .backgroundColor(this.colors.primary)
        .translate({ x: this.currentTab * (100 / this.modules.length) + '%' })
        .animation({ duration: 250, curve: Curve.EaseInOut })
    }
    .width('100%')
    .height(3)
  }

  @Builder
  ModuleCard(module: Module) {
    Column() {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)

      Text(module.summary)
        .fontSize(14)
        .fontColor(this.colors.onSurface)
        .opacity(0.8)
        .margin({ top: this.spacing.sm })

      Divider()
        .color(this.colors.outline)
        .margin({ top: this.spacing.md, bottom: this.spacing.md })

      Row() {
        Text("Progress")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)

        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.End)
      }
      .width('100%')

      // Progress bar
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(12)
          .borderRadius(12)
          .backgroundColor(this.colors.surfaceVariant)

        Row()
          .width(`${module.progress}%`)
          .height(12)
          .borderRadius(12)
          .backgroundColor(this.colors.primary)
      }
      .width('100%')
      .margin({ top: this.spacing.sm })

      Button("Review outline")
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onPrimary)
        .backgroundColor(this.colors.primary)
        .borderRadius(16)
        .height(48)
        .padding({ left: this.spacing.xl, right: this.spacing.xl })
        .margin({ top: this.spacing.lg })
        .onClick(() => {})
    }
    .width('100%')
    .padding(this.spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.colors.surface)
    .borderRadius(20)
    .margin({ top: this.spacing.lg })
  }

  @Builder
  FocusBoardCard() {
    Column() {
      Text("Focus board")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)

      Column({ space: this.spacing.sm }) {
        ForEach(this.tasks, (task: TaskItem) => {
          Column() {
            Text(task.title)
              .fontSize(14)
              .fontColor(this.colors.onSurface)
            Text(task.duration)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.secondary)
              .margin({ top: this.spacing.xs })
          }
          .width('100%')
          .padding(this.spacing.sm)
          .backgroundColor(this.colors.surfaceVariant)
          .borderRadius(12)
          .alignItems(HorizontalAlign.Start)
        }, (item: TaskItem) => item.title)
      }
      .width('100%')
      .margin({ top: this.spacing.sm })
    }
    .layoutWeight(1)
    .padding(this.spacing.md)
    .backgroundColor(this.colors.surface)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ReflectionCard() {
    Column() {
      Text("Reflection")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)

      Text(this.focusNote)
        .fontSize(14)
        .fontColor(this.colors.onSurface)
        .width('100%')
        .padding(this.spacing.md)
        .backgroundColor(this.colors.surface)
        .borderRadius(16)
        .margin({ top: this.spacing.sm })

      Button("Shuffle note")
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onPrimary)
        .backgroundColor(this.colors.primary)
        .borderRadius(16)
        .height(48)
        .margin({ top: this.spacing.md })
        .onClick(() => {
          this.focusNote = "Blend high and low tones before next critique"
        })
    }
    .layoutWeight(1)
    .padding(this.spacing.md)
    .backgroundColor(this.colors.surfaceVariant)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: this.spacing.md })
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text("Next checkpoint")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
        Text("12:40 Studio")
          .fontSize(14)
          .fontColor(this.colors.onSurface)
          .opacity(0.8)
          .margin({ top: this.spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button("Launch session")
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onPrimary)
        .backgroundColor(this.colors.primary)
        .borderRadius(16)
        .height(48)
        .padding({ left: this.spacing.xl, right: this.spacing.xl })
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: this.spacing.lg, right: this.spacing.lg, top: this.spacing.sm, bottom: this.spacing.sm })
    .backgroundColor(this.colors.surface)
  }
}
