@Entry
@Component
struct BeatMakerScreen {
  @State private bpm: number = 120;
  @State private isPlaying: boolean = false;
  @State private volume: number = 0.8;
  @State private pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

  private getPadLabel(index: number): string {
    if (index === 0) return 'KICK';
    if (index === 1) return 'SNARE';
    if (index === 2) return 'CLAP';
    if (index === 3) return 'HI-HAT';
    if (index === 4) return 'TOM 1';
    if (index === 5) return 'TOM 2';
    if (index === 6) return 'CRASH';
    if (index === 7) return 'RIDE';
    if (index === 8) return 'PERC 1';
    if (index === 9) return 'PERC 2';
    if (index === 10) return 'FX 1';
    if (index === 11) return 'FX 2';
    return `SMP ${index + 1}`;
  }

  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 0 }) {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  private InfoDisplay() {
    Stack() {
      Rect()
        .width('100%')
        .height(80)
        .fill('#F5F5F5')
        .stroke(Color.Black)
        .strokeWidth(2)
        .radius(4)
      Row() {
        Column({ space: 0 }) {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')
          Text(`${Math.floor(this.bpm)}`)
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Circle()
          .width(12)
          .height(12)
          .fill(this.isPlaying ? '#FF5722' : '#80808080')
      }
      .padding(16)
      .width('100%')
    }
    .height(80)
    .width('100%')
  }

  @Builder
  private DrumPad(index: number) {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill(this.pads[index] ? Color.Black : '#EEEEEE')
        .stroke(this.pads[index] ? Color.Black : '#E0E0E0')
        .strokeWidth(1)
        .radius(8)
      Column({ space: 4 }) {
        if (this.pads[index]) {
          Circle()
            .width(6)
            .height(6)
            .fill(Color.White)
        }
        Text(this.getPadLabel(index))
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.pads[index] ? Color.White : '#808080')
      }
    }
    .aspectRatio(1)
    .width('100%')
    .onClick(() => {
      let next: boolean[] = this.pads.slice();
      next[index] = !next[index];
      this.pads = next;
    })
  }

  @Builder
  private PadGrid() {
    Grid() {
      ForEach(Array.from({ length: 16 }, (_: Object, index: number) => index), (index: number) => {
        GridItem() {
          this.DrumPad(index)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
    .width('100%')
  }

  @Builder
  private ControlSection() {
    Column({ space: 24 }) {
      Row({ space: 16 }) {
        Column({ space: 0 }) {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Slider({ value: this.bpm, min: 60, max: 200 })
            .selectedColor(Color.Black)
            .onChange((value: number) => {
              this.bpm = value;
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column({ space: 0 }) {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Slider({ value: this.volume, min: 0, max: 1 })
            .selectedColor(Color.Black)
            .onChange((value: number) => {
              this.volume = value;
            })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')

      Row() {
        Button('🗑  CLEAR')
          .height(48)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .padding({ left: 24, right: 24 })
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#E0E0E0' })
          .borderRadius(24)
          .onClick(() => {
            this.pads = Array.from({ length: 16 }, () => false);
          })
        Blank()
        Button(this.isPlaying ? 'Ⅱ  STOP' : '▶  PLAY')
          .width(140)
          .height(64)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .backgroundColor(Color.Black)
          .borderRadius(32)
          .onClick(() => {
            this.isPlaying = !this.isPlaying;
          })
      }
      .width('100%')
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })
        Blank().height(20)
        this.InfoDisplay()
          .padding({ left: 24, right: 24 })
        Blank().height(24)
        this.PadGrid()
          .padding({ left: 24, right: 24 })
        Blank().height(24)
        this.ControlSection()
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
