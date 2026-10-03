// ArkTS translation of 075.swift (SwiftUI).
// iOS-specific concepts are adapted to the ArkUI declarative component model:
//   - @main struct App -> @Entry @Component
//   - View / body -> @Component / build()
//   - @State -> @State
//   - ZStack / HStack / VStack -> Stack / Row / Column
//   - ScrollView -> Scroll
//   - TabView(PageTabViewStyle) -> Swiper
//   - GeometryReader -> onAreaChange
//   - Color / Font.system -> hex color / fontSize + fontWeight

@Entry
@Component
struct StudyFocusApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    // SwiftUI: .preferredColorScheme(.light) and .statusBarHidden(true).
    // ArkUI defaults to a light theme; status-bar visibility is an application-level setting.
    StudyFocusSplitScreen()
  }
}

// MARK: - App Tokens

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyTokens {
  displaySize: number;
  displayWeight: number;
  headlineSize: number;
  headlineWeight: number;
  titleSize: number;
  titleWeight: number;
  bodySize: number;
  bodyWeight: number;
  labelSize: number;
  labelWeight: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ShapesTokens {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
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
  };

  static readonly Typography: TypographyTokens = {
    displaySize: 30,
    displayWeight: 600, // .semibold
    headlineSize: 22,
    headlineWeight: 500, // .medium
    titleSize: 18,
    titleWeight: 500, // .medium
    bodySize: 14,
    bodyWeight: 400, // .regular
    labelSize: 12,
    labelWeight: 500 // .medium
  };

  static readonly Spacing: SpacingTokens = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  };

  static readonly Shapes: ShapesTokens = {
    small: 12,
    medium: 16,
    large: 20
  };
}

// MARK: - Models

class StudyModule {
  id: string = '';
  name: string = '';
  progress: number = 0;
  summary: string = '';
  private static counter: number = 0;

  constructor(name: string, progress: number, summary: string) {
    StudyModule.counter += 1;
    this.id = 'module-' + StudyModule.counter.toString();
    this.name = name;
    this.progress = progress;
    this.summary = summary;
  }
}

class TaskItem {
  id: string = '';
  title: string = '';
  duration: string = '';
  private static counter: number = 0;

  constructor(title: string, duration: string) {
    TaskItem.counter += 1;
    this.id = 'task-' + TaskItem.counter.toString();
    this.title = title;
    this.duration = duration;
  }
}

// MARK: - Main Screen

