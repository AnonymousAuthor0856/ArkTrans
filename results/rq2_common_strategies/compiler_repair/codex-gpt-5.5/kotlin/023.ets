class PomodoroColors {
  static primary: string = '#FF8FAB';
  static secondary: string = '#B4E3D0';
  static tertiary: string = '#FFD6A5';
  static background: string = '#FFFCF9';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FDE2E4';
  static success: string = '#4ADE80';
  static error: string = '#FB7185';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State knobX: number = 0;
  @State knobY: number = 0;
  @State isRunning: boolean = false;

  private progressValue(): number {
    return ((this.knobX + this.knobY) % 400) / 4;
  }

  @Builder
  TimerDial() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(250)
        .height(250)
        .fill('#66B4E3D0')
      Circle()
        .width(60)
        .height(60)
        .fill(PomodoroColors.primary)
        .translate({ x: this.knobX - 110, y: this.knobY - 110 })
    }
    .width(280)
    .height(280)
    .backgroundColor(PomodoroColors.surfaceVariant)
    .borderRadius(140)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
    .gesture(
      PanGesture()
        .onActionUpdate((event: GestureEvent) => {
          let nextX: number = this.knobX + event.offsetX;
          let nextY: number = this.knobY + event.offsetY;
          if (nextX < 0) {
            nextX = 0;
          }
          if (nextX > 220) {
            nextX = 220;
          }
          if (nextY < 0) {
            nextY = 0;
          }
          if (nextY > 220) {
            nextY = 220;
          }
          this.knobX = nextX;
          this.knobY = nextY;
        })
    )
  }

  build() {
    Column() {
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor(PomodoroColors.onSurface)
        .lineHeight(36)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Column() {
        this.TimerDial()

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? PomodoroColors.success : PomodoroColors.error)
          .lineHeight(26)
          .margin({ top: 24 })

        Row({ space: 16 }) {
          Button('Start')
            .fontSize(16)
            .fontColor(PomodoroColors.onPrimary)
            .width(90)
            .height(90)
            .backgroundColor(PomodoroColors.primary)
            .borderRadius(45)
            .onClick(() => {
              this.isRunning = true;
            })
          Button('Stop')
            .fontSize(16)
            .fontColor(PomodoroColors.onSecondary)
            .width(90)
            .height(90)
            .backgroundColor(PomodoroColors.tertiary)
            .borderRadius(45)
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        Progress({ value: this.progressValue(), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color(PomodoroColors.primary)
          .backgroundColor(PomodoroColors.surfaceVariant)
          .margin({ top: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PomodoroColors.background)
  }
}
