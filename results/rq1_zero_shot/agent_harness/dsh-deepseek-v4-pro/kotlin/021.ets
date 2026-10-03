const Colors = {
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

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

interface KanbanColumn {
  title: string;
  tasks: string[];
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;
  @State columns: KanbanColumn[] = [
    { title: 'To Do', tasks: ['Write report', 'Design mockup'] },
    { title: 'In Progress', tasks: ['Implement feature X', 'Fix layout bug'] },
    { title: 'Done', tasks: ['Team sync', 'Client feedback'] }
  ];

  build() {
    Column() {
      Row() {
        Text('Kanban Board')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Colors.background)

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
            .selectedColor(Colors.primary)
            .onChange((isOn: boolean) => {
              this.notificationsEnabled = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Row({ space: Spacing.md }) {
            ForEach(this.columns, (col: KanbanColumn) => {
              Column() {
                Text(col.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.primary)
                ForEach(col.tasks, (task: string) => {
                  Column() {
                    Text(task)
                      .fontSize(14)
                      .fontColor(Colors.onSurface)
                  }
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(10)
                }, (task: string) => task)
              }
              .width(220)
              .padding(Spacing.md)
              .space(Spacing.sm)
              .backgroundColor(Colors.surface)
              .borderRadius(14)
              .shadow({ radius: 8, color: 'rgba(0, 0, 0, 0.16)', offsetY: 4 })
            }, (col: KanbanColumn) => col.title)
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .width('100%')

        Text('Task Completion')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Progress({ value: 65, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .space(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
