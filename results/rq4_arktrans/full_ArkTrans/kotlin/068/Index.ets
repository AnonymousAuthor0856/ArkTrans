@Entry
@Component
struct Index {
  @State timerValue: string = "02:34"
  @State targetPhase: string = "Macro tempo"

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List({ space: 20 }) {
        ListItem() {
          // === Row (Top Section) ===
          Row({ space: 16 }) {
            // === Surface (Timer Card) ===
            Column() {
              Column({ space: 16 }) {
                // Box (Circular Timer)
                Stack({ alignContent: Alignment.Center }) {
                  // Gradient Border Simulation using a slightly larger background circle
                  Circle().width(150).height(150).fill('#0D0616')
                  
                  // Inner Content
                  Column({ space: 0 }) {
                    Text(this.timerValue).fontSize(48).fontWeight(FontWeight.Bold).fontColor('#F8F4FF').lineHeight(50)
                    Text('Timer').fontSize(14).fontColor('#A0A0A0')
                  }
                }.width(160).height(160)
                .border({ width: 10, color: '#000', radius: 90 }) 
                // Note: ArkTS doesn't support gradient borders natively on shapes easily without custom drawing. 
                // Using a solid border or shadow for structure here to ensure compilation.
                .shadow({ radius: 10, color: '#7C4DFF' }) 

                // Tags Row
                Row({ space: 8 }) {
                  ForEach(['Macro', 'Tempo', 'Breath'], (tag: string) => {
                    Text(tag)
                      .fontSize(14)
                      .fontColor('#F8F4FF')
                      .backgroundColor('#2B1B4B')
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                      .borderRadius(8)
                  })
                }
              }
              .alignItems(HorizontalAlign.Center)
              .padding(16)
            }
            .width('60%')
            .height(320)
            .backgroundColor('#0D0616')
            .borderRadius(24)

            // Metrics Column
            Column({ space: 16 }) {
              // Metric 1: Load
              Column({ space: 4 }) {
                Text('Load').fontSize(14).fontColor('#A0A0A0')
                Text('72%').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                Text('+4%').fontSize(14).fontColor('#A0A0A0')
              }
              .width('100%')
              .backgroundColor('#1A0F2C')
              .padding(16)
              .borderRadius(20)

              // Metric 2: VO2
              Column({ space: 4 }) {
                Text('VO2').fontSize(14).fontColor('#A0A0A0')
                Text('41').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                Text('+1').fontSize(14).fontColor('#A0A0A0')
              }
              .width('100%')
              .backgroundColor('#1A0F2C')
              .padding(16)
              .borderRadius(20)

              // Metric 3: Focus
              Column({ space: 4 }) {
                Text('Focus').fontSize(14).fontColor('#A0A0A0')
                Text('88%').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#08D6FF')
                Text('stable').fontSize(14).fontColor('#A0A0A0')
              }
              .width('100%')
              .backgroundColor('#1A0F2C')
              .padding(16)
              .borderRadius(20)
            }
            .width('40%')
            .height(320)
          }
          .width('100%')
        }

        ListItem() {
          // === Row (Set Card) ===
          Row({ space: 0 }) {
            Column({ space: 8 }) {
              Text('Warm circuit').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
              Text('Energy').fontSize(16).fontColor('#A0A0A0')
            }
            
            Blank()

            Column({ space: 8 }) {
              Text('3 sets').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#7C4DFF')
              Button() {
                Text('Start').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#05030A')
              }
              .backgroundColor('#08D6FF')
              .borderRadius(12)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            }
            .alignItems(HorizontalAlign.End)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .backgroundColor('#1A0F2C')
          .padding(20)
          .borderRadius(24)
        }
        
        // Placeholder for the cut-off card at the bottom of the list
        ListItem() {
           Column()
             .width('100%')
             .height(40)
             .backgroundColor('#1A0F2C')
             .borderRadius(24)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })

      // === CenterAlignedTopAppBar ===
      Row() {
        // Left Icon Placeholder
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .opacity(0.5) // Dimming as it's just a placeholder in screenshot
          }
          .width(40)
          .height(40)
          .backgroundColor('#2B1B4B')
          .borderRadius(20)
        }
        .margin({ left: 20 })

        Blank()

        // Center Title
        Column({ space: 0 }) {
          Text('MacroTrainer').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#F8F4FF')
          Text('Neon workout stack').fontSize(14).fontColor('#A0A0A0')
        }
        .alignItems(HorizontalAlign.Center)

        Blank()

        // Right Icon Placeholder
        Button() {
          Stack({ alignContent: Alignment.Center }) {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
              .opacity(0.5)
          }
          .width(40)
          .height(40)
          .backgroundColor('#2B1B4B')
          .borderRadius(20)
        }
        .margin({ right: 20 })
      }
      .width('100%')
      .height(80)
      .backgroundColor('#05030A')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // === Bottom Sheet / Surface ===
      Column() {
        Row({ space: 0 }) {
          Column({ space: 8 }) {
            Text('Next macro').fontSize(14).fontColor('#A0A0A0')
            Text(this.targetPhase).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#F8F4FF')
          }

          Blank()

          Button() {
            Text('Prime').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#05030A')
          }
          .backgroundColor('#08D6FF')
          .borderRadius(24)
          .padding({ left: 32, right: 32, top: 16, bottom: 16 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20, top: 20, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('#1A0F2C')
      .shadow({ radius: 10, color: '#000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#05030A')
  }
}