@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = new Array(16).fill(false);

  private padLabels: string[] = [
    'KICK', 'SNARE', 'CLAP', 'HI-HAT',
    'TOM 1', 'TOM 2', 'CRASH', 'RIDE',
    'PERC 1', 'PERC 2', 'FX 1', 'FX 2',
    'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16'
  ];

  build() {
    Column() {
      this.HeaderSection()

      Blank()

      this.InfoDisplay(this.bpm, this.isPlaying)

      Blank()

      this.PadGrid()

      Blank()

      this.ControlSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
          .letterSpacing(2)
        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Image($r('sys.media.ohos_ic_public_settings'))
        .width(24)
        .height(24)
        .fillColor(Color.Black)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay(bpm: number, isPlaying: boolean) {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
        Text(bpm.toFixed(0))
          .fontSize(32)
          .fontFamily('monospace')
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle({ width: 12, height: 12 })
        .fill(isPlaying ? '#FF5722' : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .border({ width: 2, color: Color.Black, radius: 4 })
    .backgroundColor('#F5F5F5')
    .padding(16)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PadGrid() {
    Grid() {
      ForEach(this.pads, (isActive: boolean, index: number) => {
        GridItem() {
          this.DrumPad(isActive, this.padLabels[index], index)
        }
      }, (item: boolean, index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
  }

  @Builder
  DrumPad(isActive: boolean, label: string, index: number) {
    Column() {
      if (isActive) {
        Circle({ width: 6, height: 6 })
          .fill(Color.White)
        Blank()
      }
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(isActive ? Color.White : '#888888')
    }
    .width('100%')
    .aspectRatio(1)
    .borderRadius(8)
    .backgroundColor(isActive ? Color.Black : '#EEEEEE')
    .border({
      width: 1,
      color: isActive ? Color.Black : '#E0E0E0',
      radius: 8
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.pads[index] = !this.pads[index];
    })
  }

  @Builder
  ControlSection() {
    Column() {
      Row() {
        Column() {
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
              this.bpm = value;
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
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
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()

      Row() {
        this.CustomOutlinedButton('CLEAR', () => {
          for (let i = 0; i < this.pads.length; i++) {
            this.pads[i] = false;
          }
        })

        Blank()

        Row() {
          if (this.isPlaying) {
            Row() {
              Rect().width(5).height(16).fill(Color.White)
              Blank()
              Rect().width(5).height(16).fill(Color.White)
            }
            .width(16)
            .height(16)
            .justifyContent(FlexAlign.SpaceBetween)
          } else {
            Path()
              .commands('M0 0 L16 8 L0 16 Z')
              .fill(Color.White)
              .width(16)
              .height(16)
          }
          Blank()
          Text(this.isPlaying ? 'STOP' : 'PLAY')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
        }
        .width(140)
        .height(64)
        .borderRadius(32)
        .backgroundColor(Color.Black)
        .justifyContent(FlexAlign.Center)
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

  @Builder
  CustomOutlinedButton(text: string, onClick: () => void) {
    Row() {
      Path()
        .commands('M6 2v2h2v10H6v2h8v-2h2V4h-2V2H6zm2 2h4v2H8V4zm0 4h6v6H8V8z')
        .fill('#888888')
        .width(16)
        .height(16)
      Blank()
      Text(text)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .height(48)
    .padding({ left: 24, right: 24 })
    .border({ width: 1, color: '#E0E0E0', radius: 24 })
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      onClick();
    })
  }
}
