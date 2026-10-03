import { LengthMetrics } from '@kit.ArkUI'

// Design Tokens
const Colors = {
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
}

const Spacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 40,
  xxxl: 56,
}

// Data Models
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

// Top App Bar
@Component
struct TopAppBar {
  build() {
    ZStack() {
      Rectangle()
        .fill(Colors.surface)
        .opacity(0.95)

      Row() {
        Circle()
          .fill(Colors.surfaceVariant)
          .width(24)
          .height(24)
          .onClick(() => {})

        Blank()

        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .opacity(0.7)
        }

        Blank()

        Circle()
          .fill(Colors.surfaceVariant)
          .width(24)
          .height(24)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    }
    .width('100%')
    .height(60)
  }
}

// Metric Card
@Component
struct MetricCard {
  metric: PerformanceMetric = { label: '', value: '', change: '' }

  build() {
    Column({ space: Spacing.xxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Colors.secondary)
        .alignSelf(ItemAlign.Start)

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(Colors.onSurface)
        .opacity(0.7)
        .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(Spacing.sm)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(18)
  }
}

// Metrics Column
@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = []

  build() {
    Column({ space: Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(120)
  }
}

// Timer Ring
@Component
struct TimerRing {
  timerValue: string = ''
  tags: string[] = []

  build() {
    ZStack() {
      RoundedRect()
        .fill(Colors.surface)
        .borderRadius(28)
        .shadow({ radius: 6, color: '#42000000', offsetX: 0, offsetY: 4 })

      Column({ space: Spacing.sm }) {
        ZStack() {
          Circle()
            .stroke({
              width: 10,
              color: new LinearGradient({
                angle: 135,
                colors: [
                  [Colors.primary, 0.0],
                  [Colors.secondary, 0.33],
                  [Colors.tertiary, 0.66],
                  [Colors.primary, 1.0]
                ]
              })
            })
            .width(160)
            .height(160)

          Column({ space: 4 }) {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onSurface)

            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)
              .opacity(0.7)
          }
        }

        Row({ space: Spacing.xxs }) {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .padding({ left: Spacing.xs, right: Spacing.xs, top: Spacing.xxs, bottom: Spacing.xxs })
              .backgroundColor(Colors.surfaceVariant)
              .fontColor(Colors.onSurface)
              .borderRadius(8)
          }, (tag: string) => tag)
        }
      }
      .padding(Spacing.md)
    }
  }
}

// Timer Section
@Component
struct TimerSection {
  timerValue: string = ''
  tags: string[] = []
  metrics: PerformanceMetric[] = []

  build() {
    Row({ space: Spacing.sm }) {
      TimerRing({ timerValue: this.timerValue, tags: this.tags })
      MetricsColumn({ metrics: this.metrics })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// Set List Item
@Component
struct SetListItemView {
  set: MacroSet = { title: '', reps: '', phase: '' }

  build() {
    Row() {
      Column({ space: Spacing.xxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column({ space: Spacing.xxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)

        Text('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .padding({ left: Spacing.xs, right: Spacing.xs, top: Spacing.xxs, bottom: Spacing.xxs })
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .borderRadius(8)
          .onClick(() => {})
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surfaceVariant)
    .opacity(0.9)
    .borderRadius(18)
  }
}

// Sets List Section
@Component
struct SetsListSection {
  sets: MacroSet[] = []

  build() {
    Column({ space: Spacing.sm }) {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      }, (set: MacroSet) => set.title)
    }
    .width('100%')
  }
}

// Main Content
@Component
struct MainContent {
  sets: MacroSet[] = []
  metrics: PerformanceMetric[] = []
  tags: string[] = []
  timerValue: string = ''

  build() {
    Scroll() {
      Column({ space: Spacing.lg }) {
        TimerSection({
          timerValue: this.timerValue,
          tags: this.tags,
          metrics: this.metrics
        })
        SetsListSection({ sets: this.sets })
      }
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .width('100%')
    }
    .width('100%')
    .layoutWeight(1)
  }
}

// Bottom Bar
@Component
struct BottomBar {
  targetPhase: string = ''

  build() {
    ZStack() {
      Rectangle()
        .fill(Colors.surfaceVariant)
        .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })

      Row() {
        Column({ space: Spacing.xxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.xs, bottom: Spacing.xs })
          .backgroundColor(Colors.secondary)
          .fontColor(Colors.onSecondary)
          .borderRadius(18)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    }
    .width('100%')
    .height(80)
  }
}

// Main Entry
@Entry
@Component
struct ContentView {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'

  sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ]

  metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ]

  tags: string[] = ['Macro', 'Tempo', 'Breath']

  build() {
    ZStack() {
      Rectangle()
        .fill(Colors.background)
        .width('100%')
        .height('100%')

      Column() {
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
  }
}