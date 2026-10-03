interface ColorPalette {
  primary: string
  secondary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  error: string
  onSurface: string
  muted: string
}

const COLORS: ColorPalette = {
  primary: '#00FFFF',
  secondary: '#9D00FF',
  background: '#0B0B0D',
  surface: '#1A1A1D',
  surfaceVariant: '#2E2E33',
  outline: '#3F3F46',
  error: '#EF4444',
  onSurface: '#E5E7EB',
  muted: '#A1A1AA'
}

@Entry
@Component
struct NeonRecorder {
  @State private title: string = ''
  @State private recording: boolean = false
  @State private seconds: number = 0
  private timerId: number = -1

  aboutToDisappear(): void {
    this.stopTimer()
  }

  private startTimer(): void {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  private toggleRecording(): void {
    this.recording = !this.recording
    if (this.recording) {
      this.seconds = 0
      this.startTimer()
    } else {
      this.stopTimer()
    }
  }

  private resetRecording(): void {
    this.seconds = 0
    if (this.recording) {
      this.startTimer()
    }
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.primary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 16, bottom: 16 })

      Column() {
        Column() {
          Text('Recording name')
            .fontSize(18)
            .fontColor(COLORS.muted)
            .width('100%')
            .margin({ bottom: 8 })

          TextInput({ text: this.title, placeholder: '' })
            .fontSize(16)
            .fontColor(COLORS.onSurface)
            .caretColor(COLORS.primary)
            .backgroundColor(COLORS.surface)
            .height(86)
            .width('100%')
            .border({
              width: 1,
              color: this.title.length === 0 ? COLORS.outline : COLORS.primary,
              radius: 20
            })
            .borderRadius(20)
            .padding({ left: 14, right: 14 })
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')

        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(24)
            .fontColor(this.recording ? COLORS.primary : COLORS.onSurface)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height(400)
        .backgroundColor(COLORS.surfaceVariant)
        .borderRadius(28)

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(24)
            .fontColor(this.recording ? '#FFFFFF' : '#000000')
            .fontWeight(FontWeight.Medium)
            .width(320)
            .height(104)
            .backgroundColor(this.recording ? COLORS.error : COLORS.primary)
            .borderRadius(28)
            .onClick(() => {
              this.toggleRecording()
            })

          Button('Reset')
            .fontSize(24)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
            .width(240)
            .height(104)
            .backgroundColor(COLORS.secondary)
            .borderRadius(28)
            .onClick(() => {
              this.resetRecording()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 32 })

        Blank()
          .height(64)

        Text(`Output Path: /storage/recordings/${this.title.length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(18)
          .fontColor(COLORS.muted)
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [[COLORS.background, 0.0], [COLORS.surfaceVariant, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}
