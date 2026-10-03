@Entry
@Component
struct MainActivity {
  @State bpm: number = 120;
  @State volume: number = 0.8;
  @State playing: boolean = false;
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

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

  private togglePad(index: number): void {
    this.pads[index] = !this.pads[index];
    this.pads = [...this.pads];
  }

  private clearPads(): void {
    this.pads = this.pads.map(() => false);
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('⚙')
        .fontSize(24)
        .fontColor('#000000')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Text(`${Math.floor(this.bpm)}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontFamily('monospace')
          .fontColor('#000000')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Circle()
        .width(12)
        .height(12)
        .fill(this.playing ? '#FF5722' : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F5F5F5')
    .border({ width: 2, color: '#000000' })
    .borderRadius(4)
  }

  @Builder
  DrumPad(active: boolean, label: string, index: number) {
    Column() {
      if (active) {
        Circle()
          .width(6)
          .height(6)
          .fill('#FFFFFF')
          .margin({ bottom: 4 })
      }
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(active ? '#FFFFFF' : '#808080')
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(active ? '#000000' : '#EEEEEE')
    .borderRadius(8)
    .border({ width: 1, color: active ? '#000000' : '#E0E0E0' })
    .onClick(() => {
      this.togglePad(index);
    })
  }

  @Builder
  PadGrid() {
    Grid() {
      ForEach(this.pads, (active: boolean, index: number) => {
        GridItem() {
          this.DrumPad(active, this.getPadLabel(index), index)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
    .width('100%')
  }

  @Builder
  ControlSection() {
    Column() {
      Row({ space: 16 }) {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
          Slider({ value: this.bpm, min: 60, max: 200, step: 1 })
            .onChange((value: number) => { this.bpm = value; })
            .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
          Slider({ value: this.volume, min: 0, max: 1, step: 0.01 })
            .onChange((value: number) => { this.volume = value; })
            .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      Row() {
        Row({ space: 8 }) {
          Text('⌫')
            .fontSize(16)
            .fontColor('#808080')
          Text('CLEAR')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .alignItems(VerticalAlign.Center)
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
        .onClick(() => { this.clearPads(); })

        Row({ space: 12 }) {
          Text(this.playing ? 'Ⅱ' : '▶')
            .fontSize(16)
            .fontColor('#FFFFFF')
          Text(this.playing ? 'STOP' : 'PLAY')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .width(140)
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#000000')
        .borderRadius(32)
        .onClick(() => { this.playing = !this.playing; })
      }
      .width('100%')
      .margin({ top: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  build() {
    Column() {
      this.HeaderSection()
      Blank().height(20)
      this.InfoDisplay()
      Blank().height(24)
      this.PadGrid()
      Blank().height(24)
      this.ControlSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
  }
}
