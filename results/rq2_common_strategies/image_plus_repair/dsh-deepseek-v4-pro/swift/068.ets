// Translated from SwiftUI to ArkTS (HarmonyOS ArkUI).
// The SwiftUI App/Scene/WindowGroup entry is represented by an @Entry @Component page.

// Data Models
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

// Design Tokens
interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface SpacingTokens {
  xxs: number;
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

class DesignTokens {
  static readonly Colors: ColorTokens = {
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

  static readonly Spacing: SpacingTokens = {
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

// MARK: - App Entry (was @main struct MacroTrainerApp: App)
@Entry
@Component
struct MacroTrainerApp {
  build() {
    // statusBar(hidden: true) / ignoresSafeArea() are window-level in ArkUI.
    Stack() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Content View
@Component
struct ContentView {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';

  sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ];

  metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
  ];

  tags: string[] = ['Macro', 'Tempo', 'Breath'];

  build() {
    Stack() {
      Column({ space: 0 }) {
        TopAppBar()
        MainContent({ sets: this.sets, metrics: this.metrics, tags: this.tags, timerValue: this.timerValue })
        BottomBar({ targetPhase: this.targetPhase })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}

// MARK: - Top App Bar
@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {
          })

        Blank()

        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7)
        }

        Blank()

        Circle()
          .width(24)
          .height(24)
          .fill(DesignTokens.Colors.surfaceVariant)
          .onClick(() => {
          })
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height(60)
    // surface at 0.95 opacity
    .backgroundColor('#F20D0616')
  }
}

// MARK: - Main Content
@Component
struct MainContent {
  sets: MacroSet[] = [];
  metrics: PerformanceMetric[] = [];
  tags: string[] = [];
  timerValue: string = '';

  build() {
    Scroll() {
      Column({ space: DesignTokens.Spacing.lg }) {
        TimerSection({ timerValue: this.timerValue, tags: this.tags, metrics: this.metrics })
        SetsListSection({ sets: this.sets })
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .layoutWeight(1)
    .scrollable(ScrollDirection.Vertical)
    .align(Alignment.TopStart)
  }
}

// MARK: - Timer Section
@Component
struct TimerSection {
  timerValue: string = '';
  tags: string[] = [];
  metrics: PerformanceMetric[] = [];

  build() {
    Row({ space: DesignTokens.Spacing.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
      MetricsColumn({ metrics: this.metrics })
    }
    .width('100%')
  }
}

@Component
struct TimerRing {
  timerValue: string = '';
  tags: string[] = [];

  build() {
    Stack() {
      Column({ space: DesignTokens.Spacing.sm }) {
        Stack() {
          Circle()
            .width(160)
            .height(160)
            .sweepGradient({
              center: [80, 80],
              colors: [
                [DesignTokens.Colors.primary, 0.0],
                [DesignTokens.Colors.secondary, 0.33],
                [DesignTokens.Colors.tertiary, 0.66],
                [DesignTokens.Colors.primary, 1.0]
              ]
            })

          Circle()
            .width(140)
            .height(140)
            .fill(DesignTokens.Colors.surface)

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

@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = [];

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = new PerformanceMetric('', '', '');

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

// MARK: - Sets List Section
@Component
struct SetsListSection {
  sets: MacroSet[] = [];

  build() {
    Column() {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      }, (set: MacroSet) => set.title)
    }
  }
}

@Component
struct SetListItemView {
  set: MacroSet = new MacroSet('', '', '');

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
          .onClick(() => {
            // Start action
          })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    // surfaceVariant at 0.9 opacity
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
  }
}

// MARK: - Bottom Bar
@Component
struct BottomBar {
  targetPhase: string = '';

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
          .onClick(() => {
            // Prime action
          })
      }
      .width('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height(80)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })
  }
}

// MARK: - Color Extension
// The SwiftUI Color(hex:alpha:) initializer is unnecessary in ArkTS:
// DesignTokens stores the equivalent '#RRGGBB' hex strings directly above.

// MARK: - Preview
// SwiftUI PreviewProvider has no ArkTS equivalent; the page renders via @Entry MacroTrainerApp.
