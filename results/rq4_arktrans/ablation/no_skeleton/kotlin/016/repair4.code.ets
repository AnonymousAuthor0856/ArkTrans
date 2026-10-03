@Entry
@Component
struct NeonRecorder {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  build() {
    Column() {
      // Top Bar
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FFFF')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ bottom: 32 })

      // Input Field
      TextInput({ placeholder: 'Recording name' })
        .type(InputType.TEXT)
        .fontColor('#E5E7EB')
        .placeholderColor('#E5E7EB')
        .backgroundColor('#0B0B0D')
        .border({ width: 1, color: '#3F3F46', radius: 10 })
        .borderRadius(10)
        .padding({ left: 16, top: 16, bottom: 16 })
        .height(56)
        .width('100%')
        .onChange((value: string) => {
          this.title = value
        })

      // Visualizer Card
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
      .margin({ top: 16 })

      // Action Buttons
      Row() {
        Button(this.recording ? 'Stop' : 'Record')
          .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
          .fontColor('#000000')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(14)
          .height(52)
          .width(160)
          .onClick(() => {
            this.recording = !this.recording
            if (this.recording) {
              this.seconds = 0
            }
          })

        Button('Reset')
          .backgroundColor('#9D00FF')
          .fontColor('#FFFFFF')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .borderRadius(14)
          .height(52)
          .width(120)
          .onClick(() => {
            this.seconds = 0
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({ top: 16 })

      Blank()

      // Output Path
      Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#A1A1AA')
        .margin({ bottom: 32 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#0B0B0D', 0], ['#2E2E33', 1]]
    })
  }
}