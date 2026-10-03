// entry/src/main/ets/pages/Index.ets
const APP_NAME: string = '021KanbanBoarden';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/** AppTokens.Colors */
export class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#60A5FA';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F3F4F6';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

/** AppTokens.TypographyTokens */
export class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

/** AppTokens.Shapes */
export class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

/** AppTokens.Spacing */
export class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

/** AppTokens.ShadowSpec */
export class ShadowSpec {
  elevation: number;
  radius: number;
  offsetX: number;
  offsetY: number;
  opacity: number;
  color: string;

  constructor(elevation: number, radius: number, offsetY: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.offsetX = 0;
    this.offsetY = offsetY;
    this.opacity = opacity;
    this.color = 'rgba(0, 0, 0, ' + opacity.toString() + ')';
  }
}

/** AppTokens.ElevationMapping */
export class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16);
}

export class KanbanColumn {
  title: string;
  tasks: string[];

  constructor(title: string, tasks: string[]) {
    this.title = title;
    this.tasks = tasks;
  }
}

@Extend(Text)
function displayText() {
  .fontSize(AppTypography.displaySize)
  .fontWeight(AppTypography.displayWeight)
  .fontColor(AppColors.onSurface)
}

@Extend(Text)
function titleText() {
  .fontSize(AppTypography.titleSize)
  .fontWeight(AppTypography.titleWeight)
  .fontColor(AppColors.onSurface)
}

@Extend(Text)
function bodyText() {
  .fontSize(AppTypography.bodySize)
  .fontWeight(AppTypography.bodyWeight)
  .fontColor(AppColors.onSurface)
}

@Entry
@Component
struct KanbanBoardPage {
  @State notificationsEnabled: boolean = true;
  @State taskCompletion: number = 0.65;
  private columns: KanbanColumn[] = [
    new KanbanColumn('To Do', ['Write report', 'Design mockup']),
    new KanbanColumn('In Progress', ['Implement feature X', 'Fix layout bug']),
    new KanbanColumn('Done', ['Team sync', 'Client feedback'])
  ];

  @Builder
  topBar() {
    Row() {
      Text('Kanban Board').displayText()
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 18, bottom: 10, left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.background)
  }

  @Builder
  notificationsRow() {
    Row() {
      Text('Notifications').titleText()

      Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
        .width(52)
        .height(30)
        .selectedColor(AppColors.primary)
        .onChange((isOn: boolean) => {
          this.notificationsEnabled = isOn;
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  columnRail() {
    Scroll() {
      Row({ space: AppSpacing.md }) {
        ForEach(this.columns, (col: KanbanColumn) => {
          this.columnCard(col)
        }, (col: KanbanColumn) => col.title)
      }
      .height('100%')
      .alignItems(VerticalAlign.Top)
    }
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
    .width('100%')
    .height('100%')
  }

  @Builder
  columnCard(col: KanbanColumn) {
    Column({ space: AppSpacing.sm }) {
      Text(col.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.primary)

      ForEach(col.tasks, (task: string) => {
        Text(task)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .padding({ left: 16, right: 16, top: 9, bottom: 9 })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
          })
      }, (task: string) => col.title + '-' + task)
    }
    .width(220)
    .height('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .alignItems(HorizontalAlign.Start)
    .shadow({
      radius: AppElevation.level2.radius,
      color: AppElevation.level2.color,
      offsetX: AppElevation.level2.offsetX,
      offsetY: AppElevation.level2.offsetY
    })
  }

  @Builder
  progressSection() {
    Column({ space: AppSpacing.sm }) {
      Text('Task Completion').titleText()

      Progress({ value: this.taskCompletion * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant)
        .style({ strokeWidth: 8 })
        .borderRadius(4)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      this.topBar()

      Column({ space: AppSpacing.lg }) {
        this.notificationsRow()
        this.columnRail()
        this.progressSection()
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
}