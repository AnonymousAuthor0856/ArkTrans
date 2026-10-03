const PRIMARY: string = '#00FF66'
const TEXT_PRIMARY: string = '#E0E0E0'
const TRACK: string = '#141414'
const BACKGROUND: string = '#000000'

@Entry
@Component
struct AudioMixerTerminal {
  @State bass: number = 40
  @State mid: number = 50
  @State treble: number = 60
  @State master: number = 70

  @Builder
  mixerSlider(label: string, value: number, onChange: (value: number) => void) {
    Column({ space: 4 }) {
      Text(`${label} ${Math.round(value)}%`)
        .fontSize(26)
        .fontColor(TEXT_PRIMARY)
        .fontWeight(FontWeight.Normal)
        .width('100%')
        .textAlign(TextAlign.Start)

      Slider({
        value: value,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(32)
        .blockColor(PRIMARY)
        .trackColor(TRACK)
        .selectedColor(PRIMARY)
        .onChange((sliderValue: number) => {
          onChange(sliderValue)
        })
    }
    .width('100%')
  }

  build() {
    Column({ space: 0 }) {
      Text('Audio Mixer Terminal')
        .fontSize(48)
        .fontColor(PRIMARY)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .height(100)
        .textAlign(TextAlign.Center)
        .textOverflow({ overflow: TextOverflow.None })

      Column({ space: 28 }) {
        this.mixerSlider('Bass', this.bass, (value: number) => {
          this.bass = value
        })

        this.mixerSlider('Mid', this.mid, (value: number) => {
          this.mid = value
        })

        this.mixerSlider('Treble', this.treble, (value: number) => {
          this.treble = value
        })

        Progress({
          value: this.master,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(8)
          .margin({ top: 26 })
          .backgroundColor(TRACK)
          .color(PRIMARY)

        Text(`Master Volume ${Math.round(this.master)}%`)
          .fontSize(32)
          .fontColor(TEXT_PRIMARY)
          .fontWeight(FontWeight.Normal)
          .width('100%')
          .textAlign(TextAlign.Start)

        Slider({
          value: this.master,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .height(32)
          .blockColor(PRIMARY)
          .trackColor(TRACK)
          .selectedColor(PRIMARY)
          .onChange((value: number) => {
            this.master = value
          })

        Button('Apply Settings', { type: ButtonType.Capsule })
          .fontSize(32)
          .fontColor('#000000')
          .fontWeight(FontWeight.Normal)
          .width('100%')
          .height(102)
          .backgroundColor(PRIMARY)
          .borderRadius(22)
          .margin({ top: 0 })
          .onClick(() => {
          })
      }
      .width('100%')
      .padding({ left: 32, right: 32, top: 136, bottom: 24 })
      .layoutWeight(1)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .padding({ top: 12 })
  }
}
