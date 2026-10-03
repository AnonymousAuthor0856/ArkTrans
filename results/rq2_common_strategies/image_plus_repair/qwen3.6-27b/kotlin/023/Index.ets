@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false
  @State timeLeft: number = 25 * 60 // 25 minutes in seconds

  build() {
    Column() {
      Text(this.formatTime(this.timeLeft))
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 50 })

      Row() {
        Button(this.isRunning ? 'Pause' : 'Start')
          .onClick(() => {
            this.isRunning = !this.isRunning
            if (this.isRunning) {
              setInterval(() => {
                if (this.timeLeft > 0) {
                  this.timeLeft--
                } else {
                  this.isRunning = false
                }
              }, 1000)
            }
          })

        Button('Reset')
          .margin({ left: 20 })
          .onClick(() => {
            this.isRunning = false
            this.timeLeft = 25 * 60
          })
      }
      .justifyContent(FlexAlign.Center)
      .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  formatTime(seconds: number): string {
    const mins = Math.floor(seconds / 60)
    const secs = seconds % 60
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
  }
}