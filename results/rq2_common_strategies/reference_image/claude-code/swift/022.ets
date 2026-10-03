// App design tokens
class AppTokens {
  static Colors = {
    primary: '#FF38BDF8',
    secondary: '#FF6366F1',
    tertiary: '#FFA5B4FC',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
  };

  static Typography = {
    display: { size: 26, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static Shapes = {
    small: 6,
    medium: 10,
    large: 16,
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static Elevation = {
    level1: { radius: 4, dy: 2, opacity: 0.12 },
    level2: { radius: 8, dy: 4, opacity: 0.16 },
  };
}

// Task data model
interface Task {
  id: string;
  name: string;
  progress: number;
}

// Custom Switch component
@Component
struct CustomSwitch {
  @Link isOn: boolean;
  checkedThumbColor: string = AppTokens.Colors.primary;

  build() {
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      // Track
      Stack() { }
        .width(51)
        .height(31)
        .borderRadius(15.5)
        .backgroundColor(this.isOn ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)

      // Thumb
      Stack() { }
        .width(27)
        .height(27)
        .borderRadius(13.5)
        .backgroundColor(this.isOn ? this.checkedThumbColor : AppTokens.Colors.surface)
        .margin(2)
    }
    .width(51)
    .height(31)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}

// Custom Linear Progress component
@Component
struct CustomLinearProgress {
  progress: number = 0;
  trackColor: string = AppTokens.Colors.surfaceVariant;
  progressColor: string = AppTokens.Colors.secondary;
  height: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Stack() { }
        .width('100%')
        .height(this.height)
        .borderRadius(this.height / 2)
        .backgroundColor(this.trackColor)

      // Progress fill
      Stack() { }
        .width(`${this.progress * 100}%`)
        .height(this.height)
        .borderRadius(this.height / 2)
        .backgroundColor(this.progressColor)
    }
    .width('100%')
    .height(this.height)
  }
}

// Task item component
@Component
struct TaskItem {
  task: Task;

  build() {
    Column() {
      Text(this.task.name)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.primary)
        .margin({ bottom: AppTokens.Spacing.sm })

      CustomLinearProgress({
        progress: this.task.progress,
        trackColor: AppTokens.Colors.surfaceVariant,
        progressColor: AppTokens.Colors.secondary,
        height: 8,
      })
        .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor('rgba(255, 255, 255, 0.7)')
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level1.dy,
    })
  }
}

// Main entry component
@Entry
@Component
struct RootScreen {
  @State tasks: Task[] = [
    { id: '1', name: 'Design Phase', progress: 0.8 },
    { id: '2', name: 'Development', progress: 0.5 },
    { id: '3', name: 'Testing', progress: 0.3 },
    { id: '4', name: 'Documentation', progress: 0.6 },
    { id: '5', name: 'Deployment', progress: 0.2 },
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      // Top bar
      Text('Project Timeline')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: AppTokens.Spacing.sm + 20,
          bottom: AppTokens.Spacing.lg,
        })
        .backgroundColor(AppTokens.Colors.background)

      // Main content area with gradient background
      Column() {
        // Notifications toggle row
        Row() {
          Text('Notifications')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          CustomSwitch({
            isOn: $notificationsEnabled,
            checkedThumbColor: AppTokens.Colors.primary,
          })
        }
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.lg })

        // Task list (scrollable)
        Scroll() {
          Column() {
            ForEach(this.tasks, (task: Task) => {
              TaskItem({ task: task })
                .width('100%')
                .margin({ bottom: AppTokens.Spacing.md })
            }, (task: Task) => task.id)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Add Task button
        Button('Add Task')
          .width('100%')
          .height(52)
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.lg })
          .onClick(() => {
            console.info('Add Task button tapped!');
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .backgroundImage(
        `linear-gradient(180deg, rgba(255,255,255,0.8) 0%, ${AppTokens.Colors.background} 50%, rgba(255,255,255,0.8) 100%)`,
        ImageRepeat.NoRepeat
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
