@Entry
@Component
struct NeonRecorder {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1

  aboutToDisappear(): void {
    this.stopTimer()
  }

  build() {
    Column() {
      // === Header ===
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FFFF')
        .padding({ top: 16, bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor('#0B0B0D')

      // === Content Area ===
      Column({ space: 16 }) {
        // === Input Section ===
        Column({ space: 8 }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#9CA3AF')
            .alignSelf(ItemAlign.Start)

          TextInput({ placeholder: '' })
            .text(this.title)
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.title = value
            })
            .fontSize(14)
            .fontColor('#E5E7EB')
            .backgroundColor('#1A1A1D')
            .borderRadius(10)
            .border({ width: 1, color: this.title.length > 0 ? '#00FFFF' : '#3F3F46' })
            .padding(12)
            .width('100%')
        }

        // === Status Card ===
        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#2E2E33')
        .borderRadius(14)

        // === Buttons Row ===
        Row({ space: 24 }) {
          Button() {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#000000')
          }
          .width(160)
          .height(52)
          .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
          .borderRadius(14)
          .onClick(() => {
            this.recording = !this.recording
            if (this.recording) {
              this.seconds = 0
              this.startTimer()
            } else {
              this.stopTimer()
            }
          })

          Button() {
            Text('Reset')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .width(120)
          .height(52)
          .backgroundColor('#9D00FF')
          .borderRadius(14)
          .onClick(() => {
            this.seconds = 0
            if (this.recording) {
              this.stopTimer()
              this.startTimer()
            }
          })
        }

        Blank()

        // === Output Path ===
        Text(`Output Path: /storage/recordings/${this.title.length > 0 ? this.title : 'untitled'}.mp3`)
          .fontSize(14)
          .fontColor('#9CA3AF')
          .alignSelf(ItemAlign.Start)
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 90,
        colors: [['#0B0B0D', 0], ['#2E2E33', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0B0B0D')
  }

  startTimer(): void {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }
}