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
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
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
struct MainActivity {
  @State notificationsEnabled: boolean = true;
  private tasks: Task[] = [
    new Task('Design Phase', 0.8),
    new Task('Development', 0.5),
    new Task('Testing', 0.3),
    new Task('Documentation', 0.6),
    new Task('Deployment', 0.2)
  ];

  @Builder
  Header(): void {
    Text('Project Timeline')
      .fontSize(26)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(AppColors.background);
  }

  @Builder
  TaskRow(task: Task): void {
    Column({ space: AppSpacing.sm }) {
      Text(task.name)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary);
      Progress({ value: task.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor('#B3FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start);
  }

  build() {
    Column() {
      this.Header();
      Column({ space: AppSpacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
          Blank();
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppColors.primary)
            .onChange((value: boolean) => {
              this.notificationsEnabled = value;
            });
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);
        Scroll() {
          Column({ space: AppSpacing.md }) {
            ForEach(this.tasks, (task: Task) => {
              this.TaskRow(task);
            }, (task: Task) => task.name)
          }
        }
        .layoutWeight(1);
        Button('Add Task')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
          .width('100%')
          .height(52);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surfaceVariant);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
