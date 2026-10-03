@Entry
@Component
struct NeonRecorderPage {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1
  @State isFocused: boolean = false

  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
    }
  }

  private startTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
    }
    this.timerId = setInterval(() => {
      this.seconds++
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
        .fontColor('#00FFFF')
        .margin({ top: 48, bottom: 16 })

      Column() {
        Column() {
          Text('Recording name')
            .fontSize(14)
            .fontColor(this.isFocused ? '#00FFFF' : '#E5E7EB')
            .margin({ bottom: 4 })
          TextInput({ placeholder: '', text: this.title })
            .placeholderColor('#E5E7EB')
            .fontColor('#E5E7EB')
            .fontSize(14)
            .caretColor('#00FFFF')
            .backgroundColor(Color.Transparent)
            .height(32)
            .onChange((value: string) => {
              this.title = value
            })
            .onFocus(() => {
              this.isFocused = true
            })
            .onBlur(() => {
              this.isFocused = false
            })
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 10, bottom: 10 })
        .borderRadius(10)
        .border({
          width: this.isFocused ? 2 : 1,
          color: this.isFocused ? '#00FFFF' : '#3F3F46'
        })
        .backgroundColor('#1A1A1D')
        .margin({ bottom: 16 })

        Row() {
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
        }
        .width('100%')
        .height(200)
        .backgroundColor('#2E2E33')
        .borderRadius(14)
        .margin({ bottom: 16 })

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
            .borderRadius(14)
            .height(52)
            .width(160)
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
            .fontColor('#FFFFFF')
            .backgroundColor('#9D00FF')
            .borderRadius(14)
            .height(52)
            .width(120)
            .onClick(() => {
              this.seconds = 0
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 32 })

        Text(`Output Path: /storage/recordings/${this.title.length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('rgba(229, 231, 235, 0.7)')
          .width('100%')
          .textAlign(TextAlign.Center)

      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0B0B0D', 0.0], ['#2E2E33', 1.0]]
    })
  }
}
