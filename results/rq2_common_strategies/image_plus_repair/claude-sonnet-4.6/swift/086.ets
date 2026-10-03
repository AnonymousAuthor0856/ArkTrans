@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = new Array(16).fill(false)

  getPadLabel(index: number): string {
    switch (index) {
      case 0: return "KICK"
      case 1: return "SNARE"
      case 2: return "CLAP"
      case 3: return "HI-HAT"
      case 4: return "TOM 1"
      case 5: return "TOM 2"
      case 6: return "CRASH"
      case 7: return "RIDE"
      case 8: return "PERC 1"
      case 9: return "PERC 2"
      case 10: return "FX 1"
      case 11: return "FX 2"
      default: return `SMP ${index + 1}`
    }
  }

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text("POCKET")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
            .letterSpacing(2)
          Text("BEATS-909")
            .fontSize(28)
            .fontWeight(FontWeight.Bolder)
            .letterSpacing(-1)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text("⚙")
          .fontSize(24)
          .fontColor('#000000')
      }
      .width('100%')
      .padding({ top: 24, left: 24, right: 24 })

      // Info Display
      Stack() {
        Row() {
          Column() {
            Text("TEMPO")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#888888')
            Text(`${Math.round(this.bpm)}`)
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontFamily('monospace')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Circle()
            .width(12)
            .height(12)
            .fill(this.isPlaying ? '#FF5722' : '#AAAAAA')
        }
        .width('100%')
        .padding(16)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#F5F5F5')
      .borderRadius(4)
      .border({ width: 2, color: '#000000' })
      .margin({ top: 20, left: 24, right: 24 })

      // Pad Grid
      Grid() {
        ForEach(this.pads, (isActive: boolean, index: number) => {
          GridItem() {
            Column() {
              if (isActive) {
                Circle()
                  .width(6)
                  .height(6)
                  .fill('#FFFFFF')
                  .margin({ bottom: 4 })
              }
              Text(this.getPadLabel(index))
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(isActive ? '#FFFFFF' : '#888888')
            }
            .width('100%')
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(isActive ? '#000000' : '#EEEEEE')
            .borderRadius(8)
            .border({ width: 1, color: isActive ? '#000000' : '#E0E0E0' })
            .onClick(() => {
              let newPads = [...this.pads]
              newPads[index] = !newPads[index]
              this.pads = newPads
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')
      .padding({ top: 24, left: 24, right: 24 })

      // BPM and VOL sliders
      Row() {
        Column() {
          Text("BPM")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            style: SliderStyle.OutSet
          })
            .selectedColor('#000000')
            .trackColor('#DDDDDD')
            .blockColor('#000000')
            .onChange((value: number) => {
              this.bpm = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .selectedColor('#000000')
            .trackColor('#DDDDDD')
            .blockColor('#000000')
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 16 })
      }
      .width('100%')
      .padding({ top: 24, left: 24, right: 24 })
      .alignItems(VerticalAlign.Top)

      // Transport Buttons
      Row() {
        // Clear Button
        Row() {
          Text("🗑")
            .fontSize(16)
            .fontColor('#888888')
          Text("CLEAR")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .margin({ left: 8 })
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.pads = new Array(16).fill(false)
        })

        Blank()

        // Play Button
        Row() {
          Text(this.isPlaying ? "⏸" : "▶")
            .fontSize(16)
            .fontColor('#FFFFFF')
          Text(this.isPlaying ? "STOP" : "PLAY")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .letterSpacing(1)
            .margin({ left: 12 })
        }
        .width(140)
        .height(64)
        .backgroundColor('#000000')
        .borderRadius(32)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
      .padding({ top: 24, left: 24, right: 24, bottom: 24 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Start)
  }
}