// index.ets
import { Length, Resource, Color } from '@ohos.arkui.UIContext';

// MARK: - App Tokens
class AppColors {
  static readonly primary: string = '#C08552';
  static readonly secondary: string = '#9BB1C8';
  static readonly tertiary: string = '#E6CFAF';
  static readonly background: string = '#F3EFE6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E7DDCF';
  static readonly outline: string = '#D4C5B6';
  static readonly success: string = '#6BB187';
  static readonly warning: string = '#E2A458';
  static readonly error: string = '#D66B5D';
  static readonly onPrimary: string = '#2A1C13';
  static readonly onSecondary: string = '#15202B';
  static readonly onTertiary: string = '#2C1F10';
  static readonly onBackground: string = '#261E19';
  static readonly onSurface: string = '#2E251D';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
  static readonly xxxl: number = 48;
}

class AppShapes {
  static readonly small: number = 12;
  static readonly medium: number = 16;
  static readonly large: number = 20;
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
        .backgroundColor(AppColors.background);

      Column() {
        // Top Bar
        Row() {
          Text("Back")
            .fontSize(12)
            .fontColor(AppColors.onSurface)
            .margin({ left: AppSpacing.lg });

          Blank();

          Text("Study Focus Split")
            .fontSize(18)
            .fontColor(AppColors.onSurface)
            .margin({ right: AppSpacing.lg });

          Blank();

          Text("Share")
            .fontSize(12)
            .fontColor(AppColors.secondary)
            .margin({ right: AppSpacing.lg });
        }
        .width('100%')
        .height(56)
        .backgroundColor(AppColors.surface);

        // Scrollable Content
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            // Tab Row
            Scroll() {
              Row({ space: 0 }) {
                ForEach(this.modules, (module: StudyModule, index: number) => {
                  Column({ space: 8 }) {
                    Text(module.name.replace(/ /g, '\n'))
                      .fontSize(12)
                      .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
                      .textAlign(TextAlign.Center)
                      .maxLines(2)
                      .height(40);

                    // Indicator
                    Row()
                      .width('100%')
                      .height(2)
                      .backgroundColor(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent.toString());
                  }
                  .width(90)
                  .padding({ top: 8, bottom: 8 })
                  .onClick(() => {
                    this.selectedTabIndex = index;
                  });
                }, (module: StudyModule) => module.name);
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .backgroundColor(AppColors.surface);
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%');

            // Pager Content (Main Card)
            Swiper() {
              ForEach(this.modules, (module: StudyModule, index: number) => {
                Column() {
                  this.ModuleCard(module)
                }
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg });
              }, (module: StudyModule) => module.name);
            }
            .index(this.selectedTabIndex)
            .indicator(false)
            .loop(false)
            .height(220)
            .width('100%');

            // Dual Pane
            Row({ space: AppSpacing.md }) {
              // Left Pane: Focus Board
              Column() {
                this.FocusBoardPane();
              }
              .layoutWeight(1)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 });

              // Right Pane: Reflection
              Column() {
                this.ReflectionPane();
              }
              .layoutWeight(1)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.large)
              .shadow({ radius: 4, color: '#0D000000', offsetY: 2 });
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .alignItems(VerticalAlign.Top);

            // Bottom Spacer
            Column().height(100);
          }
          .padding({ top: AppSpacing.md });
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%');

      // Bottom Bar
      Column() {
        Blank();

        Row() {
          Column({ space: AppSpacing.xs }) {
            Text("Next checkpoint")
              .fontSize(12)
              .fontColor(AppColors.onSurface);
            Text("12:40 Studio")
              .fontSize(14)
              .fontColor(AppColors.onSurface);
          }
          .alignItems(HorizontalAlign.Start);

          Blank();

          Text("Launch session")
            .fontSize(12)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium);
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.surface)
        .shadow({ radius: 4, color: '#1A000000', offsetY: -2 });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column({ space: AppSpacing.sm }) {
      Text(module.name)
        .fontSize(22)
        .fontColor(AppColors.onSurface);

      Text(module.summary)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.8);

      Divider()
        .color(AppColors.outline)
        .margin({ top: 4, bottom: 4 });

      Row() {
        Text("Progress")
          .fontSize(12)
          .fontColor(AppColors.onSurface);
        Blank();
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontColor(AppColors.primary);
      }
      .width('100%');

      // Progress Bar
      Stack({ alignContent: Alignment.Start }) {
        // Background
        Row()
          .width('100%')
          .height(12)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small);
        
        // Fill
        Row()
          .width(`${module.progress}%`)
          .height(12)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small);
      }
      .width('100%')
      .height(12);

      Text("Review outline")
        .fontSize(12)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .margin({ top: 8 });
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({ radius: 4, color: '#0D000000', offsetY: 2 });
  }

  @Builder
  FocusBoardPane() {
    Column({ space: AppSpacing.sm }) {
      Text("Focus board")
        .fontSize(18)
        .fontColor(AppColors.onSurface);

      ForEach(this.tasks, (task: TaskItem) => {
        Row() {
          Column({ space: AppSpacing.xs }) {
            Text(task.title)
              .fontSize(14)
              .fontColor(AppColors.onSurface);
            Text(task.duration)
              .fontSize(12)
              .fontColor(AppColors.secondary);
          }
          .alignItems(HorizontalAlign.Start);

          Blank();
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .backgroundColor(AppColors.surfaceVariant)
        .opacity(0.6)
        .borderRadius(AppShapes.small);
      }, (task: TaskItem) => task.title);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  ReflectionPane() {
    Column({ space: AppSpacing.sm }) {
      Text("Reflection")
        .fontSize(18)
        .fontColor(AppColors.onSurface);

      Text(this.focusNote)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .padding(AppSpacing.md)
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium);

      Text("Shuffle note")
        .fontSize(12)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 0, right: 0, top: 12, bottom: 12 })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
          this.focusNote = "Blend high and low tones before next critique";
        });
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start);
  }
}