import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

class AppTokens {
  static readonly Colors = {
    primary: '#2563EB',
    secondary: '#60A5FA',
    tertiary: '#3B82F6',
    background: '#F3F4F6',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#DC2626',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#FFFFFF',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static readonly TypographyTokens = {
    displaySize: 28,
    titleSize: 18,
    bodySize: 14,
    labelSize: 12
  };

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static readonly ElevationMapping = {
    level1: {
      radius: 4,
      offsetY: 2,
      color: '#1F000000'
    },
    level2: {
      radius: 8,
      offsetY: 4,
      color: '#29000000'
    }
  };
}

class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

@Component
struct AssistChipView {
  task: string = '';

  build() {
    Text(this.task)
      .fontSize(AppTokens.TypographyTokens.bodySize)
      .fontWeight(FontWeight.Regular)
      .fontColor(AppTokens.Colors.onSurface)
      .maxLines(1)
      .textOverflow({ overflow: TextOverflow.Clip })
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .onClick(() => {
      })
  }
}

@Component
struct CardView {
  column: KanbanColumn = new KanbanColumn('', []);

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text(this.column.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.primary)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
      }, (task: string) => task)

      Blank()
        .layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Start)
    .width(220)
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: AppTokens.ElevationMapping.level2.color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.offsetY
    })
  }
}

@Component
struct LinearProgressBar {
  value: number = 0.65;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(4)

      Row()
        .width(`${this.value * 100}%`)
        .height(8)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(4)
    }
    .width('100%')
    .height(8)
  }
}

@Entry
@Component
struct RootScreen {
  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  @State notificationsEnabled: boolean = true;

  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context)
      .then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      })
      .catch((err: BusinessError) => {
        console.error(`set full screen failed: ${err.code}, ${err.message}`);
      });
  }

  build() {
    Column() {
      Row() {
        Text('Kanban Board')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.lg,
        bottom: AppTokens.Spacing.md
      })
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(AppTokens.Colors.primary)
            .switchPointColor(AppTokens.Colors.surface)
            .width(52)
            .height(32)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              CardView({ column: col })
            }, (col: KanbanColumn) => col.title)
          }
          .height('100%')
          .padding({
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Text('Task Completion')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        LinearProgressBar({ value: 0.65 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}