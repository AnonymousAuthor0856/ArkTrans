import { router } from '@kit.ArkUI';

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

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
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

      Blank()

      Button({ type: ButtonType.Normal }) {
        Text("⚙")
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
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
    Stack() {
      Row() {
        Column() {
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

        Blank()

        Circle()
          .width(12)
          .height(12)
          .fill(this.isPlaying ? '#FF5722' : '#80808080')
      }
      .width('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#F5F5F5')
    .borderRadius(4)
    .border({ width: 2, color: Color.Black })
  }
}

@Component
struct DrumPad {
  @Prop isActive: boolean = false;
  onClick: () => void = () => {};
  @Prop label: string = '';

  build() {
    Button({ type: ButtonType.Normal }) {
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
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .aspectRatio(1)
    .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isActive ? Color.Black : '#E0E0E0'
    })
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[];

  build() {
    Grid() {
      ForEach(Array.from({ length: 16 }, (_, i) => i), (index: number) => {
        GridItem() {
          DrumPad({
            isActive: this.pads[index],
            label: getPadLabel(index),
            onClick: () => {
              let newPads = [...this.pads];
              newPads[index] = !newPads[index];
              this.pads = newPads;
            }
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
  }
}

@Component
struct ControlSection {
  @Link bpm: number;
  @Link volume: number;
  @Link isPlaying: boolean;
  onClear: () => void = () => {};

  build() {
    Column({ space: 24 }) {
      Row({ space: 16 }) {
        Column() {
          Text("BPM")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            style: SliderStyle.OutSet
          })
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.bpm = value;
            })
            .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            style: SliderStyle.OutSet
          })
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.volume = value;
            })
            .width('100%')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row() {
        Button({ type: ButtonType.Normal }) {
          Row({ space: 8 }) {
            Text("🗑")
              .fontSize(16)
              .fontColor(Color.Gray)
            Text("CLEAR")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .backgroundColor(Color.Transparent)
        .borderRadius(24)
        .border({ width: 1, color: '#E0E0E0' })
        .onClick(() => {
          this.onClear();
        })

        Blank()

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
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width(140)
        .height(64)
        .backgroundColor(Color.Black)
        .borderRadius(32)
        .onClick(() => {
          this.isPlaying = !this.isPlaying;
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = new Array(16).fill(false);

  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank().height(20)

        InfoDisplay({
          bpm: this.bpm,
          isPlaying: this.isPlaying
        })
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        PadGrid({ pads: $pads })
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        ControlSection({
          bpm: $bpm,
          volume: $volume,
          isPlaying: $isPlaying,
          onClear: () => {
            this.pads = new Array(16).fill(false);
          }
        })
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}