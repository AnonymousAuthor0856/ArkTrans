@Entry
@Component
struct RootScreen {
  @State private bass: number = 0.4;
  @State private mid: number = 0.5;
  @State private treble: number = 0.6;
  @State private master: number = 0.7;

  @Builder
  MixerSlider(label: string, value: number) {
    Column() {
      Text(label + ' ' + Math.round(value * 100).toString() + '%')
        .fontSize(13)
        .fontColor('#E0E0E0')
      Slider({ value: value, min: 0, max: 1, step: 0.01 })
        .selectedColor('#00FF66')
        .trackColor('#141414')
        .width('100%')
        .onChange((next: number) => {
          if (label === 'Bass') {
            this.bass = next;
          } else if (label === 'Mid') {
            this.mid = next;
          } else {
            this.treble = next;
          }
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor('#00FF66')
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor('#000000')

      Column() {
        this.MixerSlider('Bass', this.bass)
        this.MixerSlider('Mid', this.mid)
          .margin({ top: 16 })
        this.MixerSlider('Treble', this.treble)
          .margin({ top: 16 })

        Blank().height(16)
        Progress({ value: this.master, total: 1, type: ProgressType.Linear })
          .color('#00FF66')
          .backgroundColor('#141414')
          .width('100%')
          .height(6)

        Text('Master Volume ' + Math.round(this.master * 100).toString() + '%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
          .width('100%')
          .margin({ top: 16 })

        Slider({ value: this.master, min: 0, max: 1, step: 0.01 })
          .selectedColor('#00FF66')
          .trackColor('#141414')
          .width('100%')
          .onChange((next: number) => {
            this.master = next;
          })
          .margin({ top: 16 })

        Button('Apply Settings')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .backgroundColor('#00FF66')
          .width('100%')
          .height(48)
          .borderRadius(10)
          .margin({ top: 16 })
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
