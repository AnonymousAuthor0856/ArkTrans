class DesignColors {
  static primary: string = '#7C4DFF';
  static secondary: string = '#08D6FF';
  static tertiary: string = '#FF8E3C';
  static background: string = '#05030A';
  static surface: string = '#0D0616';
  static surfaceVariant: string = '#1A0F2C';
  static outline: string = '#3A2759';
  static success: string = '#56F0A6';
  static warning: string = '#FFC857';
  static error: string = '#FF5B7A';
  static onPrimary: string = '#05030A';
  static onSecondary: string = '#05030A';
  static onTertiary: string = '#120601';
  static onBackground: string = '#F4ECFF';
  static onSurface: string = '#F8F4FF';
}

class DesignSpacing {
  static xxs: number = 4;
  static xs: number = 8;
  static sm: number = 12;
  static md: number = 16;
  static lg: number = 20;
  static xl: number = 28;
  static xxl: number = 40;
  static xxxl: number = 56;
}

class MacroSet {
  title: string;
  reps: string;
  phase: string;

  constructor(title: string, reps: string, phase: string) {
    this.title = title;
    this.reps = reps;
    this.phase = phase;
  }
}

class PerformanceMetric {
  label: string;
  value: string;
  change: string;

  constructor(label: string, value: string, change: string) {
    this.label = label;
    this.value = value;
    this.change = change;
  }
}

@Entry
@Component
struct ContentView {
  @State private timerValue: string = '02:34';
  @State private targetPhase: string = 'Macro tempo';
  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ];
  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
  ];
  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  @Builder
  private TopAppBar() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('#0D0616F2')
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(DesignColors.surfaceVariant)
        Blank()
        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignColors.onSurface)
          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FFB3')
        }
        Blank()
        Circle()
          .width(24)
          .height(24)
          .fill(DesignColors.surfaceVariant)
      }
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
      .width('100%')
    }
    .height(60)
    .width('100%')
  }

  @Builder
  private TimerRing() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill(DesignColors.surface)
        .radius(28)
      Column({ space: DesignSpacing.sm }) {
        Stack() {
          Circle()
            .width(160)
            .height(160)
            .fill(Color.Transparent)
            .stroke(DesignColors.primary)
            .strokeWidth(10)
          Circle()
            .width(138)
            .height(138)
            .fill(Color.Transparent)
            .stroke(DesignColors.secondary)
            .strokeWidth(4)
          Column({ space: 4 }) {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignColors.onSurface)
            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#F8F4FFB3')
          }
        }
        .width(160)
        .height(160)

        Row({ space: DesignSpacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignColors.onSurface)
              .padding({ left: DesignSpacing.xs, right: DesignSpacing.xs, top: DesignSpacing.xxs, bottom: DesignSpacing.xxs })
              .backgroundColor(DesignColors.surfaceVariant)
              .borderRadius(8)
          })
        }
      }
      .padding(DesignSpacing.md)
    }
    .height(244)
    .layoutWeight(1)
    .shadow({ radius: 6, color: '#00000042', offsetX: 0, offsetY: 4 })
  }

  @Builder
  private MetricCard(metric: PerformanceMetric) {
    Column({ space: DesignSpacing.xxs }) {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignColors.onSurface)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(DesignColors.secondary)
      Text(metric.change)
        .fontSize(14)
        .fontColor('#F8F4FFB3')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(DesignSpacing.sm)
    .width('100%')
    .backgroundColor(DesignColors.surfaceVariant)
    .borderRadius(18)
  }

  @Builder
  private MetricsColumn() {
    Column({ space: DesignSpacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        this.MetricCard(metric)
      })
    }
    .width(120)
  }

  @Builder
  private SetListItem(set: MacroSet) {
    Row() {
      Column({ space: DesignSpacing.xxs }) {
        Text(set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.onSurface)
        Text(set.phase)
          .fontSize(14)
          .fontColor('#F8F4FFB3')
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Column({ space: DesignSpacing.xxs }) {
        Text(set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(DesignColors.primary)
        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.onSecondary)
          .padding({ left: DesignSpacing.xs, right: DesignSpacing.xs, top: DesignSpacing.xxs, bottom: DesignSpacing.xxs })
          .backgroundColor(DesignColors.secondary)
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.End)
    }
    .padding(DesignSpacing.md)
    .width('100%')
    .backgroundColor('#1A0F2CE6')
    .borderRadius(18)
  }

  @Builder
  private BottomBar() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill(DesignColors.surfaceVariant)
      Row() {
        Column({ space: DesignSpacing.xxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignColors.onSurface)
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.onSecondary)
          .padding({ left: DesignSpacing.xl, right: DesignSpacing.xl, top: DesignSpacing.xs, bottom: DesignSpacing.xs })
          .backgroundColor(DesignColors.secondary)
          .borderRadius(18)
      }
      .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
      .width('100%')
    }
    .height(80)
    .width('100%')
    .shadow({ radius: 12, color: '#00000042', offsetX: 0, offsetY: -6 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.TopAppBar()
        Scroll() {
          Column({ space: DesignSpacing.lg }) {
            Row({ space: DesignSpacing.sm }) {
              this.TimerRing()
              this.MetricsColumn()
            }
            .width('100%')

            Column({ space: DesignSpacing.lg }) {
              ForEach(this.sets, (set: MacroSet) => {
                this.SetListItem(set)
              })
            }
            .width('100%')
          }
          .padding({ left: DesignSpacing.lg, right: DesignSpacing.lg, top: DesignSpacing.md, bottom: DesignSpacing.md })
          .width('100%')
        }
        .layoutWeight(1)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignColors.background)
  }
}
