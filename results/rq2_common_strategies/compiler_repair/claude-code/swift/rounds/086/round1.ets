@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = [false, false, false, false, false, false, false, false,
                            false, false, false, false, false, false, false, false];

  build() {
    Stack() {
      Column({ space: 0 }) {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank(20)

        InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })
          .padding({ left: 24, right: 24 })

        Blank(24)

        PadGrid({ pads: this.pads })
          .padding({ left: 24, right: 24 })

        Blank(24)

        ControlSection({
          bpm: $bpm,
          volume: $volume,
          isPlaying: $isPlaying,
          onClear: () => {
            this.pads = [false, false, false, false, false, false, false, false,
                         false, false, false, false, false, false, false, false];
          }
        })
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 0 }) {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#9E9E9E')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }
}

@Component
struct InfoDisplay {
  @Prop bpm: number;
  @Prop isPlaying: boolean;

  build() {
    Stack() {
      Row() {
        Column({ space: 0 }) {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#9E9E9E')

          Text(this.bpm.toFixed(0))
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontFamily('monospace')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Circle({ width: 12, height: 12 })
          .fill(this.isPlaying ? '#FF5722' : 'rgba(158, 158, 158, 0.5)')
      }
      .padding(16)
      .width('100%')
    }
    .width('100%')
    .height(80)
    .backgroundColor('#F5F5F5')
    .border({ width: 2, color: Color.Black })
    .borderRadius(4)
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[];

  private getPadLabel(index: number): string {
    switch (index) {
      case 0: return 'KICK';
      case 1: return 'SNARE';
      case 2: return 'CLAP';
      case 3: return 'HI-HAT';
      case 4: return 'TOM 1';
      case 5: return 'TOM 2';
      case 6: return 'CRASH';
      case 7: return 'RIDE';
      case 8: return 'PERC 1';
      case 9: return 'PERC 2';
      case 10: return 'FX 1';
      case 11: return 'FX 2';
      default: return `SMP ${index + 1}`;
    }
  }

  build() {
    Grid() {
      ForEach(this.pads, (item: boolean, index: number) => {
        GridItem() {
          DrumPad({
            isActive: this.pads[index],
            onClick: () => { this.pads[index] = !this.pads[index]; },
            label: this.getPadLabel(index)
          })
        }
      }, (item: boolean, index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
  }
}

@Component
struct DrumPad {
  @Prop isActive: boolean;
  onClick: () => void = () => {};
  @Prop label: string = '';

  build() {
    Button() {
      Stack() {
        Column({ space: 4 }) {
          if (this.isActive) {
            Circle({ width: 6, height: 6 })
              .fill(Color.White)
          }

          Text(this.label)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? Color.White : '#9E9E9E')
        }
      }
      .width('100%')
      .height('100%')
      .aspectRatio(1)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isActive ? Color.Black : '#E0E0E0'
    })
    .onClick(() => this.onClick())
    .width('100%')
    .aspectRatio(1)
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
        Column({ space: 0 }) {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)

          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Black)
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.bpm = Math.round(value);
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column({ space: 0 }) {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)

          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Black)
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.volume = value;
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')

      Row() {
        Button() {
          Row({ space: 8 }) {
            Image($r('sys.media.ohos_ic_public_delete'))
              .width(16)
              .height(16)
              .fillColor('#9E9E9E')

            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .padding({ left: 24, right: 24 })
          .height(48)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.White)
        .borderRadius(24)
        .border({ width: 1, color: '#E0E0E0' })
        .onClick(() => this.onClear())

        Blank()

        Button() {
          Row({ space: 12 }) {
            if (this.isPlaying) {
              Image($r('sys.media.ohos_ic_public_pause'))
                .width(16)
                .height(16)
                .fillColor(Color.White)
            } else {
              Image($r('sys.media.ohos_ic_public_play'))
                .width(16)
                .height(16)
                .fillColor(Color.White)
            }

            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .letterSpacing(1)
          }
          .width(140)
          .height(64)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Black)
        .borderRadius(32)
        .onClick(() => { this.isPlaying = !this.isPlaying; })
      }
      .width('100%')
    }
    .width('100%')
  }
}
