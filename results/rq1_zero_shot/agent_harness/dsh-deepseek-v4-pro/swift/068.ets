// MARK: - Data Models
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

// MARK: - Design Tokens
const DesignTokens = {
  Colors: {
    primary: '#7C4DFF',
    secondary: '#08D6FF',
    tertiary: '#FF8E3C',
    background: '#05030A',
    surface: '#0D0616',
    surfaceVariant: '#1A0F2C',
    outline: '#3A2759',
    success: '#56F0A6',
    warning: '#FFC857',
    error: '#FF5B7A',
    onPrimary: '#05030A',
    onSecondary: '#05030A',
    onTertiary: '#120601',
    onBackground: '#F4ECFF',
    onSurface: '#F8F4FF'
  },
  Spacing: {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56
  }
};

// MARK: - ContentView
@Component
struct ContentView {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

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

  build() {
    Stack() {
      Column({ space: 0 }) {
        TopAppBar()
        MainContent({
          sets: this.sets,
          metrics: this.metrics,
          tags: this.tags,
          timerValue: this.timerValue
        })
        BottomBar({ targetPhase: this.targetPhase })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Row()
          .width(24)
          .height(24)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {})

        Blank()

        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3F8F4FF')
        }

        Blank()

        Row()
          .width(24)
          .height(24)
          .backgroundColor(DesignTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .onClick(() => {})
      }
      .alignItems(VerticalAlign.Center)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .width('100%')
    .height(60)
    .backgroundColor('#F20D0616')
  }
}

// MARK: - Main Content
@Component
struct MainContent {
  sets: MacroSet[] = [];
  metrics: PerformanceMetric[] = [];
  tags: string[] = [];
  @Prop timerValue: string = '';

  build() {
    Scroll() {
      Column({ space: DesignTokens.Spacing.lg }) {
        TimerSection({ timerValue: this.timerValue, tags: this.tags, metrics: this.metrics })
        SetsListSection({ sets: this.sets })
      }
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  @Prop timerValue: string = '';
  tags: string[] = [];
  metrics: PerformanceMetric[] = [];

  build() {
    Row({ space: DesignTokens.Spacing.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
      MetricsColumn({ metrics: this.metrics })
    }
  }
}

// MARK: - Timer Ring
@Component
struct TimerRing {
  @Prop timerValue: string = '';
  tags: string[] = [];

  build() {
    Stack() {
      Column({ space: DesignTokens.Spacing.sm }) {
        Stack() {
          Row()
            .width(160)
            .height(160)
            .borderRadius(80)
            .border({ width: 10, color: DesignTokens.Colors.primary })

          Column({ space: 4 }) {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.Colors.onSurface)
            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#B3F8F4FF')
          }
        }

        Row({ space: DesignTokens.Spacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
              .backgroundColor(DesignTokens.Colors.surfaceVariant)
              .fontColor(DesignTokens.Colors.onSurface)
              .borderRadius(8)
          }, (tag: string) => tag)
        }
      }
      .padding(DesignTokens.Spacing.md)
    }
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(28)
    .shadow({ radius: 6, color: '#42000000', offsetX: 0, offsetY: 4 })
  }
}

// MARK: - Metrics Column
@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = [];

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ label: metric.label, value: metric.value, change: metric.change })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
  }
}

// MARK: - Metric Card
@Component
struct MetricCard {
  @Prop label: string = '';
  @Prop value: string = '';
  @Prop change: string = '';

  build() {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
      Text(this.value)
        .fontSize(22)
        .fontWeight(FontWeight.Semibold)
        .fontColor(DesignTokens.Colors.secondary)
      Text(this.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#B3F8F4FF')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
  }
}

// MARK: - Sets List Section
@Component
struct SetsListSection {
  sets: MacroSet[] = [];

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ title: set.title, reps: set.reps, phase: set.phase })
      }, (set: MacroSet) => set.title)
    }
  }
}

// MARK: - Set List Item View
@Component
struct SetListItemView {
  @Prop title: string = '';
  @Prop reps: string = '';
  @Prop phase: string = '';

  build() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text(this.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#B3F8F4FF')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Semibold)
          .fontColor(DesignTokens.Colors.primary)

        Button() {
          Text('Start')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .padding({ left: DesignTokens.Spacing.xs, right: DesignTokens.Spacing.xs, top: DesignTokens.Spacing.xxs, bottom: DesignTokens.Spacing.xxs })
            .backgroundColor(DesignTokens.Colors.secondary)
            .fontColor(DesignTokens.Colors.onSecondary)
            .borderRadius(8)
        }
        .onClick(() => {})
      }
      .alignItems(HorizontalAlign.End)
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  @Prop targetPhase: string = '';

  build() {
    Stack() {
      Row() {
        Column({ space: DesignTokens.Spacing.xxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button() {
          Text('Prime')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .padding({ left: DesignTokens.Spacing.xl, right: DesignTokens.Spacing.xl, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
            .backgroundColor(DesignTokens.Colors.secondary)
            .fontColor(DesignTokens.Colors.onSecondary)
            .borderRadius(18)
        }
        .onClick(() => {})
      }
      .alignItems(VerticalAlign.Center)
      .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.md, bottom: DesignTokens.Spacing.md })
    }
    .width('100%')
    .height(80)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })
  }
}

// MARK: - MacroTrainerApp
@Entry
@Component
struct MacroTrainerApp {
  build() {
    ContentView()
  }
}
