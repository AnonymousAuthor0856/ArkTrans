@Entry
@Component
struct MacroTrainer {
  @State timerValue: string = '02:34'

  build() {
    // === Column (Root) ===
    // modifier: { width: '100%', height: '100%', backgroundColor: '#05030A' }
    // children: 3
    Column() {
      // === Row (Top Bar) ===
      // props: { space: 16, verticalAlignment: VerticalAlign.Center }
      // modifier: { width: '100%', padding: 16, backgroundColor: '#0D0616' }
      // children: 3
      Row({ space: 16, verticalAlignment: VerticalAlign.Center }) {
        // === Image (Nav Icon Placeholder) ===
        // modifier: { width: 24, height: 24, backgroundColor: '#1A0F2C' }
        Image($r('app.media.startIcon')).width(24).height(24).backgroundColor('#1A0F2C')

        // === Column (Title) ===
        // props: { space: 4 }
        // modifier: { layoutWeight: 1, horizontalAlign: HorizontalAlign.Center }
        // children: 2
        Column({ space: 4 }) {
          // === Text ===
          // props: { text: 'MacroTrainer' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#F8F4FF' }
          Text('MacroTrainer').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
          
          // === Text ===
          // props: { text: 'Neon workout stack' }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#BDB7E9' }
          Text('Neon workout stack').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#BDB7E9')
        }

        // === Image (Action Icon Placeholder) ===
        // modifier: { width: 24, height: 24, backgroundColor: '#1A0F2C' }
        Image($r('app.media.startIcon')).width(24).height(24).backgroundColor('#1A0F2C')
      }.width('100%').padding(16).backgroundColor('#0D0616')

      // === Scroll (Content) ===
      // modifier: { width: '100%', layoutWeight: 1 }
      // children: 1
      Scroll() {
        // === Column (List Container) ===
        // props: { space: 20 }
        // modifier: { width: '100%', padding: 16 }
        // children: 2
        Column({ space: 20 }) {
          // === Row (Stats Section) ===
          // props: { space: 12 }
          // modifier: { width: '100%' }
          // children: 2
          Row({ space: 12 }) {
            // === Column (Timer Card) ===
            // props: { space: 12, horizontalAlign: HorizontalAlign.Center }
            // modifier: { layoutWeight: 1, backgroundColor: '#0D0616', borderRadius: 28, padding: 16 }
            // children: 2
            Column({ space: 12, horizontalAlign: HorizontalAlign.Center }) {
              // === Stack (Progress Ring) ===
              // props: { alignContent: Alignment.Center }
              // modifier: { width: 160, height: 160 }
              // children: 2
              Stack({ alignContent: Alignment.Center }) {
                // === Circle (Gradient Border Simulation) ===
                // Note: ArkTS doesn't support SweepGradient on border directly in simple way. 
                // Using a large circle with gradient background and smaller inner circle to simulate ring.
                // Outer Circle
                Circle().width(160).height(160).fill(LinearGradient({
                  angle: 45,
                  colors: [['#7C4DFF', 0], ['#08D6FF', 0.5], ['#FF8E3C', 1]]
                }))
                
                // Inner Mask (to create the ring effect)
                Circle().width(140).height(140).fill('#0D0616')
                
                // === Column (Timer Text) ===
                // props: { space: 4, horizontalAlign: HorizontalAlign.Center }
                // children: 2
                Column({ space: 4, horizontalAlign: HorizontalAlign.Center }) {
                  // === Text ===
                  // props: { text: this.timerValue }
                  // modifier: { fontSize: 32, fontWeight: FontWeight.Bold, color: '#F8F4FF' }
                  Text(this.timerValue).fontSize(32).fontWeight(FontWeight.Bold).fontColor('#F8F4FF')
                  
                  // === Text ===
                  // props: { text: 'Timer' }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#BDB7E9' }
                  Text('Timer').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#BDB7E9')
                }
              }

              // === Row (Tags) ===
              // props: { space: 4 }
              // children: 3
              Row({ space: 4 }) {
                // === Text (Tag 1) ===
                // props: { text: 'Macro' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#F8F4FF', backgroundColor: '#1A0F2C', borderRadius: 8, padding: { left: 8, right: 8, top: 4, bottom: 4 } }
                Text('Macro').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF').backgroundColor('#1A0F2C').borderRadius(8).padding({ left: 8, right: 8, top: 4, bottom: 4 })
                
                // === Text (Tag 2) ===
                // props: { text: 'Tempo' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#F8F4FF', backgroundColor: '#1A0F2C', borderRadius: 8, padding: { left: 8, right: 8, top: 4, bottom: 4 } }
                Text('Tempo').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF').backgroundColor('#1A0F2C').borderRadius(8).padding({ left: 8, right: 8, top: 4, bottom: 4 })
                
                // === Text (Tag 3) ===
                // props: { text: 'Breath' }
                // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#F8F4FF', backgroundColor: '#1A0F2C', borderRadius: 8, padding: { left: 8, right: 8, top: 4, bottom: 4 } }
                Text('Breath').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF').backgroundColor('#1A0F2C').borderRadius(8).padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }
            }.layoutWeight(1).backgroundColor('#0D0616').borderRadius(28).padding(16)

            // === Column (Metrics) ===
            // props: { space: 12 }
            // modifier: { width: 120 }
            // children: 3
            Column({ space: 12 }) {
              // === Metric Item 1 ===
              // modifier: { width: '100%', backgroundColor: '#1A0F2C', borderRadius: 18, padding: 12 }
              // children: 1
              Column({ space: 4 }) {
                Text('Load').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                Text('72%').fontSize(22).fontWeight(FontWeight.SemiBold).fontColor('#08D6FF')
                Text('+4%').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#BDB7E9')
              }.width('100%').backgroundColor('#1A0F2C').borderRadius(18).padding(12)

              // === Metric Item 2 ===
              // modifier: { width: '100%', backgroundColor: '#1A0F2C', borderRadius: 18, padding: 12 }
              // children: 1
              Column({ space: 4 }) {
                Text('VO2').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                Text('41').fontSize(22).fontWeight(FontWeight.SemiBold).fontColor('#08D6FF')
                Text('+1').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#BDB7E9')
              }.width('100%').backgroundColor('#1A0F2C').borderRadius(18).padding(12)

              // === Metric Item 3 ===
              // modifier: { width: '100%', backgroundColor: '#1A0F2C', borderRadius: 18, padding: 12 }
              // children: 1
              Column({ space: 4 }) {
                Text('Focus').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                Text('88%').fontSize(22).fontWeight(FontWeight.SemiBold).fontColor('#08D6FF')
                Text('stable').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#BDB7E9')
              }.width('100%').backgroundColor('#1A0F2C').borderRadius(18).padding(12)
            }.width(120)
          }

          // === Column (Workout List) ===
          // props: { space: 12 }
          // modifier: { width: '100%' }
          // children: 2
          Column({ space: 12 }) {
            // === Workout Item 1 ===
            // modifier: { width: '100%', backgroundColor: '#1A0F2C', borderRadius: 18, padding: 16 }
            // children: 1
            Row({ space: 16, verticalAlignment: VerticalAlign.Center }) {
              // === Column (Left Info) ===
              // props: { space: 4 }
              // modifier: { layoutWeight: 1 }
              // children: 2
              Column({ space: 4 }) {
                Text('Warm circuit').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                Text('Energy').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#BDB7E9')
              }.layoutWeight(1)

              // === Column (Right Action) ===
              // props: { space: 4, horizontalAlign: HorizontalAlign.End }
              // children: 2
              Column({ space: 4, horizontalAlign: HorizontalAlign.End }) {
                Text('3 sets').fontSize(22).fontWeight(FontWeight.SemiBold).fontColor('#7C4DFF')
                Button('Start')
                  .backgroundColor('#08D6FF')
                  .fontColor('#05030A')
                  .borderRadius(8)
                  .width(80)
                  .height(40)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
              }
            }.width('100%').backgroundColor('#1A0F2C').borderRadius(18).padding(16)

            // === Workout Item 2 ===
            // modifier: { width: '100%', backgroundColor: '#1A0F2C', borderRadius: 18, padding: 16 }
            // children: 1
            Row({ space: 16, verticalAlignment: VerticalAlign.Center }) {
              // === Column (Left Info) ===
              // props: { space: 4 }
              // modifier: { layoutWeight: 1 }
              // children: 2
              Column({ space: 4 }) {
                Text('Core push').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
                Text('Explosive').fontSize(14).fontWeight(FontWeight.Normal).fontColor('#BDB7E9')
              }.layoutWeight(1)

              // === Column (Right Action) ===
              // props: { space: 4, horizontalAlign: HorizontalAlign.End }
              // children: 2
              Column({ space: 4, horizontalAlign: HorizontalAlign.End }) {
                Text('4 rounds').fontSize(22).fontWeight(FontWeight.SemiBold).fontColor('#7C4DFF')
                Button('Start')
                  .backgroundColor('#08D6FF')
                  .fontColor('#05030A')
                  .borderRadius(8)
                  .width(80)
                  .height(40)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
              }
            }.width('100%').backgroundColor('#1A0F2C').borderRadius(18).padding(16)
          }
        }.width('100%').padding(16)
      }.width('100%').layoutWeight(1)

      // === Row (Bottom Bar) ===
      // props: { space: 16, verticalAlignment: VerticalAlign.Center }
      // modifier: { width: '100%', padding: 16, backgroundColor: '#1A0F2C' }
      // children: 2
      Row({ space: 16, verticalAlignment: VerticalAlign.Center }) {
        // === Column (Next Macro Info) ===
        // props: { space: 4 }
        // modifier: { layoutWeight: 1 }
        // children: 2
        Column({ space: 4 }) {
          Text('Next macro').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
          Text('Macro tempo').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#F8F4FF')
        }.layoutWeight(1)

        // === Button (Prime) ===
        // modifier: { backgroundColor: '#08D6FF', borderRadius: 18, padding: { left: 28, right: 28, top: 8, bottom: 8 } }
        // children: 1
        Button('Prime')
          .backgroundColor('#08D6FF')
          .fontColor('#05030A')
          .borderRadius(18)
          .padding({ left: 28, right: 28, top: 8, bottom: 8 })
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
      }.width('100%').padding(16).backgroundColor('#1A0F2C')
    }.width('100%').height('100%').backgroundColor('#05030A')
  }
}