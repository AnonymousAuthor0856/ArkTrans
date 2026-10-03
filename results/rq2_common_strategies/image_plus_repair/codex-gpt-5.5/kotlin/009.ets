@Entry
@Component
struct VideoPlayerPage {
  @State currentTime: number = 95
  @State playing: boolean = false
  @State fullscreen: boolean = false
  private readonly totalTime: number = 240

  private formatTime(seconds: number): string {
    const total = Math.max(0, Math.floor(seconds))
    const minutes = Math.floor(total / 60)
    const remainder = total % 60
    return `${minutes}:${remainder.toString().padStart(2, '0')}`
  }

  build() {
    Column() {
      if (!this.fullscreen) {
        Row() {
          Text('Video Player')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .height(128)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }

      Stack({ alignContent: Alignment.Center }) {
        Text('Video Surface')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#334155')
      .borderRadius(22)

      if (!this.fullscreen) {
        Column() {
          Text('Journey through the Skies')
            .width('100%')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .margin({ bottom: 12 })

          Slider({
            value: this.currentTime,
            min: 0,
            max: this.totalTime,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor('#1E3A8A')
            .trackColor('#475569')
            .selectedColor('#1E3A8A')
            .blockSize({ width: 8, height: 88 })
            .trackThickness(8)
            .showSteps(false)
            .onChange((value: number) => {
              this.currentTime = value
            })
            .height(40)

          Row() {
            Text(this.formatTime(this.currentTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A0AABA')
            Blank()
            Text(this.formatTime(this.totalTime))
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#A0AABA')
          }
          .width('100%')
          .margin({ top: 8, bottom: 24 })

          Row() {
            Button('−10s')
              .width(166)
              .height(80)
              .fontSize(18)
              .fontColor('#1E293B')
              .backgroundColor('#E9DDF8')
              .borderRadius(22)
              .onClick(() => {
                this.currentTime = Math.max(0, this.currentTime - 10)
              })

            Button(this.playing ? 'Ⅱ' : '▶')
              .width(144)
              .height(144)
              .fontSize(28)
              .fontColor('#FFFFFF')
              .backgroundColor('#1E3A8A')
              .borderRadius(72)
              .onClick(() => {
                this.playing = !this.playing
              })

            Button('+30s')
              .width(166)
              .height(80)
              .fontSize(18)
              .fontColor('#1E293B')
              .backgroundColor('#E9DDF8')
              .borderRadius(22)
              .onClick(() => {
                this.currentTime = Math.min(this.totalTime, this.currentTime + 30)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ bottom: 40 })

          Button('Fullscreen')
            .width(196)
            .height(62)
            .fontSize(16)
            .fontColor('#475569')
            .backgroundColor('#0F172A')
            .border({ width: 1, color: '#475569' })
            .borderRadius(14)
            .onClick(() => {
              this.fullscreen = !this.fullscreen
            })
        }
        .width('100%')
        .height('46.4%')
        .padding({ left: 48, right: 48, top: 48, bottom: 64 })
        .justifyContent(FlexAlign.SpaceBetween)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
    .justifyContent(FlexAlign.Start)
  }
}
