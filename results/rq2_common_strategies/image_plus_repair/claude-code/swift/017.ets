@Entry
@Component
struct AudioMixerTerminal {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  private primaryColor: string = '#00FF66'
  private onSurfaceColor: string = '#E0E0E0'
  private bgColor: string = '#000000'
  private surfaceVariantColor: string = '#141414'
  private onPrimaryColor: string = '#000000'

  build() {
    Stack() {
      Column() {
        Text('Audio Mixer Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryColor)
          .width('100%')
          .textAlign(TextAlign.Center)
          .height(64)

        Column({ space: 16 }) {
          this.MixerSlider('Bass', this.bass, (v: number) => { this.bass = v })
          this.MixerSlider('Mid', this.mid, (v: number) => { this.mid = v })
          this.MixerSlider('Treble', this.treble, (v: number) => { this.treble = v })

          Blank()
            .height(16)

          Progress({ value: this.master * 100, total: 100, type: ProgressType.Linear })
            .width('100%')
            .height(6)
            .color(this.primaryColor)
            .backgroundColor(this.surfaceVariantColor)

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .width('100%')

          Slider({
            value: this.master * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(this.primaryColor)
            .trackColor(this.surfaceVariantColor)
            .selectedColor(this.primaryColor)
            .width('100%')
            .onChange((value: number) => {
              this.master = value / 100
            })

          Button('Apply Settings')
            .width('100%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onPrimaryColor)
            .backgroundColor(this.primaryColor)
            .borderRadius(10)
        }
        .width('100%')
        .padding(16)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MixerSlider(label: string, value: number, onChange: (v: number) => void) {
    Column({ space: 4 }) {
      Text(`${label} ${Math.round(value * 100)}%`)
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.onSurfaceColor)

      Slider({
        value: value * 100,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(this.primaryColor)
        .trackColor(this.surfaceVariantColor)
        .selectedColor(this.primaryColor)
        .width('100%')
        .onChange((v: number) => {
          onChange(v / 100)
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}
