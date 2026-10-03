@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Circle().width(24).height(24).fill('#1A0F2C')
          Blank()
          Column() {
            Text('MacroTrainer').fontColor('#F8F4FF').fontSize(16).fontWeight(FontWeight.Medium)
            Text('Neon workout stack').fontColor('#9D97AC').fontSize(12).fontWeight(FontWeight.Medium)
          }
          Blank()
          Circle().width(24).height(24).fill('#1A0F2C')
        }.width('100%').padding({ left: 24, right: 24, top: 16, bottom: 16 })

        Scroll() {
          Column() {
            // Timer Section
            Row() {
              // Left: Timer Card
              Column() {
                Stack() {
                  // Background circle for gradient effect simulation
                  Circle().width(180).height(180).borderWidth(12).borderColor('#000000')
                  
                  Column() {
                    Text('02:34').fontColor('#FFFFFF').fontSize(40).fontWeight(FontWeight.Bold)
                    Text('Timer').fontColor('#9D97AC').fontSize(14).margin({ top: 4 })
                  }
                }.width(200).height(200)

                Row() {
                  Text('Macro').fontColor('#F8F4FF').fontSize(14).backgroundColor('#1A0F2C').borderRadius(8).padding({ left: 12, right: 12, top: 6, bottom: 6 }).margin({ right: 8 })
                  Text('Tempo').fontColor('#F8F4FF').fontSize(14).backgroundColor('#1A0F2C').borderRadius(8).padding({ left: 12, right: 12, top: 6, bottom: 6 }).margin({ right: 8 })
                  Text('Breath').fontColor('#F8F4FF').fontSize(14).backgroundColor('#1A0F2C').borderRadius(8).padding({ left: 12, right: 12, top: 6, bottom: 6 })
                }.justifyContent(FlexAlign.Start).margin({ top: 16 })
              }.layoutWeight(1).alignItems(HorizontalAlign.Center)

              // Right: Metrics Column
              Column() {
                // Load
                Column() {
                  Text('Load').fontColor('#9D97AC').fontSize(14)
                  Text('72%').fontColor('#08D6FF').fontSize(32).fontWeight(FontWeight.Bold).margin({ top: 4 })
                  Text('+4%').fontColor('#9D97AC').fontSize(14).margin({ top: 4 })
                }.width('100%').backgroundColor('#1A0F2C').borderRadius(16).padding(16).margin({ bottom: 16 })

                // VO2
                Column() {
                  Text('VO2').fontColor('#9D97AC').fontSize(14)
                  Text('41').fontColor('#08D6FF').fontSize(32).fontWeight(FontWeight.Bold).margin({ top: 4 })
                  Text('+1').fontColor('#9D97AC').fontSize(14).margin({ top: 4 })
                }.width('100%').backgroundColor('#1A0F2C').borderRadius(16).padding(16).margin({ bottom: 16 })

                // Focus
                Column() {
                  Text('Focus').fontColor('#9D97AC').fontSize(14)
                  Text('88%').fontColor('#08D6FF').fontSize(32).fontWeight(FontWeight.Bold).margin({ top: 4 })
                  Text('stable').fontColor('#9D97AC').fontSize(14).margin({ top: 4 })
                }.width('100%').backgroundColor('#1A0F2C').borderRadius(16).padding(16)
              }.width('45%')
            }.margin({ top: 24 })

            // Sets List Section
            Column() {
              // Warm circuit
              Row() {
                Column() {
                  Text('Warm circuit').fontColor('#F8F4FF').fontSize(20).fontWeight(FontWeight.Medium)
                  Text('Energy').fontColor('#9D97AC').fontSize(16).margin({ top: 4 })
                }.layoutWeight(1)
                
                Column() {
                  Text('3 sets').fontColor('#B06AFF').fontSize(24).fontWeight(FontWeight.Bold)
                  Button('Start')
                    .backgroundColor('#08D6FF')
                    .fontColor('#05030A')
                    .borderRadius(12)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .margin({ top: 8 })
                }.alignItems(HorizontalAlign.End)
              }.width('100%').backgroundColor('#1A0F2C').borderRadius(20).padding(20).margin({ bottom: 16 })

              // Core push
              Row() {
                Column() {
                  Text('Core push').fontColor('#F8F4FF').fontSize(20).fontWeight(FontWeight.Medium)
                  Text('Explosive').fontColor('#9D97AC').fontSize(16).margin({ top: 4 })
                }.layoutWeight(1)
                
                Column() {
                  Text('4 rounds').fontColor('#B06AFF').fontSize(24).fontWeight(FontWeight.Bold)
                  Button('Start')
                    .backgroundColor('#08D6FF')
                    .fontColor('#05030A')
                    .borderRadius(12)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .margin({ top: 8 })
                }.alignItems(HorizontalAlign.End)
              }.width('100%').backgroundColor('#1A0F2C').borderRadius(20).padding(20)
            }.margin({ top: 24 })
            
            Blank().height(100) // Spacer for scrolling
          }.padding({ left: 24, right: 24 })
        }

        // Bottom Bar
        Row() {
          Column() {
            Text('Next macro').fontColor('#F8F4FF').fontSize(12).fontWeight(FontWeight.Medium)
            Text('Macro tempo').fontColor('#F8F4FF').fontSize(16).fontWeight(FontWeight.Medium).margin({ top: 4 })
          }.layoutWeight(1)
          
          Button('Prime')
            .backgroundColor('#08D6FF')
            .fontColor('#05030A')
            .borderRadius(18)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .padding({ left: 32, right: 32, top: 8, bottom: 8 })
        }.width('100%').padding({ left: 24, right: 24, top: 16, bottom: 16 }).backgroundColor('#1A0F2C')
      }.width('100%').height('100%').backgroundColor('#05030A')
    }.width('100%').height('100%')
  }
}