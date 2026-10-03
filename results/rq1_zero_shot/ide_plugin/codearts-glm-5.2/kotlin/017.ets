const AppColors = {
  primary: '#00FF66',
  secondary: '#CCCCCC',
  tertiary: '#999999',
  background: '#000000',
  surface: '#0A0A0A',
  surfaceVariant: '#141414',
  outline: '#2A2A2A',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#000000',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#E0E0E0',
  onSurface: '#E0E0E0'
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
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        this.MixerSlider('Bass', this.bass, (v: number) => { this.bass = v })
        this.MixerSlider('Mid', this.mid, (v: number) => { this.mid = v })
        this.MixerSlider('Treble', this.treble, (v: number) => { this.treble = v })

        Blank().height(AppSpacing.lg)

        Progress({
          value: this.master,
          total: 1,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppColors.primary)
          .backgroundColor(AppColors.surfaceVariant)

        Text(`Master Volume ${Math.floor(this.master * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Slider({
          value: this.master,
          min: 0,
          max: 1,
          style: SliderStyle.OutSet
        })
          .blockColor(AppColors.primary)
          .trackColor(AppColors.surfaceVariant)
          .selectedColor(AppColors.primary)
          .width('100%')
          .onChange((value: number) => {
            this.master = value
          })

        Button('Apply Settings')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
          .width('100%')
          .height(48)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  MixerSlider(label: string, value: number, onChange: (v: number) => void) {
    Column({ space: AppSpacing.xs }) {
      Text(`${label} ${Math.floor(value * 100)}%`)
        .fontSize(13)
        .fontColor(AppColors.onSurface)
      Slider({
        value: value,
        min: 0,
        max: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .width('100%')
        .onChange((v: number) => {
          onChange(v)
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}