@Entry
@Component
struct Index {
  @State timerDisplay: string = '00:00'
  @State isRunning: boolean = false
  @State statusText: string = 'Focus Mode OFF'
  @State startLabel: string = 'Start'
  @State stopLabel: string = 'Stop'
  @State syncProgress: number = 0.3
  @State titleText: string = 'Pomodoro Timer'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 24 }) {
        // Surface / Circle Container
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Canvas().width('100%').height('100%')
          }.width('100%').height('100%')
        }
        .width(280)
        .height(280)
        .borderRadius(140)
        .backgroundColor('#FDE2E4')
        .shadow({ radius: 4, color: '#1A000000' })

        // Status Text
        Text(this.statusText)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? '#4CAF50' : '#F44336')

        // Buttons Row
        Row({ space: 16 }) {
          Button() {
            Text(this.startLabel)
              .fontColor('#FFFFFF')
          }
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor('#FF8FAB')
          .onClick(() => {
            this.isRunning = true
            this.statusText = 'Focus Mode ON'
          })

          Button() {
            Text(this.stopLabel)
              .fontColor('#1E1E1E')
          }
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor('#FCE4EC')
          .onClick(() => {
            this.isRunning = false
            this.statusText = 'Focus Mode OFF'
          })
        }
        .alignItems(VerticalAlign.Center)

        // Progress Bar
        Progress({ value: this.syncProgress, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#FF8FAB')
          .trackColor('#FDE2E4')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#FFFCF9')

      // Top App Bar (Overlay)
      Row() {
        Text(this.titleText)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFCF9')
    }
    .width('100%')
    .height('100%')
  }
}