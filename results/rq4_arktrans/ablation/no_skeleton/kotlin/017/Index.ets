@Entry
@Component
struct AudioMixerTerminal {
  @State bass: number = 40
  @State mid: number = 50
  @State treble: number = 60
  @State master: number = 70

  build() {
    Column() {
      // Header
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ bottom: 16 })

      // Bass Slider
      this.MixerSliderRow('Bass', this.bass, (val: number) => { this.bass = val })

      // Mid Slider
      this.MixerSliderRow('Mid', this.mid, (val: number) => { this.mid = val })

      // Treble Slider
      this.MixerSliderRow('Treble', this.treble, (val: number) => { this.treble = val })

      Blank().height(16)

      // Master Progress Bar
      Progress({ value: this.master, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color('#00FF66')
        .backgroundColor('#141414')

      // Master Label
      Text(`Master Volume ${this.master}%`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E0E0')
        .margin({ top: 8, bottom: 8 })

      // Master Slider
      Slider({ value: this.master, min: 0, max: 100 })
        .width('100%')
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .blockColor('#00FF66')

      // Apply Button
      Button('Apply Settings')
        .width('100%')
        .height(48)
        .backgroundColor('#00FF66')
        .fontColor('#000000')
        .borderRadius(10)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 16 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .backgroundColor('#000000')
  }

  @Builder
  MixerSliderRow(label: string, value: number, onChange: (val: number) => void) {
    Column() {
      Text(`${label} ${value}%`)
        .fontSize(13)
        .fontColor('#E0E0E0')
        .margin({ bottom: 4 })

      Slider({ value: value, min: 0, max: 100 })
        .width('100%')
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .blockColor('#00FF66')
        .onChange((newValue: number) => {
          onChange(newValue)
        })
    }
    .margin({ bottom: 16 })
  }
}