@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';
  private swiperController: SwiperController = new SwiperController();

  private modules: StudyModule[] = [
    new StudyModule('Clay Resonance', 72, 'Acoustic prototypes'),
    new StudyModule('Material Memory', 54, 'Tactile journaling'),
    new StudyModule('Morph Lab', 83, 'Color blending'),
    new StudyModule('Studio Review', 28, 'Peer critique')
  ];

  private tasks: TaskItem[] = [
    new TaskItem('Research layering', '45m'),
    new TaskItem('Feedback sync', '30m'),
    new TaskItem('Practice recall', '20m')
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Button('Back', { type: ButtonType.Normal })
            .backgroundColor(Color.Transparent)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .onClick(() => {
            })
          Blank()
          Text('Study Focus Split')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Button('Share', { type: ButtonType.Normal })
            .backgroundColor(Color.Transparent)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.secondary)
            .onClick(() => {
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Tab Row
            Scroll() {
              Row() {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(module.name.split(' ').join('\n'))
                      .fontSize(AppTokens.Typography.labelSize)
                      .fontWeight(AppTokens.Typography.labelWeight)
                      .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40)

                    Row()
                      .width('100%')
                      .height(2)
                      .backgroundColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    animateTo({ duration: 300 }, () => {
                      this.selectedTabIndex = index;
                    });
                    this.swiperController.changeIndex(index, true);
                  })
                }, (module: StudyModule, index: number) => index.toString())
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface)
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Pager Content (Main Card)
            Swiper(this.swiperController) {
              ForEach(this.modules, (module: StudyModule, index: number) => {
                ModuleCard({ module: module })
                  .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              }, (module: StudyModule, index: number) => index.toString())
            }
            .index(this.selectedTabIndex)
            .loop(false)
            .indicator(false)
            .width('100%')
            .height(220) // Fixed height to match design
            .onChange((index: number) => {
              this.selectedTabIndex = index;
            })

            // Dual Pane
            Row({ space: AppTokens.Spacing.md }) {
              // Left Pane: Focus Board
              Column() {
                CardView({ bgColor: AppTokens.Colors.surface }) {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Text('Focus board')
                      .fontSize(AppTokens.Typography.titleSize)
                      .fontWeight(AppTokens.Typography.titleWeight)
                      .fontColor(AppTokens.Colors.onSurface)

                    ForEach(this.tasks, (task: TaskItem, index: number) => {
                      Row() {
                        Column({ space: AppTokens.Spacing.xs }) {
                          Text(task.title)
                            .fontSize(AppTokens.Typography.bodySize)
                            .fontWeight(AppTokens.Typography.bodyWeight)
                            .fontColor(AppTokens.Colors.onSurface)
                          Text(task.duration)
                            .fontSize(AppTokens.Typography.labelSize)
                            .fontWeight(AppTokens.Typography.labelWeight)
                            .fontColor(AppTokens.Colors.secondary)
                        }
                        .alignItems(HorizontalAlign.Start)
                        Blank()
                      }
                      .width('100%')
                      .padding(AppTokens.Spacing.sm)
                      .backgroundColor('#E7DDCF99') // surfaceVariant.opacity(0.6)
                      .borderRadius(AppTokens.Shapes.small)
                    }, (task: TaskItem, index: number) => index.toString())

                    // Button placeholder
                    Blank().height(8) // Mimic button presence
                    Button('Add checkpoint')
                      .fontSize(AppTokens.Typography.labelSize)
                      .fontWeight(AppTokens.Typography.labelWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .width('100%')
                      .padding({ top: 8, bottom: 8 })
                      .backgroundColor(AppTokens.Colors.surfaceVariant)
                      .borderRadius(AppTokens.Shapes.small)
                      .opacity(0.0) // Invisible placeholder to match spacing logic
                      .height(0) // Hiding it to match screenshot more closely
                      .onClick(() => {
                      })
                  }
                  .width('100%')
                  .padding(AppTokens.Spacing.md)
                  .alignItems(HorizontalAlign.Start)
                }
              }
              .layoutWeight(1)

              // Right Pane: Reflection
              Column() {
                CardView({ bgColor: AppTokens.Colors.surfaceVariant }) {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Text('Reflection')
                      .fontSize(AppTokens.Typography.titleSize)
                      .fontWeight(AppTokens.Typography.titleWeight)
                      .fontColor(AppTokens.Colors.onSurface)

                    Text(this.focusNote)
                      .fontSize(AppTokens.Typography.bodySize)
                      .fontWeight(AppTokens.Typography.bodyWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .padding(AppTokens.Spacing.md)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .backgroundColor(AppTokens.Colors.surface)
                      .borderRadius(AppTokens.Shapes.medium)

                    Button('Shuffle note')
                      .fontSize(AppTokens.Typography.labelSize)
                      .fontWeight(AppTokens.Typography.labelWeight)
                      .fontColor('#000000CC') // Color.black.opacity(0.8)
                      .width('100%')
                      .padding({ top: 12, bottom: 12 })
                      .backgroundColor(AppTokens.Colors.primary)
                      .borderRadius(AppTokens.Shapes.medium)
                      .onClick(() => {
                        this.focusNote = 'Blend high and low tones before next critique';
                      })
                  }
                  .width('100%')
                  .padding(AppTokens.Spacing.md)
                  .alignItems(HorizontalAlign.Start)
                }
              }
              .layoutWeight(1)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            Blank().height(100) // Spacer().frame(height: 100)
          }
          .padding({ top: AppTokens.Spacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom Bar
      Column() {
        Blank()
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text('Next checkpoint')
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(AppTokens.Typography.labelWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('12:40 Studio')
              .fontSize(AppTokens.Typography.bodySize)
              .fontWeight(AppTokens.Typography.bodyWeight)
              .fontColor('#2E251DCC') // onSurface.opacity(0.8)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Launch session')
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor('#000000B3') // Color.black.opacity(0.7)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
            })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ color: '#0000001A', radius: 4, offsetX: 0, offsetY: -2 }) // black.opacity(0.1)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct ModuleCard {
  module: StudyModule = new StudyModule('', 0, '');
  @State progressBarWidth: number = 0;

  build() {
    CardView({ bgColor: AppTokens.Colors.surface }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Text(this.module.name)
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(AppTokens.Typography.headlineWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.module.summary)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor('#2E251DCC') // onSurface.opacity(0.8)

        Divider()
          .strokeWidth(1)
          .color(AppTokens.Colors.outline)
          .margin({ top: 4, bottom: 4 })

        Row() {
          Text('Progress')
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text(this.module.progress + '%')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.primary)
        }
        .width('100%')

        // Progress Bar (GeometryReader -> onAreaChange)
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(12)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Row()
            .width(this.progressBarWidth * this.module.progress / 100)
            .height(12)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .height(12)
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.progressBarWidth = Number(newValue.width);
        })

        Blank().height(8) // Spacer().frame(height: 8)

        Button('Review outline')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor('#000000B3') // Color.black.opacity(0.7)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .onClick(() => {
          })
      }
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
  }
}

@Component
struct CardView {
  bgColor: string = '#FFFFFF';

  @Builder
  defaultContent() {
  }

  @BuilderParam content: () => void = this.defaultContent;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(this.bgColor)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ color: '#0000000D', radius: 4, offsetX: 0, offsetY: 2 }) // black.opacity(0.05)
  }
}
