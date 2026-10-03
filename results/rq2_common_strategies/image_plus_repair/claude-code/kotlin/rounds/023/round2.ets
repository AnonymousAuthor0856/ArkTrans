@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false
  @State progressValue: number = 95

  private readonly colors = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFCF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    success: '#4ADE80',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(72)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 48, bottom: 56 })

      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 340, height: 340 })
          .fill(this.colors.surfaceVariant)
          .shadow({
            radius: 24,
            color: 'rgba(0,0,0,0.15)',
            offsetX: 0,
            offsetY: 10
          })

        Circle({ width: 240, height: 240 })
          .fill('#E0E5DE')
      }
      .width(340)
      .height(340)
      .margin({ bottom: 56 })

      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(48)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? this.colors.success : this.colors.primary)
        .margin({ bottom: 40 })

      Row() {
        Button('Start')
          .width(180)
          .height(180)
          .borderRadius(90)
          .backgroundColor(this.colors.primary)
          .fontColor(this.colors.onPrimary)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.isRunning = true
          })

        Blank()
          .width(32)

        Button('Stop')
          .width(180)
          .height(180)
          .borderRadius(90)
          .backgroundColor(this.colors.tertiary)
          .fontColor(this.colors.onSecondary)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.isRunning = false
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 56 })

      Progress({ value: this.progressValue, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(20)
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant)
        .borderRadius(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding({ left: 24, right: 24 })
  }
}
