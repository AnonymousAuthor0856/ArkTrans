@Entry
@Component
struct PocketBeats {
  @State bpm: number = 120
  @State volume: number = 0.8
  @State isPlaying: boolean = false
  @State activePads: boolean[] = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false
  ]

  private readonly padLabels: string[] = [
    'KICK', 'SNARE', 'CLAP', 'HI-HAT',
    'TOM 1', 'TOM 2', 'CRASH', 'RIDE',
    'PERC 1', 'PERC 2', 'FX 1', 'FX 2',
    'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16'
  ]

  private togglePad(index: number): void {
    const nextPads: boolean[] = this.activePads.slice()
    nextPads[index] = !nextPads[index]
    this.activePads = nextPads
  }

  private clearPads(): void {
    this.activePads = [
      false, false, false, false,
      false, false, false, false,
      false, false, false, false,
      false, false, false, false
    ]
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Column({ space: 5 }) {
          Text('POCKET')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8A8A8A')
            .letterSpacing(2)

          Text('BEATS-909')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text('⚙')
          .fontSize(31)
          .fontColor(Color.Black)
          .width(42)
          .height(42)
          .textAlign(TextAlign.Center)
          .onClick(() => {})
      }
      .width('100%')
      .height(76)
      .alignItems(VerticalAlign.Center)

      Blank().height(18)

      Stack() {
        Row() {
          Column({ space: 8 }) {
            Text('TEMPO')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#888888')

            Text(this.bpm.toFixed(0))
              .fontSize(34)
              .fontFamily('monospace')
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Circle({ width: 12, height: 12 })
            .fill(this.isPlaying ? '#FF5722' : '#CCCCCC')
        }
        .width('100%')
        .height('100%')
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(80)
      .backgroundColor('#F5F5F5')
      .border({ width: 2, color: Color.Black, radius: 4 })

      Blank().height(24)

      Grid() {
        ForEach(this.padLabels, (label: string, index: number) => {
          GridItem() {
            Stack() {
              if (this.activePads[index]) {
                Circle({ width: 6, height: 6 })
                  .fill(Color.White)
                  .margin({ bottom: 21 })
              }

              Text(label)
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.activePads[index] ? Color.White : '#888888')
            }
            .width('100%')
            .height('100%')
            .alignContent(Alignment.Center)
          }
          .width('100%')
          .aspectRatio(1)
          .backgroundColor(this.activePads[index] ? Color.Black : '#EEEEEE')
          .border({
            width: 1,
            color: this.activePads[index] ? Color.Black : '#E0E0E0',
            radius: 8
          })
          .borderRadius(8)
          .onClick(() => this.togglePad(index))
        }, (label: string) => label)
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')
      .height(312)

      Blank().height(24)

      Row({ space: 16 }) {
        Column({ space: 8 }) {
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
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .onChange((value: number) => {
              this.bpm = value
            })
            .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column({ space: 8 }) {
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
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .onChange((value: number) => {
              this.volume = value
            })
            .width('100%')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Blank().height(24)

      Row() {
        Text('CLEAR')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .height(48)
          .padding({ left: 24, right: 24 })
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .borderRadius(24)
          .textAlign(TextAlign.Center)
          .onClick(() => this.clearPads())

        Blank()

        Row({ space: 12 }) {
          Text(this.isPlaying ? 'Ⅱ' : '▶')
            .fontSize(17)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)

          Text(this.isPlaying ? 'STOP' : 'PLAY')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .letterSpacing(1)
        }
        .height(64)
        .width(140)
        .justifyContent(FlexAlign.Center)
        .borderRadius(32)
        .backgroundColor(Color.Black)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 36, bottom: 24 })
    .backgroundColor(Color.White)
  }
}
