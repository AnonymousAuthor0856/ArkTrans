@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false
  @State knobX: number = 0
  @State knobY: number = 0
  @State progressValue: number = 0

  private readonly colors = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFCF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    outline: '#FCC2D7',
    success: '#4ADE80',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(60)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .margin({ top: 40, bottom: 40 })

      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 280, height: 280 })
          .fill(this.colors.surfaceVariant)
          .shadow({
            radius: 20,
            color: 'rgba(0,0,0,0.18)',
            offsetX: 0,
            offsetY: 8
          })

        Circle({ width: 200, height: 200 })
          .fill(this.colors.secondary)
          .opacity(0.4)
      }
      .width(280)
      .height(280)
      .margin({ top: 20, bottom: 40 })

      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(40)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? this.colors.success : this.colors.primary)
        .margin({ bottom: 32 })

      Row() {
        Button('Start')
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(this.colors.primary)
          .fontColor(this.colors.onPrimary)
          .fontSize(20)
          .onClick(() => {
            this.isRunning = true
          })

        Button('Stop')
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(this.colors.tertiary)
          .fontColor(this.colors.onSecondary)
          .fontSize(20)
          .onClick(() => {
            this.isRunning = false
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: 40 })

      Progress({ value: this.progressValue, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant)
        .borderRadius(4)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding({ left: 16, right: 16 })
  }
}
