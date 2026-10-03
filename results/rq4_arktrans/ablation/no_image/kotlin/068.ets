import { Alignment, FlexAlign, HorizontalAlign, VerticalAlign } from '@kit.ArkUI';

interface MetricItem {
  label: string;
  value: string;
  change: string;
}

@Entry
@Component
struct Index {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"
  // Corrected invalid state declarations to valid types with default values
  @State timerValueNum: number = 0
  @State Timer: number = 0
  @State tag: number = 0
  @State metricLabel: string = ""
  @State metricValue: string = ""
  @State metricChange: string = ""
  @State setTitle: string = ""
  @State setPhase: string = ""
  @State setReps: string = ""
  @State Start: number = 0
  @State MacroTrainer: number = 0
  @State NeonWorkoutStack: number = 0
  @State NextMacro: number = 0
  @State targetPhaseValue: number = 0
  @State Prime: number = 0

  // Mock data for lists to ensure compilation and UI rendering
  private tags: string[] = ["Macro", "Tempo", "Breath"]
  private metrics: MetricItem[] = [
    { label: "Intensity", value: "85%", change: "+5%" },
    { label: "Volume", value: "1200kg", change: "-2%" }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 20 }) {
        ListItem() {
          Row({ space: 8 }) {
            // Left Column (Timer)
            Column() {
              Column({ space: 8 }) {
                // Circular Timer Box
                Stack({ alignContent: Alignment.Center }) {
                  Column({ space: 0 }) {
                    Text(this.timerValue).fontSize(32).fontWeight(FontWeight.Bold).fontColor('#F8F4FF')
                    Text('Timer').fontSize(14).fontColor('#F8F4FF')
                  }.alignItems(HorizontalAlign.Center)
                }
                .width(160)
                .height(160)
                .borderRadius(80)
                .backgroundColor('#1E1B2E') // Approximation of surface color
                .border({ width: 10, color: '#7C4DFF' }) // Simplified gradient border

                // Tags Row
                Row({ space: 4 }) {
                  ForEach(this.tags, (tagItem: string) => {
                    Stack({ alignContent: Alignment.Center }) {
                      Text(tagItem).fontSize(12).fontColor('#F8F4FF')
                    }
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#2D2A3A') // SurfaceVariant approximation
                    .borderRadius(4)
                  })
                }
              }
              .alignItems(HorizontalAlign.Center)
              .padding(16)
            }
            .layoutWeight(1)
            .backgroundColor('#0D0616')
            .borderRadius(16)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

            // Right Column (Metrics)
            Column({ space: 8 }) {
              ForEach(this.metrics, (metric: MetricItem) => {
                Column({ space: 4 }) {
                  Text(metric.label).fontSize(12).fontColor('#F8F4FF')
                  Text(metric.value).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                  Text(metric.change).fontSize(14).fontColor('#F8F4FF')
                }
                .width('100%')
                .backgroundColor('#2D2A3A') // SurfaceVariant approximation
                .borderRadius(8)
                .padding(12)
              })
            }
            .width(120)
          }
          .width('100%')
        }

        ListItem() {
          // Set Info Row
          Row({ space: 0 }) {
            Column({ space: 4 }) {
              Text("Squat").fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
              Text("Working Set").fontSize(14).fontColor('#F8F4FF')
            }
            
            Blank()

            Column({ space: 4 }) {
              Text("5 x 5").fontSize(24).fontWeight(FontWeight.Bold).fontColor('#7C4DFF')
              Button() {
                Text('Start').fontSize(12).fontColor('#05030A')
              }
              .backgroundColor('#08D6FF') // Secondary color approximation
              .borderRadius(4)
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
            }
            .alignItems(HorizontalAlign.End)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .backgroundColor('#2D2A3A') // SurfaceVariant with alpha approx
          .borderRadius(8)
          .padding(16)
        }
      }
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .width('100%')
      .layoutWeight(1)

      // Top App Bar Area (Simulated as part of stack for layout simplicity in this skeleton)
      Column({ space: 0 }) {
        Column({ space: 0 }) {
          Text('MacroTrainer').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
          Text('Neon workout stack').fontSize(12).fontColor('#F8F4FF')
        }
        .alignItems(HorizontalAlign.Center)
        
        // Icons placeholders
        Row({ space: 16 }) {
           Button() {
             Stack({ alignContent: Alignment.Center }) {}
               .width(24)
               .height(24)
               .borderRadius(12)
               .backgroundColor('#2D2A3A')
           }
           
           Button() {
             Stack({ alignContent: Alignment.Center }) {}
               .width(24)
               .height(24)
               .borderRadius(12)
               .backgroundColor('#2D2A3A')
           }
        }
        .justifyContent(FlexAlign.End)
        .width('100%')
        .padding(16)
      }
      .backgroundColor('#1E1B2E') // Surface with alpha approx
      .zIndex(10)

      // Bottom Sheet / Next Macro Area
      Column() {
        Row({ space: 0 }) {
          Column({ space: 4 }) {
            Text("Next macro").fontSize(12).fontColor('#F8F4FF')
            Text(this.targetPhase).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
          }
          
          Blank()

          Button() {
            Text('Prime').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#05030A')
          }
          .backgroundColor('#08D6FF') // Secondary color
          .borderRadius(8)
          .padding({ left: 20, right: 20, top: 8, bottom: 8 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      }
      .backgroundColor('#1A0F2C')
      .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
      .position({ x: 0, y: '100%' }) // Position at bottom if needed, or just flow
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#05030A')
  }
}