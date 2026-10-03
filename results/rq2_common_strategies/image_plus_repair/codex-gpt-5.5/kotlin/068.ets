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

class DesignColors {
  static readonly primary: string = '#7C4DFF'
  static readonly secondary: string = '#08D6FF'
  static readonly tertiary: string = '#FF8E3C'
  static readonly background: string = '#05030A'
  static readonly surface: string = '#0D0616'
  static readonly surfaceVariant: string = '#1A0F2C'
  static readonly onPrimary: string = '#05030A'
  static readonly onSecondary: string = '#05030A'
  static readonly onBackground: string = '#F4ECFF'
  static readonly onSurface: string = '#F8F4FF'
}

@Component
struct NeonDot {
  build() {
    Circle()
      .width(48)
      .height(48)
      .fill(DesignColors.surfaceVariant)
  }
}

@Component
struct ProgressTimer {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(320)
        .height(320)
        .onReady(() => {
          this.context.clearRect(0, 0, 320, 320)
          const colors: string[] = [
            DesignColors.primary,
            '#5D6DFF',
            '#319FFF',
            DesignColors.secondary,
            '#5CD1BB',
            '#D6B56E',
            DesignColors.tertiary,
            '#D069BE',
            '#A464FF'
          ]
          const start: number = -Math.PI / 2
          const step: number = Math.PI * 2 / colors.length
          this.context.lineWidth = 20
          this.context.lineCap = 'round'
          colors.forEach((color: string, index: number) => {
            this.context.beginPath()
            this.context.arc(160, 160, 140, start + step * index, start + step * (index + 1) + 0.02)
            this.context.strokeStyle = color
            this.context.stroke()
          })
        })

      Circle()
        .width(280)
        .height(280)
        .fill(DesignColors.surface)

      Column({ space: 6 }) {
        Text('02:34')
          .fontSize(62)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignColors.onSurface)
          .lineHeight(70)
        Text('Timer')
          .fontSize(25)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3F8F4FF')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(320)
    .height(320)
  }
}

@Component
struct MetricCard {
  metric: PerformanceMetric = { label: '', value: '', change: '' }

  build() {
    Column({ space: 10 }) {
      Text(this.metric.label)
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
        .fontColor(DesignColors.onSurface)
      Text(this.metric.value)
        .fontSize(44)
        .fontWeight(FontWeight.Bold)
        .fontColor('#20D9FF')
      Text(this.metric.change)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3F8F4FF')
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding({ left: 24, right: 24 })
    .width(240)
    .height(177)
    .backgroundColor(DesignColors.surfaceVariant)
    .borderRadius(36)
  }
}

@Component
struct MacroChip {
  text: string = ''

  build() {
    Text(this.text)
      .fontSize(25)
      .fontWeight(FontWeight.Bold)
      .fontColor(DesignColors.onSurface)
      .textAlign(TextAlign.Center)
      .lineHeight(30)
      .width(96)
  }
}

@Component
struct TimerPanel {
  build() {
    Column() {
      ProgressTimer()
        .margin({ top: 30 })

      Row({ space: 18 }) {
        MacroChip({ text: 'Macro' })
        MacroChip({ text: 'Tempo' })
        MacroChip({ text: 'Bre\nath' })
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Top)
      .margin({ top: 30 })
    }
    .alignItems(HorizontalAlign.Center)
    .width(376)
    .height(484)
    .backgroundColor(DesignColors.surfaceVariant)
    .borderRadius(56)
  }
}

@Component
struct SetRow {
  set: MacroSet = { title: '', reps: '', phase: '' }

  build() {
    Row() {
      Column({ space: 10 }) {
        Text(this.set.title)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignColors.onSurface)
        Text(this.set.phase)
          .fontSize(28)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3F8F4FF')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
      .height('100%')

      Blank()

      Column({ space: 20 }) {
        Text(this.set.reps)
          .fontSize(42)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignColors.primary)
          .textAlign(TextAlign.End)
        Button() {
          Text('Start')
            .fontSize(25)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignColors.onSecondary)
        }
        .width(116)
        .height(80)
        .backgroundColor('#20C9EC')
        .borderRadius(16)
        .stateEffect(false)
      }
      .alignItems(HorizontalAlign.End)
      .justifyContent(FlexAlign.Center)
      .height('100%')
    }
    .width(640)
    .height(220)
    .padding({ left: 32, right: 32, top: 28, bottom: 28 })
    .backgroundColor('#EA1A0F2C')
    .borderRadius(34)
  }
}

@Component
struct BottomMacroBar {
  build() {
    Row() {
      Column({ space: 10 }) {
        Text('Next macro')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignColors.onSurface)
        Text('Macro tempo')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      Blank()

      Button() {
        Text('Prime')
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignColors.onSecondary)
      }
      .width(200)
      .height(80)
      .backgroundColor('#20C9EC')
      .borderRadius(40)
      .stateEffect(false)
    }
    .width(640)
    .height(240)
    .padding({ left: 0, right: 0, top: 32, bottom: 32 })
    .backgroundColor(DesignColors.surfaceVariant)
    .borderRadius(34)
  }
}

@Entry
@Component
struct MacroTrainerPage {
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

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          NeonDot()
          Blank()
          NeonDot()
        }
        .width(656)
        .height(48)
        .margin({ left: 32, top: 40 })

        Column({ space: 2 }) {
          Text('MacroTrainer')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(DesignColors.onSurface)
            .lineHeight(38)
          Text('Neon workout stack')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#B3F8F4FF')
            .lineHeight(30)
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
        .margin({ top: -54 })

        Row({ space: 24 }) {
          TimerPanel()

          Column({ space: 24 }) {
            ForEach(this.metrics, (metric: PerformanceMetric) => {
              MetricCard({ metric: metric })
            }, (metric: PerformanceMetric) => metric.label)
          }
        }
        .width(640)
        .height(580)
        .margin({ left: 40, top: 62 })

        Column({ space: 40 }) {
          ForEach(this.sets, (set: MacroSet) => {
            SetRow({ set: set })
          }, (set: MacroSet) => set.title)
        }
        .width(640)
        .margin({ left: 40, top: 39 })

        BottomMacroBar()
          .margin({ left: 40, top: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignColors.background)
  }
}
