@Entry
@Component
struct AudioMixerPage {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  private readonly colors = {
    primary: '#00FF66',
    secondary: '#CCCCCC',
    tertiary: '#999999',
    background: '#000000',
    surface: '#0A0A0A',
    surfaceVariant: '#141414',
    outline: '#2A2A2A',
    onPrimary: '#000000',
    onSurface: '#E0E0E0'
  }

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.primary)
        .margin({ bottom: 16 })

      Column() {
        MixerSlider({ label: 'Bass', value: this.bass, onChange: (v: number) => { this.bass = v } })
        MixerSlider({ label: 'Mid', value: this.mid, onChange: (v: number) => { this.mid = v } })
        MixerSlider({ label: 'Treble', value: this.treble, onChange: (v: number) => { this.treble = v } })
      }
      .margin({ bottom: 16 })

      Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
        .color(this.colors.primary)
        .backgroundColor(this.colors.surfaceVariant)
        .height(6)
        .width('100%')
        .margin({ bottom: 8 })

      Text(`Master Volume ${Math.round(this.master * 100)}%`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .margin({ bottom: 8 })

      Slider({ value: this.master * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
        .blockColor(this.colors.primary)
        .trackColor(this.colors.surfaceVariant)
        .selectedColor(this.colors.primary)
        .width('100%')
        .onChange((value: number) => {
          this.master = value / 100
        })
        .margin({ bottom: 16 })

      Button('Apply Settings')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onPrimary)
        .backgroundColor(this.colors.primary)
        .borderRadius(10)
        .height(48)
        .width('100%')
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
    .padding(16)
  }
}

@Component
struct MixerSlider {
  label: string = ''
  value: number = 0
  onChange: (v: number) => void = () => {}

  private readonly colors = {
    primary: '#00FF66',
    surfaceVariant: '#141414',
    onSurface: '#E0E0E0'
  }

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(13)
        .fontColor(this.colors.onSurface)
        .margin({ bottom: 4 })

      Slider({ value: this.value * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
        .blockColor(this.colors.primary)
        .trackColor(this.colors.surfaceVariant)
        .selectedColor(this.colors.primary)
        .width('100%')
        .onChange((val: number) => {
          this.onChange(val / 100)
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 12 })
  }
}
