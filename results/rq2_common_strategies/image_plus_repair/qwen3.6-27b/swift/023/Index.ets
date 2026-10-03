@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false

  build() {
    Column() {
      // Top Bar
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .margin({ top: 48, bottom: 24 })

      // Main Content
      Column() {
        // Timer Circle
        Row() {
          Circle()
            .width(280)
            .height(280)
            .fill('#FDE2E4')
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })

          Circle()
            .width(180)
            .height(180)
            .fill('#B4E3D0')
            .opacity(0.4)

          Circle()
            .width(60)
            .height(60)
            .fill('#FF8FAB')
        }
        .width(280)
        .height(280)

        // Focus Mode Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? '#4ADE80' : '#FB7185')
          .margin({ top: 24 })

        // Start/Stop Buttons
        Row() {
          Button('Start')
            .onClick(() => {
              this.isRunning = true
            })
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FF8FAB')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)

          Button('Stop')
            .onClick(() => {
              this.isRunning = false
            })
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FFD6A5')
            .fontColor('#1E1E1E')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 24 })

        // Progress Bar
        Row() {
          Row()
            .width('40%')
            .height(8)
            .borderRadius(4)
            .backgroundColor('#FF8FAB')
        }
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor('#FDE2E4')
        .margin({ top: 24 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFDF9')
  }
}