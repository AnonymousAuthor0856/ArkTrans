class AppTokens {
  static readonly Colors = {
    primary: '#FFEF476F',
    secondary: '#FFFFD166',
    tertiary: '#FF06D6A0',
    background: '#FFFFFCF2',
    surface: '#FFFFF8E1',
    surfaceVariant: '#FFFCE7E7',
    outline: '#FFBDBDBD',
    success: '#FF06D6A0',
    warning: '#FFFFA600',
    error: '#FFD62828',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF1F1F1F',
    onTertiary: '#FF1F1F1F',
    onBackground: '#FF1F1F1F',
    onSurface: '#FF1F1F1F'
  }
}

@Entry
@Component
struct RetroMusicPlayer {
  @State knobX: number = 140
  @State knobY: number = 140
  @State isDragging: boolean = false

  private centerX: number = 140
  private centerY: number = 140
  private radius: number = 120

  build() {
    Column() {
      Stack() {
        Text('Retro Music Player')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(80)
      .backgroundColor(AppTokens.Colors.background)
      .alignContent(Alignment.Center)

      Column() {
        Stack() {
          Row()
            .width(240)
            .height(240)
            .borderRadius(120)
            .border({ width: 8, color: AppTokens.Colors.secondary })

          Row()
            .width(24)
            .height(24)
            .borderRadius(12)
            .backgroundColor(AppTokens.Colors.primary)
            .position({ x: this.knobX - 12, y: this.knobY - 12 })
        }
        .width(280)
        .height(280)
        .borderRadius(16)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 3, color: AppTokens.Colors.outline })
        .alignContent(Alignment.Center)
        .gesture(
          PanGesture({ distance: 0 })
            .onActionUpdate((event: GestureEvent) => {
              this.isDragging = true
              const x = event.fingerList[0].localX
              const y = event.fingerList[0].localY
              const dx = x - this.centerX
              const dy = y - this.centerY
              const dist = Math.sqrt(dx * dx + dy * dy)
              if (dist <= this.radius) {
                this.knobX = x
                this.knobY = y
              } else {
                const angle = Math.atan2(dy, dx)
                this.knobX = this.centerX + Math.cos(angle) * this.radius
                this.knobY = this.centerY + Math.sin(angle) * this.radius
              }
            })
            .onActionEnd(() => {
              this.isDragging = false
            })
        )

        Text('Track: Summer Nights')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 32 })

        Row() {
          Button('Play') {
          }
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(140)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(12)

          Button('Pause') {
          }
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(140)
          .height(56)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(12)
          .margin({ left: 32 })
        }
        .margin({ top: 32 })

        Text('Knob X:268 Y:303')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: 32 })
      }
      .padding({ left: 32, right: 32 })
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}