@Entry
@Component
struct RootScreen {
  @State private knobX: number = 140;
  @State private knobY: number = 140;
  @State private isRunning: boolean = false;

  @Builder
  TimerCircle() {
    Stack() {
      Circle()
        .width(280)
        .height(280)
        .fill('#FDE2E4')
      Circle()
        .width(180)
        .height(180)
        .fill('#66B4E3D0')
      Circle()
        .width(60)
        .height(60)
        .fill('#FF8FAB')
        .position({ x: this.knobX, y: this.knobY })
    }
    .width(280)
    .height(280)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      Blank().height(16)
      Row() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFCF9')

      Column() {
        this.TimerCircle()
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? '#4ADE80' : '#FB7185')
          .margin({ top: 24 })

        Row() {
          Button('Start')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .backgroundColor('#FF8FAB')
            .width(90)
            .height(90)
            .borderRadius(45)
            .onClick(() => {
              this.isRunning = true;
            })
          Button('Stop')
            .fontSize(14)
            .fontColor('#1E1E1E')
            .backgroundColor('#FFD6A5')
            .width(90)
            .height(90)
            .borderRadius(45)
            .margin({ left: 16 })
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .margin({ top: 24 })

        Stack({ alignContent: Alignment.Start }) {
          Capsule()
            .width('100%')
            .height(8)
            .fill('#FDE2E4')
          Capsule()
            .width('40%')
            .height(8)
            .fill('#FF8FAB')
        }
        .width('100%')
        .height(8)
        .padding({ left: 16, right: 16 })
        .margin({ top: 24 })
      }
      .width('100%')
      .padding({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF9')
  }
}
