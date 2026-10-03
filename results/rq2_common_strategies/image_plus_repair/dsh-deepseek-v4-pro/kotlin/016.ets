@Entry
@Component
struct NeonRecorderPage {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  build() {
    Column() {
      Row() {
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      Column({ space: 16 }) {
        TextInput({ placeholder: 'Recording name', text: this.title })
          .onChange((value: string) => {
            this.title = value
          })
          .width('100%')
          .height(56)
          .borderRadius(10)
          .border({ width: 1, color: '#3F3F46' })
          .fontSize(14)
          .fontColor('#E5E7EB')
          .placeholderColor('#E5E7EB')
          .backgroundColor('#1A1A1D')

        Stack() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
        }
        .width('100%')
        .height(200)
        .borderRadius(14)
        .backgroundColor('#2E2E33')
        .alignContent(Alignment.Center)

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .height(52)
            .width(160)
            .borderRadius(14)
            .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
            .fontColor('#000000')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
              }
            })

          Button('Reset')
            .height(52)
            .width(120)
            .borderRadius(14)
            .backgroundColor('#9D00FF')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.seconds = 0
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank()
          .height(32)

        Text(`Output Path: /storage/recordings/${this.title.trim() === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('rgba(229,231,235,0.7)')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#0B0B0D', 0.0], ['#2E2E33', 1.0]]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0B0B0D')
  }
}
