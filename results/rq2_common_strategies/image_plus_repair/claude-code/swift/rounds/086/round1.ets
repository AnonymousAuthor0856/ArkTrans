@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

  private padLabels: string[] = [
    "KICK", "SNARE", "CLAP", "HI-HAT",
    "TOM 1", "TOM 2", "CRASH", "RIDE",
    "PERC 1", "PERC 2", "FX 1", "FX 2",
    "SMP 13", "SMP 14", "SMP 15", "SMP 16"
  ];

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text("POCKET")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor("#999999")
            .letterSpacing(2)
          Text("BEATS-909")
            .fontSize(28)
            .fontWeight(FontWeight.Bolder)
            .fontColor("#000000")
            .letterSpacing(-1)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text("⚙")
          .fontSize(28)
          .fontColor(Color.Black)
      }
      .width('100%')
      .padding({ top: 24, left: 24, right: 24 })

      // Info Display
      Stack() {
        Row()
          .width('100%')
          .height(80)
          .backgroundColor("#F5F5F5")
          .border({ width: 2, color: "#000000" })
          .borderRadius(8)

        Row() {
          Column() {
            Text("TEMPO")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor("#999999")
            Text(this.bpm.toFixed(0))
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontColor("#000000")
              .fontFamily("monospace")
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Circle({ width: 12, height: 12 })
            .fill(this.isPlaying ? "#FF5722" : "#80808080")
        }
        .width('100%')
        .padding(16)
      }
      .width('100%')
      .height(80)
      .padding({ left: 24, right: 24 })
      .margin({ top: 20 })

      // Drum Pad Grid
      Grid() {
        ForEach(Array.from(Array(16).keys()), (index: number) => {
          GridItem() {
            Column() {
              if (this.pads[index]) {
                Circle({ width: 6, height: 6 })
                  .fill(Color.White)
                  .margin({ bottom: 4 })
              }
              Text(this.padLabels[index])
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.pads[index] ? "#FFFFFF" : "#999999")
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.pads[index] ? "#000000" : "#EEEEEE")
            .borderRadius(16)
            .border({
              width: 1,
              color: this.pads[index] ? "#000000" : "#E0E0E0"
            })
            .onClick(() => {
              this.pads[index] = !this.pads[index];
            })
          }
          .aspectRatio(1)
        }, (index: number) => index.toString())
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .padding({ left: 24, right: 24 })
      .margin({ top: 24 })

      // Bottom Controls
      Column() {
        // Sliders Row
        Row() {
          // BPM Slider
          Column() {
            Text("BPM")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor("#000000")
            Slider({
              value: this.bpm,
              min: 60,
              max: 200,
              style: SliderStyle.OutSet
            })
              .blockColor(Color.White)
              .selectedColor("#000000")
              .trackColor("#E0E0E0")
              .onChange((value: number) => {
                this.bpm = value;
              })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          // VOL Slider
          Column() {
            Text("VOL")
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor("#000000")
            Slider({
              value: this.volume,
              min: 0,
              max: 1,
              style: SliderStyle.OutSet
            })
              .blockColor(Color.White)
              .selectedColor("#000000")
              .trackColor("#E0E0E0")
              .onChange((value: number) => {
                this.volume = value;
              })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
        }
        .width('100%')

        // Transport Buttons Row
        Row() {
          // Clear Button
          Button() {
            Row() {
              Text("🗑")
                .fontSize(16)
                .fontColor("#999999")
              Text("CLEAR")
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor("#000000")
                .margin({ left: 8 })
            }
            .padding({ left: 8, right: 8 })
          }
          .height(48)
          .backgroundColor(Color.White)
          .borderRadius(24)
          .border({ width: 1, color: "#E0E0E0" })
          .onClick(() => {
            for (let i = 0; i < 16; i++) {
              this.pads[i] = false;
            }
          })

          Blank()

          // Play Button
          Button() {
            Row() {
              Text(this.isPlaying ? "⏸" : "▶")
                .fontSize(16)
                .fontColor(Color.White)
              Text(this.isPlaying ? "STOP" : "PLAY")
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .letterSpacing(1)
                .margin({ left: 12 })
            }
          }
          .width(140)
          .height(64)
          .backgroundColor("#000000")
          .borderRadius(32)
          .onClick(() => {
            this.isPlaying = !this.isPlaying;
          })
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, bottom: 24 })
      .margin({ top: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
