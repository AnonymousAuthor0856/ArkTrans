import router from '@ohos.router';

@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = new Array(16).fill(false);

  getPadLabel(index: number): string {
    switch (index) {
      case 0: return "KICK";
      case 1: return "SNARE";
      case 2: return "CLAP";
      case 3: return "HI-HAT";
      case 4: return "TOM 1";
      case 5: return "TOM 2";
      case 6: return "CRASH";
      case 7: return "RIDE";
      case 8: return "PERC 1";
      case 9: return "PERC 2";
      case 10: return "FX 1";
      case 11: return "FX 2";
      default: return `SMP ${index + 1}`;
    }
  }

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)

      Scroll() {
        Column({ space: 0 }) {
          // Header Section
          Row() {
            Column({ space: 0 }) {
              Text("POCKET")
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor('#888888')
                .letterSpacing(2)

              Text("BEATS-909")
                .fontSize(28)
                .fontWeight(FontWeight.Bolder)
                .fontColor('#000000')
                .letterSpacing(-1)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button({ type: ButtonType.Normal }) {
              Text("⚙")
                .fontSize(24)
                .fontColor('#000000')
            }
            .backgroundColor(Color.Transparent)
            .width(40)
            .height(40)
          }
          .width('100%')
          .padding({ top: 24, left: 24, right: 24 })

          // Spacer
          Column().height(20)

          // Info Display
          Stack() {
            Row()
              .width('100%')
              .height(80)
              .backgroundColor('#F5F5F5')
              .borderRadius(4)
              .border({ width: 2, color: '#000000' })

            Row() {
              Column({ space: 0 }) {
                Text("TEMPO")
                  .fontSize(10)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#888888')

                Text(`${Math.floor(this.bpm)}`)
                  .fontSize(32)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#000000')
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
          }
          .width('100%')
          .height(80)
          .padding({ left: 24, right: 24 })

          // Spacer
          Column().height(24)

          // Pad Grid
          Grid() {
            ForEach(this.pads, (isActive: boolean, index: number) => {
              GridItem() {
                Button({ type: ButtonType.Normal }) {
                  Column({ space: 4 }) {
                    if (isActive) {
                      Circle()
                        .width(6)
                        .height(6)
                        .fill(Color.White)
                    }
                    Text(this.getPadLabel(index))
                      .fontSize(10)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(isActive ? Color.White : '#888888')
                  }
                  .width('100%')
                  .height('100%')
                  .justifyContent(FlexAlign.Center)
                  .alignItems(HorizontalAlign.Center)
                }
                .width('100%')
                .aspectRatio(1)
                .backgroundColor(isActive ? '#000000' : '#EEEEEE')
                .borderRadius(8)
                .border({
                  width: 1,
                  color: isActive ? '#000000' : '#E0E0E0'
                })
                .onClick(() => {
                  let newPads = [...this.pads];
                  newPads[index] = !newPads[index];
                  this.pads = newPads;
                })
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)
          .width('100%')
          .padding({ left: 24, right: 24 })

          // Spacer
          Column().height(24)

          // Control Section
          Column({ space: 24 }) {
            // Sliders Row
            Row({ space: 16 }) {
              // BPM Slider
              Column({ space: 4 }) {
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
                  .trackColor('#CCCCCC')
                  .onChange((value: number) => {
                    this.bpm = value;
                  })
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              // VOL Slider
              Column({ space: 4 }) {
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
                  .trackColor('#CCCCCC')
                  .onChange((value: number) => {
                    this.volume = value;
                  })
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
            }
            .width('100%')

            // Transport Buttons Row
            Row() {
              // Clear Button
              Button({ type: ButtonType.Normal }) {
                Row({ space: 8 }) {
                  Text("🗑")
                    .fontSize(16)
                    .fontColor('#888888')
                  Text("CLEAR")
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#000000')
                }
                .padding({ left: 24, right: 24 })
              }
              .height(48)
              .backgroundColor(Color.Transparent)
              .borderRadius(24)
              .border({ width: 1, color: '#E0E0E0' })
              .onClick(() => {
                this.pads = new Array(16).fill(false);
              })

              Blank()

              // Play/Stop Button
              Button({ type: ButtonType.Normal }) {
                Row({ space: 12 }) {
                  Text(this.isPlaying ? "⏸" : "▶")
                    .fontSize(16)
                    .fontColor(Color.White)
                  Text(this.isPlaying ? "STOP" : "PLAY")
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.White)
                    .letterSpacing(1)
                }
              }
              .width(140)
              .height(64)
              .backgroundColor('#000000')
              .borderRadius(32)
              .onClick(() => {
                this.isPlaying = !this.isPlaying;
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}