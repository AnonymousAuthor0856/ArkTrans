@Entry
@Component
struct ContentView {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1

  // Color constants with non-conflicting names (including alpha variants)
  private readonly colorPrimary: string = '#FF00FFFF'
  private readonly colorSecondary: string = '#FF9D00FF'
  private readonly colorBg: string = '#FF0B0B0D'
  private readonly colorSurface: string = '#FF1A1A1D'
  private readonly colorSurfaceVariant: string = '#FF2E2E33'
  private readonly colorOutline: string = '#FF3F3F46'
  private readonly colorOnPrimary: string = '#FF000000'
  private readonly colorOnSecondary: string = '#FFFFFFFF'
  private readonly colorOnSurface: string = '#FFE5E7EB'
  private readonly colorOnSurfaceOpacity70: string = '#B3E5E7EB' // 0.7 opacity
  private readonly colorOnSurfaceOpacity50: string = '#80E5E7EB' // 0.5 opacity
  private readonly colorError: string = '#FFEF4444'

  aboutToAppear() {
    // reserved
  }

  aboutToDisappear() {
    this.stopTimer()
  }

  private startTimer(): void {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds++
    }, 1000)
  }

  private stopTimer(): void {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  build() {
    Column({ space: 0 }) {
      // Title bar
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colorPrimary)
        .padding({ top: 16, bottom: 16 })
        .width('100%')
        .backgroundColor(this.colorBg)

      // Content area
      Column({ space: 12 }) {
        // Recording name input
        Column({ space: 4 }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colorOnSurfaceOpacity70)

          TextInput({ placeholder: '' })
            .fontSize(14)
            .fontColor(this.colorOnSurface)
            .padding(12)
            .backgroundColor(this.colorSurface)
            .borderRadius(10)
            .border({ width: 1, color: this.title.length > 0 ? this.colorPrimary : this.colorOutline })
            .placeholderFont({ size: 14, weight: FontWeight.Regular })
            .placeholderColor(this.colorOnSurfaceOpacity50)
            .onChange((value: string) => {
              this.title = value
            })
        }

        // Recording status card
        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width('100%')
            .height(200)
            .backgroundColor(this.colorSurfaceVariant)
            .borderRadius(14)
          Text(this.recording ? 'Recording... ' + this.seconds + 's' : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? this.colorPrimary : this.colorOnSurface)
        }

        // Buttons row
        Row({ space: 24 }) {
          // Record / Stop button
          Button() {
            Text(this.recording ? 'Stop' : 'Record')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnPrimary)
          }
          .width(160)
          .height(52)
          .backgroundColor(this.recording ? this.colorError : this.colorPrimary)
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

          // Reset button
          Button() {
            Text('Reset')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnSecondary)
          }
          .width(120)
          .height(52)
          .backgroundColor(this.colorSecondary)
          .borderRadius(14)
          .onClick(() => {
            this.seconds = 0
            if (this.recording) {
              this.stopTimer()
              this.startTimer()
            }
          })
        }.alignItems(VerticalAlign.Center).justifyContent(FlexAlign.Center)

        Blank().height(32)

        // Output path text
        Text('Output Path: /storage/recordings/' + (this.title.length > 0 ? this.title : 'untitled') + '.mp3')
          .fontSize(14)
          .fontColor(this.colorOnSurfaceOpacity70)
          .width('100%')
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(this.colorBg) // simplified gradient
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorBg)
    .padding(0)
  }
}