// StudyFocusApp.ets
// Converted from SwiftUI to ArkTS

// MARK: - App Tokens
interface AppColors {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface AppTypographyItem {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: AppTypographyItem;
  headline: AppTypographyItem;
  title: AppTypographyItem;
  body: AppTypographyItem;
  label: AppTypographyItem;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: AppColors = {
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
  };

  static readonly Typography: AppTypography = {
    display: { size: 30, weight: FontWeight.Medium },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Spacing: AppSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48,
  };

  static readonly Shapes: AppShapes = {
    small: 12,
    medium: 16,
    large: 20,
  };
}

// MARK: - Models
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

// MARK: - Main Screen
@Entry
@Component
struct StudyFocusSplitScreen {
  @State private selectedTabIndex: number = 0;
  @State private focusNote: string = "Focus on tone shifts across clay gradients";
  private swiperController: SwiperController = new SwiperController();

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
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background);

      Column() {
        // Top Bar
        Row() {
          Text("Back")
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSurface);

          Blank();

          Text("Study Focus Split")
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface);

          Blank();

          Text("Share")
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.secondary);
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface);

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Tab Row
            Scroll() {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Text(module.name.replace(/ /g, '\n'))
                      .fontSize(AppTokens.Typography.label.size)
                      .fontWeight(AppTokens.Typography.label.weight)
                      .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40);

                    // Indicator
                    Column()
                      .width('100%')
                      .height(2)
                      .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent);
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                  });
                }, (module: StudyModule) => module.name)
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface);
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off);

            // Pager Content (Main Card)
            Swiper(this.swiperController) {
              ForEach(this.modules, (module: StudyModule, index: number) => {
                ModuleCard({ module: module })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });
              }, (module: StudyModule) => module.name)
            }
            .index(this.selectedTabIndex)
            .indicator(false)
            .height(220)
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            });

            // Dual Pane
            Row({ space: AppTokens.Spacing.md }) {
              // Left Pane: Focus Board
              Column() {
                FocusBoard({ tasks: this.tasks });
              }
              .layoutWeight(1)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 });

              // Right Pane: Reflection
              Column() {
                ReflectionPanel({ focusNote: this.focusNote, onShuffle: () => {
                  this.focusNote = "Blend high and low tones before next critique";
                }});
              }
              .layoutWeight(1)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 });
            }
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .alignItems(VerticalAlign.Top);

            // Bottom Spacer
            Column().height(100);
          }
          .padding({ top: AppTokens.Spacing.md });
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1);
      }

      // Bottom Bar
      Column() {
        Blank();

        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text("Next checkpoint")
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface);
            Text("12:40 Studio")
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface);
          }
          .alignItems(HorizontalAlign.Start);

          Blank();

          Text("Launch session")
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium);
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetY: -2 });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct ModuleCard {
  private module: StudyModule = new StudyModule("", 0, "");

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(this.module.name)
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onSurface);

      Text(this.module.summary)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface);

      Divider()
        .color(AppTokens.Colors.outline)
        .margin({ top: 4, bottom: 4 });

      Row() {
        Text("Progress")
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface);

        Blank();

        Text(`${this.module.progress}%`)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.primary);
      }
      .width('100%');

      // Progress Bar
      Stack({ alignContent: Alignment.Start }) {
        // Background
        Column()
          .width('100%')
          .height(12)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small);

        // Fill
        Column()
          .width(`${this.module.progress}%`)
          .height(12)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small);
      }
      .width('100%')
      .height(12);

      // Button
      Text("Review outline")
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ top: 8 });
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 });
  }
}

@Component
struct FocusBoard {
  private tasks: TaskItem[] = [];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Focus board")
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface);

      ForEach(this.tasks, (task: TaskItem) => {
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text(task.title)
              .fontSize(AppTokens.Typography.body.size)
              .fontWeight(AppTokens.Typography.body.weight)
              .fontColor(AppTokens.Colors.onSurface);
            Text(task.duration)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.secondary);
          }
          .alignItems(HorizontalAlign.Start);

          Blank();
        }
        .width('100%')
        .padding(AppTokens.Spacing.sm)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .opacity(0.6);
      }, (task: TaskItem) => task.title);
    }
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start);
  }
}

@Component
struct ReflectionPanel {
  private focusNote: string = "";
  private onShuffle: () => void = () => {};

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Reflection")
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface);

      Text(this.focusNote)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%');

      Text("Shuffle note")
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ top: 12, bottom: 12 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.onShuffle();
        });
    }
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start);
  }
}