@Entry
@Component
struct Index {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  private cPrimary: string = '#00FF66'
  private cSecondary: string = '#CCCCCC'
  private cTertiary: string = '#999999'
  private cBackground: string = '#000000'
  private cSurface: string = '#0A0A0A'
  private cSurfaceVariant: string = '#141414'
  private cOutline: string = '#2A2A2A'
  private cOnSurface: string = '#E0E0E0'

  private percent(value: number): string {
    return Math.round(value * 100).toString() + '%'
  }

  @Builder
  MixerSlider(label: string, value: number) {
    Column() {
      Text(label + ' ' + this.percent(value))
        .fontSize(13)
        .fontColor(this.cOnSurface)
        .width('100%')
        .margin({ bottom: 4 })
      Slider({ value: value, min: 0, max: 1, step: 0.01 })
        .width('100%')
        .onChange((next: number) => {
          if (label === 'Bass') {
            this.bass = next
          } else if (label === 'Mid') {
            this.mid = next
          } else if (label === 'Treble') {
            this.treble = next
          }
        })
    }
    .width('100%')
  }

  @Builder
  MasterProgress() {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(6)
        .radius(3)
        .fill(this.cSurfaceVariant)
      Rect()
        .width((this.master * 100).toString() + '%')
        .height(6)
        .radius(3)
        .fill(this.cPrimary)
    }
    .width('100%')
    .height(6)
  }

  build() {
    Column() {
      Text('Audio Mixer Terminal')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.cPrimary)
        .textAlign(TextAlign.Center)
        .width('100%')
        .height(64)
        .backgroundColor(this.cBackground)

      Column() {
        this.MixerSlider('Bass', this.bass)
        this.MixerSlider('Mid', this.mid)
          
        this.MixerSlider('Treble', this.treble)

        Blank().height(16)

        this.MasterProgress()

        Text('Master Volume ' + this.percent(this.master))
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.cOnSurface)
          .width('100%')
          .margin({ top: 16 })

        Slider({ value: this.master, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .onChange((value: number) => {
            this.master = value
          })

        Button('Apply Settings')
          .width('100%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .backgroundColor(this.cPrimary)
          .borderRadius(10)
          .margin({ top: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .backgroundColor(this.cBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }
}
