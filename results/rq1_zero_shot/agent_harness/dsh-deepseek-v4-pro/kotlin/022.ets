const Colors = {
  primary: '#38BDF8',
  secondary: '#6366F1',
  tertiary: '#A5B4FC',
  background: '#F1F5F9',
  surface: '#FFFFFF',
  surfaceVariant: '#E2E8F0',
  outline: '#D1D5DB',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#1E1E1E',
  onTertiary: '#1E1E1E',
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

interface Task {
  name: string;
  progress: number;
}

@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true;
  @State tasks: Task[] = [
    { name: 'Design Phase', progress: 0.8 },
    { name: 'Development', progress: 0.5 },
    { name: 'Testing', progress: 0.3 },
    { name: 'Documentation', progress: 0.6 },
    { name: 'Deployment', progress: 0.2 }
  ];

  build() {
    Column() {
      Row() {
        Text('Project Timeline')
          .fontSize(26)
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
          Column({ space: Spacing.md }) {
            ForEach(this.tasks, (task: Task) => {
              Column() {
                Text(task.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.primary)
                Progress({ value: Math.round(task.progress * 100), total: 100, type: ProgressType.Linear })
                  .width('100%')
                  .height(8)
                  .color(Colors.secondary)
                  .backgroundColor(Colors.surfaceVariant)
              }
              .width('100%')
              .padding(Spacing.md)
              .space(Spacing.sm)
              .backgroundColor(Colors.surface)
              .borderRadius(16)
              .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
            }, (task: Task) => task.name)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        Button('Add Task')
          .width('100%')
          .height(52)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(18)
          .borderRadius(16)
          .onClick(() => {})
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .space(Spacing.lg)
      .linearGradient({ direction: GradientDirection.Bottom, colors: [['#FFFFFF', 0], [Colors.background, 0.5], ['#FFFFFF', 1]] })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
