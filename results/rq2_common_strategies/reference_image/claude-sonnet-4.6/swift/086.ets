// Index.ets  —  Pocket Beats-909 (ArkTS / HarmonyOS ArkUI)
// Target: HarmonyOS NEXT, DevEco Studio 5.x, ArkTS (Stage model)

const PAD_LABELS: string[] = [
  'KICK', 'SNARE', 'CLAP', 'HI-HAT',
  'TOM 1', 'TOM 2', 'CRASH', 'RIDE',
  'PERC 1', 'PERC 2', 'FX 1', 'FX 2',
  'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16'
];

@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = new Array<boolean>(16).fill(false);

  private readonly indices: number[] =
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  // MARK: - Logic

  private togglePad(index: number): void {
    const next: boolean[] = this.pads.slice();
    next[index] = !next[index];
    this.pads = next;
  }

  private clearPads(): void {
    this.pads = new Array<boolean>(16).fill(false);
  }

  // MARK: - Sub views

  @Builder
  HeaderSection() {
    Row() {
      Column({ space: 0 }) {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#9E9E9E')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(900)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('\u2699')            // gear glyph
        .fontSize(24)
        .fontColor(Color.Black)
        .onClick(() => {
          // settings hook
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column({ space: 0 }) {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#9E9E9E')

        Text(`${Math.round(this.bpm)}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle({ width: 12, height: 12 })
        .fill(this.isPlaying ? '#FF5722' : '#BDBDBD')
    }
    .width('100%')
    .height(80)
    .padding({ left: 16, right: 16 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F5F5F5')
    .borderRadius(4)
    .border({ width: 2, color: Color.Black })
  }

  @Builder
  DrumPad(index: number) {
    Column() {
      if (this.pads[index]) {
        Circle({ width: 6, height: 6 })
          .fill(Color.White)
          .margin({ bottom: 4 })
      }

      Text(PAD_LABELS[index])
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.pads[index] ? Color.White : '#9E9E9E')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.pads[index] ? Color.Black : '#EEEEEE')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.pads[index] ? Color.Black : '#E0E0E0'
    })
    .onClick(() => {
      this.togglePad(index);
    })
  }

  @Builder
  PadGrid() {
    Flex({
      wrap: FlexWrap.Wrap,
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Start
    }) {
      ForEach(this.indices, (index: number) => {
        Column() {
          this.DrumPad(index);
        }
        .width('23%')
        .margin({ bottom: 12 })
      }, (index: number) => index.toString())
    }
    .width('100%')
  }

  @Builder
  ControlSection() {
    Column({ space: 24 }) {
      // Sliders row
      Row({ space: 16 }) {
        Column({ space: 0 }) {
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
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .blockColor(Color.White)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.bpm = value;
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 0 }) {
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
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .blockColor(Color.White)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.volume = value;
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      // Transport row
      Row() {
        Row({ space: 8 }) {
          Text('\uD83D\uDDD1')   // trash glyph
            .fontSize(16)
            .fontColor('#9E9E9E')

          Text('CLEAR')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .borderRadius(24)
        .border({ width: 1, color: '#E0E0E0' })
        .onClick(() => {
          this.clearPads();
        })

        Blank()

        Row({ space: 12 }) {
          Text(this.isPlaying ? '\u275A\u275A' : '\u25B6')
            .fontSize(16)
            .fontColor(Color.White)

          Text(this.isPlaying ? 'STOP' : 'PLAY')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)
        }
        .width(140)
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Black)
        .borderRadius(32)
        .onClick(() => {
          this.isPlaying = !this.isPlaying;
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  // MARK: - Body

  build() {
    Column() {
      this.HeaderSection();

      Blank().height(20);

      this.InfoDisplay();

      Blank().height(24);

      this.PadGrid();

      Blank().height(24);

      this.ControlSection();
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .backgroundColor(Color.White)
  }
}