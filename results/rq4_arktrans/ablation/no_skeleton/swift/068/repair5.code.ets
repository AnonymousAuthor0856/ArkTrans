@Entry
@Component
struct MacroTrainerApp {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // === Background ===
      Column() {
        Blank()
      }.width('100%').height('100%').backgroundColor('#05030A')

      // === Main Layout ===
      Column() {
        // === Top App Bar ===
        Row() {
          // Left Icon Placeholder
          Circle().fill('#1A0F2C').width(24).height(24)
          
          Blank()
          
          // Center Text
          Column() {
            Text("MacroTrainer").fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
            Text("Neon workout stack").fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF').opacity(0.7)
          }
          
          Blank()
          
          // Right Icon Placeholder
          Circle().fill('#1A0F2C').width(24).height(24)
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#0D0616').opacity(0.95)

        // === Scrollable Content ===
        Scroll() {
          Column({ space: 20 }) {
            
            // === Timer & Metrics Section ===
            Row({ space: 12 }) {
              
              // --- Timer Ring Card ---
              Column({ space: 12 }) {
                // Gradient Ring Simulation using a thick border circle
                // Note: ArkTS doesn't support AngularGradient stroke directly on Circle easily without canvas or complex shapes.
                // We use a conic gradient background with a mask to simulate the ring.
                Stack() {
                  // The Ring
                  Circle()
                    .width(160).height(160)
                    .borderWidth(10)
                    .borderStyle(BorderStyle.Solid)
                    .linearGradient({
                      angle: 360,
                      colors: [
                        ['#7C4DFF', 0],
                        ['#08D6FF', 33],
                        ['#FF8E3C', 66],
                        ['#7C4DFF', 100]
                      ]
                    })
                  
                  // Inner Mask to create the hole (simulating stroke)
                  // In real production, we might use a ClipPath or Canvas for perfect donut, 
                  // but stacking a slightly smaller solid circle works for this visual style.
                  Circle()
                    .width(140).height(140)
                    .backgroundColor('#0D0616') // Matches card bg

                  // Timer Text
                  Column({ space: 4 }) {
                    Text(this.timerValue).fontSize(32).fontWeight(FontWeight.Bold).fontColor('#F8F4FF')
                    Text("Timer").fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF').opacity(0.7)
                  }
                }

                // Tags
                Row({ space: 4 }) {
                  Text("Macro")
                    .fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1A0F2C').borderRadius(8)
                  
                  Text("Tempo")
                    .fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1A0F2C').borderRadius(8)
                  
                  Text("Breath")
                    .fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1A0F2C').borderRadius(8)
                }
              }
              .width('100%')
              .layoutWeight(1)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .padding(16)
              .backgroundColor('#0D0616')
              .borderRadius(28)
              .shadow({ radius: 6, color: '#42000000', offsetY: 4 })

              // --- Metrics Column ---
              Column({ space: 12 }) {
                // Metric 1: Load
                Column({ space: 4 }) {
                  Text("Load").fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                  Text("72%").fontSize(22).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                  Text("+4%").fontSize(14).fontWeight(FontWeight.Normal).fontColor('#F8F4FF').opacity(0.7)
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#1A0F2C')
                .borderRadius(18)

                // Metric 2: VO2
                Column({ space: 4 }) {
                  Text("VO2").fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                  Text("41").fontSize(22).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                  Text("+1").fontSize(14).fontWeight(FontWeight.Normal).fontColor('#F8F4FF').opacity(0.7)
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#1A0F2C')
                .borderRadius(18)

                // Metric 3: Focus
                Column({ space: 4 }) {
                  Text("Focus").fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                  Text("88%").fontSize(22).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                  Text("stable").fontSize(14).fontWeight(FontWeight.Normal).fontColor('#F8F4FF').opacity(0.7)
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#1A0F2C')
                .borderRadius(18)
              }
              .width(120)
            }

            // === Sets List Section ===
            Column({ space: 20 }) {
              
              // Set 1: Warm circuit
              Row() {
                Column({ space: 4 }) {
                  Text("Warm circuit").fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                  Text("Energy").fontSize(14).fontWeight(FontWeight.Normal).fontColor('#F8F4FF').opacity(0.7)
                }
                
                Blank()
                
                Column({ space: 4 }, { alignItems: ItemAlign.End }) {
                  Text("3 sets").fontSize(22).fontWeight(FontWeight.Bold).fontColor('#7C4DFF')
                  Button({ type: ButtonType.Normal, stateEffect: true })
                    .backgroundColor('#08D6FF')
                    .borderRadius(8)
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .fontColor('#05030A')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .width('auto')
                    .height('auto')
                    .onClick(() => {})
                }
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#1A0F2C').opacity(0.9)
              .borderRadius(18)

              // Set 2: Core push
              Row() {
                Column({ space: 4 }) {
                  Text("Core push").fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                  Text("Explosive").fontSize(14).fontWeight(FontWeight.Normal).fontColor('#F8F4FF').opacity(0.7)
                }
                
                Blank()
                
                Column({ space: 4 }, { alignItems: ItemAlign.End }) {
                  Text("4 rounds").fontSize(22).fontWeight(FontWeight.Bold).fontColor('#7C4DFF')
                  Button({ type: ButtonType.Normal, stateEffect: true })
                    .backgroundColor('#08D6FF')
                    .borderRadius(8)
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .fontColor('#05030A')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .width('auto')
                    .height('auto')
                    .onClick(() => {})
                }
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#1A0F2C').opacity(0.9)
              .borderRadius(18)

              // Set 3: Cooldown flow (Added from source code data, though not explicitly in screenshot crop, good practice to include)
              Row() {
                Column({ space: 4 }) {
                  Text("Cooldown flow").fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                  Text("Calm").fontSize(14).fontWeight(FontWeight.Normal).fontColor('#F8F4FF').opacity(0.7)
                }
                
                Blank()
                
                Column({ space: 4 }, { alignItems: ItemAlign.End }) {
                  Text("6 min").fontSize(22).fontWeight(FontWeight.Bold).fontColor('#7C4DFF')
                  Button({ type: ButtonType.Normal, stateEffect: true })
                    .backgroundColor('#08D6FF')
                    .borderRadius(8)
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .fontColor('#05030A')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .width('auto')
                    .height('auto')
                    .onClick(() => {})
                }
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#1A0F2C').opacity(0.9)
              .borderRadius(18)
            }
          }
          .padding({ left: 20, right: 20, top: 16, bottom: 100 }) // Bottom padding to avoid overlap with fixed bar
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // === Bottom Bar ===
      Row() {
        Column({ space: 4 }) {
          Text("Next macro").fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
          Text(this.targetPhase).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
        }
        
        Blank()
        
        Button({ type: ButtonType.Normal, stateEffect: true })
          .backgroundColor('#08D6FF')
          .borderRadius(18)
          .padding({ left: 28, right: 28, top: 8, bottom: 8 })
          .fontColor('#05030A')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width('auto')
          .height('auto')
          .onClick(() => {})
      }
      .width('100%')
      .height(80)
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#1A0F2C')
      .shadow({ radius: 12, color: '#42000000', offsetY: -6 })
    }
    .width('100%')
    .height('100%')
  }
}