@Entry
@Component
struct VideoPlayer {
  @State currentTime: number = 95
  private totalTime: number = 240
  private title: string = "Journey through the Skies"

  build() {
    Column() {
      // Top Bar
      Text('Video Player')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 24, bottom: 24 })

      // Video Surface
      Column() {
        Text("Video Surface")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#334155')
      .borderRadius(12)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // Controls Container
      Column() {
        // Title
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .margin({ bottom: 12 })

        // Slider
        Slider({ value: this.currentTime / this.totalTime, min: 0, max: 1, step: 0.001 })
          .width('100%')
          .trackColor('#475569')
          .selectedColor('#1E3A8A')
          .blockColor('#1E3A8A')

        // Time Labels
        Row() {
          Text(this.formatTime(this.currentTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .opacity(0.7)
          
          Blank()
          
          Text(this.formatTime(this.totalTime))
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .opacity(0.7)
        }
        .width('100%')
        .margin({ top: 8, bottom: 24 })

        // Main Buttons
        Row() {
          Button('-10s')
            .backgroundColor('#E2E8F0')
            .fontColor('#0F172A')
            .borderRadius(12)
            .height(48)
            .width(100)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Button('▶')
            .backgroundColor('#1E3A8A')
            .fontColor('#FFFFFF')
            .borderRadius(36)
            .height(72)
            .width(72)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)

          Button('+30s')
            .backgroundColor('#E2E8F0')
            .fontColor('#0F172A')
            .borderRadius(12)
            .height(48)
            .width(100)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ bottom: 24 })

        // Fullscreen Chip
        Button('Fullscreen')
          .backgroundColor('transparent')
          .borderWidth(1)
          .borderColor('#475569')
          .fontColor('#94A3B8')
          .borderRadius(8)
          .height(40)
          .width(120)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#0F172A')
  }

  formatTime(seconds: number): string {
    const total = Math.max(0, Math.floor(seconds))
    const m = Math.floor(total / 60)
    const s = total % 60
    return `${m}:${s < 10 ? '0' : ''}${s}`
  }
}