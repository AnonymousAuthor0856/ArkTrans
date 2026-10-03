@Entry
@Component
struct BeatMakerScreen {
  @State bpm: number = 120
  @State volume: number = 0.8
  @State isPlaying: boolean = false
  @State pad0: boolean = false
  @State pad1: boolean = false
  @State pad2: boolean = false
  @State pad3: boolean = false
  @State pad4: boolean = false
  @State pad5: boolean = false
  @State pad6: boolean = false
  @State pad7: boolean = false
  @State pad8: boolean = false
  @State pad9: boolean = false
  @State pad10: boolean = false
  @State pad11: boolean = false
  @State pad12: boolean = false
  @State pad13: boolean = false
  @State pad14: boolean = false
  @State pad15: boolean = false

  clearPads(): void {
    this.pad0 = false
    this.pad1 = false
    this.pad2 = false
    this.pad3 = false
    this.pad4 = false
    this.pad5 = false
    this.pad6 = false
    this.pad7 = false
    this.pad8 = false
    this.pad9 = false
    this.pad10 = false
    this.pad11 = false
    this.pad12 = false
    this.pad13 = false
    this.pad14 = false
    this.pad15 = false
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Column({ space: 0 }) {
            Text('POCKET')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8E8E93')
              .letterSpacing(2)
              .lineHeight(18)

            Text('BEATS-909')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .lineHeight(38)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Text('\u2699')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
          }
          .width(48)
          .height(48)
          .padding(0)
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .height(74)
        .alignItems(VerticalAlign.Top)
        .margin({ top: 24 })

        Row() {
          Column({ space: 0 }) {
            Text('TEMPO')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8E8E93')
              .lineHeight(15)

            Text(Math.round(this.bpm).toString())
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontFamily('monospace')
              .fontColor(Color.Black)
              .lineHeight(45)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Circle()
            .width(12)
            .height(12)
            .fill(this.isPlaying ? '#FF5722' : '#C7C7CC')
        }
        .width('100%')
        .height(80)
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#F5F5F5')
        .border({ width: 2, color: Color.Black, radius: 4 })
        .margin({ top: 20 })

        Grid() {
          GridItem() { DrumPad({ label: 'KICK', isActive: $pad0 }) }
          GridItem() { DrumPad({ label: 'SNARE', isActive: $pad1 }) }
          GridItem() { DrumPad({ label: 'CLAP', isActive: $pad2 }) }
          GridItem() { DrumPad({ label: 'HI-HAT', isActive: $pad3 }) }
          GridItem() { DrumPad({ label: 'TOM 1', isActive: $pad4 }) }
          GridItem() { DrumPad({ label: 'TOM 2', isActive: $pad5 }) }
          GridItem() { DrumPad({ label: 'CRASH', isActive: $pad6 }) }
          GridItem() { DrumPad({ label: 'RIDE', isActive: $pad7 }) }
          GridItem() { DrumPad({ label: 'PERC 1', isActive: $pad8 }) }
          GridItem() { DrumPad({ label: 'PERC 2', isActive: $pad9 }) }
          GridItem() { DrumPad({ label: 'FX 1', isActive: $pad10 }) }
          GridItem() { DrumPad({ label: 'FX 2', isActive: $pad11 }) }
          GridItem() { DrumPad({ label: 'SMP 13', isActive: $pad12 }) }
          GridItem() { DrumPad({ label: 'SMP 14', isActive: $pad13 }) }
          GridItem() { DrumPad({ label: 'SMP 15', isActive: $pad14 }) }
          GridItem() { DrumPad({ label: 'SMP 16', isActive: $pad15 }) }
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')
        .margin({ top: 24 })

        Blank()
          .height(24)

        Column({ space: 24 }) {
          Row({ space: 16 }) {
            Column({ space: 14 }) {
              Text('BPM')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(15)

              Slider({ value: this.bpm, min: 60, max: 200, step: 1, style: SliderStyle.OutSet })
                .blockColor(Color.White)
                .trackColor('#E5E5EA')
                .selectedColor(Color.Black)
                .height(30)
                .onChange((value: number) => {
                  this.bpm = value
                })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Column({ space: 14 }) {
              Text('VOL')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .lineHeight(15)

              Slider({ value: this.volume, min: 0, max: 1, step: 0.01, style: SliderStyle.OutSet })
                .blockColor(Color.White)
                .trackColor('#E5E5EA')
                .selectedColor(Color.Black)
                .height(30)
                .onChange((value: number) => {
                  this.volume = value
                })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Top)

          Row() {
            Button({ type: ButtonType.Normal, stateEffect: false }) {
              Row({ space: 8 }) {
                Text('\u232B')
                  .fontSize(22)
                  .fontColor('#8E8E93')
                  .width(24)
                  .textAlign(TextAlign.Center)

                Text('CLEAR')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
              }
              .height(48)
              .padding({ left: 24, right: 24 })
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .border({ width: 1, color: '#E0E0E0', radius: 24 })
            }
            .height(48)
            .padding(0)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.clearPads()
            })

            Blank()

            Button({ type: ButtonType.Normal, stateEffect: false }) {
              Row({ space: 12 }) {
                Text(this.isPlaying ? '\u275A\u275A' : '\u25B6')
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .width(24)
                  .textAlign(TextAlign.Center)

                Text(this.isPlaying ? 'STOP' : 'PLAY')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .letterSpacing(1)
              }
              .width(140)
              .height(64)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(Color.Black)
              .borderRadius(32)
            }
            .width(140)
            .height(64)
            .padding(0)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              this.isPlaying = !this.isPlaying
            })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .margin({ bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct DrumPad {
  label: string = ''
  @Link isActive: boolean

  build() {
    Button({ type: ButtonType.Normal, stateEffect: false }) {
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
          .fontColor(this.isActive ? Color.White : '#8E8E93')
          .textAlign(TextAlign.Center)
          .maxLines(1)
      }
      .width('100%')
      .aspectRatio(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
      .border({ width: 1, color: this.isActive ? Color.Black : '#E0E0E0', radius: 8 })
    }
    .width('100%')
    .aspectRatio(1)
    .padding(0)
    .backgroundColor(Color.Transparent)
    .onClick(() => {
      this.isActive = !this.isActive
    })
  }
}
