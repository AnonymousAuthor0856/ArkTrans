// Design Tokens
class ColorsClass {
  primary: string = '#7C4DFF'
  secondary: string = '#08D6FF'
  tertiary: string = '#FF8E3C'
  background: string = '#05030A'
  surface: string = '#0D0616'
  surfaceVariant: string = '#1A0F2C'
  outline: string = '#3A2759'
  success: string = '#56F0A6'
  warning: string = '#FFC857'
  error: string = '#FF5B7A'
  onPrimary: string = '#05030A'
  onSecondary: string = '#05030A'
  onTertiary: string = '#120601'
  onBackground: string = '#F4ECFF'
  onSurface: string = '#F8F4FF'
  onSurfaceDim: string = '#B0A8C8'
}

class SpacingClass {
  xxs: number = 4
  xs: number = 8
  sm: number = 12
  md: number = 16
  lg: number = 20
  xl: number = 28
  xxl: number = 40
  xxxl: number = 56
}

const Colors = new ColorsClass()
const Spacing = new SpacingClass()

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

const setsData: MacroSet[] = [
  { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
  { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
  { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' },
]

const metricsData: PerformanceMetric[] = [
  { label: 'Load', value: '72%', change: '+4%' },
  { label: 'VO2', value: '41', change: '+1' },
  { label: 'Focus', value: '88%', change: 'stable' },
]

const tagsData: string[] = ['Macro', 'Tempo', 'Breath']

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle()
          .fill(Colors.surfaceVariant)
          .width(24)
          .height(24)

        Blank()

        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurfaceDim)
        }

        Blank()

        Circle()
          .fill(Colors.surfaceVariant)
          .width(24)
          .height(24)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    }
    .width('100%')
    .height(60)
    .backgroundColor(Colors.surface)
  }
}

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
        .fontColor(Colors.onSurfaceDim)
        .alignSelf(ItemAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Spacing.sm)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(18)
  }
}

@Component
struct MetricsColumn {
  metrics: PerformanceMetric[] = []

  build() {
    Column({ space: Spacing.sm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCard({ metric: metric })
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(130)
  }
}

@Component
struct TimerRing {
  timerValue: string = '00:00'
  tags: string[] = []

  build() {
    Column() {
      Stack() {
        // Outer decorative ring using border
        Circle()
          .width(160)
          .height(160)
          .fill(Color.Transparent)
          .border({ width: 10, color: Colors.primary, radius: 80 })

        // Inner accent ring
        Circle()
          .width(160)
          .height(160)
          .fill(Color.Transparent)
          .border({ width: 10, color: Colors.secondary, radius: 80 })
          .opacity(0.6)

        Column({ space: 4 }) {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)

          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurfaceDim)
        }
      }
      .width(160)
      .height(160)

      Row({ space: Spacing.xxs }) {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .padding({ left: Spacing.xs, right: Spacing.xs, top: Spacing.xxs, bottom: Spacing.xxs })
            .backgroundColor(Colors.surfaceVariant)
            .borderRadius(8)
        }, (tag: string) => tag)
      }
      .margin({ top: Spacing.sm })
    }
    .alignItems(HorizontalAlign.Center)
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(28)
    .shadow({ radius: 6, color: '#42000000', offsetX: 0, offsetY: 4 })
  }
}

@Component
struct TimerSection {
  timerValue: string = '00:00'
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
          .fontColor(Colors.onSurfaceDim)
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
          .fontColor(Colors.onSecondary)
          .padding({ left: Spacing.xs, right: Spacing.xs, top: Spacing.xxs, bottom: Spacing.xxs })
          .backgroundColor(Colors.secondary)
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(18)
  }
}

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

@Component
struct BottomBar {
  targetPhase: string = ''

  build() {
    Stack() {
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
          .fontColor(Colors.onSecondary)
          .padding({ left: Spacing.xl, right: Spacing.xl, top: Spacing.xs, bottom: Spacing.xs })
          .backgroundColor(Colors.secondary)
          .borderRadius(18)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    }
    .width('100%')
    .height(80)
    .backgroundColor(Colors.surfaceVariant)
    .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })
  }
}

@Entry
@Component
struct ContentView {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column({ space: Spacing.lg }) {
          TimerSection({
            timerValue: this.timerValue,
            tags: tagsData,
            metrics: metricsData
          })

          SetsListSection({ sets: setsData })
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBar({ targetPhase: this.targetPhase })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}