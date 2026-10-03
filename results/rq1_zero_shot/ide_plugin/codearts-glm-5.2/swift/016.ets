class AppTokens {
  static readonly Colors = {
    primary: '#FF00FFFF',
    secondary: '#FF9D00FF',
    tertiary: '#FF00FFA3',
    background: '#FF0B0B0D',
    surface: '#FF1A1A1D',
    surfaceVariant: '#FF2E2E33',
    outline: '#FF3F3F46',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF000000',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF000000',
    onBackground: '#FFE5E7EB',
    onSurface: '#FFE5E7EB',
    onSurface70: '#B3E5E7EB'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }
}

@Entry
@Component
struct NeonRecorder {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1

  private startTimer() {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  private stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        Column() {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface70)

          TextInput({ text: this.title, placeholder: '' })
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .padding(12)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(10)
            .border({ width: 1, color: this.title.length === 0 ? AppTokens.Colors.outline : AppTokens.Colors.primary })
            .placeholderColor(AppTokens.Colors.onSurface70)
            .margin({ top: 8 })
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .borderRadius(14)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .alignContent(Alignment.Center)
        .margin({ top: 16 })

        Row() {
          Button(this.recording ? 'Stop' : 'Record') {
          }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(160)
          .height(52)
          .borderRadius(14)
          .backgroundColor(this.recording ? AppTokens.Colors.error : AppTokens.Colors.primary)
          .onClick(() => {
            this.recording = !this.recording
            if (this.recording) {
              this.seconds = 0
              this.startTimer()
            } else {
              this.stopTimer()
            }
          })

          Button('Reset') {
          }
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .width(120)
          .height(52)
          .borderRadius(14)
          .backgroundColor(AppTokens.Colors.secondary)
          .margin({ left: 24 })
          .onClick(() => {
            this.seconds = 0
            if (this.recording) {
              this.stopTimer()
              this.startTimer()
            }
          })
        }
        .margin({ top: 16 })

        Text(`Output Path: /storage/recordings/${this.title.length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface70)
          .width('100%')
          .margin({ top: 32 })
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}