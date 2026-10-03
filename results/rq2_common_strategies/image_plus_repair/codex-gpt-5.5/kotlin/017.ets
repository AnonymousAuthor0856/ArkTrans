@Entry
@Component
struct MainPage {
  @State private bass: number = 0.4
  @State private mid: number = 0.5
  @State private treble: number = 0.6
  @State private master: number = 0.7

  private readonly primary: string = '#00FF66'
  private readonly pageBackground: string = '#000000'
  private readonly surface: string = '#141414'
  private readonly textColor: string = '#E0E0E0'

  @Builder
  private MixerSlider(label: string, value: number, onChange: (value: number) => void, topMargin: number = 0) {
    Column({ space: 8 }) {
      Text(`${label} ${Math.round(value * 100)}%`)
        .fontSize(26)
        .fontColor(this.textColor)
        .fontWeight(FontWeight.Normal)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: value,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(42)
        .selectedColor(this.primary)
        .blockColor(this.primary)
        .trackColor(this.surface)
        .onChange((current: number) => {
          onChange(current)
        })
    }
    .width('100%')
    .margin({ top: topMargin })
  }

  build() {
    Column({ space: 0 }) {
      Text('Audio Mixer Terminal')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.primary)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 18, bottom: 62 })

      this.MixerSlider('Bass', this.bass, (value: number) => {
        this.bass = value
      })

      this.MixerSlider('Mid', this.mid, (value: number) => {
        this.mid = value
      }, 28)

      this.MixerSlider('Treble', this.treble, (value: number) => {
        this.treble = value
      }, 28)

      Progress({
        value: this.master,
        total: 1,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(6)
        .margin({ top: 90 })
        .color(this.primary)
        .backgroundColor(this.surface)
        .borderRadius(3)

      Text(`Master Volume ${Math.round(this.master * 100)}%`)
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ top: 30, bottom: 14 })

      Slider({
        value: this.master,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(42)
        .selectedColor(this.primary)
        .blockColor(this.primary)
        .trackColor(this.surface)
        .onChange((value: number) => {
          this.master = value
        })

      Button('Apply Settings', { type: ButtonType.Capsule })
        .width('100%')
        .height(96)
        .fontSize(32)
        .fontColor('#000000')
        .backgroundColor(this.primary)
        .margin({ top: 36 })
        .onClick(() => {
          this.master = this.master
        })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 32, right: 32, top: 0, bottom: 24 })
    .backgroundColor(this.pageBackground)
    .justifyContent(FlexAlign.Start)
  }
}
