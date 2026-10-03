import { display } from '@kit.ArkUI'

const BG: string = '#05030A'
const SURFACE: string = '#0D0616'
const SURFACE_VARIANT: string = '#1A0F2C'
const PRIMARY: string = '#7C4DFF'
const SECONDARY: string = '#08D6FF'
const TERTIARY: string = '#FF8E3C'
const ON_SURFACE: string = '#F8F4FF'
const MUTED: string = '#B7ADC7'

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

@Entry
@Component
struct MacroTrainer {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'
  @State activeSet: string = ''
  private screenWidth: number = 375

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

  aboutToAppear(): void {
    try {
      this.screenWidth = display.getDefaultDisplaySync().width
    } catch (_) {
      this.screenWidth = 375
    }
  }

  private contentWidth(): number {
    return Math.max(300, this.screenWidth - 40)
  }

  private timerPanelWidth(): number {
    return Math.max(190, this.contentWidth() * 0.605)
  }

  private metricWidth(): number {
    return Math.max(108, this.contentWidth() - this.timerPanelWidth() - 12)
  }

  build() {
    Column() {
      this.topBar()

      Scroll() {
        Column({ space: 20 }) {
          Row({ space: 12 }) {
            this.timerPanel()
            this.metricsColumn()
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          ForEach(this.sets, (item: MacroSet) => {
            this.setCard(item)
          }, (item: MacroSet) => item.title)
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 18 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  topBar() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(SURFACE_VARIANT)
          .onClick(() => {})

        Blank()
          .layoutWeight(1)

        Circle()
          .width(24)
          .height(24)
          .fill(SURFACE_VARIANT)
          .onClick(() => {})
      }
      .padding({ left: 20, right: 20 })

      Column({ space: 2 }) {
        Text('MacroTrainer')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
        Text('Neon workout stack')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(MUTED)
      }
    }
    .height(62)
    .width('100%')
    .backgroundColor(SURFACE)
    .opacity(0.95)
  }

  @Builder
  timerPanel() {
    Column({ space: 12 }) {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(160)
          .height(160)
          .border({
            width: 10,
            color: SECONDARY
          })
          .rotate({ angle: -28 })
          .shadow({
            radius: 3,
            color: PRIMARY,
            offsetX: 0,
            offsetY: 0
          })

        Column({ space: 4 }) {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_SURFACE)
          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(MUTED)
        }
      }
      .width(190)
      .height(190)

      Row({ space: 4 }) {
        ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SURFACE)
            .backgroundColor(SURFACE_VARIANT)
            .borderRadius(8)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        })
      }
    }
    .width(this.timerPanelWidth())
    .height(294)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(SURFACE)
    .borderRadius(28)
    .shadow({
      radius: 6,
      color: '#42000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  metricsColumn() {
    Column({ space: 12 }) {
      ForEach(this.metrics, (metric: PerformanceMetric) => {
        this.metricCard(metric)
      }, (metric: PerformanceMetric) => metric.label)
    }
    .width(this.metricWidth())
  }

  @Builder
  metricCard(metric: PerformanceMetric) {
    Column({ space: 4 }) {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(SECONDARY)
      Text(metric.change)
        .fontSize(14)
        .fontColor(MUTED)
    }
    .width('100%')
    .height(90)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding({ left: 12, right: 8 })
    .backgroundColor(SURFACE_VARIANT)
    .borderRadius(18)
  }

  @Builder
  setCard(item: MacroSet) {
    Row() {
      Column({ space: 4 }) {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
        Text(item.phase)
          .fontSize(14)
          .fontColor(MUTED)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Column({ space: 4 }) {
        Text(item.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
        Button('Start', { type: ButtonType.Capsule })
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#05030A')
          .backgroundColor(SECONDARY)
          .height(30)
          .padding({ left: 12, right: 12 })
          .onClick(() => {
            this.activeSet = item.title
            this.timerValue = '03:00'
          })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .height(84)
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(SURFACE_VARIANT)
    .borderRadius(18)
    .opacity(this.activeSet === item.title ? 0.82 : 1)
  }

  @Builder
  bottomBar() {
    Row() {
      Column({ space: 4 }) {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Prime', { type: ButtonType.Capsule })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#05030A')
        .backgroundColor(SECONDARY)
        .height(36)
        .padding({ left: 28, right: 28 })
        .onClick(() => {
          this.targetPhase = 'Primed'
        })
    }
    .width('100%')
    .height(80)
    .padding({ left: 20, right: 20, top: 12, bottom: 12 })
    .backgroundColor(SURFACE_VARIANT)
    .shadow({
      radius: 12,
      color: '#42000000',
      offsetX: 0,
      offsetY: -6
    })
  }
}
