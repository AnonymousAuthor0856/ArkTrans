class AppColors {
  static primary: string = '#C08552';
  static secondary: string = '#9BB1C8';
  static tertiary: string = '#E6CFAF';
  static background: string = '#F3EFE6';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E7DDCF';
  static outline: string = '#D4C5B6';
  static success: string = '#6BB187';
  static warning: string = '#E2A458';
  static error: string = '#D66B5D';
  static onPrimary: string = '#2A1C13';
  static onSecondary: string = '#15202B';
  static onTertiary: string = '#2C1F10';
  static onBackground: string = '#261E19';
  static onSurface: string = '#2E251D';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
  static xxxl: number = 48;
}

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
struct StudyFocusSplitScreen {
  @State private selectedTabIndex: number = 0;
  @State private focusNote: string = 'Focus on tone shifts across clay gradients';
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

  @Builder
  private TopBar() {
    Row() {
      Button('Back')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
      Blank()
      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Blank()
      Button('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  private tabLabel(name: string): string {
    return name.replace(' ', '\n');
  }

  @Builder
  private TabRow() {
    Scroll() {
      Row({ space: 0 }) {
        ForEach(this.modules, (module: StudyModule, index: number) => {
          Column({ space: 8 }) {
            Text(this.tabLabel(module.name))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTabIndex === index ? AppColors.primary : AppColors.onSurface)
              .textAlign(TextAlign.Center)
              .height(40)
            Rect()
              .height(2)
              .width('100%')
              .fill(this.selectedTabIndex === index ? AppColors.primary : Color.Transparent)
          }
          .width(90)
          .padding({ top: 8, bottom: 8 })
          .onClick(() => {
            this.selectedTabIndex = index;
          })
        })
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .width('100%')
  }

  @Builder
  private ModuleCard(module: StudyModule) {
    Column({ space: AppSpacing.sm }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
      Text(module.summary)
        .fontSize(14)
        .fontColor('#2E251DCC')
        .width('100%')
        .textAlign(TextAlign.Start)
      Divider()
        .color(AppColors.outline)
        .margin({ top: 4, bottom: 4 })
      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Blank()
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      Stack({ alignContent: Alignment.Start }) {
        Rect()
          .width('100%')
          .height(12)
          .fill(AppColors.surfaceVariant)
          .radius(12)
        Rect()
          .width(`${module.progress}%`)
          .height(12)
          .fill(AppColors.primary)
          .radius(12)
      }
      .width('100%')
      .height(12)
      Blank().height(8)
      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .height(220)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0000000D', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private FocusBoard() {
    Column({ space: AppSpacing.sm }) {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
      ForEach(this.tasks, (task: TaskItem) => {
        Row() {
          Column({ space: AppSpacing.xs }) {
            Text(task.title)
              .fontSize(14)
              .fontColor(AppColors.onSurface)
            Text(task.duration)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
          }
          .alignItems(HorizontalAlign.Start)
          Blank()
        }
        .padding(AppSpacing.sm)
        .width('100%')
        .backgroundColor('#E7DDCF99')
        .borderRadius(12)
      })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0000000D', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private ReflectionCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
      Text(this.focusNote)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .padding(AppSpacing.md)
        .width('100%')
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
      Button('Shuffle note')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ top: 12, bottom: 12 })
        .width('100%')
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .layoutWeight(1)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(20)
    .shadow({ radius: 4, color: '#0000000D', offsetX: 0, offsetY: 2 })
  }

  @Builder
  private BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('12:40 Studio')
          .fontSize(14)
          .fontColor('#2E251DCC')
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button('Launch session')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .width('100%')
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 4, color: '#0000001A', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.TopBar()
        Scroll() {
          Column({ space: AppSpacing.lg }) {
            this.TabRow()
            this.ModuleCard(this.modules[this.selectedTabIndex])
              .margin({ left: AppSpacing.lg, right: AppSpacing.lg })
            Row({ space: AppSpacing.md }) {
              this.FocusBoard()
              this.ReflectionCard()
            }
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .width('100%')
            Blank().height(100)
          }
          .padding({ top: AppSpacing.md })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
