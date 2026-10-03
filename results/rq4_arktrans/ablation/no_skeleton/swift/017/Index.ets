@Entry
@Component
struct RootScreen {
  @State bass: number = 40
  @State mid: number = 50
  @State treble: number = 60
  @State master: number = 70

  build() {
    Column() {
      // Top Bar
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(64)

      // Content Area
      Column({ space: 16 }) {
        this.MixerSliderComponent('Bass', this.bass, (val: number) => { this.bass = val })
        this.MixerSliderComponent('Mid', this.mid, (val: number) => { this.mid = val })
        this.MixerSliderComponent('Treble', this.treble, (val: number) => { this.treble = val })

        Blank().height(16)

        // Linear Progress Indicator
        Progress({ value: this.master / 100, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#00FF66')
          .backgroundColor('#141414')

        Text(`Master Volume ${this.master}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
          .width('100%')
          .textAlign(TextAlign.Start)

        Slider({ value: this.master, min: 0, max: 100 })
          .width('100%')
          .selectedColor('#00FF66')
          .trackColor('#141414')
          .blockColor('#00FF66')

        Button('Apply Settings')
          .type(ButtonType.Normal)
          .backgroundColor('#00FF66')
          .fontColor('#000000')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .height(48)
          .borderRadius(10)
      }
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }

  @Builder
  MixerSliderComponent(label: string, value: number, onChange: (val: number) => void) {
    Column({ space: 4 }) {
      Text(`${label} ${value}%`)
        .fontSize(13)
        .fontColor('#E0E0E0')
      
      Slider({ value: value, min: 0, max: 100 })
        .width('100%')
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .blockColor('#00FF66')
        .onChange((newValue: number) => {
          onChange(newValue)
        })
    }
  }
}