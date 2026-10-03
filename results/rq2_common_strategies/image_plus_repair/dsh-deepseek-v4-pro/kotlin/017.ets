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
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor('#000000')

      Column({ space: 16 }) {
        MixerSlider({ label: 'Bass', value: $bass })
        MixerSlider({ label: 'Mid', value: $mid })
        MixerSlider({ label: 'Treble', value: $treble })

        Blank()
          .height(16)

        Progress({ value: this.master, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#00FF66')
          .backgroundColor('#141414')

        Text('Master Volume ' + Math.floor(this.master * 100) + '%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')

        Slider({ value: this.master, min: 0, max: 1, style: SliderStyle.OutSet })
          .onChange((value: number, mode: SliderChangeMode) => {
            this.master = value
          })
          .width('100%')
          .selectedColor('#00FF66')
          .trackColor('#141414')
          .blockColor('#00FF66')

        Button('Apply Settings')
          .width('100%')
          .height(48)
          .backgroundColor('#00FF66')
          .fontColor('#000000')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .borderRadius(10)
          .onClick(() => {})
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}

@Component
struct MixerSlider {
  label: string = ''
  @Link value: number

  build() {
    Column({ space: 4 }) {
      Text(this.label + ' ' + Math.floor(this.value * 100) + '%')
        .fontSize(13)
        .fontWeight(FontWeight.Normal)
        .fontColor('#E0E0E0')

      Slider({ value: this.value, min: 0, max: 1, style: SliderStyle.OutSet })
        .onChange((value: number, mode: SliderChangeMode) => {
          this.value = value
        })
        .width('100%')
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .blockColor('#00FF66')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
