class MixerColors {
  static primary: string = '#00FF66';
  static secondary: string = '#CCCCCC';
  static tertiary: string = '#999999';
  static background: string = '#000000';
  static surface: string = '#0A0A0A';
  static surfaceVariant: string = '#141414';
  static outline: string = '#2A2A2A';
  static onPrimary: string = '#000000';
  static onSurface: string = '#E0E0E0';
}

@Entry
@Component
struct Index {
  @State bass: number = 40;
  @State mid: number = 50;
  @State treble: number = 60;
  @State master: number = 70;

  @Builder
  MixerSlider(label: string, value: number, onChange: (value: number) => void) {
    Column({ space: 4 }) {
      Text(label + ' ' + Math.round(value).toString() + '%')
        .fontSize(13)
        .fontColor(MixerColors.onSurface)
        .lineHeight(18)
      Slider({ value: value, min: 0, max: 100, step: 1 })
        .width('100%')
        .selectedColor(MixerColors.primary)
        .trackColor(MixerColors.surfaceVariant)
        .onChange(onChange)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(MixerColors.primary)
        .lineHeight(32)
        .width('100%')
        .height(64)
        .textAlign(TextAlign.Center)
        .backgroundColor(MixerColors.background)

      Column({ space: 16 }) {
        this.MixerSlider('Bass', this.bass, (value: number) => {
          this.bass = value;
        })
        this.MixerSlider('Mid', this.mid, (value: number) => {
          this.mid = value;
        })
        this.MixerSlider('Treble', this.treble, (value: number) => {
          this.treble = value;
        })

        Blank().height(16)

        Progress({ value: this.master, total: 100, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color(MixerColors.primary)
          .backgroundColor(MixerColors.surfaceVariant)

        Text('Master Volume ' + Math.round(this.master).toString() + '%')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(MixerColors.onSurface)
          .lineHeight(22)

        Slider({ value: this.master, min: 0, max: 100, step: 1 })
          .width('100%')
          .selectedColor(MixerColors.primary)
          .trackColor(MixerColors.surfaceVariant)
          .onChange((value: number) => {
            this.master = value;
          })

        Button('Apply Settings')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(MixerColors.onPrimary)
          .backgroundColor(MixerColors.primary)
          .borderRadius(10)
          .width('100%')
          .height(48)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(MixerColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MixerColors.background)
  }
}
