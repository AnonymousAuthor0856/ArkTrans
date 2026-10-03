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
          .backgroundColor('#FFFFFF')
          .borderRadius(8)
          .padding(12)
          .onChange((value: string) => {
            this.title = value
          })

        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
              .fontSize(16)
              .fontColor(this.recording ? '#6750A4' : '#E5E7EB')
          }
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })

        Row({ space: 16 }) {
          Button() {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(16)
              .fontColor('#FFFFFF')
          }
          .height(52)
          .width(160)
          .backgroundColor(this.recording ? '#B3261E' : '#6750A4')
          .borderRadius(24)
          .onClick(() => {
            this.recording = !this.recording
          })

          Button() {
            Text('Reset')
              .fontSize(16)
              .fontColor('#FFFFFF')
          }
          .height(52)
          .width(120)
          .backgroundColor('#9CA3AF')
          .borderRadius(24)
          .onClick(() => {
            this.seconds = 0
            this.recording = false
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(32)

        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('#E5E7EB')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#0B0B0D')

      Row() {
        Text('Neon Recorder')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#0B0B0D')
    }
    .width('100%')
    .height('100%')
  }
}