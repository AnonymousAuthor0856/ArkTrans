@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // modifier: { width: '100%', height: '100%', backgroundColor: '#FFFDF9' }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 3
      Column() {
        // === Blank ===
        // modifier: { height: 16 }
        Blank().height(16)

        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', height: 64, backgroundColor: '#FFFDF9' }
        // children: 1
        Row() {
          // === Text ===
          // props: { text: 'Pomodoro Timer' }
          // modifier: { fontSize: 30, fontWeight: FontWeight.Bold, fontColor: '#1E1E1E' }
          Text('Pomodoro Timer').fontSize(30).fontWeight(FontWeight.Bold).fontColor('#1E1E1E')
        }.width('100%').height(64).backgroundColor('#FFFDF9')

        // === Column ===
        // props: { space: 24 }
        // modifier: { width: '100%', padding: { top: 16 } }
        // children: 4
        Column({ space: 24 }) {
          // === Stack ===
          // props: { alignContent: Alignment.Center }
          // modifier: { width: 280, height: 280 }
          // children: 3
          Stack({ alignContent: Alignment.Center }) {
            // === Circle ===
            // modifier: { width: 280, height: 280, backgroundColor: '#FDE2E4', shadow: { radius: 8, color: '#2D000000', offsetY: 4 } }
            Circle().width(280).height(280).backgroundColor('#FDE2E4').shadow({ radius: 8, color: '#2D000000', offsetY: 4 })

            // === Circle ===
            // modifier: { width: 180, height: 180, backgroundColor: '#B4E3D0', opacity: 0.4 }
            Circle().width(180).height(180).backgroundColor('#B4E3D0').opacity(0.4)

            // === Circle ===
            // modifier: { width: 60, height: 60, backgroundColor: '#FF8FAB' }
            Circle().width(60).height(60).backgroundColor('#FF8FAB')
          }.width(280).height(280)

          // === Text ===
          // props: { text: this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.Medium, fontColor: this.isRunning ? '#4ADE80' : '#FB7185' }
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF').fontSize(20).fontWeight(FontWeight.Medium).fontColor(this.isRunning ? '#4ADE80' : '#FB7185')

          // === Row ===
          // props: { space: 16 }
          // modifier: { width: '100%', justifyContent: FlexAlign.Center }
          // children: 2
          Row({ space: 16 }) {
            // === Button ===
            // modifier: { width: 90, height: 90, backgroundColor: '#FF8FAB', borderRadius: 45 }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'Start' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#FFFFFF' }
              Text('Start').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#FFFFFF')
            }.width(90).height(90).backgroundColor('#FF8FAB').borderRadius(45).onClick(() => {
              this.isRunning = true
            })

            // === Button ===
            // modifier: { width: 90, height: 90, backgroundColor: '#FFD6A5', borderRadius: 45 }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: 'Stop' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#1E1E1E' }
              Text('Stop').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#1E1E1E')
            }.width(90).height(90).backgroundColor('#FFD6A5').borderRadius(45).onClick(() => {
              this.isRunning = false
            })
          }.width('100%').justifyContent(FlexAlign.Center)

          // === Stack ===
          // props: { alignContent: Alignment.Start }
          // modifier: { width: '100%', padding: { left: 16, right: 16 } }
          // children: 2
          Stack({ alignContent: Alignment.Start }) {
            // === Capsule ===
            // modifier: { width: '100%', height: 8, backgroundColor: '#FDE2E4' }
            Capsule().width('100%').height(8).backgroundColor('#FDE2E4')

            // === Capsule ===
            // modifier: { width: '40%', height: 8, backgroundColor: '#FF8FAB' }
            Capsule().width('40%').height(8).backgroundColor('#FF8FAB')
          }.width('100%').padding({ left: 16, right: 16 })
        }.width('100%').padding({ top: 16 })
      }.width('100%')
    }.width('100%').height('100%').backgroundColor('#FFFDF9')
  }
}