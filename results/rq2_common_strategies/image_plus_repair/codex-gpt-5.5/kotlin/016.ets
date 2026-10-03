@Entry
@Component
struct NeonRecorder {
  @State recordingName: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1

  aboutToDisappear(): void {
    this.stopTimer()
  }

  private startTimer(): void {
    this.stopTimer()
    this.timerId = setInterval(() => {
      if (this.recording) {
        this.seconds += 1
      }
    }, 1000)
  }

  private stopTimer(): void {
    if (this.timerId >= 0) {
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
    this.recording = false
    this.stopTimer()
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FFFF')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 28, bottom: 78 })

      TextInput({ placeholder: 'Recording name', text: this.recordingName })
        .onChange((value: string) => {
          this.recordingName = value
        })
        .fontSize(32)
        .fontColor('#E5E7EB')
        .placeholderColor('#E5E7EB')
        .caretColor('#00FFFF')
        .padding({ left: 30, right: 24 })
        .height(112)
        .width('100%')
        .border({
          width: 2,
          color: '#3F3F46',
          radius: 20
        })
        .backgroundColor('#0B0B0D')
        .margin({ bottom: 32 })

      Stack() {
        Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
          .fontSize(36)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(400)
      .borderRadius(28)
      .backgroundColor('#2E2E33')
      .margin({ bottom: 32 })

      Row() {
        Button(this.recording ? 'Stop' : 'Record')
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.recording ? '#FFFFFF' : '#000000')
          .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
          .borderRadius(28)
          .height(104)
          .width(320)
          .onClick(() => {
            this.toggleRecording()
          })

        Button('Reset')
          .fontSize(34)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#9D00FF')
          .borderRadius(28)
          .height(104)
          .width(240)
          .onClick(() => {
            this.resetRecording()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ bottom: 124 })

      Text(`Output Path: /storage/recordings/${this.recordingName.trim() === '' ? 'untitled' : this.recordingName}.mp3`)
        .fontSize(28)
        .fontColor('#B8B8BE')
        .textAlign(TextAlign.Center)
        .width('100%')
        .maxLines(2)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 0, bottom: 32 })
    .backgroundColor('#0B0B0D')
    .justifyContent(FlexAlign.Start)
  }
}
