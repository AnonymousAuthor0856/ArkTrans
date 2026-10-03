import window from '@ohos.window';

interface KanbanColumn {
  title: string;
  tasks: string[];
}

class AppColors {
  static readonly primary: ResourceColor = '#2563EB';
  static readonly secondary: ResourceColor = '#60A5FA';
  static readonly tertiary: ResourceColor = '#3B82F6';
  static readonly background: ResourceColor = '#F3F4F6';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E5E7EB';
  static readonly outline: ResourceColor = '#D1D5DB';
  static readonly success: ResourceColor = '#16A34A';
  static readonly warning: ResourceColor = '#F59E0B';
  static readonly error: ResourceColor = '#DC2626';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#1E1E1E';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#1E1E1E';
  static readonly onSurface: ResourceColor = '#1E1E1E';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

@Component
struct LinearProgressIndicator {
  @Prop value: number = 0;

  private progressWidth(): string {
    const normalized = Math.max(0, Math.min(1, this.value));
    return `${normalized * 100}%`;
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width(this.progressWidth())
        .height(8)
        .backgroundColor(AppColors.primary)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(4)
    .clip(true)
  }
}

@Component
struct AssistChipView {
  @Prop task: string = '';

  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(this.task)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
    .onClick(() => {
    })
  }
}

@Component
struct CardView {
  @Prop column: KanbanColumn = {
    title: '',
    tasks: []
  };

  build() {
    Column({ space: AppSpacing.sm }) {
      Text(this.column.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.primary)

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      Blank()
        .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .width(220)
    .height('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level2.radius,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
    {
      title: 'To Do',
      tasks: ['Write report', 'Design mockup']
    },
    {
      title: 'In Progress',
      tasks: ['Implement feature X', 'Fix layout bug']
    },
    {
      title: 'Done',
      tasks: ['Team sync', 'Client feedback']
    }
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((mainWindow: window.Window) => {
      mainWindow.setWindowLayoutFullScreen(true);
      mainWindow.setWindowSystemBarEnable([]);
    });
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Column({ space: 0 }) {
          Row() {
            Blank()

            Text('Kanban Board')
              .fontSize(AppTypography.displaySize)
              .fontWeight(AppTypography.displayWeight)
              .fontColor(AppColors.onSurface)

            Blank()
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: AppSpacing.md
          })
        }
        .width('100%')
        .backgroundColor(AppColors.background)

        Column({ space: AppSpacing.lg }) {
          Row() {
            Text('Notifications')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSurface)

            Blank()

            Toggle({
              type: ToggleType.Switch,
              isOn: this.notificationsEnabled
            })
              .selectedColor(AppColors.primary)
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              })
          }
          .width('100%')

          Scroll() {
            Row({ space: AppSpacing.md }) {
              ForEach(this.columns, (col: KanbanColumn) => {
                CardView({ column: col })
              }, (col: KanbanColumn) => col.title)
            }
            .height('100%')
            .padding({
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
          }
          .width('100%')
          .layoutWeight(1)
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Text('Task Completion')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface)

          LinearProgressIndicator({ value: 0.65 })
            .width('100%')
            .height(8)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}