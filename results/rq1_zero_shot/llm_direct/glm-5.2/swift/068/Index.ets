// MacroTrainerApp.ets
import { router } from '@kit.ArkUI';

// MARK: - Data Models
interface MacroSet {
  title: string;
  reps: string;
  phase: string;
}

interface PerformanceMetric {
  label: string;
  value: string;
  change: string;
}

// MARK: - Design Tokens
class DesignTokens {
  static readonly Colors = {
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
  };

  static readonly Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56
  };
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .opacity(0.95);

      Row() {
        Circle({ width: 24, height: 24 })
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {});

        Blank();

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface);

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7);
        }
        .alignItems(HorizontalAlign.Center);

        Blank();

        Circle({ width: 24, height: 24 })
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {});
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      });
    }
    .width('100%')
    .height(60);
  }
}

// MARK: - Metric Card
@Component
struct MetricCard {
  private metric: PerformanceMetric = {
    label: '',
    value: '',
    change: ''
  };

  build() {
    Column() {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface);

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(DesignTokens.Colors.secondary);

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(DesignTokens.Colors.onSurface)
        .opacity(0.7);
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18);
  }
}

// MARK: - Metrics Column
@Component
struct MetricsColumn {
  private metrics: PerformanceMetric[] = [];

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric });
      });
    }
    .width(120);
  }
}

// MARK: - Timer Ring
@Component
struct TimerRing {
  private timerValue: string = '00:00';
  private tags: string[] = [];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .borderRadius(28)
        .shadow({ radius: 6, color: '#000000', offsetX: 0, offsetY: 4 })
        .opacity(0.26); // Note: shadow opacity in ArkUI is usually handled differently, but this is a visual approximation

      Column({ space: DesignTokens.Spacing.sm }) {
        Stack({ alignContent: Alignment.Center }) {
          // Gradient Ring approximation using multiple arcs or a border. 
          // For simplicity, a solid border is used here as true angular gradients on strokes are complex.
          Circle({ width: 160, height: 160 })
            .fill(Color.Transparent)
            .stroke(DesignTokens.Colors.primary)
            .strokeWidth(10);

          Column({ space: 4 }) {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(DesignTokens.Colors.onSurface);

            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onSurface)
              .opacity(0.7);
          }
        }
        .width(160)
        .height(160);

        Row({ space: DesignTokens.Spacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .padding({
                left: DesignTokens.Spacing.xs,
                right: DesignTokens.Spacing.xs,
                top: DesignTokens.Spacing.xxs,
                bottom: DesignTokens.Spacing.xxs
              })
              .backgroundColor(DesignTokens.Colors.surfaceVariant)
              .fontColor(DesignTokens.Colors.onSurface)
              .borderRadius(8);
          });
        }
      }
      .padding(DesignTokens.Spacing.md);
    }
    .layoutWeight(1);
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  private timerValue: string = '00:00';
  private tags: string[] = [];
  private metrics: PerformanceMetric[] = [];

  build() {
    Row({ space: DesignTokens.Spacing.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags });
      MetricsColumn({ metrics: this.metrics });
    }
    .width('100%');
  }
}

// MARK: - Set List Item View
@Component
struct SetListItemView {
  private set: MacroSet = { title: '', reps: '', phase: '' };

  build() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface);

        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7);
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1);

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.Colors.primary);

        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .padding({
            left: DesignTokens.Spacing.xs,
            right: DesignTokens.Spacing.xs,
            top: DesignTokens.Spacing.xxs,
            bottom: DesignTokens.Spacing.xxs
          })
          .backgroundColor(DesignTokens.Colors.secondary)
          .fontColor(DesignTokens.Colors.onSecondary)
          .borderRadius(8);
      }
      .alignItems(HorizontalAlign.End);
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.9)
    .borderRadius(18);
  }
}

// MARK: - Sets List Section
@Component
struct SetsListSection {
  private sets: MacroSet[] = [];

  build() {
    Column({ space: DesignTokens.Spacing.lg }) {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set });
      });
    }
    .width('100%');
  }
}

// MARK: - Main Content
@Component
struct MainContent {
  private sets: MacroSet[] = [];
  private metrics: PerformanceMetric[] = [];
  private tags: string[] = [];
  private timerValue: string = '00:00';

  build() {
    Scroll() {
      Column({ space: DesignTokens.Spacing.lg }) {
        TimerSection({ timerValue: this.timerValue, tags: this.tags, metrics: this.metrics });
        SetsListSection({ sets: this.sets });
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      });
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off);
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  private targetPhase: string = '';

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .shadow({ radius: 12, color: '#000000', offsetX: 0, offsetY: -6 });

      Row() {
        Column({ space: DesignTokens.Spacing.xxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface);

          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface);
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1);

        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .padding({
            left: DesignTokens.Spacing.xl,
            right: DesignTokens.Spacing.xl,
            top: DesignTokens.Spacing.xs,
            bottom: DesignTokens.Spacing.xs
          })
          .backgroundColor(DesignTokens.Colors.secondary)
          .fontColor(DesignTokens.Colors.onSecondary)
          .borderRadius(18);
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      });
    }
    .width('100%')
    .height(80);
  }
}

// MARK: - Content View
@Entry
@Component
struct ContentView {
  @State private timerValue: string = '02:34';
  @State private targetPhase: string = 'Macro tempo';

  private sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ];

  private metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ];

  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.background);

      Column() {
        TopAppBar();
        MainContent({
          sets: this.sets,
          metrics: this.metrics,
          tags: this.tags,
          timerValue: this.timerValue
        });
        BottomBar({ targetPhase: this.targetPhase });
      }
      .width('100%')
      .height('100%');
    }
    .width('100%')
    .height('100%');
  }
}