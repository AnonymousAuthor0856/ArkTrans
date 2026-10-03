interface MacroSet {
  title: string
  reps: string
  phase: string
}

interface PerformanceMetric {
  label: string
  value: string
  change: string
}

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
    onSurface: '#F8F4FF',
    onSurface70: 'rgba(248, 244, 255, 0.7)',
    surface95: 'rgba(13, 6, 22, 0.95)',
    surfaceVariant90: 'rgba(26, 15, 44, 0.9)',
    shadow: 'rgba(0, 0, 0, 0.26)'
  }

  static readonly Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 40,
    xxxl: 56
  }
}

@Entry
@Component
struct ContentView {
  @State private timerValue: string = '02:34'
  @State private targetPhase: string = 'Macro tempo'

  private sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ]

  private metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ]

  private tags: string[] = ['Macro', 'Tempo', 'Breath']

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
          .layoutWeight(1)

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
            .fontColor(DesignTokens.Colors.onSurface70)
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
      .height('100%')
      .padding({
        left: DesignTokens.Spacing.lg,
        right: DesignTokens.Spacing.lg,
        top: DesignTokens.Spacing.md,
        bottom: DesignTokens.Spacing.md
      })
    }
    .width('100%')
    .height(60)
    .backgroundColor(DesignTokens.Colors.surface95)
  }
}

@Component
struct MainContent {
  sets: MacroSet[] = []
  metrics: PerformanceMetric[] = []
  tags: string[] = []
  timerValue: string = ''

  build() {
    Scroll() {
      Column({ space: DesignTokens.Spacing.lg }) {
        TimerSection({
          timerValue: this.timerValue,
          tags: this.tags,
          metrics: this.metrics
        })

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
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct TimerSection {
  timerValue: string = ''
  tags: string[] = []
  metrics: PerformanceMetric[] = []

  build() {
    Row({ space: DesignTokens.Spacing.sm }) {
      TimerRing({
        timerValue: this.timerValue,
        tags: this.tags
      })
        .layoutWeight(1)

      MetricsColumn({ metrics: this.metrics })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TimerRing {
  timerValue: string = ''
  tags: string[] = []

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      Stack() {
        Circle()
          .width(160)
          .height(160)
          .fill(Color.Transparent)
          .stroke(DesignTokens.Colors.primary)
          .strokeWidth(10)

        Circle()
          .width(152)
          .height(152)
          .fill(Color.Transparent)
          .stroke(DesignTokens.Colors.secondary)
          .strokeWidth(3)
          .opacity(0.75)

        Column({ space: 4 }) {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignTokens.Colors.onSurface)

          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface70)
        }
      }
      .width(160)
      .height(160)

      Row({ space: DesignTokens.Spacing.xxs }) {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .padding({
              left: DesignTokens.Spacing.xs,
              right: DesignTokens.Spacing.xs,
              top: DesignTokens.Spacing.xxs,
              bottom: DesignTokens.Spacing.xxs
            })
            .backgroundColor(DesignTokens.Colors.surfaceVariant)
            .borderRadius(8)
        }, (tag: string) => tag)
      }
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(28)
    .shadow({
      radius: 6,
      color: DesignTokens.Colors.shadow,
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = []

  build() {
    Column({ space: DesignTokens.Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = { label: '', value: '', change: '' }

  build() {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(DesignTokens.Colors.secondary)

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(DesignTokens.Colors.onSurface70)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(18)
  }
}

@Component
struct SetsListSection {
  sets: MacroSet[] = []

  build() {
    Column({ space: DesignTokens.Spacing.lg }) {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      }, (set: MacroSet) => set.title)
    }
    .width('100%')
  }
}

@Component
struct SetListItemView {
  set: MacroSet = { title: '', reps: '', phase: '' }

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
          .fontColor(DesignTokens.Colors.onSurface70)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column({ space: DesignTokens.Spacing.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(DesignTokens.Colors.primary)

        Button('Start')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .padding({
            left: DesignTokens.Spacing.xs,
            right: DesignTokens.Spacing.xs,
            top: DesignTokens.Spacing.xxs,
            bottom: DesignTokens.Spacing.xxs
          })
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(8)
          .onClick(() => {
          })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surfaceVariant90)
    .borderRadius(18)
  }
}

@Component
struct BottomBar {
  targetPhase: string = ''

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
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSecondary)
          .padding({
            left: DesignTokens.Spacing.xl,
            right: DesignTokens.Spacing.xl,
            top: DesignTokens.Spacing.xs,
            bottom: DesignTokens.Spacing.xs
          })
          .backgroundColor(DesignTokens.Colors.secondary)
          .borderRadius(18)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
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
    .shadow({
      radius: 12,
      color: DesignTokens.Colors.shadow,
      offsetX: 0,
      offsetY: -6
    })
  }
}