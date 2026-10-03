@Entry
@Component
struct MacroTrainerPage {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'

  private sets: Array<MacroSet> = [
    { title: 'Warm circuit', reps: '3 sets', phase: 'Energy' },
    { title: 'Core push', reps: '4 rounds', phase: 'Explosive' },
    { title: 'Cooldown flow', reps: '6 min', phase: 'Calm' }
  ]

  private metrics: Array<PerformanceMetric> = [
    { label: 'Load', value: '72%', change: '+4%' },
    { label: 'VO2', value: '41', change: '+1' },
    { label: 'Focus', value: '88%', change: 'stable' }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle({ width: 24, height: 24 })
          .fill('#1A0F2C')

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
          Text('Neon workout stack')
            .fontSize(12)
            .fontColor('rgba(248, 244, 255, 0.7)')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Circle({ width: 24, height: 24 })
          .fill('#1A0F2C')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('rgba(13, 6, 22, 0.95)')

      // Scrollable content
      Scroll() {
        Column() {
          // Timer + Metrics row
          Row() {
            // Timer card
            Column() {
              Stack({ alignContent: Alignment.Center }) {
                // Outer gradient ring
                Circle()
                  .width(160)
                  .height(160)
                  .sweepGradient({
                    center: ['50%', '50%'],
                    start: 0,
                    end: 360,
                    colors: ['#7C4DFF', '#08D6FF', '#FF8E3C', '#7C4DFF']
                  })

                // Inner fill
                Circle()
                  .width(140)
                  .height(140)
                  .fill('#0D0616')

                Column() {
                  Text(this.timerValue)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#F8F4FF')
                  Text('Timer')
                    .fontSize(12)
                    .fontColor('rgba(248, 244, 255, 0.7)')
                }
                .alignItems(HorizontalAlign.Center)
              }
              .width(160)
              .height(160)

              // Tags row
              Row() {
                ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontColor('#F8F4FF')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1A0F2C')
                    .borderRadius(8)
                }, (tag: string) => tag)
              }
              .margin({ top: 12 })
            }
            .layoutWeight(1)
            .padding(16)
            .backgroundColor('#0D0616')
            .borderRadius(28)
            .alignItems(HorizontalAlign.Center)

            // Metrics column
            Column() {
              ForEach(this.metrics, (metric: PerformanceMetric) => {
                Column() {
                  Text(metric.label)
                    .fontSize(12)
                    .fontColor('#F8F4FF')
                  Text(metric.value)
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#08D6FF')
                    .margin({ top: 2, bottom: 2 })
                  Text(metric.change)
                    .fontSize(14)
                    .fontColor('rgba(248, 244, 255, 0.7)')
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#1A0F2C')
                .borderRadius(18)
              }, (metric: PerformanceMetric) => metric.label)
            }
            .width(120)
            .margin({ left: 12 })
          }
          .width('100%')

          // Sets list
          Column() {
            ForEach(this.sets, (set: MacroSet) => {
              Row() {
                Column() {
                  Text(set.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#F8F4FF')
                  Text(set.phase)
                    .fontSize(14)
                    .fontColor('rgba(248, 244, 255, 0.7)')
                    .margin({ top: 4 })
                }
                .layoutWeight(1)

                Column() {
                  Text(set.reps)
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#7C4DFF')
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
              .backgroundColor('rgba(26, 15, 44, 0.9)')
              .borderRadius(18)
            }, (set: MacroSet) => set.title)
          }
          .width('100%')
          .margin({ top: 20 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#05030A')

      // Bottom Bar
      Row() {
        Column() {
          Text('Next macro')
            .fontSize(12)
            .fontColor('#F8F4FF')
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
            .margin({ top: 4 })
        }

        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#05030A')
          .backgroundColor('#08D6FF')
          .borderRadius(18)
          .padding({ left: 28, right: 28, top: 8, bottom: 8 })
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#1A0F2C')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#05030A')
  }
}

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
