@Entry
@Component
struct NeonRecorderApp {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0
  private timerId: number = -1

  // AppTokens - Colors
  private primary: string = '#00FFFF'
  private secondary: string = '#9D00FF'
  private tertiary: string = '#00FFA3'
  private background: string = '#0B0B0D'
  private surface: string = '#1A1A1D'
  private surfaceVariant: string = '#2E2E33'
  private outline: string = '#3F3F46'
  private success: string = '#22C55E'
  private warning: string = '#F59E0B'
  private error: string = '#EF4444'
  private onPrimary: string = '#000000'
  private onSecondary: string = '#FFFFFF'
  private onTertiary: string = '#000000'
  private onBackground: string = '#E5E7EB'
  private onSurface: string = '#E5E7EB'

  // Spacing tokens
  private spacingXs: number = 4
  private spacingSm: number = 8
  private spacingMd: number = 12
  private spacingLg: number = 16
  private spacingXl: number = 24
  private spacingXxl: number = 32

  // Shape tokens
  private smallCornerRadius: number = 6
  private mediumCornerRadius: number = 10
  private largeCornerRadius: number = 14

  startTimer() {
    this.stopTimer()
    this.timerId = setInterval(() => {
      this.seconds += 1
    }, 1000)
  }

  stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
      this.timerId = -1
    }
  }

  build() {
    Column() {
      // Top bar
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.primary)
        .padding({ top: this.spacingLg, bottom: this.spacingLg })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(this.background)

      // Content area
      Column({ space: this.spacingLg }) {
        // Recording name input
        Column({ space: this.spacingSm }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E5E7EB')
            .width('100%')
            .textAlign(TextAlign.Start)

          TextInput({ placeholder: '', text: this.title })
            .fontSize(14)
            .fontColor(this.onSurface)
            .padding(this.spacingMd)
            .backgroundColor(this.surface)
            .borderRadius(this.mediumCornerRadius)
            .border({
              width: 1,
              color: this.title === '' ? this.outline : this.primary
            })
            .caretColor(this.primary)
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // Recording status card
        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? this.primary : this.onSurface)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(this.largeCornerRadius)

        // Button row
        Row({ space: this.spacingXl }) {
          Button(this.recording ? 'Stop' : 'Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimary)
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? this.error : this.primary)
            .borderRadius(this.largeCornerRadius)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
                this.startTimer()
              } else {
                this.stopTimer()
              }
            })

          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSecondary)
            .width(120)
            .height(52)
            .backgroundColor(this.secondary)
            .borderRadius(this.largeCornerRadius)
            .onClick(() => {
              this.seconds = 0
              if (this.recording) {
                this.stopTimer()
                this.startTimer()
              }
            })
        }
        .justifyContent(FlexAlign.Center)

        Blank()
          .height(this.spacingXxl)

        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('#B3E5E7EB')
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .padding(this.spacingLg)
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [[this.background, 0], [this.surfaceVariant, 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
  }
}