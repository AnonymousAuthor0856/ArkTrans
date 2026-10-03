// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#FF2563EB',
    secondary: '#FF60A5FA',
    tertiary: '#FF3B82F6',
    background: '#FFF3F4F6',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
  };
  static readonly Typography = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };
  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  };
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };
}

interface KanbanColumn {
  title: string;
  tasks: string[];
}

@Entry
@Component
struct RootScreen {
  @State notificationsEnabled: boolean = true;
  
  private columns: KanbanColumn[] = [
    { title: "To Do", tasks: ["Write report", "Design mockup"] },
    { title: "In Progress", tasks: ["Implement feature X", "Fix layout bug"] },
    { title: "Done", tasks: ["Team sync", "Client feedback"] }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Kanban Board")
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center);

      // Content Area
      Scroll() {
        Column() {
          // Notifications Row
          Row() {
            Text("Notifications")
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onSurface);
            
            Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
              .selectedColor(AppTokens.Colors.primary)
              .onChange((isOn: boolean) => {
                this.notificationsEnabled = isOn;
              });
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg });

          // Kanban Columns (Horizontal Scroll)
          Scroll() {
            Row() {
              ForEach(this.columns, (col: KanbanColumn) => {
                // Card
                Column() {
                  Text(col.title)
                    .fontSize(AppTokens.Typography.title.fontSize)
                    .fontWeight(AppTokens.Typography.title.fontWeight)
                    .fontColor(AppTokens.Colors.primary)
                    .margin({ bottom: AppTokens.Spacing.sm });

                  ForEach(col.tasks, (task: string) => {
                    // AssistChip equivalent
                    Text(task)
                      .fontSize(AppTokens.Typography.body.fontSize)
                      .fontWeight(AppTokens.Typography.body.fontWeight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .backgroundColor(AppTokens.Colors.surfaceVariant)
                      .borderRadius(AppTokens.Shapes.medium)
                      .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                      .margin({ bottom: AppTokens.Spacing.sm });
                  });
                }
                .width(220)
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.large)
                .shadow({ radius: 8, color: '#29000000', offsetX: 0, offsetY: 4 })
                .margin({ right: AppTokens.Spacing.md });
              });
            }
            .padding({ bottom: AppTokens.Spacing.lg });
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%');

          // Task Completion Progress
          Text("Task Completion")
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm });

          // LinearProgressIndicator equivalent
          Row() {
            // Track
            Row() {
              // Progress
              Row()
                .width('65%')
                .height('100%')
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(4);
            }
            .width('100%')
            .height(8)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(4);
          }
          .width('100%');
        }
        .padding(AppTokens.Spacing.lg);
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}