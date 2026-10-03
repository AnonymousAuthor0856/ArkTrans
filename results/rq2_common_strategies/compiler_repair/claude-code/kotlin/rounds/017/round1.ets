@Entry
@Component
struct AudioMixerPage {
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
        .margin({ bottom: 16 })

      Column() {
        MixerSlider({ label: 'Bass', value: this.bass, onChange: (v: number) => { this.bass = v } })
        MixerSlider({ label: 'Mid', value: this.mid, onChange: (v: number) => { this.mid = v } })
        MixerSlider({ label: 'Treble', value: this.treble, onChange: (v: number) => { this.treble = v } })
      }
      .margin({ bottom: 16 })

      Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
        .color('#00FF66')
        .backgroundColor('#141414')
        .height(6)
        .width('100%')
        .margin({ bottom: 8 })

      Text(`Master Volume ${Math.round(this.master * 100)}%`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E0E0')
        .margin({ bottom: 8 })

      Slider({ value: this.master * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
        .blockColor('#00FF66')
        .trackColor('#141414')
        .selectedColor('#00FF66')
        .width('100%')
        .onChange((value: number) => {
          this.master = value / 100
        })
        .margin({ bottom: 16 })

      Button('Apply Settings')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(10)
        .height(48)
        .width('100%')
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
    .padding(16)
  }
}

@Component
struct MixerSlider {
  label: string = ''
  value: number = 0
  onChange: (v: number) => void = () => {}

  build() {
    Column() {
      Text(`${this.label} ${Math.round(this.value * 100)}%`)
        .fontSize(13)
        .fontColor('#E0E0E0')
        .margin({ bottom: 4 })

      Slider({ value: this.value * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
        .blockColor('#00FF66')
        .trackColor('#141414')
        .selectedColor('#00FF66')
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
