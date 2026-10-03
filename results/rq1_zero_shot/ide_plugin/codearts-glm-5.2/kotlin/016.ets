const AppColors = {
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

const AppSpacing = {
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
      Text('Neon Recorder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Column({ space: 4 }) {
          Text('Recording name')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          TextInput(this.title)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
            .backgroundColor(AppColors.surface)
            .border({ width: 1, color: AppColors.outline, radius: 10 })
            .width('100%')
            .height(48)
            .onChange((value: string) => {
              this.title = value
            })
        }
        .width('100%')

        Column() {
          Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.recording ? AppColors.primary : AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(14)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Row() {
          Button(this.recording ? 'Stop' : 'Record')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(this.recording ? AppColors.error : AppColors.primary)
            .borderRadius(14)
            .height(52)
            .width(160)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
              }
            })

          Button('Reset')
            .type(ButtonType.Normal)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(14)
            .height(52)
            .width(120)
            .onClick(() => {
              this.seconds = 0
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(AppSpacing.xxl)

        Text(`Output Path: /storage/recordings/${this.title.length === 0 ? 'untitled' : this.title}.mp3`)
          .fontSize(14)
          .fontColor('#B3E5E7EB')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#0B0B0D', 0], ['#2E2E33', 1]]
      })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}