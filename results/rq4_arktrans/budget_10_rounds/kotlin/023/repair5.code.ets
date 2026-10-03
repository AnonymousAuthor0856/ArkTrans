@Entry
@Component
struct Index {
  @State isRunning: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 24 }) {
        // === Surface (Circle) ===
        Column() {
          // Inner Box/Canvas simulation
          Stack({ alignContent: Alignment.Center }) {
            Canvas().width('100%').height('100%')
          }.width('100%').height('100%')
        }
        .width(280).height(280).borderRadius(140)
        .backgroundColor('#FDE2E4')
        .shadow({ radius: 4, color: '#1A000000' })

        // === Text (Status) ===
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? '#4CAF50' : '#FF8FAB')

        // === Row (Buttons) ===
        Row({ space: 16 }) {
          // Start Button
          Button() {
            Text('Start')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
          }
          .width(90).height(90).borderRadius(45)
          .backgroundColor('#FF8FAB')
          .onClick(() => { this.isRunning = true })

          // Stop Button
          Button() {
            Text('Stop')
              .fontColor('#1E1E1E')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
          }
          .width(90).height(90).borderRadius(45)
          .backgroundColor('#FFDDB7')
          .onClick(() => { this.isRunning = false })
        }
        .justifyContent(FlexAlign.Center)

        // === Progress Indicator ===
        Progress({ value: 0.3, total: 1, type: ProgressType.Linear })
          .width('100%').height(8).borderRadius(4)
          .color('#FF8FAB')
          .linearProgressStyle({ trackColor: '#FDE2E4' })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%').height('100%')
      .padding(16)
      .backgroundColor('#FFFCF9')

      // === Top App Bar ===
      Column() {
        Text('Pomodoro Timer')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .padding({ top: 50, bottom: 20 })
      .backgroundColor('#FFFCF9')
    }
    .width('100%').height('100%')
  }
}