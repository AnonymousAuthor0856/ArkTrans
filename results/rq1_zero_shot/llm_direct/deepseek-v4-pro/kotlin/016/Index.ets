@Entry
@Component
struct MainView {
  @State private title: string = ''
  @State private recording: boolean = false
  @State private seconds: number = 0
  private timerId: number = -1

  private readonly primary: string = '#00FFFF'
  private readonly secondary: string = '#9D00FF'
  private readonly tertiary: string = '#00FFA3'
  private readonly background: string = '#0B0B0D'
  private readonly surface: string = '#1A1A1D'
  private readonly surfaceVariant: string = '#2E2E33'
  private readonly outline: string = '#3F3F46'
  private readonly onSurface: string = '#E5E7EB'
  private readonly onPrimary: string = '#000000'
  private readonly onSecondary: string = '#FFFFFF'
  private readonly error: string = '#EF4444'

  aboutToDisappear(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  private startTimer(): void {
    this.timerId = setInterval(() => {
      if (this.recording) {
        this.seconds++
      }
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

  private resetTimer(): void {
    this.seconds = 0
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 16, bottom: 16 })
      }
      .width('100%')
      .backgroundColor(this.background)

      // Main content
      Column({ space: 16 }) {
        // Text input
        TextInput({ text: this.title, placeholder: 'Recording name' })
          .width('100%')
          .height(56)
          .fontColor(this.onSurface)
          .placeholderColor(this.onSurface)
          .placeholderFont({ size: 14 })
          .backgroundColor(this.surface)
          .borderRadius(10)
          .border({ width: 1, color: this.outline })
          .onChange((value: string) => {
            this.title = value
          })

        // Status card
        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? this.primary : this.onSurface)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(14)

        // Buttons row
        Row({ space: 16 }) {
          Button(this.recording ? 'Stop' : 'Record')
            .width(160)
            .height(52)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimary)
            .backgroundColor(this.recording ? this.error : this.primary)
            .borderRadius(14)
            .onClick(() => {
              this.toggleRecording()
            })

          Button('Reset')
            .width(120)
            .height(52)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSecondary)
            .backgroundColor(this.secondary)
            .borderRadius(14)
            .onClick(() => {
              this.resetTimer()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        // Spacer
        Blank()
          .height(32)

        // Output path
        Text(`Output Path: /storage/recordings/${this.title.trim() === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('#B3E5E7EB')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [[this.background, 0.0], [this.surfaceVariant, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}