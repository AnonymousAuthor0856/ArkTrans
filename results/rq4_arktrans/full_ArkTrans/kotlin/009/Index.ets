@Entry
@Component
struct Index {
  @State currentTime: number = 95 // 1:35 in seconds
  @State totalTime: number = 240 // 4:00 in seconds
  @State playing: boolean = false
  @State fullscreen: boolean = false

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Video Surface Placeholder
        Stack({ alignContent: Alignment.Center }) {
          Text('Video Surface')
            .fontSize(20)
            .fontColor('#E2E8F0')
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height(300)
        .backgroundColor('#334155')
        .borderRadius(16)
        .margin({ top: 60, bottom: 24 })

        // Controls Container
        Column({ space: 12 }) {
          // Title
          Text('Journey through the Skies')
            .fontSize(20)
            .fontColor('#E2E8F0')
            .fontWeight(FontWeight.Medium)
            .textAlign(TextAlign.Start)
            .width('100%')

          // Slider
          Slider({
            value: this.currentTime,
            min: 0,
            max: this.totalTime,
            style: SliderStyle.OutSet
          })
          .width('100%')
          .trackThickness(10)
          .selectedColor('#1E40AF')
          .blockColor('#1E40AF')
          .trackColor('#475569')

          // Time Row
          Row() {
            Text(this.formatTime(this.currentTime))
              .fontSize(14)
              .fontColor('#94A3B8')
            Blank()
            Text(this.formatTime(this.totalTime))
              .fontSize(14)
              .fontColor('#94A3B8')
          }
          .width('100%')
          .margin({ top: -10, bottom: 10 })

          // Main Buttons Row
          Row() {
            // Rewind Button
            Button('-10s')
              .backgroundColor('#E9D5FF')
              .fontColor('#1E1B4B')
              .borderRadius(16)
              .width(100)
              .height(50)
              .onClick(() => {
                this.currentTime = Math.max(0, this.currentTime - 10)
              })

            Blank()

            // Play/Pause Button
            Button(this.playing ? 'II' : '▶')
              .backgroundColor('#1E40AF')
              .fontColor('#FFFFFF')
              .borderRadius(36)
              .width(72)
              .height(72)
              .fontSize(24)
              .onClick(() => {
                this.playing = !this.playing
              })

            Blank()

            // Forward Button
            Button('+30s')
              .backgroundColor('#E9D5FF')
              .fontColor('#1E1B4B')
              .borderRadius(16)
              .width(100)
              .height(50)
              .onClick(() => {
                this.currentTime = Math.min(this.totalTime, this.currentTime + 30)
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          // Fullscreen Chip
          Button(this.fullscreen ? 'Exit Fullscreen' : 'Fullscreen')
            .backgroundColor('transparent')
            .borderWidth(1)
            .borderColor('#475569')
            .fontColor('#94A3B8')
            .borderRadius(8)
            .width(140)
            .height(40)
            .margin({ top: 10 })
            .onClick(() => {
              this.fullscreen = !this.fullscreen
            })
        }
        .width('100%')
        .padding(24)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#0F172A')

      // Top App Bar (Overlay)
      Row() {
        Text('Video Player')
          .fontSize(20)
          .fontColor('#E2E8F0')
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }

  formatTime(seconds: number): string {
    const m = Math.floor(seconds / 60)
    const s = Math.floor(seconds % 60)
    return `${m}:${s < 10 ? '0' : ''}${s}`
  }
}