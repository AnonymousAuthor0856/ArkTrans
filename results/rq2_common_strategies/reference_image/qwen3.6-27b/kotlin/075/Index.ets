import { router } from '@kit.ArkUI';

// --- Design Tokens & Constants ---

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
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 48
  },
  Radius: {
    small: 12,
    medium: 16,
    large: 20
  }
};

interface StudyModule {
  name: string;
  progress: number;
  summary: string;
}

interface TaskItem {
  title: string;
  duration: string;
}

@Entry
@Component
struct RootScreen {
  @State modules: StudyModule[] = [
    { name: "Clay Resonance", progress: 72, summary: "Acoustic prototypes" },
    { name: "Material Memory", progress: 54, summary: "Tactile journaling" },
    { name: "Morph Lab", progress: 83, summary: "Color blending" },
    { name: "Studio Review", progress: 28, summary: "Peer critique" }
  ];

  @State tasks: TaskItem[] = [
    { title: "Research layering", duration: "45m" },
    { title: "Feedback sync", duration: "30m" },
    { title: "Practice recall", duration: "20m" }
  ];

  @State focusNote: string = "Focus on tone shifts across clay gradients";
  @State currentTabIndex: number = 0;

  build() {
    Column() {
      // Top Bar
      this.TopBar();

      // Main Scrollable Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Tab Row
          this.TabRow();

          // Pager / Card Area
          this.ModuleCard(this.modules[this.currentTabIndex]);

          // Split Panes (Focus Board & Reflection)
          this.SplitPanes();
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md });

      // Bottom Bar
      this.BottomBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Text("Back")
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Medium)
        .fontSize(12)
        .onClick(() => {
          // Navigation logic placeholder
        });

      Blank().layoutWeight(1);

      Text("Study Focus Split")
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Medium)
        .fontSize(18)
        .textAlign(TextAlign.Center);

      Blank().layoutWeight(1);

      Text("Share")
        .fontColor(AppTokens.Colors.secondary)
        .fontWeight(FontWeight.Medium)
        .fontSize(12)
        .onClick(() => {
          // Share logic placeholder
        });
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppTokens.Colors.surface)
  }

  @Builder
  TabRow() {
    Row() {
      ForEach(this.modules, (module: StudyModule, index: number) => {
        Column() {
          Text(module.name)
            .fontColor(index === this.currentTabIndex ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .fontWeight(FontWeight.Medium)
            .fontSize(12)
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .textAlign(TextAlign.Center);
          
          // Active Indicator Line
          if (index === this.currentTabIndex) {
            Divider()
              .color(AppTokens.Colors.primary)
              .strokeWidth(3)
              .margin({ top: 4 });
          }
        }
        .layoutWeight(1)
        .onClick(() => {
          this.currentTabIndex = index;
        })
        .padding({ bottom: 8 })
      })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.05)', offsetY: 2 })
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(module.name)
        .fontColor(AppTokens.Colors.onSurface)
        .fontWeight(FontWeight.Medium)
        .fontSize(22);

      Text(module.summary)
        .fontColor(Color.AppTokens.Colors.onSurface.withAlpha(0.8))
        .fontSize(14);

      Divider()
        .color(AppTokens.Colors.outline)
        .strokeWidth(1);

      Row() {
        Text("Progress")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(12);
        
        Blank().layoutWeight(1);
        
        Text(`${module.progress}%`)
          .fontColor(AppTokens.Colors.primary)
          .fontWeight(FontWeight.Medium)
          .fontSize(18);
      }
      .width('100%');

      // Progress Bar
      Row() {
        Row()
          .width(`${module.progress}%`)
          .height(12)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.small);
      }
      .width('100%')
      .height(12)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Radius.small);

      Button("Review outline")
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Medium)
        .fontSize(12)
        .borderRadius(AppTokens.Radius.medium)
        .margin({ top: AppTokens.Spacing.sm });
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.08)', offsetY: 4 })
  }

  @Builder
  SplitPanes() {
    Row({ space: AppTokens.Spacing.md }) {
      // Focus Board
      Column({ space: AppTokens.Spacing.sm }) {
        Text("Focus board")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(18);

        Column({ space: AppTokens.Spacing.sm }) {
          ForEach(this.tasks, (task: TaskItem) => {
            Column({ space: AppTokens.Spacing.xs }) {
              Text(task.title)
                .fontColor(AppTokens.Colors.onSurface)
                .fontSize(14);
              
              Text(task.duration)
                .fontColor(AppTokens.Colors.secondary)
                .fontWeight(FontWeight.Medium)
                .fontSize(12);
            }
            .padding(AppTokens.Spacing.sm)
            .backgroundColor(Color.AppTokens.Colors.surfaceVariant.withAlpha(0.6))
            .borderRadius(AppTokens.Radius.small);
          })
        }

        Button("Add checkpoint")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .fontSize(12)
          .borderRadius(AppTokens.Radius.medium);
      }
      .layoutWeight(1)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Radius.large)
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.08)', offsetY: 4 });

      // Reflection
      Column({ space: AppTokens.Spacing.sm }) {
        Text("Reflection")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(18);

        Text(this.focusNote)
          .fontColor(AppTokens.Colors.onSurface)
          .fontSize(14)
          .lineHeight(22)
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.medium);

        Button("Shuffle note")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Medium)
          .fontSize(12)
          .borderRadius(AppTokens.Radius.medium)
          .onClick(() => {
            this.focusNote = "Blend high and low tones before next critique";
          });
      }
      .layoutWeight(1)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Radius.large)
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.08)', offsetY: 4 });
    }
    .width('100%');
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text("Next checkpoint")
          .fontColor(AppTokens.Colors.onSurface)
          .fontWeight(FontWeight.Medium)
          .fontSize(12);
        
        Text("12:40 Studio")
          .fontColor(Color.AppTokens.Colors.onSurface.withAlpha(0.8))
          .fontSize(14);
      }

      Blank().layoutWeight(1);

      Button("Launch session")
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Medium)
        .fontSize(12)
        .borderRadius(AppTokens.Radius.medium)
        .onClick(() => {
          // Launch logic
        });
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
  }
}