class AppTokens {
  static readonly Colors = {
    primary: '#FFFF8FAB',
    secondary: '#FFB4E3D0',
    tertiary: '#FFFFD6A5',
    background: '#FFFFFCF9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFFDE2E4',
    outline: '#FFFCC2D7',
    success: '#FF4ADE80',
    warning: '#FFFACC15',
    error: '#FFFB7185',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1E1E1E',
    onTertiary: '#FF1E1E1E',
    onBackground: '#FF1E1E1E',
    onSurface: '#FF1E1E1E',
    secondary40: '#66B4E3D0'
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }
}

@Entry
@Component
struct PomodoroTimer {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isRunning: boolean = false

  private centerX: number = 140
  private centerY: number = 140
  private trackRadius: number = 90

  build() {
    Column() {
      Row().height(16)

      Stack() {
        Text('Pomodoro Timer')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(64)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Column() {
        Stack() {
          Row()
            .width(280)
            .height(280)
            .borderRadius(140)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })

          Row()
            .width(180)
            .height(180)
            .borderRadius(90)
            .backgroundColor(AppTokens.Colors.secondary40)

          Row()
            .width(60)
            .height(60)
            .borderRadius(30)
            .backgroundColor(AppTokens.Colors.primary)
            .position({ x: this.knobX - 30, y: this.knobY - 30 })
        }
        .width(280)
        .height(280)
        .alignContent(Alignment.Center)
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              const x = event.fingerList[0].localX
              const y = event.fingerList[0].localY
              const vx = x - this.centerX
              const vy = y - this.centerY
              const dist = Math.sqrt(vx * vx + vy * vy)
              if (dist === 0) {
                return
              }
              const nx = vx / dist
              const ny = vy / dist
              this.knobX = this.centerX + nx * this.trackRadius
              this.knobY = this.centerY + ny * this.trackRadius
            })
        )

        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ top: 24 })

        Row() {
          Button('Start') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(AppTokens.Colors.primary)
          .onClick(() => {
            this.isRunning = true
          })

          Button('Stop') {
          }
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(90)
          .height(90)
          .borderRadius(45)
          .backgroundColor(AppTokens.Colors.tertiary)
          .margin({ left: 16 })
          .onClick(() => {
            this.isRunning = false
          })
        }
        .margin({ top: 24 })

        Stack() {
          Row()
            .width('100%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.surfaceVariant)

          Row()
            .width('40%')
            .height(8)
            .borderRadius(4)
            .backgroundColor(AppTokens.Colors.primary)
        }
        .alignContent(Alignment.Start)
        .width('100%')
        .padding({ left: 16, right: 16 })
        .margin({ top: 24 })
      }
      .padding({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}