@Entry
@Component
struct Index {
  @State bass: number = 0
  @State label: string = 'Bass'
  @State fontSize: number = 24
  @State mid: number = 0
  @State treble: number = 0
  @State syncProgress: number = 0.3
  @State master: number = 0

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        // Bass Slider
        Column({ space: 4 }) {
          Text(`${this.label} ${(this.bass * 100).toFixed(0)}%`)
            .fontColor('#E0E0E0')
            .fontSize(this.fontSize)
          
          Slider({ value: this.bass, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .onChange((value: number) => {
              this.bass = value
            })
        }.alignItems(HorizontalAlign.Start)

        // Mid Slider
        Column({ space: 4 }) {
          Text(`Mid ${(this.mid * 100).toFixed(0)}%`)
            .fontColor('#E0E0E0')
            .fontSize(this.fontSize)
          
          Slider({ value: this.mid, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .onChange((value: number) => {
              this.mid = value
            })
        }.alignItems(HorizontalAlign.Start)

        // Treble Slider
        Column({ space: 4 }) {
          Text(`Treble ${(this.treble * 100).toFixed(0)}%`)
            .fontColor('#E0E0E0')
            .fontSize(this.fontSize)
          
          Slider({ value: this.treble, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .onChange((value: number) => {
              this.treble = value
            })
        }.alignItems(HorizontalAlign.Start)

        // Spacer
        Blank().height(16)

        // Progress Indicator (Sync/Loading visual)
        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(6)
          .color('#00FF66')
          .backgroundColor('#141414')

        // Master Volume Label
        Text(`Master Volume ${(this.master * 100).toFixed(0)}%`)
          .fontColor('#E0E0E0')
          .fontSize(18) // Approximating titleMedium

        // Master Volume Slider
        Slider({ value: this.master, min: 0, max: 1, step: 0.01 })
          .width('100%')
          .onChange((value: number) => {
            this.master = value
          })

        // Apply Button
        Button() {
          Text('Apply Settings')
            .fontColor('#FFFFFF') // Assuming onPrimary is white/light against primary color
            .fontSize(18)
        }
        .width('100%')
        .height(48)
        .backgroundColor('#6750A4') // Approximating AppTokens.Colors.primary
        .borderRadius(8) // Approximating medium shape
        .onClick(() => {
          // Action placeholder
        })
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#000000')

      // Top App Bar Overlay
      Row() {
        Text('Audio Mixer Terminal')
          .fontColor('#00FF66')
          .fontSize(24) // Approximating displayLarge
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#000000')
    }
    .width('100%')
    .height('100%')
  }
}