class Colors {
  primary: string = '#2563EB';
  secondary: string = '#60A5FA';
  tertiary: string = '#3B82F6';
  background: string = '#F3F4F6';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E5E7EB';
  outline: string = '#D1D5DB';
  success: string = '#16A34A';
  warning: string = '#F59E0B';
  error: string = '#DC2626';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#1E1E1E';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#1E1E1E';
  onSurface: string = '#1E1E1E';
}

class FontSpec {
  size: number = 0;
  weight: FontWeight = FontWeight.Normal;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class TypographyTokens {
  display: FontSpec = new FontSpec(28, FontWeight.Bold);
  title: FontSpec = new FontSpec(18, FontWeight.Medium);
  body: FontSpec = new FontSpec(14, FontWeight.Normal);
  label: FontSpec = new FontSpec(12, FontWeight.Medium);
}

class Spacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class ElevationSpec {
  radius: number = 0;
  y: number = 0;
  opacity: number = 0;

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius;
    this.y = y;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  level1: ElevationSpec = new ElevationSpec(4, 2, 0.12);
  level2: ElevationSpec = new ElevationSpec(8, 4, 0.16);
}

class AppTokens {
  static Colors: Colors = new Colors();
  static TypographyTokens: TypographyTokens = new TypographyTokens();
  static Spacing: Spacing = new Spacing();
  static ElevationMapping: ElevationMapping = new ElevationMapping();
  static Shapes = {
    small: 6,
    medium: 10,
    large: 14
  };
}

interface KanbanColumn {
  id: string;
  title: string;
  tasks: string[];
}

@Component
struct AssistChipView {
  task: string = '';

  build() {
    Button(this.task)
      .fontSize(AppTokens.TypographyTokens.body.size)
      .fontWeight(AppTokens.TypographyTokens.body.weight)
      .fontColor(AppTokens.Colors.onSurface)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg,
        top: AppTokens.Spacing.sm,
        bottom: AppTokens.Spacing.sm
      })
      .onClick(() => {
      })
  }
}

@Component
struct CardView {
  column: KanbanColumn = { id: '', title: '', tasks: [] };

  build() {
    Column() {
      Text(this.column.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.sm })

      ForEach(this.column.tasks, (task: string) => {
        AssistChipView({ task: task })
          .margin({ bottom: AppTokens.Spacing.sm })
      }, (task: string) => task)

      Blank()
    }
    .width(220)
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.y
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;

  private columns: KanbanColumn[] = [
    { id: '1', title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { id: '2', title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { id: '3', title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Kanban Board')
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.md
        })

        Column() {
          Row() {
            Text('Notifications')
              .fontSize(AppTokens.TypographyTokens.title.size)
              .fontWeight(AppTokens.TypographyTokens.title.weight)
              .fontColor(AppTokens.Colors.onSurface)

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor(AppTokens.Colors.primary)
              .onChange((value: boolean) => {
                this.notificationsEnabled = value;
              })
          }
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          List() {
            ForEach(this.columns, (col: KanbanColumn) => {
              ListItem() {
                CardView({ column: col })
              }
            }, (col: KanbanColumn) => col.id)
          }
          .listDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
          .margin({ bottom: AppTokens.Spacing.lg })
          .layoutWeight(1)

          Text('Task Completion')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.md })

          Progress({ value: 65, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .height(8)
            .borderRadius(4)
            .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .padding(AppTokens.Spacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
