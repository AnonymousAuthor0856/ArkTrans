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
struct Page068 {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'
  private tags: string[] = ['Macro', 'Tempo', 'Breath']
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
    Column() {
      Row() {
        Stack() {
        }
        .width(24)
        .height(24)
        .backgroundColor('#1A0F2C')
        .borderRadius(12)

        Column() {
          Text('MacroTrainer')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
          Text('Neon workout stack')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
            .opacity(0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
        }
        .width(24)
        .height(24)
        .backgroundColor('#1A0F2C')
        .borderRadius(12)
      }
      .width('100%')
      .height(56)
      .padding({ left: 20, right: 20 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#0D0616')

      Scroll() {
        Column({ space: 20 }) {
          Row({ space: 12 }) {
            Column({ space: 12 }) {
              Stack() {
                Circle({ width: 160, height: 160 })
                  .fill('#0D0616')
                  .stroke('#08D6FF')
                  .strokeWidth(10)
                Column() {
                  Text(this.timerValue)
                    .fontSize(32)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#F8F4FF')
                  Text('Timer')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#F8F4FF')
                    .opacity(0.7)
                }
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
              }
              .width(160)
              .height(160)

              Row({ space: 4 }) {
                ForEach(this.tags, (tag: string) => {
                  Text(tag)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#F8F4FF')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1A0F2C')
                    .borderRadius(8)
                })
              }
            }
            .layoutWeight(1)
            .padding(16)
            .backgroundColor('#0D0616')
            .borderRadius(28)
            .alignItems(HorizontalAlign.Center)

            Column({ space: 12 }) {
              ForEach(this.metrics, (m: PerformanceMetric) => {
                Column({ space: 4 }) {
                  Text(m.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#F8F4FF')
                  Text(m.value)
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#08D6FF')
                  Text(m.change)
                    .fontSize(14)
                    .fontColor('#F8F4FF')
                    .opacity(0.7)
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#1A0F2C')
                .borderRadius(18)
              })
            }
            .width(120)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          ForEach(this.sets, (s: MacroSet) => {
            Row() {
              Column({ space: 4 }) {
                Text(s.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#F8F4FF')
                Text(s.phase)
                  .fontSize(14)
                  .fontColor('#F8F4FF')
                  .opacity(0.7)
              }
              .alignItems(HorizontalAlign.Start)

              Column({ space: 4 }) {
                Text(s.reps)
                  .fontSize(22)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#7C4DFF')
                Button('Start')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#05030A')
                  .backgroundColor('#08D6FF')
                  .height(32)
                  .borderRadius(8)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }
              .alignItems(HorizontalAlign.End)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .padding(16)
            .backgroundColor('#1A0F2C')
            .borderRadius(18)
          })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .width('100%')

      Row() {
        Column({ space: 4 }) {
          Text('Next macro')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
          Text(this.targetPhase)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8F4FF')
        }
        .alignItems(HorizontalAlign.Start)

        Button('Prime')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#05030A')
          .backgroundColor('#08D6FF')
          .height(40)
          .borderRadius(18)
          .padding({ left: 28, right: 28, top: 8, bottom: 8 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#1A0F2C')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#05030A')
  }
}
