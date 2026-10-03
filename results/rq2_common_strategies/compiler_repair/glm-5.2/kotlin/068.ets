// Index.ets

class MacroSet {
  title: string = '';
  reps: string = '';
  phase: string = '';

  constructor(title: string, reps: string, phase: string) {
    this.title = title;
    this.reps = reps;
    this.phase = phase;
  }
}

class PerformanceMetric {
  label: string = '';
  value: string = '';
  change: string = '';

  constructor(label: string, value: string, change: string) {
    this.label = label;
    this.value = value;
    this.change = change;
  }
}

@Entry
@Component
struct RootScreen {
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

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#1A0F2C')

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontColor('#F8F4FF')
            .fontWeight(FontWeight.Medium)
          Text('Neon workout stack')
            .fontSize(12)
            .fontColor('#F8F4FF')
            .opacity(0.7)
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Row()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#1A0F2C')
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#0D0616')
      .opacity(0.95)

      // Content List
      Scroll() {
        Column() {
          // Top Section: Timer and Metrics
          Row() {
            // Timer Card
            Column() {
              Stack() {
                Column() {
                  Text(this.timerValue)
                    .fontSize(32)
                    .fontColor('#F8F4FF')
                    .fontWeight(FontWeight.Bold)
                  Text('Timer')
                    .fontSize(12)
                    .fontColor('#F8F4FF')
                    .opacity(0.7)
                    .margin({ top: 4 })
                }
                .justifyContent(FlexAlign.Center)
              }
              .width(160)
              .height(160)
              .borderRadius(80)
              .backgroundColor('#0D0616')
              .border({ width: 10, color: '#7C4DFF' })

              Row() {
                ForEach(this.tags, (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontColor('#F8F4FF')
                    .backgroundColor('#1A0F2C')
                    .borderRadius(8)
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .margin({ right: 4 })
                })
              }
              .margin({ top: 12 })
            }
            .layoutWeight(1)
            .padding(16)
            .backgroundColor('#0D0616')
            .borderRadius(28)
            .alignItems(HorizontalAlign.Center)

            // Metrics Column
            Column() {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                Column() {
                  Text(metric.label)
                    .fontSize(12)
                    .fontColor('#F8F4FF')
                  Text(metric.value)
                    .fontSize(22)
                    .fontColor('#08D6FF')
                    .fontWeight(FontWeight.Medium)
                    .margin({ top: 4 })
                  Text(metric.change)
                    .fontSize(14)
                    .fontColor('#F8F4FF')
                    .opacity(0.7)
                    .margin({ top: 4 })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#1A0F2C')
                .borderRadius(18)
                .margin({ bottom: 12 })
                .alignItems(HorizontalAlign.Start)
              })
            }
            .width(120)
            .margin({ left: 12 })
          }
          .width('100%')

          // Sets List
          ForEach(this.sets, (set: MacroSet) => {
            Row() {
              Column() {
                Text(set.title)
                  .fontSize(16)
                  .fontColor('#F8F4FF')
                  .fontWeight(FontWeight.Medium)
                Text(set.phase)
                  .fontSize(14)
                  .fontColor('#F8F4FF')
                  .opacity(0.7)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)

              Column() {
                Text(set.reps)
                  .fontSize(22)
                  .fontColor('#7C4DFF')
                  .fontWeight(FontWeight.Medium)
                Button('Start')
                  .fontSize(12)
                  .fontColor('#05030A')
                  .backgroundColor('#08D6FF')
                  .borderRadius(8)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#1A0F2C')
            .opacity(0.9)
            .borderRadius(18)
            .margin({ top: 20 })
            .justifyContent(FlexAlign.SpaceBetween)
          })
        }
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      // Bottom Bar
      Row() {
        Column() {
          Text('Next macro')
            .fontSize(12)
            .fontColor('#F8F4FF')
          Text(this.targetPhase)
            .fontSize(16)
            .fontColor('#F8F4FF')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Prime')
          .fontSize(16)
          .fontColor('#05030A')
          .backgroundColor('#08D6FF')
          .borderRadius(18)
          .padding({ left: 28, right: 28, top: 8, bottom: 8 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#1A0F2C')
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#05030A')
  }
}