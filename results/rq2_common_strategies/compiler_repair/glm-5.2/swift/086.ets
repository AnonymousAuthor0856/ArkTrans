// Index.ets

// MARK: - Helpers
function getPadLabel(index: number): string {
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

// MARK: - Main Screen
@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120;
  @State isPlaying: boolean = false;
  @State volume: number = 0.8;
  @State pads: boolean[] = Array(16).fill(false);

  build() {
    Stack() {
      Column() {
        // Top Header
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        // Spacer
        Blank().height(20)

        // LCD Display / Info Panel
        InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })
          .padding({ left: 24, right: 24 })

        // Spacer
        Blank().height(24)

        // The Grid (Drum Pads)
        PadGrid({ 
          pads: this.pads, 
          onToggle: (i: number) => {
            this.pads[i] = !this.pads[i];
          }
        })
          .padding({ left: 24, right: 24 })

        // Spacer
        Blank().height(24)

        // Bottom Controls
        ControlSection({
          bpm: this.bpm,
          volume: this.volume,
          isPlaying: this.isPlaying,
          onBpmChange: (v: number) => this.bpm = v,
          onVolChange: (v: number) => this.volume = v,
          onPlayToggle: () => this.isPlaying = !this.isPlaying,
          onClear: () => {
            this.pads = Array(16).fill(false);
          }
        })
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bolder) // 'Black' is not available, using 'Bolder'
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      // Settings Button Placeholder
      Text('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
    }
    .width('100%')
  }
}

@Component
struct InfoDisplay {
  @Prop bpm: number = 120;
  @Prop isPlaying: boolean = false;

  build() {
    Stack() {
      // Background & Border
      Column() {}
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')
        .border({ width: 2, color: Color.Black, radius: 4 })

      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)

          Text(`${Math.round(this.bpm)}`)
            .fontSize(32)
            .fontFamily('monospace')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // LED Indicator
        Circle()
          .width(12)
          .height(12)
          .fill(this.isPlaying ? '#FF5722' : 'rgba(128,128,128,0.5)')
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct PadGrid {
  @Prop pads: boolean[];
  onToggle: (index: number) => void = () => {};

  build() {
    Grid() {
      ForEach(this.pads, (isActive: boolean, index: number) => {
        GridItem() {
          DrumPad({ 
            isActive: isActive, 
            onTap: () => this.onToggle(index), 
            label: getPadLabel(index) 
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
struct DrumPad {
  @Prop isActive: boolean = false;
  onTap: () => void = () => {};
  @Prop label: string = '';

  build() {
    Button({ type: ButtonType.Normal }) {
      Stack() {
        // Background
        Column() {}
          .width('100%')
          .height('100%')
          .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
          .border({ 
            width: 1, 
            color: this.isActive ? Color.Black : '#E0E0E0', 
            radius: 8 
          })

        // Content
        Column() {
          if (this.isActive) {
            Circle()
              .width(6)
              .height(6)
              .fill(Color.White)
              .margin({ bottom: 4 })
          }

          Text(this.label)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? Color.White : Color.Gray)
        }
        .justifyContent(FlexAlign.Center)
      }
      .aspectRatio(1)
    }
    .padding(0)
    .backgroundColor(Color.Transparent)
    .onClick(this.onTap)
  }
}

@Component
struct ControlSection {
  @Prop bpm: number = 120;
  @Prop volume: number = 0.8;
  @Prop isPlaying: boolean = false;
  
  onBpmChange: (value: number) => void = () => {};
  onVolChange: (value: number) => void = () => {};
  onPlayToggle: () => void = () => {};
  onClear: () => void = () => {};

  build() {
    Column() {
      // Sliders Row
      Row() {
        // BPM Slider Column
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 4 })

          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .onChange(this.onBpmChange)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        // VOL Slider Column
        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 4 })

          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .onChange(this.onVolChange)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .margin({ bottom: 24 })

      // Transport Buttons Row
      Row() {
        // Clear Button
        Button({ type: ButtonType.Normal }) {
          Row() {
            Text('🗑')
              .fontSize(16)
              .fontColor(Color.Gray)
              .margin({ right: 8 })
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .padding({ left: 24, right: 24 })
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
        }
        .backgroundColor(Color.Transparent)
        .padding(0)
        .onClick(this.onClear)

        Blank()

        // Play Button
        Button({ type: ButtonType.Normal }) {
          Row() {
            Text(this.isPlaying ? '⏸' : '▶')
              .fontSize(16)
              .fontColor(Color.White)
              .margin({ right: 12 })
            
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .letterSpacing(1)
          }
          .width(140)
          .height(64)
          .backgroundColor(Color.Black)
          .borderRadius(32)
          .justifyContent(FlexAlign.Center)
        }
        .padding(0)
        .backgroundColor(Color.Transparent)
        .onClick(this.onPlayToggle)
      }
      .width('100%')
    }
  }
}