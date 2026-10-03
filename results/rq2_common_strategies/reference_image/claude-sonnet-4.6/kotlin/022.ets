// 022GanttCharten | Productivity | Glassmorphic | en | 720x1280

const NAME: string = '022GanttCharten';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Glassmorphic';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#38BDF8';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#A5B4FC';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceGlass: string = '#B3FFFFFF';
  static readonly surfaceFaint: string = '#E5FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 26;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class AppElevation {
  static readonly radius1: number = 4;
  static readonly dy1: number = 2;
  static readonly color1: string = '#1F1E1E1E';
  static readonly radius2: number = 8;
  static readonly dy2: number = 4;
  static readonly color2: string = '#291E1E1E';
}

class Task {
  name: string;
  progress: number;

  constructor(name: string, progress: number) {
    this.name = name;
    this.progress = progress;
  }
}

@Entry
@Component
struct Index {
  @State tasks: Task[] = [
    new Task('Design Phase', 0.8),
    new Task('Development', 0.5),
    new Task('Testing', 0.3),
    new Task('Documentation', 0.6),
    new Task('Deployment', 0.2)
  ];
  @State notificationsEnabled: boolean = true;

  @Builder
  TaskCard(task: Task) {
    Column() {
      Text(task.name)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Start)

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(8)
          .borderRadius(4)
          .backgroundColor(AppColors.surfaceVariant)

        Row()
          .width(`${Math.round(task.progress * 100)}%`)
          .height(8)
          .borderRadius(4)
          .linearGradient({
            angle: 90,
            colors: [[AppColors.secondary, 0.0], [AppColors.tertiary, 1.0]]
          })

        Row() {
          Circle({ width: 6, height: 6 })
            .fill(AppColors.secondary)
        }
        .width('100%')
        .height(8)
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .height(8)
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .borderRadius(AppShapes.large)
    .backgroundColor(AppColors.surfaceGlass)
    .border({ width: 1, color: AppColors.surfaceFaint })
    .shadow({
      radius: AppElevation.radius2,
      color: AppElevation.color2,
      offsetX: 0,
      offsetY: AppElevation.dy2
    })
  }

  build() {
    Column() {
      // Top app bar (CenterAlignedTopAppBar)
      Text('Project Timeline')
        .fontSize(AppTypography.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
        .backgroundColor(AppColors.background)

      // Body
      Column() {
        Row() {
          Text('Notifications')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppColors.primary)
            .switchPointColor(AppColors.onPrimary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .height(40)
        .alignItems(VerticalAlign.Center)

        List({ space: AppSpacing.md }) {
          ForEach(this.tasks, (task: Task) => {
            ListItem() {
              this.TaskCard(task)
            }
          }, (task: Task) => task.name)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .margin({ top: AppSpacing.lg, bottom: AppSpacing.lg })

        Button('Add Task', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(52)
          .borderRadius(AppShapes.large)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(AppTypography.titleSize)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [AppColors.surfaceFaint, 0.0],
          [AppColors.background, 0.5],
          [AppColors.surfaceFaint, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}