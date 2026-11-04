@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  private cPrimary: string = '#00FFFF'
  private cSecondary: string = '#9D00FF'
  private cTertiary: string = '#00FFA3'
  private cBackground: string = '#0B0B0D'
  private cSurface: string = '#1A1A1D'
  private cSurfaceVariant: string = '#2E2E33'
  private cOutline: string = '#3F3F46'
  private cError: string = '#EF4444'
  private cOnSurface: string = '#E5E7EB'
  private cMuted: string = '#B3E5E7EB'

  private outputPath(): string {
    const name = this.title.length === 0 ? 'untitled' : this.title
    return 'Output Path: /storage/recordings/' + name + '.mp3'
  }

  private statusText(): string {
    return this.recording ? 'Recording... ' + this.seconds.toString() + 's' : 'Press Record'
  }

  build() {
    Column() {
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cPrimary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(this.cBackground)

      Column() {
        Column() {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cMuted)
            .width('100%')
            .margin({ bottom: 8 })
          TextInput({ text: this.title })
            .height(48)
            .fontSize(14)
            .fontColor(this.cOnSurface)
            .backgroundColor(this.cSurface)
            .border({ width: 1, color: this.title.length === 0 ? this.cOutline : this.cPrimary, radius: 10 })
            .padding({ left: 12, right: 12 })
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')

        Stack({ alignContent: Alignment.Center }) {
          Rect()
            .width('100%')
            .height(200)
            .radius(14)
            .fill(this.cSurfaceVariant)
          Text(this.statusText())
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? this.cPrimary : this.cOnSurface)
        }
        .width('100%')
        .height(200)
        .margin({ top: 16 })

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .width(160)
            .height(52)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .backgroundColor(this.recording ? this.cError : this.cPrimary)
            .borderRadius(14)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
              }
            })
          Blank().width(24)
          Button('Reset')
            .width(120)
            .height(52)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .backgroundColor(this.cSecondary)
            .borderRadius(14)
            .onClick(() => {
              this.seconds = 0
            })
        }
        .margin({ top: 16 })

        Blank().height(32)

        Text(this.outputPath())
          .fontSize(14)
          .fontColor(this.cMuted)
          .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
