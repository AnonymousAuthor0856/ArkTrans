const PRIMARY: ResourceColor = '#00FF66'
const SECONDARY: ResourceColor = '#CCCCCC'
const BACKGROUND: ResourceColor = '#000000'
const SURFACE_VARIANT: ResourceColor = '#141414'
const ON_PRIMARY: ResourceColor = '#000000'
const ON_SURFACE: ResourceColor = '#E0E0E0'

const SPACING_XS: number = 4
const SPACING_LG: number = 16

@Entry
@Component
struct Index {
  @State private bass: number = 40
  @State private mid: number = 50
  @State private treble: number = 60
  @State private master: number = 70

  @Builder
  private MixerSlider(label: string, value: number, onValueChange: (value: number) => void) {
    Column({ space: SPACING_XS }) {
      Text(`${label} ${Math.floor(value)}%`)
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)

      Slider({
        value: value,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackThickness(16)
        .selectedColor(PRIMARY)
        .trackColor(SURFACE_VARIANT)
        .blockColor(PRIMARY)
        .blockSize({ width: 4, height: 44 })
        .showTips(false)
        .onChange((newValue: number, mode: SliderChangeMode) => {
          onValueChange(newValue)
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(PRIMARY)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(BACKGROUND)

      Column({ space: SPACING_LG }) {
        this.MixerSlider('Bass', this.bass, (value: number) => {
          this.bass = value
        })

        this.MixerSlider('Mid', this.mid, (value: number) => {
          this.mid = value
        })

        this.MixerSlider('Treble', this.treble, (value: number) => {
          this.treble = value
        })

        Blank()
          .height(SPACING_LG)

        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(6)
            .borderRadius(3)
            .backgroundColor(SURFACE_VARIANT)

          Row()
            .width(`${this.master}%`)
            .height(6)
            .borderRadius(3)
            .backgroundColor(PRIMARY)
        }
        .width('100%')
        .height(6)

        Text(`Master Volume ${Math.floor(this.master)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)

        Slider({
          value: this.master,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .trackThickness(16)
          .selectedColor(PRIMARY)
          .trackColor(SURFACE_VARIANT)
          .blockColor(PRIMARY)
          .blockSize({ width: 4, height: 44 })
          .showTips(false)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.master = value
          })

        Button('Apply Settings', { type: ButtonType.Normal, stateEffect: true })
          .width('100%')
          .height(48)
          .borderRadius(10)
          .backgroundColor(PRIMARY)
          .fontColor(ON_PRIMARY)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: SPACING_LG,
        right: SPACING_LG,
        top: SPACING_LG,
        bottom: SPACING_LG
      })
      .alignItems(HorizontalAlign.Start)
      .backgroundColor(BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}