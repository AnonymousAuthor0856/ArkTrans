@Entry
@Component
struct Index {
  @State videoTitle: string = 'Journey through the Skies'
  @State currentTime: number = 95
  @State totalTime: number = 240
  @State isPlaying: boolean = false
  @State isFullscreen: boolean = false

  private formatTime(sec: number): string {
    const total = Math.max(0, Math.floor(sec))
    const m = Math.floor(total / 60)
    const s = total % 60
    return `${m}:${s < 10 ? '0' + s : s}`
  }

  build() {
    Column() {
      if (!this.isFullscreen) {
        Text('Video Player')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#E2E8F0')
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 48, bottom: 24 })
      }

      Column() {
        Column() {
          Text('Video Surface')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#334155')
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Column({ space: 12 }) {
          Text(this.videoTitle)
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')

          Slider({
            value: this.currentTime / this.totalTime * 100,
            min: 0,
            max: 100,
            step: 0.1,
            style: SliderStyle.OutSet
          })
            .blockColor('#1E3A8A')
            .selectedColor('#1E3A8A')
            .trackColor('#475569')
            .onChange((value: number) => {
              this.currentTime = value / 100 * this.totalTime
            })

          Row() {
            Text(this.formatTime(this.currentTime))
              .fontSize(16)
              .fontColor('#94A3B8')
            Blank()
            Text(this.formatTime(this.totalTime))
              .fontSize(16)
              .fontColor('#94A3B8')
          }
          .width('100%')

          Row() {
            Button('-10s')
              .fontSize(24)
              .fontColor('#1E293B')
              .backgroundColor('#E9D5FF')
              .borderRadius(24)
              .height(64)
              .padding({ left: 32, right: 32 })
              .onClick(() => {
                this.currentTime = Math.max(0, this.currentTime - 10)
              })

            Blank()

            Button(this.isPlaying ? '⏸' : '▶')
              .fontSize(32)
              .fontColor('#FFFFFF')
              .backgroundColor('#1E3A8A')
              .borderRadius(72)
              .width(100)
              .height(100)
              .onClick(() => {
                this.isPlaying = !this.isPlaying
              })

            Blank()

            Button('+30s')
              .fontSize(24)
              .fontColor('#1E293B')
              .backgroundColor('#E9D5FF')
              .borderRadius(24)
              .height(64)
              .padding({ left: 32, right: 32 })
              .onClick(() => {
                this.currentTime = Math.min(this.totalTime, this.currentTime + 30)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ top: 16 })

          Row() {
            Button(this.isFullscreen ? 'Exit Fullscreen' : 'Fullscreen')
              .fontSize(20)
              .fontColor(this.isFullscreen ? '#3B82F6' : '#94A3B8')
              .backgroundColor(Color.Transparent)
              .borderRadius(24)
              .border({
                width: 2,
                color: this.isFullscreen ? '#3B82F6' : '#475569'
              })
              .height(56)
              .padding({ left: 32, right: 32 })
              .onClick(() => {
                this.isFullscreen = !this.isFullscreen
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16 })
        }
        .width('100%')
        .padding(24)
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }
}
