@Entry
@Component
struct ContentView {
  @State private title: string = '';
  @State private recording: boolean = false;
  @State private seconds: number = 0;

  private outputName(): string {
    return this.title === '' ? 'untitled' : this.title;
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FFFF')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#0B0B0D')

      Column() {
        Column() {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E5E7EB')
          TextInput({ text: this.title })
            .fontSize(14)
            .fontColor('#E5E7EB')
            .backgroundColor('#1A1A1D')
            .border({ width: 1, color: this.title === '' ? '#3F3F46' : '#00FFFF', radius: 10 })
            .borderRadius(10)
            .height(46)
            .padding({ left: 12, right: 12 })
            .margin({ top: 8 })
            .onChange((value: string) => {
              this.title = value;
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Rect()
            .width('100%')
            .height(200)
            .fill('#2E2E33')
            .radius(14)
          Text(this.recording ? 'Recording... ' + this.seconds.toString() + 's' : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
        }
        .width('100%')
        .height(200)
        .margin({ top: 16 })

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
            .width(160)
            .height(52)
            .borderRadius(14)
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
              }
            })
          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .backgroundColor('#9D00FF')
            .width(120)
            .height(52)
            .borderRadius(14)
            .margin({ left: 24 })
            .onClick(() => {
              this.seconds = 0;
            })
        }
        .margin({ top: 16 })

        Blank().height(32)
        Text('Output Path: /storage/recordings/' + this.outputName() + '.mp3')
          .fontSize(14)
          .fontColor('#B3E5E7EB')
          .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor('#0B0B0D')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0B0B0D')
  }
}
