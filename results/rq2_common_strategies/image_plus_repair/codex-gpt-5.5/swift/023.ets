@Entry
@Component
struct PomodoroTimer {
  @State isRunning: boolean = false
  @State knobX: number = 140
  @State knobY: number = 140
  private readonly trackRadius: number = 90

  build() {
    Column({ space: 0 }) {
      Blank()
        .height(16)

      Text('Pomodoro Timer')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)

      Column({ space: 24 }) {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(280)
            .height(280)
            .fill('#FDE2E4')
            .shadow(8)

          Circle()
            .width(180)
            .height(180)
            .fill('#B4E3D0')
            .opacity(0.4)

          Circle()
            .width(60)
            .height(60)
            .fill('#FF8FAB')
            .position({ x: this.knobX, y: this.knobY })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Move || event.type === TouchType.Down) {
                const dx = event.touches[0].x - 140
                const dy = event.touches[0].y - 140
                const distance = Math.sqrt(dx * dx + dy * dy)
                if (distance > 0) {
                  this.knobX = 140 + dx / distance * this.trackRadius
                  this.knobY = 140 + dy / distance * this.trackRadius
                }
              }
            })
        }
        .width(280)
        .height(280)

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? '#4ADE80' : '#FB7185')

        Row({ space: 32 }) {
          Button('Start')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FF8FAB')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .onClick(() => {
              this.isRunning = true
            })

          Button('Stop')
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor('#FFD6A5')
            .fontSize(14)
            .fontColor('#1E1E1E')
            .onClick(() => {
              this.isRunning = false
            })
        }

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor('#FDE2E4')

          Row()
            .width('40%')
            .height(8)
            .borderRadius(4)
            .backgroundColor('#FF8FAB')
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .padding({ top: 16 })
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFCF9')
    .justifyContent(FlexAlign.Start)
  }
}
