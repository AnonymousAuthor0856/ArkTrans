@Entry
@Component
struct RootScreen {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#0B0B0D')

      // Content
      Column() {
        // Text Input
        Column() {
          Text('Recording name')
            .fontSize(12)
            .fontColor('#E5E7EB')
            .margin({ bottom: 4 })
          TextInput({ text: this.title, placeholder: 'Enter recording name...' })
            .onChange((value: string) => {
              this.title = value
            })
            .width('100%')
            .height(48)
            .fontSize(14)
            .fontColor('#E5E7EB')
            .placeholderColor('#9CA3AF')
            .backgroundColor('#2E2E33')
            .borderRadius(10)
            .borderWidth(1)
            .borderColor('#3F3F46')
            .padding({ left: 12, right: 12 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .margin({ bottom: 16 })

        // Recording Status Card
        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#2E2E33')
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 16 })

        // Buttons Row
        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
              }
            })
            .height(52)
            .width(160)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
            .borderRadius(14)

          Button('Reset')
            .onClick(() => {
              this.seconds = 0
            })
            .height(52)
            .width(120)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#9D00FF')
            .borderRadius(14)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 32 })

        // Output Path
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('rgba(229,231,235,0.7)')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#0B0B0D', 0.0], ['#2E2E33', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0B0B0D')
  }
}