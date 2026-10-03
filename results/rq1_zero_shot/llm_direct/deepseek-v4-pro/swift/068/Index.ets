@Entry
@Component
struct MacroTrainerApp {
  build() {
    Stack() {
      ContentView()
    }
    .backgroundColor('#05030A')
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'
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
    .backgroundColor('#05030A')
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
          .fill('#1A0F2C')
          .onClick(() => {})

        Blank()
          .width(20)

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')

          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3A8C7')
        }
        .alignItems(HorizontalAlign.Center)

        Blank()
          .width(20)

        Circle()
          .width(24)
          .height(24)
          .fill('#1A0F2C')
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(60)
    .backgroundColor('#0D0616')
  }
}

@Component
struct MainContent {
  @Prop sets: MacroSet[]
  @Prop metrics: PerformanceMetric[]
  @Prop tags: string[]
  @Prop timerValue: string

  build() {
    Scroll() {
      Column() {
        TimerSection({
          timerValue: this.timerValue,
          tags: this.tags,
          metrics: this.metrics
        })

        SetsListSection({ sets: this.sets })
      }
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Component
struct TimerSection {
  @Prop timerValue: string
  @Prop tags: string[]
  @Prop metrics: PerformanceMetric[]

  build() {
    Row() {
      TimerRing({
        timerValue: this.timerValue,
        tags: this.tags
      })

      Blank()
        .width(12)

      MetricsColumn({ metrics: this.metrics })
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct TimerRing {
  @Prop timerValue: string
  @Prop tags: string[]

  build() {
    Stack() {
      Column() {
        Stack() {
          Circle()
            .width(160)
            .height(160)
            .fill('#0D0616')
            .stroke('#7C4DFF')
            .strokeWidth(10)

          Column() {
            Text(this.timerValue)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#F8F4FF')

            Text('Timer')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#B3A8C7')
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(160)
        .height(160)

        Blank()
          .height(12)

        Row() {
          ForEach(this.tags, (tag: string) => {
            Text(tag)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor('#1A0F2C')
              .fontColor('#F8F4FF')
              .borderRadius(8)
          }, (tag: string) => tag)
        }
        .justifyContent(FlexAlign.Center)
      }
      .padding(16)
      .alignItems(HorizontalAlign.Center)
    }
    .backgroundColor('#0D0616')
    .borderRadius(28)
    .shadow({ radius: 6, color: '#42000000', offsetX: 0, offsetY: 4 })
  }
}

@Component
struct MetricsColumn {
  @Prop metrics: PerformanceMetric[]

  build() {
    Column() {
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
  @Prop metric: PerformanceMetric

  build() {
    Column() {
      Text(this.metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#F8F4FF')

      Blank()
        .height(4)

      Text(this.metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor('#08D6FF')

      Blank()
        .height(4)

      Text(this.metric.change)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#B3A8C7')
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#1A0F2C')
    .borderRadius(18)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SetsListSection {
  @Prop sets: MacroSet[]

  build() {
    Column() {
      ForEach(this.sets, (set: MacroSet) => {
        SetListItemView({ set: set })
      }, (set: MacroSet) => set.title)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SetListItemView {
  @Prop set: MacroSet

  build() {
    Row() {
      Column() {
        Text(this.set.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#F8F4FF')

        Blank()
          .height(4)

        Text(this.set.phase)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor('#B3A8C7')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Column() {
        Text(this.set.reps)
          .fontSize(22)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#7C4DFF')

        Blank()
          .height(4)

        Button('Start')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#08D6FF')
          .fontColor('#05030A')
          .borderRadius(8)
          .onClick(() => {})
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#1A0F2C')
    .borderRadius(18)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomBar {
  @Prop targetPhase: string

  build() {
    Stack() {
      Row() {
        Column() {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')

          Blank()
            .height(4)

          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .padding({ left: 28, right: 28, top: 8, bottom: 8 })
          .backgroundColor('#08D6FF')
          .fontColor('#05030A')
          .borderRadius(18)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#1A0F2C')
    .shadow({ radius: 12, color: '#42000000', offsetX: 0, offsetY: -6 })
  }
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