import { router } from '@kit.ArkUI';

// Pad labels helper
function getPadLabel(index: number): string {
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

@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = new Array(16).fill(false);

  build() {
    Column({ space: 0 }) {
      // Header
      HeaderSection()

      Blank().height(20)

      // Info Display
      InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })

      Blank().height(24)

      // Pad Grid
      PadGrid({
        pads: this.pads,
        onPadToggle: (index: number) => {
          let newPads = [...this.pads];
          newPads[index] = !newPads[index];
          this.pads = newPads;
        }
      })

      Blank().height(24)

      // Control Section
      ControlSection({
        bpm: this.bpm,
        onBpmChange: (val: number) => { this.bpm = val; },
        volume: this.volume,
        onVolumeChange: (val: number) => { this.volume = val; },
        isPlaying: this.isPlaying,
        onPlayToggle: () => { this.isPlaying = !this.isPlaying; },
        onClear: () => {
          this.pads = new Array(16).fill(false);
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text("POCKET")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text("BEATS-909")
          .fontSize(28)
          .fontWeight(FontWeight.Bolder)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Text("⚙")
          .fontSize(20)
          .fontColor(Color.Black)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoDisplay {
  @Prop bpm: number = 120;
  @Prop isPlaying: boolean = false;

  build() {
    Row() {
      Column({ space: 2 }) {
        Text("TEMPO")
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)

        Text(`${Math.floor(this.bpm)}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontFamily('monospace')
      }
      .alignItems(HorizontalAlign.Start)

      Circle()
        .width(12)
        .height(12)
        .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .border({ width: 2, color: Color.Black, radius: 4 })
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PadGrid {
  @Prop pads: boolean[] = new Array(16).fill(false);
  onPadToggle: (index: number) => void = () => {};

  build() {
    Grid() {
      ForEach(this.pads, (isActive: boolean, index: number) => {
        GridItem() {
          DrumPad({
            isActive: isActive,
            label: getPadLabel(index),
            onClick: () => {
              this.onPadToggle(index);
            }
          })
        }
      }, (item: boolean, index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height(300)
  }
}

@Component
struct DrumPad {
  @Prop isActive: boolean = false;
  @Prop label: string = '';
  onClick: () => void = () => {};

  build() {
    Column({ space: 4 }) {
      if (this.isActive) {
        Circle()
          .width(6)
          .height(6)
          .fill(Color.White)
      }

      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? Color.White : Color.Gray)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .borderRadius(8)
    .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
    .border({
      width: 1,
      color: this.isActive ? Color.Black : '#E0E0E0',
      radius: 8
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct ControlSection {
  @Prop bpm: number = 120;
  onBpmChange: (val: number) => void = () => {};
  @Prop volume: number = 0.8;
  onVolumeChange: (val: number) => void = () => {};
  @Prop isPlaying: boolean = false;
  onPlayToggle: () => void = () => {};
  onClear: () => void = () => {};

  build() {
    Column({ space: 0 }) {
      // Sliders Row
      Row({ space: 16 }) {
        Column({ space: 4 }) {
          Text("BPM")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)

          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            step: 1,
            style: SliderStyle.OutSet
          })
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .blockColor(Color.Black)
            .onChange((value: number) => {
              this.onBpmChange(value);
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column({ space: 4 }) {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)

          Slider({
            value: this.volume * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet
          })
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .blockColor(Color.Black)
            .onChange((value: number) => {
              this.onVolumeChange(value / 100);
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')

      Blank().height(24)

      // Transport Buttons
      Row() {
        // Clear Button
        Row({ space: 8 }) {
          Text("🗑")
            .fontSize(14)
            .fontColor(Color.Gray)

          Text("CLEAR")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .borderRadius(24)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.onClear();
        })

        // Play/Stop Button
        Row({ space: 12 }) {
          Text(this.isPlaying ? "⏸" : "▶")
            .fontSize(16)
            .fontColor(Color.White)

          Text(this.isPlaying ? "STOP" : "PLAY")
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
        }
        .height(64)
        .width(140)
        .borderRadius(32)
        .backgroundColor(Color.Black)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.onPlayToggle();
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}