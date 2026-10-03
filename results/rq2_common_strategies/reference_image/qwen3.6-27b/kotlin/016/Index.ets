// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct NeonRecorder {
  @State title: string = ''
  @State isRecording: boolean = false
  @State seconds: number = 0

  // AppTokens equivalent constants
  private readonly COLORS = {
    primary: '#00FFFF',
    secondary: '#9D00FF',
    tertiary: '#00FFA3',
    background: '#0B0B0D',
    surface: '#1A1A1D',
    surfaceVariant: '#2E2E33',
    outline: '#3F3F46',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#000000',
    onSecondary: '#FFFFFF',
    onTertiary: '#000000',
    onBackground: '#E5E7EB',
    onSurface: '#E5E7EB'
  }

  private readonly SPACING = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  build() {
    Column() {
      // Top Bar
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.COLORS.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: this.SPACING.lg, bottom: this.SPACING.lg })

      // Main Content Area
      Column() {
        // Input Field
        TextInput({ placeholder: 'Recording name' })
          .type(InputType.Normal)
          .text(this.title)
          .onChange((value: string) => {
            this.title = value
          })
          .backgroundColor(Color.Transparent)
          .borderRadius(10)
          .border({ width: 1, color: this.COLORS.outline })
          .padding({ left: this.SPACING.md, right: this.SPACING.md })
          .height(56)
          .margin({ bottom: this.SPACING.lg })
          .width('100%')

        // Recording Status Card
        Column() {
          Text(this.isRecording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.isRecording ? this.COLORS.primary : this.COLORS.onSurface)
        }
        .width('100%')
        .height(200)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(this.COLORS.surfaceVariant)
        .borderRadius(14)
        .margin({ bottom: this.SPACING.lg })

        // Buttons Row
        Row() {
          // Record Button
          Button(this.isRecording ? 'Stop' : 'Record')
            .type(ButtonType.Capsule)
            .backgroundColor(this.isRecording ? this.COLORS.error : this.COLORS.primary)
            .fontColor(this.COLORS.onPrimary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(52)
            .width(160)
            .onClick(() => {
              this.isRecording = !this.isRecording
              if (this.isRecording) {
                this.seconds = 0
              }
            })

          // Reset Button
          Button('Reset')
            .type(ButtonType.Capsule)
            .backgroundColor(this.COLORS.secondary)
            .fontColor(this.COLORS.onSecondary)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .height(52)
            .width(120)
            .margin({ left: this.SPACING.md })
            .onClick(() => {
              this.seconds = 0
            })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ bottom: this.SPACING.xxl })

        // Output Path Text
        Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#B3E5E7EB') // Approximate alpha 0.7 of #E5E7EB
          .width('100%')
          .textAlign(TextAlign.Start)
      }
      .width('100%')
      .padding(this.SPACING.lg)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 90,
      colors: [
        [this.COLORS.background, 0],
        [this.COLORS.surfaceVariant, 1]
      ]
    })
  }
}