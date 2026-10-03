@Entry
@Component
struct Index {
  @State bass: number = 40
  @State mid: number = 50
  @State treble: number = 60
  @State master: number = 70

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 24, bottom: 24 })

      MixerSliderComp({ label: 'Bass', value: this.bass, onChange: (v: number) => { this.bass = v } })
      MixerSliderComp({ label: 'Mid', value: this.mid, onChange: (v: number) => { this.mid = v } })
      MixerSliderComp({ label: 'Treble', value: this.treble, onChange: (v: number) => { this.treble = v } })

      Blank().height(16)

      Progress({ value: this.master, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(6)
        .color('#00FF66')
        .backgroundColor('#141414')

      Text(`Master Volume ${this.master}%`)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E0E0E0')
        .margin({ top: 8 })

      Slider({ value: this.master, min: 0, max: 100, step: 1 })
        .width('100%')
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .onChange((value: number) => {
          this.master = Math.round(value)
        })

      Button('Apply Settings')
        .width('100%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
        .backgroundColor('#00FF66')
        .borderRadius(10)
        .margin({ top: 8 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct MixerSliderComp {
  @Prop label: string = ''
  @Prop value: number = 0
  onChange: (v: number) => void = () => {}

  build() {
    Column() {
      Text(`${this.label} ${this.value}%`)
        .fontSize(13)
        .fontColor('#E0E0E0')
        .width('100%')
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 4 })

      Slider({ value: this.value, min: 0, max: 100, step: 1 })
        .width('100%')
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .onChange((v: number) => {
          this.onChange(Math.round(v))
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 8 })
  }
}