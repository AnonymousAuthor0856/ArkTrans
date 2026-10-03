const NAME: string = "206_StudyFocusSplit_en";
const UI_TYPE: string = "Education SplitPane";
const STYLE_THEME: string = "Clay Morph";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const DENSITY_SPACING: string = "Medium";
const COMPLEXITY: string = "Pairs TabRow and Pager views to organize study modules alongside dual focus panes and actions.";
const EXTRA: string = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts.";

class AppColors {
  static readonly primary: string = '#C08552';
  static readonly secondary: string = '#9BB1C8';
  static readonly background: string = '#F3EFE6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E7DDCF';
  static readonly outline: string = '#D4C5B6';
  static readonly onSurface: string = '#2E251D';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
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
struct MainActivity {
  @State selectedPage: number = 0;
  @State focusNote: string = 'Focus on tone shifts across clay gradients';

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
  TopBar() {
    Row() {
      Button('Back')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
      Text('Study Focus Split')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
      Button('Share')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(64)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  TabRowView() {
    Row() {
      ForEach(this.modules, (module: StudyModule, index: number) => {
        Text(module.name)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedPage === index ? AppColors.primary : AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          .height(46)
          .padding({ left: 4, right: 4 })
          .backgroundColor(AppColors.surface)
          .onClick(() => {
            this.selectedPage = index;
          })
      })
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ModuleCard(module: StudyModule) {
    Column({ space: AppSpacing.sm }) {
      Text(module.name)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
      Text(module.summary)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.8)
        .width('100%')
      Divider().color(AppColors.outline)
      Row() {
        Text('Progress')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(`${module.progress}%`)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Stack({ alignContent: Alignment.Start }) {
        Blank().width('100%').height(12).backgroundColor(AppColors.surfaceVariant).borderRadius(12)
        Blank().width(`${module.progress}%`).height(12).backgroundColor(AppColors.primary).borderRadius(12)
      }
      .width('100%')
      .height(12)
      Button('Review outline')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .borderRadius(16)
    }
    .width('100%')
    .height(220)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
  }

  @Builder
  FocusBoard() {
    Column({ space: AppSpacing.sm }) {
      Text('Focus board')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
      ForEach(this.tasks, (task: TaskItem) => {
        Column({ space: AppSpacing.xs }) {
          Text(task.title)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
          Text(task.duration)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
        }
        .width('100%')
        .padding(AppSpacing.sm)
        .backgroundColor('#99E7DDCF')
        .borderRadius(12)
      })
      Button('Add checkpoint')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .borderRadius(16)
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
  }

  @Builder
  ReflectionCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Reflection')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
      Text(this.focusNote)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
      Button('Shuffle note')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .borderRadius(16)
        .onClick(() => {
          this.focusNote = 'Blend high and low tones before next critique';
        })
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(20)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Next checkpoint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('12:40 Studio')
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .opacity(0.8)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Button('Launch session')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .height(40)
        .borderRadius(16)
    }
    .width('100%')
    .height(66)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 10, color: '#29000000', offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.TabRowView()
          this.ModuleCard(this.modules[this.selectedPage])
          Row({ space: AppSpacing.md }) {
            this.FocusBoard()
            this.ReflectionCard()
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
