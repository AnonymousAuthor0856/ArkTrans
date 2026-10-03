// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timer: number = -1

  // Color tokens
  readonly colorPrimary: string = '#00FFFF'
  readonly colorSecondary: string = '#9D00FF'
  readonly colorBackground: string = '#0B0B0D'
  readonly colorSurface: string = '#1A1A1D'
  readonly colorSurfaceVariant: string = '#2E2E33'
  readonly colorOutline: string = '#3F3F46'
  readonly colorError: string = '#EF4444'
  readonly colorOnPrimary: string = '#000000'
  readonly colorOnSecondary: string = '#FFFFFF'
  readonly colorOnSurface: string = '#E5E7EB'
  readonly colorOnSurfaceDim: string = '#99E5E7EB'

  toggleRecording() {
    if (!this.recording) {
      this.recording = true
      this.seconds = 0
      this.timer = setInterval(() => {
        this.seconds += 1
      }, 1000)
    } else {
      this.recording = false
      clearInterval(this.timer)
      this.timer = -1
    }
  }

  resetRecording() {
    this.seconds = 0
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colorPrimary)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(64)
      .backgroundColor(this.colorBackground)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Scrollable content area
      Scroll() {
        Column({ space: 16 }) {
          // Recording name text field
          Stack({ alignContent: Alignment.TopStart }) {
            TextInput({ placeholder: 'Recording name', text: this.title })
              .placeholderColor(this.colorOnSurface)
              .placeholderFont({ size: 14 })
              .fontColor(this.colorOnSurface)
              .fontSize(14)
              .backgroundColor(this.colorBackground)
              .borderRadius(10)
              .borderWidth(1)
              .borderColor(this.colorOutline)
              .width('100%')
              .height(56)
              .padding({ left: 16, right: 16 })
              .caretColor(this.colorPrimary)
              .onChange((value: string) => {
                this.title = value
              })
          }
          .width('100%')

          // Recording status card
          Column() {
            Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.recording ? this.colorPrimary : this.colorOnSurface)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(200)
          .backgroundColor(this.colorSurfaceVariant)
          .borderRadius(14)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          // Buttons row
          Row({ space: 0 }) {
            // Record / Stop button
            Button(this.recording ? 'Stop' : 'Record')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnPrimary)
              .backgroundColor(this.recording ? this.colorError : this.colorPrimary)
              .borderRadius(14)
              .width(160)
              .height(52)
              .onClick(() => {
                this.toggleRecording()
              })

            Blank()

            // Reset button
            Button('Reset')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colorOnSecondary)
              .backgroundColor(this.colorSecondary)
              .borderRadius(14)
              .width(120)
              .height(52)
              .onClick(() => {
                this.resetRecording()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          // Spacer
          Column()
            .height(32)

          // Output path text
          Text(`Output Path: /storage/recordings/${this.title.trim() === '' ? 'untitled' : this.title}.mp3`)
            .fontSize(14)
            .fontColor(this.colorOnSurfaceDim)
            .textAlign(TextAlign.Center)
            .width('100%')
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(this.colorBackground)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        [0xFF0B0B0D, 0.0],
        [0xFF2E2E33, 1.0]
      ]
    })
  }
}