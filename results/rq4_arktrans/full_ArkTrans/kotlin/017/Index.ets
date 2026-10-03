@Entry
@Component
struct Index {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Column (Main Content) ===
      Column({ space: 16 }) {
        // === MixerSlider (Bass) ===
        Column({ space: 4 }) {
          Text(`Bass ${Math.round(this.bass * 100)}%`).fontColor('#E0E0E0').fontSize(16).fontWeight(FontWeight.Medium)
          Slider({ value: this.bass, min: 0, max: 1, step: 0.01 }).width('100%')
            .trackColor('#141414').selectedColor('#00FF66')
            .onChange((value: number) => { this.bass = value })
        }.alignItems(HorizontalAlign.Start)

        // === MixerSlider (Mid) ===
        Column({ space: 4 }) {
          Text(`Mid ${Math.round(this.mid * 100)}%`).fontColor('#E0E0E0').fontSize(16).fontWeight(FontWeight.Medium)
          Slider({ value: this.mid, min: 0, max: 1, step: 0.01 }).width('100%')
            .trackColor('#141414').selectedColor('#00FF66')
            .onChange((value: number) => { this.mid = value })
        }.alignItems(HorizontalAlign.Start)

        // === MixerSlider (Treble) ===
        Column({ space: 4 }) {
          Text(`Treble ${Math.round(this.treble * 100)}%`).fontColor('#E0E0E0').fontSize(16).fontWeight(FontWeight.Medium)
          Slider({ value: this.treble, min: 0, max: 1, step: 0.01 }).width('100%')
            .trackColor('#141414').selectedColor('#00FF66')
            .onChange((value: number) => { this.treble = value })
        }.alignItems(HorizontalAlign.Start)

        // === Spacer ===
        Blank().height(16)

        // === LinearProgressIndicator (Master Visual) ===
        Progress({ value: this.master, total: 1, type: ProgressType.Linear })
          .width('100%').height(6).color('#00FF66').backgroundColor('#141414')

        // === Master Volume Label ===
        Text(`Master Volume ${Math.round(this.master * 100)}%`)
          .fontColor('#E0E0E0').fontSize(20).fontWeight(FontWeight.Medium)

        // === Master Slider ===
        Slider({ value: this.master, min: 0, max: 1, step: 0.01 }).width('100%')
          .trackColor('#141414').selectedColor('#00FF66')
          .onChange((value: number) => { this.master = value })

        // === Button ===
        Button() {
          Text('Apply Settings').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Medium)
        }
        .width('100%').height(48).backgroundColor('#00FF66').borderRadius(12)
        .onClick(() => {
          // Apply logic here
        })
      }
      .width('100%').height('100%').padding(16).backgroundColor('#000000')

      // === CenterAlignedTopAppBar ===
      Row() {
        Text('Audio Mixer Terminal')
          .fontColor('#00FF66').fontSize(32).fontWeight(FontWeight.Bold)
      }
      .width('100%').justifyContent(FlexAlign.Center).padding({ bottom: 16 })
    }
    .width('100%').height('100%')
  }
}