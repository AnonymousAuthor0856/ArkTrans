const Colors = {
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

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Component
struct MixerSlider {
  @Prop label: string = ''
  @Prop value: number = 0
  onChange: (v: number) => void = () => {}

  build() {
    Column({ space: Spacing.xs }) {
      Text(this.label + ' ' + Math.floor(this.value * 100) + '%')
        .fontSize(13)
        .fontColor(Colors.onSurface)

      Slider({ value: this.value, min: 0, max: 1, step: 0.01 })
        .selectedColor(Colors.primary)
        .trackColor(Colors.surfaceVariant)
        .blockColor(Colors.primary)
        .onChange((value: number, mode: SliderChangeMode) => { this.onChange(value) })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
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
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(26)
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
        MixerSlider({ label: 'Bass', value: this.bass, onChange: (v: number) => { this.bass = v } })
        MixerSlider({ label: 'Mid', value: this.mid, onChange: (v: number) => { this.mid = v } })
        MixerSlider({ label: 'Treble', value: this.treble, onChange: (v: number) => { this.treble = v } })

        Blank().height(Spacing.lg)

        Progress({ value: Math.round(this.master * 100), total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(Colors.primary)
          .backgroundColor(Colors.surfaceVariant)

        Text('Master Volume ' + Math.floor(this.master * 100) + '%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Slider({ value: this.master, min: 0, max: 1, step: 0.01 })
          .selectedColor(Colors.primary)
          .trackColor(Colors.surfaceVariant)
          .blockColor(Colors.primary)
          .onChange((value: number, mode: SliderChangeMode) => { this.master = value })

        Button('Apply Settings', { type: ButtonType.Normal })
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(16)
          .width('100%')
          .height(48)
          .borderRadius(10)
          .onClick(() => {})
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
