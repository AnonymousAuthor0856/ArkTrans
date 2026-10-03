class ColorTokens {
  static readonly primary: string = '#FF38BDF8';
  static readonly secondary: string = '#FF6366F1';
  static readonly tertiary: string = '#FFA5B4FC';
  static readonly background: string = '#FFF1F5F9';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE2E8F0';
  static readonly outline: string = '#FFD1D5DB';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF1E1E1E';
  static readonly onTertiary: string = '#FF1E1E1E';
  static readonly onBackground: string = '#FF1E1E1E';
  static readonly onSurface: string = '#FF1E1E1E';
}

class TypographyTokens {
  static readonly displaySize: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class ShapeTokens {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 16;
}

class SpacingTokens {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ElevationData {
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;

  constructor(radius: number, dy: number, opacity: number) {
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationTokens {
  static readonly level1: ElevationData = new ElevationData(4, 2, 0.12);
  static readonly level2: ElevationData = new ElevationData(8, 4, 0.16);
}

class Task {
  id: string = '';
  name: string = '';
  progress: number = 0;

  constructor(id: string, name: string, progress: number) {
    this.id = id;
    this.name = name;
    this.progress = progress;
  }
}

@Component
struct CustomSwitch {
  @Link isOn: boolean;
  checkedThumbColor: string = ColorTokens.primary;

  build() {
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      Stack() { }
        .width(51)
        .height(31)
        .borderRadius(15.5)
        .backgroundColor(this.isOn ? ColorTokens.primary : ColorTokens.surfaceVariant)

      Stack() { }
        .width(27)
        .height(27)
        .borderRadius(13.5)
        .backgroundColor(this.isOn ? this.checkedThumbColor : ColorTokens.surface)
        .margin(2)
    }
    .width(51)
    .height(31)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
  }
}

@Component
struct CustomLinearProgress {
  progress: number = 0;
  trackColor: string = ColorTokens.surfaceVariant;
  progressColor: string = ColorTokens.secondary;
  barHeight: number = 8;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Stack() { }
        .width('100%')
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
        .backgroundColor(this.trackColor)

      Stack() { }
        .width(`${this.progress * 100}%`)
        .height(this.barHeight)
        .borderRadius(this.barHeight / 2)
        .backgroundColor(this.progressColor)
    }
    .width('100%')
    .height(this.barHeight)
  }
}

@Component
struct TaskItem {
  task: Task = new Task('', '', 0);

  build() {
    Column() {
      Text(this.task.name)
        .fontSize(TypographyTokens.titleSize)
        .fontWeight(TypographyTokens.titleWeight)
        .fontColor(ColorTokens.primary)
        .margin({ bottom: SpacingTokens.sm })

      CustomLinearProgress({
        progress: this.task.progress,
        trackColor: ColorTokens.surfaceVariant,
        progressColor: ColorTokens.secondary,
        barHeight: 8,
      })
        .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(SpacingTokens.md)
    .backgroundColor('rgba(255, 255, 255, 0.7)')
    .borderRadius(ShapeTokens.large)
    .shadow({
      radius: ElevationTokens.level1.radius,
      color: `rgba(0, 0, 0, ${ElevationTokens.level1.opacity})`,
      offsetX: 0,
      offsetY: ElevationTokens.level1.dy,
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State tasks: Task[] = [
    new Task('1', 'Design Phase', 0.8),
    new Task('2', 'Development', 0.5),
    new Task('3', 'Testing', 0.3),
    new Task('4', 'Documentation', 0.6),
    new Task('5', 'Deployment', 0.2),
  ];
  @State notificationsEnabled: boolean = true;

  build() {
    Column() {
      Text('Project Timeline')
        .fontSize(TypographyTokens.displaySize)
        .fontWeight(TypographyTokens.displayWeight)
        .fontColor(ColorTokens.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: SpacingTokens.sm + 20,
          bottom: SpacingTokens.lg,
        })
        .backgroundColor(ColorTokens.background)

      Column() {
        Row() {
          Text('Notifications')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(ColorTokens.onSurface)

          Blank()

          CustomSwitch({
            isOn: $notificationsEnabled,
            checkedThumbColor: ColorTokens.primary,
          })
        }
        .width('100%')
        .margin({ bottom: SpacingTokens.lg })

        Scroll() {
          Column() {
            ForEach(this.tasks, (task: Task) => {
              TaskItem({ task: task })
                .width('100%')
                .margin({ bottom: SpacingTokens.md })
            }, (task: Task) => task.id)
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Button('Add Task')
          .width('100%')
          .height(52)
          .fontSize(TypographyTokens.titleSize)
          .fontWeight(TypographyTokens.titleWeight)
          .fontColor(ColorTokens.onPrimary)
          .backgroundColor(ColorTokens.primary)
          .borderRadius(ShapeTokens.large)
          .margin({ top: SpacingTokens.lg })
          .onClick(() => {
            console.info('Add Task button tapped!');
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(SpacingTokens.lg)
      .backgroundImage(
        `linear-gradient(180deg, rgba(255,255,255,0.8) 0%, ${ColorTokens.background} 50%, rgba(255,255,255,0.8) 100%)`,
        ImageRepeat.NoRepeat
      )
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ColorTokens.background)
  }
}
