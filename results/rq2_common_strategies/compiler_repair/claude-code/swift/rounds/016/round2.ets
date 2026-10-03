@Entry
@Component
struct NeonRecorderPage {
  @State title: string = '';
  @State recording: boolean = false;
  @State seconds: number = 0;
  private timerId: number = -1;

  aboutToAppear() {
  }

  aboutToDisappear() {
    this.stopTimer();
  }

  private startTimer(): void {
    this.stopTimer();
    this.timerId = setInterval(() => {
      this.seconds += 1;
    }, 1000);
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FFFF')
        .padding({ top: 16, bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor('#0B0B0D')

      Column({ space: 16 }) {
        Column({ space: 8 }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('rgba(229, 231, 235, 0.7)')

          TextInput({ placeholder: '', text: this.title })
            .fontSize(14)
            .fontColor('#E5E7EB')
            .placeholderColor('#3F3F46')
            .caretColor('#00FFFF')
            .padding(12)
            .backgroundColor('#1A1A1D')
            .borderRadius(10)
            .border({
              width: 1,
              color: this.title === '' ? '#3F3F46' : '#00FFFF'
            })
            .onChange((value: string) => {
              this.title = value;
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')

        Stack() {
          Column() {}
            .width('100%')
            .height(200)
            .borderRadius(14)
            .backgroundColor('#2E2E33')

          Text(this.recording ? 'Recording... ' + this.seconds + 's' : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
        }
        .width('100%')
        .height(200)

        Row({ space: 24 }) {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .width(160)
            .height(52)
            .borderRadius(14)
            .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
            .onClick(() => {
              this.recording = !this.recording;
              if (this.recording) {
                this.seconds = 0;
                this.startTimer();
              } else {
                this.stopTimer();
              }
            })

          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .width(120)
            .height(52)
            .borderRadius(14)
            .backgroundColor('#9D00FF')
            .onClick(() => {
              this.seconds = 0;
              if (this.recording) {
                this.stopTimer();
                this.startTimer();
              }
            })
        }

        Blank()
          .height(32)

        Text('Output Path: /storage/recordings/' + (this.title === '' ? 'untitled' : this.title) + '.mp3')
          .fontSize(14)
          .fontColor('rgba(229, 231, 235, 0.7)')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(16)
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
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
