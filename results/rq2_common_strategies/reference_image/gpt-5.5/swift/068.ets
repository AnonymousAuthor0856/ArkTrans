class AppColors {
  static readonly primary: string = '#7C4DFF'
  static readonly secondary: string = '#08D6FF'
  static readonly tertiary: string = '#FF8E3C'
  static readonly background: string = '#05030A'
  static readonly surface: string = '#0D0616'
  static readonly surfaceVariant: string = '#1A0F2C'
  static readonly surfaceVariant90: string = '#E61A0F2C'
  static readonly outline: string = '#3A2759'
  static readonly success: string = '#56F0A6'
  static readonly warning: string = '#FFC857'
  static readonly error: string = '#FF5B7A'
  static readonly onPrimary: string = '#05030A'
  static readonly onSecondary: string = '#05030A'
  static readonly onTertiary: string = '#120601'
  static readonly onBackground: string = '#F4ECFF'
  static readonly onSurface: string = '#F8F4FF'
  static readonly black26: string = '#42000000'
}

class AppSpacing {
  static readonly xxs: number = 4
  static readonly xs: number = 8
  static readonly sm: number = 12
  static readonly md: number = 16
  static readonly lg: number = 20
  static readonly xl: number = 28
  static readonly xxl: number = 40
  static readonly xxxl: number = 56
}

class MacroSet {
  title: string
  reps: string
  phase: string

  constructor(title: string, reps: string, phase: string) {
    this.title = title
    this.reps = reps
    this.phase = phase
  }
}

class PerformanceMetric {
  label: string
  value: string
  change: string

  constructor(label: string, value: string, change: string) {
    this.label = label
    this.value = value
    this.change = change
  }
}

@Entry
@Component
struct ContentView {
  @State private timerValue: string = '02:34'
  @State private targetPhase: string = 'Macro tempo'

  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ]

  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
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

        BottomBar({ targetPhase: this.targetPhase })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct TopAppBar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.surfaceVariant)
          .onClick(() => {
          })

        Blank()

        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .opacity(0.7)
        }

        Blank()

        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.surfaceVariant)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(60)
    .backgroundColor(AppColors.surface)
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
      Column({ space: AppSpacing.lg }) {
        TimerSection({
          timerValue: this.timerValue,
          tags: this.tags,
          metrics: this.metrics
        })

        SetsListSection({ sets: this.sets })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Component
struct TimerSection {
  timerValue: string = ''
  tags: string[] = []
  metrics: PerformanceMetric[] = []

  build() {
    Row({ space: AppSpacing.sm }) {
      TimerRing({
        timerValue: this.timerValue,
        tags: this.tags
      })

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
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: AppSpacing.sm }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(156)
            .height(156)
            .fill('#00000000')
            .stroke(AppColors.secondary)
            .strokeWidth(10)

          Circle()
            .width(156)
            .height(156)
            .fill('#00000000')
            .stroke(AppColors.primary)
            .strokeWidth(5)
            .opacity(0.55)

          Column({ space: AppSpacing.xxs }) {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)

            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .opacity(0.7)
          }
        }
        .width(170)
        .height(170)

        Row({ space: AppSpacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .padding({
                left: AppSpacing.xs,
                right: AppSpacing.xs,
                top: AppSpacing.xxs,
                bottom: AppSpacing.xxs
              })
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(8)
          }, (tag: string) => tag)
        }
      }
      .padding(AppSpacing.sm)
    }
    .layoutWeight(1)
    .height(284)
    .backgroundColor(AppColors.surface)
    .borderRadius(28)
    .shadow({
      radius: 6,
      color: AppColors.black26,
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = []

  build() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = new PerformanceMetric('', '', '')

  build() {
    Column({ space: AppSpacing.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.secondary)

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
    }
    .width('100%')
    .height(86)
    .padding(AppSpacing.sm)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(18)
  }
}

@Component
struct SetsListSection {
  sets: MacroSet[] = []

  build() {
    Column({ space: AppSpacing.lg }) {
      ForEach(this.sets, (item: MacroSet) => {
        SetListItemView({ macroSet: item })
      }, (item: MacroSet) => item.title)
    }
    .width('100%')
  }
}

@Component
struct SetListItemView {
  macroSet: MacroSet = new MacroSet('', '', '')

  build() {
    Row() {
      Column({ space: AppSpacing.xxs }) {
        Text(this.macroSet.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(this.macroSet.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column({ space: AppSpacing.xxs }) {
        Text(this.macroSet.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Text('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .padding({
            left: AppSpacing.xs,
            right: AppSpacing.xs,
            top: AppSpacing.xxs,
            bottom: AppSpacing.xxs
          })
          .backgroundColor(AppColors.secondary)
          .borderRadius(8)
          .onClick(() => {
          })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant90)
    .borderRadius(18)
  }
}

@Component
struct BottomBar {
  targetPhase: string = ''

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Column({ space: AppSpacing.xxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .padding({
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs
          })
          .backgroundColor(AppColors.secondary)
          .borderRadius(18)
          .onClick(() => {
          })
      }
      .width('100%')
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.md,
        bottom: AppSpacing.md
      })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(80)
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({
      radius: 12,
      color: AppColors.black26,
      offsetX: 0,
      offsetY: -6
    })
  }
}