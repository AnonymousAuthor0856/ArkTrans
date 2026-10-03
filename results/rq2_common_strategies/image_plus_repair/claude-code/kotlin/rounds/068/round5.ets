@Entry
@Component
struct Index {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"

  private sets: Array<MacroSet> = [
    new MacroSet("Warm circuit", "3 sets", "Energy"),
    new MacroSet("Core push", "4 rounds", "Explosive"),
    new MacroSet("Cooldown flow", "6 min", "Calm")
  ]

  private metrics: Array<PerformanceMetric> = [
    new PerformanceMetric("Load", "72%", "+4%"),
    new PerformanceMetric("VO2", "41", "+1"),
    new PerformanceMetric("Focus", "88%", "stable")
  ]

  @Builder
  TopBar() {
    Row() {
      Circle({ width: 40, height: 40 })
        .fill('#1A0F2C')
      Column() {
        Text("MacroTrainer")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F8F4FF')
        Text("Neon workout stack")
          .fontSize(22)
          .fontColor('#F8F4FF')
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
      Circle({ width: 40, height: 40 })
        .fill('#1A0F2C')
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 12, bottom: 12 })
    .backgroundColor('#0D0616')
  }

  @Builder
  TimerRing() {
    Stack({ alignContent: Alignment.Center }) {
      Circle({ width: 280, height: 280 })
        .fill('#0D0616')
        .border({ width: 18, color: '#7C4DFF', radius: 140 })
      Column() {
        Text(this.timerValue)
          .fontSize(64)
          .fontWeight(FontWeight.Bold)
          .fontColor('#F8F4FF')
        Text("Timer")
          .fontSize(22)
          .fontColor('#F8F4FF')
          .opacity(0.7)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(280)
    .height(280)
  }

  @Builder
  TagChip(label: string) {
    Text(label)
      .fontSize(16)
      .fontColor('#F8F4FF')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor('#1A0F2C')
      .borderRadius(8)
  }

  @Builder
  MetricCard(metric: PerformanceMetric) {
    Column() {
      Text(metric.label)
        .fontSize(20)
        .fontColor('#F8F4FF')
      Text(metric.value)
        .fontSize(44)
        .fontWeight(600)
        .fontColor('#08D6FF')
        .margin({ top: 4 })
      Text(metric.change)
        .fontSize(18)
        .fontColor('#F8F4FF')
        .opacity(0.7)
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#1A0F2C')
    .borderRadius(28)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SetCard(set: MacroSet) {
    Row() {
      Column() {
        Text(set.title)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#F8F4FF')
        Text(set.phase)
          .fontSize(22)
          .fontColor('#F8F4FF')
          .opacity(0.7)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        Text(set.reps)
          .fontSize(36)
          .fontWeight(600)
          .fontColor('#7C4DFF')
        Button("Start")
          .fontSize(22)
          .fontColor('#05030A')
          .backgroundColor('#08D6FF')
          .borderRadius(16)
          .padding({ left: 20, right: 20, top: 10, bottom: 10 })
          .margin({ top: 8 })
          .onClick(() => {})
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#1A0F2C')
    .borderRadius(28)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text("Next macro")
          .fontSize(22)
          .fontColor('#F8F4FF')
        Text(this.targetPhase)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor('#F8F4FF')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button("Prime")
        .fontSize(32)
        .fontColor('#05030A')
        .backgroundColor('#08D6FF')
        .borderRadius(28)
        .padding({ left: 48, right: 48, top: 16, bottom: 16 })
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 28, right: 28, top: 20, bottom: 20 })
    .backgroundColor('#1A0F2C')
  }

  build() {
    Column() {
      this.TopBar()

      List() {
        ListItem() {
          Row() {
            Column() {
              this.TimerRing()
              Row() {
                this.TagChip("Macro")
                this.TagChip("Tempo")
                this.TagChip("Breath")
              }
              .margin({ top: 20 })
            }
            .width('60%')
            .padding(20)
            .backgroundColor('#0D0616')
            .borderRadius(36)
            .alignItems(HorizontalAlign.Center)

            Column() {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                this.MetricCard(metric)
              }, (metric: PerformanceMetric) => metric.label)
            }
            .width('38%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }

        ForEach(this.sets, (set: MacroSet) => {
          ListItem() {
            this.SetCard(set)
          }
        }, (set: MacroSet) => set.title)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#05030A')
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
