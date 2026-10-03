@Entry
@Component
struct ContentView {
  @State private title: string = ''
  @State private recording: boolean = false
  @State private seconds: number = 0
  private timer: number = -1

  private startTimer() {
    this.stopTimer()
    this.timer = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  private stopTimer() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  build() {
    Column() {
      // Top bar
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF00FFFF')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#FF0B0B0D')

      // Content area
      Column({ space: 16 }) {
        // Recording name input
        Column({ space: 8 }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(229,231,235,0.7)')
            .width('100%')
            .textAlign(TextAlign.Start)

          TextInput({ text: this.title, placeholder: '' })
            .fontSize(14)
            .fontColor('#FFE5E7EB')
            .padding(12)
            .backgroundColor('#FF1A1A1D')
            .borderRadius(10)
            .border({
              width: 1,
              color: this.title === '' ? '#FF3F3F46' : '#FF00FFFF',
              radius: 10
            })
            .caretColor('#FF00FFFF')
            .width('100%')
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // Recording status card
        Stack() {
          Column()
            .width('100%')
            .height(200)
            .backgroundColor('#FF2E2E33')
            .borderRadius(14)

          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? '#FF00FFFF' : '#FFE5E7EB')
        }
        .width('100%')
        .height(200)

        // Button row
        Row({ space: 24 }) {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF000000')
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? '#FFEF4444' : '#FF00FFFF')
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

          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFFFF')
            .width(120)
            .height(52)
            .backgroundColor('#FF9D00FF')
            .borderRadius(14)
            .onClick(() => {
              this.seconds = 0
              if (this.recording) {
                this.stopTimer()
                this.startTimer()
              }
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        // Spacer
        Column()
          .height(32)

        // Output path
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('rgba(229,231,235,0.7)')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#FF0B0B0D', 0.0], ['#FF2E2E33', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FF0B0B0D')
  }
}