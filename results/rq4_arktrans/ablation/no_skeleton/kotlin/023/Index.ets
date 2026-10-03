@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false
  @State knobX: number = 0
  @State knobY: number = 0

  build() {
    Column() {
      // === Header ===
      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 24, bottom: 24 })

      // === Circular Surface ===
      Stack() {
        // Background Circle (SurfaceVariant)
        Circle({ width: 280, height: 280 })
          .fill('#FDE2E4')
          .shadow({ radius: 8, color: '#2D000000', offsetY: 4 })

        // Inner Canvas Area for Knob
        Stack() {
          // Secondary Ring (Visual only based on screenshot)
          Circle({ width: 200, height: 200 })
            .fill('#B4E3D0')
            .opacity(0.4)

          // Draggable Knob
          Circle({ width: 60, height: 60 })
            .fill('#FF8FAB')
            .position({ x: this.knobX - 30, y: this.knobY - 30 })
            .gesture(
              PanGesture()
                .onActionUpdate((event?: GestureEvent) => {
                  if (event) {
                    this.knobX += event.offsetX
                    this.knobY += event.offsetY
                  }
                })
            )
        }.width(280).height(280)
      }

      // === Status Text ===
      Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isRunning ? '#4ADE80' : '#FB7185')
        .margin({ top: 24 })

      // === Buttons Row ===
      Row() {
        Button('Start')
          .type(ButtonType.Normal)
          .backgroundColor('#FF8FAB')
          .fontColor('#FFFFFF')
          .borderRadius(45)
          .width(90)
          .height(90)
          .onClick(() => {
            this.isRunning = true
          })

        Button('Stop')
          .type(ButtonType.Normal)
          .backgroundColor('#FFD6A5')
          .fontColor('#1E1E1E')
          .borderRadius(45)
          .width(90)
          .height(90)
          .onClick(() => {
            this.isRunning = false
          })
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
      .margin({ top: 24 })

      // === Progress Bar ===
      Progress({
        value: Math.abs((this.knobX + this.knobY) % 400),
        total: 400,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color('#FF8FAB')
        .trackColor('#FDE2E4')
        .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#FFFDF9')
  }
}