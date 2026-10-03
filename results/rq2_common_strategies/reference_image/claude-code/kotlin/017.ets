@Entry
@Component
struct Index {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  private readonly primaryColor: string = '#00FF66'
  private readonly onPrimaryColor: string = '#000000'
  private readonly onSurfaceColor: string = '#E0E0E0'
  private readonly backgroundColor: string = '#000000'
  private readonly surfaceVariantColor: string = '#141414'

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(52)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.primaryColor)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 24, bottom: 32 })

      this.MixerSlider('Bass', this.bass, (val: number) => { this.bass = val })
      this.MixerSlider('Mid', this.mid, (val: number) => { this.mid = val })
      this.MixerSlider('Treble', this.treble, (val: number) => { this.treble = val })

      Blank()
        .height(24)

      Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color(this.primaryColor)
        .backgroundColor(this.surfaceVariantColor)
        .borderRadius(3)

      Text(`Master Volume ${Math.round(this.master * 100)}%`)
        .fontSize(32)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onSurfaceColor)
        .width('100%')
        .margin({ top: 24, bottom: 16 })

      Slider({
        value: this.master,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(this.primaryColor)
        .selectedColor(this.primaryColor)
        .trackColor(this.surfaceVariantColor)
        .onChange((value: number) => {
          this.master = value
        })

      Button('Apply Settings')
        .width('100%')
        .height(96)
        .fontSize(32)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.onPrimaryColor)
        .backgroundColor(this.primaryColor)
        .borderRadius(20)
        .margin({ top: 32 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
    .padding({ left: 24, right: 24 })
  }

  @Builder
  MixerSlider(label: string, value: number, onChange: (val: number) => void) {
    Column() {
      Text(`${label} ${Math.round(value * 100)}%`)
        .fontSize(26)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.onSurfaceColor)
        .width('100%')
        .margin({ bottom: 8 })

      Slider({
        value: value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(this.primaryColor)
        .selectedColor(this.primaryColor)
        .trackColor(this.surfaceVariantColor)
        .onChange((val: number) => {
          onChange(val)
        })
    }
    .width('100%')
    .margin({ bottom: 24 })
    .alignItems(HorizontalAlign.Start)
  }
}
