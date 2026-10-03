// Design Tokens
const primaryColor: string = '#7C4DFF'
const secondaryColor: string = '#08D6FF'
const tertiaryColor: string = '#FF8E3C'
const backgroundColor: string = '#05030A'
const surfaceColor: string = '#0D0616'
const surfaceVariantColor: string = '#1A0F2C'
const onSecondaryColor: string = '#05030A'
const onSurfaceColor: string = '#F8F4FF'
const onSurfaceDimColor: string = '#F8F4FFB3'

const spacingXxs: number = 4
const spacingXs: number = 8
const spacingSm: number = 12
const spacingMd: number = 16
const spacingLg: number = 20
const spacingXl: number = 28

class MacroSet {
  title: string = ''
  reps: string = ''
  phase: string = ''
}

class PerformanceMetric {
  label: string = ''
  value: string = ''
  change: string = ''
}

@Entry
@Component
struct ContentView {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'

  sets: MacroSet[] = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' },
  ]

  metrics: PerformanceMetric[] = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' },
  ]

  tags: string[] = ['Macro', 'Tempo', 'Breath']

  build() {
    Column() {
      TopAppBar()

      Scroll() {
        Column({ space: spacingLg }) {
          Row({ space: spacingSm }) {
            TimerRingView({ timerValue: this.timerValue, tags: this.tags })
            MetricsColumnView({ metrics: this.metrics })
          }
          .alignItems(VerticalAlign.Top)

          ForEach(this.sets, (set: MacroSet) => {
            SetListItemView({ set: set })
          })
        }
        .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBarView({ targetPhase: this.targetPhase })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}

@Component
struct TopAppBar {
  build() {
    Stack() {
      Row() {
        Circle()
          .fill(surfaceVariantColor)
          .width(24)
          .height(24)

        Blank()

        Column({ space: 0 }) {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceDimColor)
        }
        .alignItems(HorizontalAlign.Center)

        Blank()

        Circle()
          .fill(surfaceVariantColor)
          .width(24)
          .height(24)
      }
      .width('100%')
      .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(60)
    .backgroundColor(surfaceColor)
  }
}

@Component
struct TimerRingView {
  timerValue: string = '00:00'
  tags: string[] = []

  build() {
    Column({ space: spacingSm }) {
      Stack() {
        // Background circle
        Circle()
          .width(160)
          .height(160)
          .fill(surfaceColor)

        // Simulate gradient ring using Shape with Path arcs
        Shape() {
          Path()
            .commands('M 80 5 A 75 75 0 0 1 155 80')
        }
        .width(160)
        .height(160)
        .strokeWidth(10)
        .stroke(tertiaryColor)
        .fill(Color.Transparent)
        .strokeLineCap(LineCapStyle.Round)

        Shape() {
          Path()
            .commands('M 155 80 A 75 75 0 0 1 80 155')
        }
        .width(160)
        .height(160)
        .strokeWidth(10)
        .stroke(primaryColor)
        .fill(Color.Transparent)
        .strokeLineCap(LineCapStyle.Round)

        Shape() {
          Path()
            .commands('M 80 155 A 75 75 0 0 1 5 80')
        }
        .width(160)
        .height(160)
        .strokeWidth(10)
        .stroke(secondaryColor)
        .fill(Color.Transparent)
        .strokeLineCap(LineCapStyle.Round)

        Shape() {
          Path()
            .commands('M 5 80 A 75 75 0 0 1 80 5')
        }
        .width(160)
        .height(160)
        .strokeWidth(10)
        .stroke(primaryColor)
        .fill(Color.Transparent)
        .strokeLineCap(LineCapStyle.Round)

        Column({ space: 4 }) {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(onSurfaceColor)

          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceDimColor)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(160)
      .height(160)

      Row({ space: spacingXxs }) {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
            .padding({ left: spacingXs, right: spacingXs, top: spacingXxs, bottom: spacingXxs })
            .backgroundColor(surfaceVariantColor)
            .borderRadius(8)
        })
      }
    }
    .alignItems(HorizontalAlign.Center)
    .padding(spacingMd)
    .backgroundColor(surfaceColor)
    .borderRadius(28)
    .shadow({ radius: 6, color: '#42000000', offsetX: 0, offsetY: 4 })
    .layoutWeight(1)
  }
}

@Component
struct MetricsColumnView {
  metrics: PerformanceMetric[] = []

  build() {
    Column({ space: spacingSm }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        MetricCardView({ metric: metric })
      })
    }
    .width(120)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct MetricCardView {
  metric: PerformanceMetric = new PerformanceMetric()

  build() {
    Column({ space: spacingXxs }) {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(onSurfaceColor)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(secondaryColor)

      Text(this.metric.change)
        .fontSize(14)
        .fontColor(onSurfaceDimColor)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(spacingSm)
    .backgroundColor(surfaceVariantColor)
    .borderRadius(18)
  }
}

@Component
struct SetListItemView {
  set: MacroSet = new MacroSet()

  build() {
    Row() {
      Column({ space: spacingXxs }) {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)

        Text(this.set.phase)
          .fontSize(14)
          .fontColor(onSurfaceDimColor)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column({ space: spacingXxs }) {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(primaryColor)

        Text('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSecondaryColor)
          .padding({ left: spacingXs, right: spacingXs, top: spacingXxs, bottom: spacingXxs })
          .backgroundColor(secondaryColor)
          .borderRadius(8)
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(spacingMd)
    .backgroundColor(surfaceVariantColor)
    .borderRadius(18)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomBarView {
  targetPhase: string = ''

  build() {
    Stack() {
      Row() {
        Column({ space: spacingXxs }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)

          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSecondaryColor)
          .padding({ left: spacingXl, right: spacingXl, top: spacingXs, bottom: spacingXs })
          .backgroundColor(secondaryColor)
          .borderRadius(18)
      }
      .width('100%')
      .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(80)
    .backgroundColor(surfaceVariantColor)
    .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })
  }
}