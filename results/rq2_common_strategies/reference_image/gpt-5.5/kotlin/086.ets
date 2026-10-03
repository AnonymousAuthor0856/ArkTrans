const GRID_ROWS: number[] = [0, 1, 2, 3];
const GRID_COLS: number[] = [0, 1, 2, 3];

@Entry
@Component
struct Index {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false
  ];

  private togglePad(index: number): void {
    const next: boolean[] = this.pads.slice();
    next[index] = !next[index];
    this.pads = next;
  }

  private clearPads(): void {
    this.pads = [
      false, false, false, false,
      false, false, false, false,
      false, false, false, false,
      false, false, false, false
    ];
  }

  build() {
    Column() {
      HeaderSection()

      Blank()
        .height(20)

      InfoDisplay({
        bpm: this.bpm,
        isPlaying: this.isPlaying
      })

      Blank()
        .height(24)

      PadGrid({
        pads: this.pads,
        onTogglePad: (index: number) => {
          this.togglePad(index);
        }
      })

      Blank()
        .height(24)

      ControlSection({
        bpm: this.bpm,
        volume: this.volume,
        isPlaying: this.isPlaying,
        onBpmChange: (value: number) => {
          this.bpm = value;
        },
        onVolumeChange: (value: number) => {
          this.volume = value;
        },
        onPlayToggle: () => {
          this.isPlaying = !this.isPlaying;
        },
        onClear: () => {
          this.clearPads();
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(34)
        .fontColor(Color.Black)
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
        .onClick(() => {
        })
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
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')

        Text(Math.round(this.bpm).toString())
          .fontSize(32)
          .fontFamily('monospace')
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
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
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F5F5F5')
    .border({
      width: 2,
      color: Color.Black,
      radius: 4
    })
  }
}

@Component
struct PadGrid {
  @Prop pads: boolean[] = [];
  onTogglePad: (index: number) => void = (index: number) => {
  };

  build() {
    Column({ space: 12 }) {
      ForEach(GRID_ROWS, (row: number) => {
        Row({ space: 12 }) {
          ForEach(GRID_COLS, (col: number) => {
            DrumPad({
              isActive: this.pads[row * 4 + col],
              label: getPadLabel(row * 4 + col),
              clickHandler: () => {
                this.onTogglePad(row * 4 + col);
              }
            })
              .layoutWeight(1)
              .aspectRatio(1)
          }, (col: number) => col.toString())
        }
        .width('100%')
      }, (row: number) => row.toString())
    }
    .width('100%')
  }
}

@Component
struct DrumPad {
  @Prop isActive: boolean = false;
  @Prop label: string = '';
  clickHandler: () => void = () => {
  };

  build() {
    Column() {
      if (this.isActive) {
        Circle()
          .width(6)
          .height(6)
          .fill(Color.White)

        Blank()
          .height(4)
      }

      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? Color.White : '#888888')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isActive ? Color.Black : '#E0E0E0',
      radius: 8
    })
    .onClick(() => {
      this.clickHandler();
    })
  }
}

@Component
struct ControlSection {
  @Prop bpm: number = 120;
  @Prop volume: number = 0.8;
  @Prop isPlaying: boolean = false;

  onBpmChange: (value: number) => void = (value: number) => {
  };
  onVolumeChange: (value: number) => void = (value: number) => {
  };
  onPlayToggle: () => void = () => {
  };
  onClear: () => void = () => {
  };

  build() {
    Column() {
      Row({ space: 16 }) {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            step: 1,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(Color.Black)
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .showTips(false)
            .onChange((value: number) => {
              this.onBpmChange(value);
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)

          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .blockColor(Color.Black)
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .showTips(false)
            .onChange((value: number) => {
              this.onVolumeChange(value);
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      Blank()
        .height(24)

      Row() {
        CustomOutlinedButton({
          text: 'CLEAR',
          icon: '⌫',
          clickHandler: () => {
            this.onClear();
          }
        })

        Row() {
          Text(this.isPlaying ? 'Ⅱ' : '▶')
            .fontSize(16)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)

          Blank()
            .width(12)

          Text(this.isPlaying ? 'STOP' : 'PLAY')
            .fontSize(16)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
        }
        .width(140)
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Color.Black)
        .borderRadius(32)
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

@Component
struct CustomOutlinedButton {
  @Prop text: string = '';
  @Prop icon: string = '';
  clickHandler: () => void = () => {
  };

  build() {
    Row() {
      Text(this.icon)
        .fontSize(16)
        .fontColor('#888888')

      Blank()
        .width(8)

      Text(this.text)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .height(48)
    .padding({
      left: 24,
      right: 24
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: '#E0E0E0',
      radius: 24
    })
    .borderRadius(24)
    .onClick(() => {
      this.clickHandler();
    })
  }
}

function getPadLabel(index: number): string {
  switch (index) {
    case 0:
      return 'KICK';
    case 1:
      return 'SNARE';
    case 2:
      return 'CLAP';
    case 3:
      return 'HI-HAT';
    case 4:
      return 'TOM 1';
    case 5:
      return 'TOM 2';
    case 6:
      return 'CRASH';
    case 7:
      return 'RIDE';
    case 8:
      return 'PERC 1';
    case 9:
      return 'PERC 2';
    case 10:
      return 'FX 1';
    case 11:
      return 'FX 2';
    default:
      return `SMP ${index + 1}`;
  }
}