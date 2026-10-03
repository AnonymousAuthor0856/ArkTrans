// MacroTrainerApp.ets

// --- Data Models ---
class MacroSet {
  title: string = '';
  reps: string = '';
  phase: string = '';
}

class PerformanceMetric {
  label: string = '';
  value: string = '';
  change: string = '';
}

// --- Design Tokens ---
class DesignTokens {
  static Colors = {
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

  static Spacing = {
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

// --- Main Entry ---
@Entry
@Component
struct MacroTrainerApp {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

  private sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' } as MacroSet,
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' } as MacroSet,
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' } as MacroSet
  ];

  private metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' } as PerformanceMetric,
    { label: 'VO2', value: '41', change: '+1' } as PerformanceMetric,
    { label: 'Focus', value: '88%', change: 'stable' } as PerformanceMetric
  ];

  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.background)

      Column() {
        TopAppBar()

        // Main Content
        Scroll() {
          Column({ space: DesignTokens.Spacing.lg }) {
            // Timer Section
            Row({ space: DesignTokens.Spacing.sm }) {
              // Timer Ring
              TimerRing({ timerValue: this.timerValue, tags: this.tags })

              // Metrics Column
              Column({ space: DesignTokens.Spacing.sm }) {
                ForEach(this.metrics, (metric: PerformanceMetric) => {
                  MetricCard({ metric: metric })
                })
              }
              .width(120)
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            // Sets List Section
            ForEach(this.sets, (set: MacroSet) => {
              SetListItemView({ set: set })
            })
          }
          .padding({
            left: DesignTokens.Spacing.lg,
            right: DesignTokens.Spacing.lg,
            top: DesignTokens.Spacing.md,
            bottom: DesignTokens.Spacing.md
          })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        BottomBar({ targetPhase: this.targetPhase })
      }
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// --- Top App Bar ---
@Component
struct TopAppBar {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surface)
        .opacity(0.95)

      Row() {
        Circle({ width: 24, height: 24 })
          .fill(DesignTokens.Colors.surfaceVariant)

        Blank()

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7)
            .margin({ top: 2 })
        }

        Blank()

        Circle({ width: 24, height: 24 })
          .fill(DesignTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .height(60)
  }
}

// --- Timer Ring ---
@Component
struct TimerRing {
  private timerValue: string = '00:00';
  private tags: string[] = [];

  build() {
    Column() {
      Stack() {
        // Background Card
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(DesignTokens.Colors.surface)
          .borderRadius(28)
          .shadow({ radius: 6, color: '#00000042', offsetY: 4 })

        // Content
        Column({ space: DesignTokens.Spacing.sm }) {
          Stack() {
            // Gradient Ring
            Circle({ width: 160, height: 160 })
              .fill(Color.Transparent)
              .stroke(DesignTokens.Colors.primary)
              .strokeWidth(10)

            Column({ space: 4 }) {
              Text(this.timerValue)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(DesignTokens.Colors.onSurface)

              Text('Timer')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface)
                .opacity(0.7)
            }
          }

          // Tags
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
                .borderRadius(8)
            })
          }
        }
        .padding(DesignTokens.Spacing.md)
      }
      .layoutWeight(1)
    }
    .layoutWeight(1)
  }
}

// --- Metric Card ---
@Component
struct MetricCard {
  private metric: PerformanceMetric = new PerformanceMetric();

  build() {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(DesignTokens.Colors.secondary)

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(DesignTokens.Colors.onSurface)
        .opacity(0.7)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
  }
}

// --- Set List Item ---
@Component
struct SetListItemView {
  private set: MacroSet = new MacroSet();

  build() {
    Row() {
      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)

        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(DesignTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.Colors.primary)

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
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .opacity(0.9)
    .borderRadius(18)
  }
}

// --- Bottom Bar ---
@Component
struct BottomBar {
  private targetPhase: string = '';

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .shadow({ radius: 12, color: '#00000042', offsetY: -6 })

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
          .borderRadius(18)
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .height(80)
  }
}