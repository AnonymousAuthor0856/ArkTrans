@Entry
@Component
struct MacroTrainerApp {
  @State timerValue: string = '02:34'
  @State targetPhase: string = 'Macro tempo'
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
  private tags: string[] = ['Macro', 'Tempo', 'Breath']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#05030A')

      Column({ space: 0 }) {
        // Top App Bar
        Row({ space: 0 }) {
          Column()
            .width(24)
            .height(24)
            .backgroundColor('#1A0F2C')
            .borderRadius(12)
          Blank()
          Column({ space: 0 }) {
            Text('MacroTrainer')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#F8F4FF')
            Text('Neon workout stack')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#F8F4FF')
              .opacity(0.7)
          }
          .alignItems(HorizontalAlign.Center)
          Blank()
          Column()
            .width(24)
            .height(24)
            .backgroundColor('#1A0F2C')
            .borderRadius(12)
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .backgroundColor('#0D0616')

        List({ space: 20 }) {
          ListItem() {
            Row({ space: 12 }) {
              // Timer ring and tags
              Stack({ alignContent: Alignment.Center }) {
                Column()
                  .width(200)
                  .height(230)
                  .backgroundColor('#0D0616')
                  .borderRadius(28)
                  .shadow({ radius: 6, color: '#42000000', offsetY: 4 })
                Column({ space: 12 }) {
                  // Circular timer ring (simplified solid border)
                  Stack({ alignContent: Alignment.Center }) {
                    Circle()
                      .width(160)
                      .height(160)
                      .border({ width: 10, color: '#7C4DFF' })
                    Column({ space: 4 }) {
                      Text(this.timerValue)
                        .fontSize(32)
                        .fontWeight(FontWeight.Bold)
                        .foregroundColor('#F8F4FF')
                      Text('Timer')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .foregroundColor('#F8F4FF')
                        .opacity(0.7)
                    }
                  }
                  .width(160)
                  .height(160)
                  // Tags row
                  Row({ space: 4 }) {
                    ForEach(this.tags, (tag: string) => {
                      Text(tag)
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                        .backgroundColor('#1A0F2C')
                        .foregroundColor('#F8F4FF')
                        .borderRadius(8)
                    })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.Center)
                }
                .padding(16)
              }
              .width(200)

              // Metrics column
              Column({ space: 12 }) {
                ForEach(this.metrics, (metric: PerformanceMetric) => {
                  Column({ space: 4 }) {
                    Text(metric.label)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#F8F4FF')
                    Text(metric.value)
                      .fontSize(22)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#08D6FF')
                    Text(metric.change)
                      .fontSize(14)
                      .foregroundColor('#F8F4FF')
                      .opacity(0.7)
                  }
                  .width('100%')
                  .alignItems(HorizontalAlign.Start)
                  .padding(12)
                  .backgroundColor('#1A0F2C')
                  .borderRadius(18)
                })
              }
              .width(120)
            }
            .width('100%')
          }

          ForEach(this.sets, (set: MacroSet) => {
            ListItem() {
              Row({ space: 0 }) {
                Column({ space: 4 }) {
                  Text(set.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#F8F4FF')
                  Text(set.phase)
                    .fontSize(14)
                    .foregroundColor('#F8F4FF')
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Column({ space: 4 }) {
                  Text(set.reps)
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#7C4DFF')
                    .textAlign(TextAlign.End)
                  Button() {
                    Text('Start')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#05030A')
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  }
                  .backgroundColor('#08D6FF')
                  .borderRadius(8)
                  .alignSelf(ItemAlign.End)
                }
                .alignItems(HorizontalAlign.End)
              }
              .padding(16)
              .width('100%')
              .backgroundColor('#1A0F2C')
              .borderRadius(18)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })

        // Bottom Bar
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text('Next macro')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#F8F4FF')
            Text(this.targetPhase)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#F8F4FF')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button() {
            Text('Prime')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#05030A')
              .padding({ left: 28, right: 28, top: 8, bottom: 8 })
          }
          .backgroundColor('#08D6FF')
          .borderRadius(18)
        }
        .width('100%')
        .height(80)
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .backgroundColor('#1A0F2C')
        .shadow({ radius: 12, color: '#42000000', offsetY: -6 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
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