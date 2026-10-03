const Colors = {
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

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  build() {
    Column() {
      Row() {
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.background)

      Column({ space: Spacing.lg }) {
        TextInput({ placeholder: 'Recording name' })
          .width('100%')
          .height(48)
          .borderRadius(10)
          .backgroundColor(Colors.surface)
          .fontColor(Colors.onSurface)
          .placeholderColor(Colors.onSurface)
          .onChange((value: string) => { this.title = value })

        Stack({ alignContent: Alignment.Center }) {
          Text(this.recording ? 'Recording... ' + this.seconds + 's' : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? Colors.primary : Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(14)

        Row() {
          Button(this.recording ? 'Stop' : 'Record', { type: ButtonType.Normal })
            .backgroundColor(this.recording ? Colors.error : Colors.primary)
            .fontColor(Colors.onPrimary)
            .fontSize(18)
            .height(52)
            .width(160)
            .borderRadius(14)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) { this.seconds = 0 }
            })

          Button('Reset', { type: ButtonType.Normal })
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .fontSize(18)
            .height(52)
            .width(120)
            .borderRadius(14)
            .onClick(() => { this.seconds = 0 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(Spacing.xxl)

        Text('Output Path: /storage/recordings/' + (this.title.trim().length == 0 ? 'untitled' : this.title) + '.mp3')
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({ angle: 180, colors: [[Colors.background, 0.0], [Colors.surfaceVariant, 1.0]] })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
