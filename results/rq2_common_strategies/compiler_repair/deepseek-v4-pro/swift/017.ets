@Entry
@Component
struct RootScreen {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  // Color constants with alpha (all fully opaque)
  private readonly cPrimary: string = '#FF00FF66'
  private readonly cSurface: string = '#FF0A0A0A'
  private readonly cSurfaceVariant: string = '#FF141414'
  private readonly cOnSurface: string = '#FFE0E0E0'
  private readonly cOnPrimary: string = '#FF000000'
  private readonly cBackground: string = '#FF000000'

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Full screen background
      Column()
        .width('100%').height('100%')
        .backgroundColor(this.cBackground)

      Column({ space: 0 }) {
        // Top bar
        Text('Audio Mixer Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cPrimary)
          .width('100%')
          .height(64)
          .padding({ top: 19, bottom: 19 }) // approximate centering
          .backgroundColor(this.cBackground)

        // Content
        Column({ space: 16 }) {
          // Bass slider
          this.buildSlider('Bass', this.bass, (value: number) => { this.bass = value })
          // Mid slider
          this.buildSlider('Mid', this.mid, (value: number) => { this.mid = value })
          // Treble slider
          this.buildSlider('Treble', this.treble, (value: number) => { this.treble = value })

          Blank().height(16)

          // Master progress bar (using Progress component)
          Progress({ value: this.master, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(6)
            .color(this.cPrimary)

          Text('Master Volume ' + Math.round(this.master * 100).toString() + '%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cOnSurface)
            .width('100%')

          // Master slider
          Slider({ value: this.master, min: 0, max: 1 })
            .width('100%')
            .onChange((value: number) => { this.master = value })

          // Apply button
          Button() {
            Text('Apply Settings')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cOnPrimary)
          }
          .width('100%')
          .height(48)
          .backgroundColor(this.cPrimary)
          .borderRadius(10)
          .onClick(() => {})
        }
        .padding(16)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(this.cBackground)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cBackground)
  }

  @Builder buildSlider(label: string, value: number, onChange: (val: number) => void) {
    Column({ space: 4 }) {
      Text(label + ' ' + Math.round(value * 100).toString() + '%')
        .fontSize(13)
        .fontWeight(FontWeight.Regular)
        .fontColor(this.cOnSurface)
      Slider({ value: value, min: 0, max: 1 })
        .width('100%')
        .onChange(onChange)
    }
  }
}