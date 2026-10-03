// Index.ets
interface DrumPadState {
  isActive: boolean;
  label: string;
}

@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State settingsHover: boolean = false;
  @State clearHover: boolean = false;
  @State playHover: boolean = false;
  private pads: DrumPadState[] = [
    { isActive: false, label: 'KICK' },
    { isActive: false, label: 'SNARE' },
    { isActive: false, label: 'CLAP' },
    { isActive: false, label: 'HI-HAT' },
    { isActive: false, label: 'TOM 1' },
    { isActive: false, label: 'TOM 2' },
    { isActive: false, label: 'CRASH' },
    { isActive: false, label: 'RIDE' },
    { isActive: false, label: 'PERC 1' },
    { isActive: false, label: 'PERC 2' },
    { isActive: false, label: 'FX 1' },
    { isActive: false, label: 'FX 2' },
    { isActive: false, label: 'SMP 13' },
    { isActive: false, label: 'SMP 14' },
    { isActive: false, label: 'SMP 15' },
    { isActive: false, label: 'SMP 16' }
  ];

  private togglePad(index: number) {
    this.pads[index].isActive = !this.pads[index].isActive;
  }

  private clearPads() {
    this.pads.forEach(pad => {
      pad.isActive = false;
    });
  }

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text('POCKET')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
            .letterSpacing(2)
          Text('BEATS-909')
            .fontSize(28)
            .fontWeight(FontWeight.Bolder)
            .letterSpacing(-1)
        }
        .alignItems(HorizontalAlign.Start)

        // Settings Icon
        Image($r('sys.media.ohos_ic_public_more'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
          .opacity(this.settingsHover ? 0.6 : 1.0)
          .onClick(() => {})
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              this.settingsHover = true;
            } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
              this.settingsHover = false;
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(20)

      // Info Display
      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#888888')
          Text(`${this.bpm.toFixed(0)}`)
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontFamily('monospace')
        }
        .alignItems(HorizontalAlign.Start)

        Circle({ width: 12, height: 12 })
          .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
      }
      .width('100%')
      .height(80)
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .border({ width: 2, color: Color.Black, radius: 4 })
      .backgroundColor('#F5F5F5')

      Blank().height(24)

      // Pad Grid
      Grid() {
        ForEach(this.pads, (pad: DrumPadState, index: number) => {
          GridItem() {
            Column() {
              if (pad.isActive) {
                Circle({ width: 6, height: 6 })
                  .fill(Color.White)
                  .margin({ bottom: 4 })
              }
              Text(pad.label)
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(pad.isActive ? Color.White : '#888888')
            }
            .width('100%')
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(pad.isActive ? Color.Black : '#EEEEEE')
            .border({
              width: 1,
              color: pad.isActive ? Color.Black : '#E0E0E0',
              radius: 8
            })
            .onClick(() => {
              this.togglePad(index);
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')

      Blank().height(24)

      // Control Section
      Column() {
        // Sliders Row
        Row() {
          // BPM Slider
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
              .width('100%')
              .blockColor(Color.Black)
              .selectedColor(Color.Black)
              .trackColor('#E0E0E0')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.bpm = value;
              })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          // Volume Slider
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
              .width('100%')
              .blockColor(Color.Black)
              .selectedColor(Color.Black)
              .trackColor('#E0E0E0')
              .onChange((value: number, mode: SliderChangeMode) => {
                this.volume = value;
              })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank().height(24)

        // Transport Buttons
        Row() {
          // Clear Button
          Row() {
            Image($r('sys.media.ohos_ic_public_remove'))
              .width(16)
              .height(16)
              .fillColor('#888888')
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 8 })
          }
          .height(48)
          .padding({ left: 24, right: 24 })
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .opacity(this.clearHover ? 0.6 : 1.0)
          .onClick(() => {
            this.clearPads();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              this.clearHover = true;
            } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
              this.clearHover = false;
            }
          })

          // Play Button
          Row() {
            if (this.isPlaying) {
              // Pause Icon
              Column()
                .width(5)
                .height(16)
                .backgroundColor(Color.White)
              Blank().width(5)
              Column()
                .width(5)
                .height(16)
                .backgroundColor(Color.White)
            } else {
              // Play Icon
              Image($r('sys.media.ohos_ic_public_play'))
                .width(16)
                .height(16)
                .fillColor(Color.White)
            }
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .height(64)
          .width(140)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(Color.Black)
          .borderRadius(32)
          .opacity(this.playHover ? 0.8 : 1.0)
          .onClick(() => {
            this.isPlaying = !this.isPlaying;
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              this.playHover = true;
            } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
              this.playHover = false;
            }
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Start)
  }
}