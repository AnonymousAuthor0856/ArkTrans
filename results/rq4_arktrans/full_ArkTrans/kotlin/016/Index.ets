@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        TextInput({ placeholder: 'Recording name' })
          .width('100%')
          .height(56)
          .backgroundColor('#1F1F23')
          .borderRadius(12)
          .borderWidth(1)
          .borderColor('#4B4B4F')
          .placeholderColor('#E5E7EB')
          .placeholderFont({ size: 18, weight: FontWeight.Normal })
          .fontSize(18)
          .fontColor('#FFFFFF')
          .type(InputType.Normal)
          .onChange((value: string) => {
            this.title = value
          })

        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
          }
        }
        .width('100%')
        .height(200)
        .backgroundColor('#2C2C30')
        .borderRadius(16)

        Row({ space: 16 }) {
          Button(this.recording ? 'Stop' : 'Record')
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? '#FF3B30' : '#00FFFF')
            .borderRadius(16)
            .fontColor('#000000')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              this.recording = !this.recording
            })

          Button('Reset')
            .width(120)
            .height(52)
            .backgroundColor('#9D00FF')
            .borderRadius(16)
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
              this.seconds = 0
              this.recording = false
            })
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(32)

        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(16)
          .fontColor('#A1A1AA')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        angle: 180,
        colors: [['#0B0B0D', 0], ['#1F1F23', 1]]
      })

      Text('Neon Recorder')
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FFFF')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 50, bottom: 20 })
    }.width('100%').height('100%')
  }
}