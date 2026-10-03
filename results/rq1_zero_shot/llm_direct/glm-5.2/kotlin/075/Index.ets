// ArkTS conversion of the Kotlin Compose code
// Converted to compilable ArkTS code

class StudyModule {
  name: string;
  progress: number;
  summary: string;

  constructor(name: string, progress: number, summary: string) {
    this.name = name;
    this.progress = progress;
    this.summary = summary;
  }
}

class TaskItem {
  title: string;
  duration: string;

  constructor(title: string, duration: string) {
    this.title = title;
    this.duration = duration;
  }
}

@Entry
@Component
struct RootScreen {
  @State currentIndex: number = 0;
  @State focusNote: string = "Focus on tone shifts across clay gradients";

  private spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  };

  private colors = {
    primary: "#C08552",
    secondary: "#9BB1C8",
    tertiary: "#E6CFAF",
    background: "#F3EFE6",
    surface: "#FFFFFF",
    surfaceVariant: "#E7DDCF",
    outline: "#D4C5B6",
    success: "#6BB187",
    warning: "#E2A458",
    error: "#D66B5D",
    onPrimary: "#2A1C13",
    onSecondary: "#15202B",
    onTertiary: "#2C1F10",
    onBackground: "#261E19",
    onSurface: "#2E251D"
  };

  private modules: StudyModule[] = [
    new StudyModule("Clay Resonance", 72, "Acoustic prototypes"),
    new StudyModule("Material Memory", 54, "Tactile journaling"),
    new StudyModule("Morph Lab", 83, "Color blending"),
    new StudyModule("Studio Review", 28, "Peer critique")
  ];

  private tasks: TaskItem[] = [
    new TaskItem("Research layering", "45m"),
    new TaskItem("Feedback sync", "30m"),
    new TaskItem("Practice recall", "20m")
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Back")
          .fontSize(12)
          .fontColor(this.colors.onSurface)
          .margin({ left: this.spacing.lg })
          .onClick(() => {})
        Text("Study Focus Split")
          .fontSize(18)
          .fontColor(this.colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Text("Share")
          .fontSize(12)
          .fontColor(this.colors.secondary)
          .margin({ right: this.spacing.lg })
          .onClick(() => {})
      }
      .width("100%")
      .height(56)
      .backgroundColor(this.colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Scroll() {
        Column({ space: this.spacing.lg }) {
          // TabRow
          Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, onChange: (index: number) => {
            this.currentIndex = index;
          }}) {
            ForEach(this.modules, (module: StudyModule, index: number) => {
              TabContent() {
                // HorizontalPager content
                Column() {
                  Column() {
                    Text(module.name)
                      .fontSize(22)
                      .fontColor(this.colors.onSurface)
                      .margin({ bottom: this.spacing.sm })
                    Text(module.summary)
                      .fontSize(14)
                      .fontColor(this.colors.onSurface)
                      .opacity(0.8)
                      .margin({ bottom: this.spacing.sm })
                    Divider().color(this.colors.outline).margin({ bottom: this.spacing.sm })
                    Row() {
                      Text("Progress")
                        .fontSize(12)
                        .fontColor(this.colors.onSurface)
                      Text(module.progress + "%")
                        .fontSize(18)
                        .fontColor(this.colors.primary)
                    }
                    .width("100%")
                    .justifyContent(FlexAlign.SpaceBetween)
                    .margin({ bottom: this.spacing.sm })

                    // Progress Bar
                    Stack({ alignContent: Alignment.Start }) {
                      Column()
                        .width("100%")
                        .height(12)
                        .backgroundColor(this.colors.surfaceVariant)
                        .borderRadius(12)
                      Column()
                        .width(module.progress + "%")
                        .height(12)
                        .backgroundColor(this.colors.primary)
                        .borderRadius(12)
                    }
                    .width("100%")
                    .height(12)
                    .margin({ bottom: this.spacing.sm })

                    Button("Review outline") {
                      Text("Review outline")
                        .fontSize(12)
                        .fontColor(this.colors.onPrimary)
                    }
                    .borderRadius(16)
                    .backgroundColor(this.colors.primary)
                    .margin({ top: this.spacing.sm })
                  }
                  .padding(this.spacing.lg)
                  .backgroundColor(this.colors.surface)
                  .borderRadius(20)
                  .width("100%")
                }
                .height(220)
                .padding({ top: this.spacing.lg, left: this.spacing.lg, right: this.spacing.lg })
              }
              .tabBar(this.TabBuilder(module.name, index))
            })
          }
          .barMode(BarMode.Scrollable)
          .barBackgroundColor(this.colors.surface)
          .height(280)

          // Dual Focus Panes
          Row({ space: this.spacing.md }) {
            // Focus Board
            Column() {
              Text("Focus board")
                .fontSize(18)
                .fontColor(this.colors.onSurface)
                .margin({ bottom: this.spacing.sm })
              ForEach(this.tasks, (task: TaskItem) => {
                Column() {
                  Text(task.title)
                    .fontSize(14)
                    .fontColor(this.colors.onSurface)
                  Text(task.duration)
                    .fontSize(12)
                    .fontColor(this.colors.secondary)
                }
                .width("100%")
                .padding(this.spacing.sm)
                .backgroundColor(this.colors.surfaceVariant)
                .opacity(0.6)
                .borderRadius(12)
                .margin({ bottom: this.spacing.sm })
              })
              Button("Add checkpoint") {
                Text("Add checkpoint")
                  .fontSize(12)
                  .fontColor(this.colors.onPrimary)
              }
              .borderRadius(16)
              .backgroundColor(this.colors.primary)
              .width("100%")
            }
            .layoutWeight(1)
            .padding(this.spacing.md)
            .backgroundColor(this.colors.surface)
            .borderRadius(20)

            // Reflection
            Column() {
              Text("Reflection")
                .fontSize(18)
                .fontColor(this.colors.onSurface)
                .margin({ bottom: this.spacing.sm })
              Text(this.focusNote)
                .fontSize(14)
                .fontColor(this.colors.onSurface)
                .padding(this.spacing.md)
                .backgroundColor(this.colors.surface)
                .borderRadius(16)
                .width("100%")
                .margin({ bottom: this.spacing.sm })
              Button("Shuffle note") {
                Text("Shuffle note")
                  .fontSize(12)
                  .fontColor(this.colors.onPrimary)
              }
              .borderRadius(16)
              .backgroundColor(this.colors.primary)
              .width("100%")
              .onClick(() => {
                this.focusNote = "Blend high and low tones before next critique";
              })
            }
            .layoutWeight(1)
            .padding(this.spacing.md)
            .backgroundColor(this.colors.surfaceVariant)
            .borderRadius(20)
          }
          .width("100%")
          .padding({ left: this.spacing.lg, right: this.spacing.lg, bottom: this.spacing.md })
        }
        .width("100%")
      }
      .layoutWeight(1)
      .backgroundColor(this.colors.background)

      // Bottom Bar
      Row() {
        Column() {
          Text("Next checkpoint")
            .fontSize(12)
            .fontColor(this.colors.onSurface)
          Text("12:40 Studio")
            .fontSize(14)
            .fontColor(this.colors.onSurface)
            .opacity(0.8)
        }
        .alignItems(HorizontalAlign.Start)

        Button("Launch session") {
          Text("Launch session")
            .fontSize(12)
            .fontColor(this.colors.onPrimary)
        }
        .borderRadius(16)
        .backgroundColor(this.colors.primary)
      }
      .width("100%")
      .padding({ left: this.spacing.lg, right: this.spacing.lg, top: this.spacing.sm, bottom: this.spacing.sm })
      .backgroundColor(this.colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(this.colors.background)
  }

  @Builder
  TabBuilder(name: string, index: number) {
    Text(name)
      .fontSize(12)
      .fontColor(this.currentIndex === index ? this.colors.primary : this.colors.onSurface)
      .margin({ top: 8, bottom: 8, left: 12, right: 12 })
  }
}