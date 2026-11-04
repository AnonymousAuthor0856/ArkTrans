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

class MacroColors {
  static readonly primary: string = '#7C4DFF';
  static readonly secondary: string = '#08D6FF';
  static readonly tertiary: string = '#FF8E3C';
  static readonly background: string = '#05030A';
  static readonly surface: string = '#0D0616';
  static readonly surfaceVariant: string = '#1A0F2C';
  static readonly outline: string = '#3A2759';
  static readonly onPrimary: string = '#05030A';
  static readonly onSecondary: string = '#05030A';
  static readonly onSurface: string = '#F8F4FF';
}

@Entry
@Component
struct Index {
  @State timerValue: string = '02:34';
  @State targetPhase: string = 'Macro tempo';
  private sets: MacroSet[] = [
    new MacroSet('Warm circuit', '3 sets', 'Energy'),
    new MacroSet('Core push', '4 rounds', 'Explosive'),
    new MacroSet('Cooldown flow', '6 min', 'Calm')
  ];
  private metrics: PerformanceMetric[] = [
    new PerformanceMetric('Load', '72%', '+4%'),
    new PerformanceMetric('VO2', '41', '+1'),
    new PerformanceMetric('Focus', '88%', 'stable')
  ];
  private tags: string[] = ['Macro', 'Tempo', 'Breath'];

  @Builder
  TopBar() {
    Row() {
      Circle()
        .width(24)
        .height(24)
        .fill(MacroColors.surfaceVariant)

      Column() {
        Text('MacroTrainer')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(MacroColors.onSurface)
        Text('Neon workout stack')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3F8F4FF')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(24)
        .height(24)
        .fill(MacroColors.surfaceVariant)
    }
    .width('100%')
    .height(68)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F20D0616')
  }

  @Builder
  TimerRing() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(160)
          .height(160)
          .fill(MacroColors.surface)
          .stroke(MacroColors.primary)
          .strokeWidth(10)
        Circle()
          .width(128)
          .height(128)
          .fill(MacroColors.surface)
          .stroke(MacroColors.secondary)
          .strokeWidth(6)
        Column() {
          Text(this.timerValue)
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor(MacroColors.onSurface)
          Text('Timer')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3F8F4FF')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(160)
      .height(160)

      Row() {
        ForEach(this.tags, (tag: string) => {
          Text(tag)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(MacroColors.onSurface)
            .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            .backgroundColor(MacroColors.surfaceVariant)
            .borderRadius(8)
            .margin({ right: tag === 'Breath' ? 0 : 4 })
        }, (tag: string) => tag)
      }
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(MacroColors.surface)
    .borderRadius(28)
    .shadow({ radius: 8, color: '#38000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  MetricCard(metric: PerformanceMetric) {
    Column() {
      Text(metric.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(MacroColors.onSurface)
      Text(metric.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(MacroColors.secondary)
        .margin({ top: 4 })
      Text(metric.change)
        .fontSize(14)
        .fontColor('#B3F8F4FF')
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(MacroColors.surfaceVariant)
    .borderRadius(18)
  }

  @Builder
  SetRow(item: MacroSet) {
    Row() {
      Column() {
        Text(item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(MacroColors.onSurface)
        Text(item.phase)
          .fontSize(14)
          .fontColor('#B3F8F4FF')
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Column() {
        Text(item.reps)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(MacroColors.primary)
        Button('Start')
          .height(32)
          .fontSize(12)
          .fontColor(MacroColors.onSecondary)
          .backgroundColor(MacroColors.secondary)
          .borderRadius(8)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#E61A0F2C')
    .borderRadius(18)
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('Next macro')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(MacroColors.onSurface)
        Text(this.targetPhase)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(MacroColors.onSurface)
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Button('Prime')
        .height(40)
        .fontSize(16)
        .fontColor(MacroColors.onSecondary)
        .backgroundColor(MacroColors.secondary)
        .borderRadius(18)
    }
    .width('100%')
    .height(76)
    .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(MacroColors.surfaceVariant)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            Row() {
              Column() {
                this.TimerRing()
              }
              .layoutWeight(1)

              Column() {
                ForEach(this.metrics, (metric: PerformanceMetric) => {
                  Column() {
                    this.MetricCard(metric)
                  }
                  .margin({ bottom: 12 })
                }, (metric: PerformanceMetric) => metric.label)
              }
              .width(120)
              .margin({ left: 12 })
            }
            .width('100%')

            ForEach(this.sets, (item: MacroSet) => {
              Column() {
                this.SetRow(item)
              }
              .margin({ top: 20 })
            }, (item: MacroSet) => item.title)
          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 16, bottom: 96 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(MacroColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MacroColors.background)
  }
}
