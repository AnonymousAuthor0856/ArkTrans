class AppTokens {
  static readonly Colors = {
    primary: '#FF00FF66',
    secondary: '#FFCCCCCC',
    tertiary: '#FF999999',
    background: '#FF000000',
    surface: '#FF0A0A0A',
    surfaceVariant: '#FF141414',
    outline: '#FF2A2A2A',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FF000000',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FFE0E0E0',
    onSurface: '#FFE0E0E0'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14
  }
}

@Entry
@Component
struct AudioMixerTerminal {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        Column() {
          Text(`Bass ${Math.floor(this.bass * 100)}%`)
            .fontSize(13)
            .fontColor(AppTokens.Colors.onSurface)
          Slider({
            value: this.bass,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.bass = value
            })
        }
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text(`Mid ${Math.floor(this.mid * 100)}%`)
            .fontSize(13)
            .fontColor(AppTokens.Colors.onSurface)
          Slider({
            value: this.mid,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.mid = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 16 })

        Column() {
          Text(`Treble ${Math.floor(this.treble * 100)}%`)
            .fontSize(13)
            .fontColor(AppTokens.Colors.onSurface)
          Slider({
            value: this.treble,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.treble = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 16 })

        Row().height(16)

        Progress({ value: this.master, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        Text(`Master Volume ${Math.floor(this.master * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .margin({ top: 16 })

        Slider({
          value: this.master,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.master = value
          })

        Button('Apply Settings') {
        }
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%')
          .height(48)
          .borderRadius(10)
          .backgroundColor(AppTokens.Colors.primary)
          .margin({ top: 16 })
      }
      .padding(16)
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}