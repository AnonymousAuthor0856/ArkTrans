@Entry
@Component
struct VideoPlayer {
  @State title: string = 'Journey through the Skies'
  @State currentTime: number = 95
  @State totalTime: number = 240
  @State playing: boolean = false
  @State fullscreen: boolean = false

  private formatTime(sec: number): string {
    let total = Math.max(0, Math.floor(sec))
    let m = Math.floor(total / 60)
    let s = total % 60
    return m + ':' + (s < 10 ? '0' + s : '' + s)
  }

  build() {
    Column() {
      if (!this.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#F8FAFC')
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#0F172A')
      }

      Column() {
        Column() {
          Text('Video Surface')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#334155')
        .borderRadius(12)
        .justifyContent(FlexAlign.Center)

        Column() {
          Text(this.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          Slider({
            value: this.currentTime / this.totalTime,
            min: 0,
            max: 1,
            step: 0.001,
            style: SliderStyle.OutSet
          })
            .blockColor('#1E3A8A')
            .trackColor('#475569')
            .selectedColor('#1E3A8A')
            .onChange((value: number) => {
              this.currentTime = value * this.totalTime
            })

          Row() {
            Text(this.formatTime(this.currentTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .opacity(0.7)
            Text(this.formatTime(this.totalTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#E2E8F0')
              .opacity(0.7)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Row() {
            Button('-10s')
              .type(ButtonType.Normal)
              .backgroundColor('#334155')
              .fontColor('#E2E8F0')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(12)
              .height(40)
              .onClick(() => {
                this.currentTime = Math.max(0, this.currentTime - 10)
              })

            Button(this.playing ? 'II' : '▶')
              .type(ButtonType.Circle)
              .backgroundColor('#1E3A8A')
              .fontColor('#FFFFFF')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .width(72)
              .height(72)
              .onClick(() => {
                this.playing = !this.playing
              })

            Button('+30s')
              .type(ButtonType.Normal)
              .backgroundColor('#334155')
              .fontColor('#E2E8F0')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(12)
              .height(40)
              .onClick(() => {
                this.currentTime = Math.min(this.totalTime, this.currentTime + 30)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .alignItems(VerticalAlign.Center)

          Row() {
            Button(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .type(ButtonType.Normal)
              .backgroundColor(this.fullscreen ? 'rgba(59, 130, 246, 0.2)' : '#334155')
              .fontColor('#E2E8F0')
              .fontSize(14)
              .borderRadius(20)
              .height(36)
              .onClick(() => {
                this.fullscreen = !this.fullscreen
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        .justifyContent(FlexAlign.Start)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }
}
