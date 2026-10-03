// Import modules
import router from '@ohos.router';

@Entry
@Component
struct Index {
  // State
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = Array(16).fill(false);

  private getPadLabel(index: number): string {
    const labels = [
      "KICK", "SNARE", "CLAP", "HI-HAT",
      "TOM 1", "TOM 2", "CRASH", "RIDE",
      "PERC 1", "PERC 2", "FX 1", "FX 2"
    ];
    if (index < labels.length) {
      return labels[index];
    }
    return `SMP ${index + 1}`;
  }

  private togglePad(index: number) {
    let newPads = [...this.pads];
    newPads[index] = !newPads[index];
    this.pads = newPads;
  }

  private clearPads() {
    this.pads = Array(16).fill(false);
  }

  build() {
    Column() {
      Column() {
        // Header
        Row() {
          Column() {
            Text("POCKET")
              .fontSize("14vp")
              .fontWeight(FontWeight.Bold)
              .fontColor("#888888")
              .letterSpacing(2)
            Text("BEATS-909")
              .fontSize("28vp")
              .fontWeight(FontWeight.Black)
              .letterSpacing(-1)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Image($r("app.media.icon"))
            .width("24vp")
            .height("24vp")
            .fillColor("#000000")
            .onClick(() => {})
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Info Display
        Row() {
          Column() {
            Text("TEMPO")
              .fontSize("10vp")
              .fontWeight(FontWeight.Bold)
              .fontColor("#888888")
            Text(`${Math.round(this.bpm)}`)
              .fontSize("32vp")
              .fontWeight(FontWeight.Medium)
              .fontFamily("monospace")
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          // LED Indicator
          Circle({ width: "12vp", height: "12vp" })
            .fill(this.isPlaying ? "#FF5722" : "#CCCCCC")
        }
        .width("100%")
        .height("80vp")
        .padding("16vp")
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor("#F5F5F5")
        .border({ width: 2, color: "#000000", radius: 4 })

        // Pad Grid
        Grid() {
          ForEach(this.pads, (isActive: boolean, index: number) => {
            GridItem() {
              this.DrumPad(isActive, this.getPadLabel(index), () => this.togglePad(index))
            }
          })
        }
        .columnsTemplate("1fr 1fr 1fr 1fr")
        .columnsGap("12vp")
        .rowsGap("12vp")
        .width("100%")
        .aspectRatio(1)

        // Control Section
        Column() {
          // Sliders Row
          Row() {
            // BPM Slider
            Column() {
              Text("BPM")
                .fontSize("10vp")
                .fontWeight(FontWeight.Bold)
              Slider({
                value: this.bpm,
                min: 60,
                max: 200,
                step: 1,
                style: SliderStyle.OutSet
              })
                .selectedColor("#000000")
                .trackColor("#E0E0E0")
                .blockColor("#000000")
                .onChange((value: number) => {
                  this.bpm = value;
                })
                .width("100%")
            }
            .layoutWeight(1)

            // Volume Slider
            Column() {
              Text("VOL")
                .fontSize("10vp")
                .fontWeight(FontWeight.Bold)
              Slider({
                value: this.volume,
                min: 0,
                max: 1,
                step: 0.01,
                style: SliderStyle.OutSet
              })
                .selectedColor("#000000")
                .trackColor("#E0E0E0")
                .blockColor("#000000")
                .onChange((value: number) => {
                  this.volume = value;
                })
                .width("100%")
            }
            .layoutWeight(1)
          }
          .width("100%")

          // Transport Buttons
          Row() {
            // Clear Button
            this.CustomButton("CLEAR", () => this.clearPads())

            // Play Button
            Row() {
              if (this.isPlaying) {
                // Pause Icon
                Row()
                  .width("5vp")
                  .height("16vp")
                  .backgroundColor("#FFFFFF")
                  .margin({ right: "3vp" })
                Row()
                  .width("5vp")
                  .height("16vp")
                  .backgroundColor("#FFFFFF")
                  .margin({ left: "3vp" })
              } else {
                // Play Icon
                Polygon({ width: "16vp", height: "16vp" })
                  .points([[0, 0], [16, 8], [0, 16]])
                  .fill("#FFFFFF")
              }

              Text(this.isPlaying ? "STOP" : "PLAY")
                .fontColor("#FFFFFF")
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .margin({ left: "12vp" })
            }
            .height("64vp")
            .width("140vp")
            .borderRadius("32vp")
            .backgroundColor("#000000")
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .onClick(() => {
              this.isPlaying = !this.isPlaying;
            })
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .margin({ top: "24vp" })
        }
        .width("100%")
      }
      .width("100%")
      .height("100%")
      .padding("24vp")
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#FFFFFF")
  }

  @Builder
  DrumPad(isActive: boolean, label: string, onClick: () => void) {
    Column() {
      if (isActive) {
        Circle({ width: "6vp", height: "6vp" })
          .fill("#FFFFFF")
          .margin({ bottom: "4vp" })
      }
      Text(label)
        .fontSize("10vp")
        .fontWeight(FontWeight.Bold)
        .fontColor(isActive ? "#FFFFFF" : "#888888")
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .aspectRatio(1)
    .borderRadius("8vp")
    .backgroundColor(isActive ? "#000000" : "#EEEEEE")
    .border({ width: 1, color: isActive ? "#000000" : "#E0E0E0", radius: 8 })
    .onClick(() => {
      onClick();
    })
  }

  @Builder
  CustomButton(text: string, onClick: () => void) {
    Row() {
      Text("🗑")
        .fontSize("16vp")
        .fontColor("#888888")
        .margin({ right: "8vp" })
      Text(text)
        .fontSize("12vp")
        .fontWeight(FontWeight.Bold)
        .fontColor("#000000")
    }
    .height("48vp")
    .padding({ left: "24vp", right: "24vp" })
    .borderRadius("24vp")
    .border({ width: 1, color: "#E0E0E0", radius: 24 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      onClick();
    })
  }
}