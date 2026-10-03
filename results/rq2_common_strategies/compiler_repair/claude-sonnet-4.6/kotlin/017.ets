@Entry
@Component
struct Index {
  @State bass: number = 0.4
  @State mid: number = 0.5
  @State treble: number = 0.6
  @State master: number = 0.7

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Audio Mixer Terminal')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FF66')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#000000')

      // Content
      Column() {
        // Bass Slider
        Column() {
          Text(`Bass ${Math.floor(this.bass * 100)}%`)
            .fontSize(13)
            .fontColor('#E0E0E0')
            .margin({ bottom: 4 })
          Slider({
            value: this.bass,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor('#00FF66')
            .trackColor('#141414')
            .onChange((value: number) => {
              this.bass = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({ bottom: 16 })

        // Mid Slider
        Column() {
          Text(`Mid ${Math.floor(this.mid * 100)}%`)
            .fontSize(13)
            .fontColor('#E0E0E0')
            .margin({ bottom: 4 })
          Slider({
            value: this.mid,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor('#00FF66')
            .trackColor('#141414')
            .onChange((value: number) => {
              this.mid = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({ bottom: 16 })

        // Treble Slider
        Column() {
          Text(`Treble ${Math.floor(this.treble * 100)}%`)
            .fontSize(13)
            .fontColor('#E0E0E0')
            .margin({ bottom: 4 })
          Slider({
            value: this.treble,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .selectedColor('#00FF66')
            .trackColor('#141414')
            .onChange((value: number) => {
              this.treble = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({ bottom: 16 })

        // Spacer
        Row().height(16)

        // Progress Bar
        Progress({
          value: this.master * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color('#00FF66')
          .backgroundColor('#141414')
          .margin({ bottom: 8 })

        // Master Volume Label
        Text(`Master Volume ${Math.floor(this.master * 100)}%`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E0E0E0')
          .margin({ bottom: 8 })

        // Master Slider
        Slider({
          value: this.master,
          min: 0,
          max: 1,
          step: 0.01,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .selectedColor('#00FF66')
          .trackColor('#141414')
          .onChange((value: number) => {
            this.master = value
          })
          .margin({ bottom: 16 })

        // Apply Button
        Button('Apply Settings')
          .width('100%')
          .height(48)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000')
          .backgroundColor('#00FF66')
          .borderRadius(10)
      }
      .width('100%')
      .padding(16)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000000')
  }
}