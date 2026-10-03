import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - App Tokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    display: { size: 30, weight: FontWeight.Semibold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  },
  Shapes: {
    small: 12,
    medium: 16,
    large: 20
  }
};

// MARK: - Models
interface StudyModule {
  id: string;
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  id: string;
  title: string;
  duration: string;
}

// MARK: - Components

@Component
struct CardView {
  @Prop backgroundColor: string;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content();
    }
    .backgroundColor(this.backgroundColor)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 2 })
  }
}

@Component
struct ModuleCard {
  @ObjectLink module: StudyModule;

  build() {
    CardView({ backgroundColor: AppTokens.Colors.surface }) {
      Column({ space: AppTokens.Spacing.sm }) {
        Text(this.module.name)
          .font({ size: AppTokens.Typography.headline.size, weight: AppTokens.Typography.headline.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .alignSelf(ItemAlign.Start);

        Text(this.module.summary)
          .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
          .fontColor('rgba(46, 37, 29, 0.8)') // Opacity logic for ArkTS
          .alignSelf(ItemAlign.Start);

        Divider()
          .color(AppTokens.Colors.outline)
          .margin({ top: 4, bottom: 4 });

        Row() {
          Text("Progress")
            .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
            .fontColor(AppTokens.Colors.onSurface);
          Blank();
          Text(`${this.module.progress}%`)
            .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
            .fontColor(AppTokens.Colors.primary);
        }

        // Progress Bar
        Row() {
          Progress({ value: this.module.progress, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(12)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .linearProgress({ color: AppTokens.Colors.primary, cornerRadius: AppTokens.Shapes.small });
        }
        .margin({ top: 8 });

        Button("Review outline") {
          // Action
        }
        .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
        .fontColor('#2A1C13') // Dark text on brown button
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .alignSelf(ItemAlign.Start);
      }
      .padding(AppTokens.Spacing.lg)
    }
  }
}

// MARK: - Main Screen

@Entry
@Component
struct StudyFocusSplitScreen {
  @State selectedTabIndex: number = 0;
  @State focusNote: string = "Focus on tone shifts across clay gradients";

  modules: StudyModule[] = [
    { id: '1', name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { id: '2', name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { id: '3', name: "Morph Lab", progress: 83, summary: "Color blending" },
    { id: '4', name: "Studio Review", progress: 28, summary: "Peer critique" }
  ];

  tasks: TaskItem[] = [
    { id: '1', title: "Research layering", duration: "45m" },
    { id: '2', title: "Feedback sync", duration: "30m" },
    { id: '3', title: "Practice recall", duration: "20m" }
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
          Button("Back") {
            // Action
          }
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(Color.Transparent)
          .borderWidth(0);

          Blank();
          Text("Study Focus Split")
            .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
            .fontColor(AppTokens.Colors.onSurface);
          Blank();
          Button("Share") {
            // Action
          }
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .borderWidth(0);
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface);

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            
            // Tab Row
            Scroll({ scrollable: ScrollDirection.Horizontal, indicator: Indicator.AutoNever }) {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(module.name.replace(' ', '\n'))
                      .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                      .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40);
                    
                    Rect()
                      .fill(this.selectedTabIndex === index ? AppTokens.Colors.primary : Color.Transparent)
                      .height(2);
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                  });
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
              .backgroundColor(AppTokens.Colors.surface);
            }
            .height(60); // Approximate height for tabs

            // Pager Content (Main Card)
            // Note: ArkTS doesn't have a direct PageTabViewStyle equivalent that works seamlessly with 
            // dynamic data without complex gesture handling. We simulate the active card view here.
            // In a real app, you might use a custom horizontal swiper or just show the selected one if it's not strictly paging.
            // To match the screenshot exactly which shows ONE card, we render the selected one.
            Column() {
              ModuleCard({ module: this.modules[this.selectedTabIndex] })
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .height(220);

            // Dual Pane
            Row({ space: AppTokens.Spacing.md }) {
              // Left Pane: Focus Board
              Column() {
                CardView({ backgroundColor: AppTokens.Colors.surface }) {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Text("Focus board")
                      .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
                      .fontColor(AppTokens.Colors.onSurface)
                      .alignSelf(ItemAlign.Start);

                    ForEach(this.tasks, (task: TaskItem) => {
                      Row() {
                        Column({ space: AppTokens.Spacing.xs }) {
                          Text(task.title)
                            .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
                            .fontColor(AppTokens.Colors.onSurface);
                          Text(task.duration)
                            .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                            .fontColor(AppTokens.Colors.secondary);
                        }
                        .alignSelf(ItemAlign.Start);
                        Blank();
                      }
                      .padding(AppTokens.Spacing.sm)
                      .backgroundColor('rgba(231, 221, 207, 0.6)') // SurfaceVariant opacity
                      .borderRadius(AppTokens.Shapes.small);
                    });

                    // Spacer to mimic cutoff
                    Blank().height(8);
                  }
                  .padding(AppTokens.Spacing.md)
                }
              }
              .layoutWeight(1);

              // Right Pane: Reflection
              Column() {
                CardView({ backgroundColor: AppTokens.Colors.surfaceVariant }) {
                  Column({ space: AppTokens.Spacing.sm }) {
                    Text("Reflection")
                      .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
                      .fontColor(AppTokens.Colors.onSurface)
                      .alignSelf(ItemAlign.Start);

                    Text(this.focusNote)
                      .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
                      .fontColor(AppTokens.Colors.onSurface)
                      .padding(AppTokens.Spacing.md)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .backgroundColor(AppTokens.Colors.surface)
                      .borderRadius(AppTokens.Shapes.medium);

                    Button("Shuffle note") {
                      this.focusNote = "Blend high and low tones before next critique";
                    }
                    .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
                    .fontColor('#2A1C13') // Dark text
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.medium)
                    .width('100%')
                    .padding({ top: 12, bottom: 12 });
                  }
                  .padding(AppTokens.Spacing.md)
                }
              }
              .layoutWeight(1);
            }
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });

            Blank().height(100);
          }
          .padding({ top: AppTokens.Spacing.md });
        }
        .layoutWeight(1);

        // Bottom Bar
        Row() {
          Column({ space: AppTokens.Spacing.xs }) {
            Text("Next checkpoint")
              .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
              .fontColor(AppTokens.Colors.onSurface);
            Text("12:40 Studio")
              .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
              .fontColor('rgba(46, 37, 29, 0.8)');
          }
          .alignSelf(ItemAlign.Start);
          
          Blank();
          
          Button("Launch session") {
            // Action
          }
          .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
          .fontColor('#2A1C13') // Dark text
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 24, right: 24, top: 12, bottom: 12 });
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}