@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

  getPadLabel(index: number): string {
    switch (index) {
      case 0: return 'KICK'
      case 1: return 'SNARE'
      case 2: return 'CLAP'
      case 3: return 'HI-HAT'
      case 4: return 'TOM 1'
      case 5: return 'TOM 2'
      case 6: return 'CRASH'
      case 7: return 'RIDE'
      case 8: return 'PERC 1'
      case 9: return 'PERC 2'
      case 10: return 'FX 1'
      case 11: return 'FX 2'
      default: return 'SMP ' + (index + 1)
    }
  }

  togglePad(index: number): void {
    const p = this.pads.slice()
    p[index] = !p[index]
    this.pads = p
  }

  build() {
    Column() {
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
            .fontColor('#000000')
        }
        Button({ type: ButtonType.Circle }) {
          Text('⚙').fontSize(24).fontColor('#000000')
        }
        .width(48).height(48)
        .backgroundColor('#00000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(20)

      Column() {
        Row() {
          Column() {
            Text('TEMPO')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#888888')
            Text(Math.floor(this.bpm).toString())
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontFamily('monospace')
              .fontColor('#000000')
          }
          Stack() {}
            .width(12).height(12)
            .borderRadius(6)
            .backgroundColor(this.isPlaying ? '#FF5722' : '#CCCCCC')
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(80)
      .padding(16)
      .backgroundColor('#F5F5F5')
      .border({ width: 2, color: '#000000', radius: 4 })

      Blank().height(24)

      Grid() {
        ForEach(this.pads, (active: boolean, index: number) => {
          GridItem() {
            Column() {
              if (active) {
                Stack() {}
                  .width(6).height(6)
                  .borderRadius(3)
                  .backgroundColor('#FFFFFF')
                Blank().height(4)
              }
              Text(this.getPadLabel(index))
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(active ? '#FFFFFF' : '#888888')
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .backgroundColor(active ? '#000000' : '#EEEEEE')
            .borderRadius(8)
            .border({ width: 1, color: active ? '#000000' : '#E0E0E0' })
            .onClick(() => { this.togglePad(index) })
          }
          .height(70)
        }, (active: boolean, index: number) => index.toString())
      }
      .width('100%')
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)

      Blank().height(24)

      Column() {
        Row() {
          Column() {
            Text('BPM')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Slider({ value: this.bpm, min: 60, max: 200, style: SliderStyle.OutSet })
              .blockColor('#000000')
              .selectedColor('#000000')
              .trackColor('#E0E0E0')
              .onChange((value: number) => { this.bpm = value })
          }
          .layoutWeight(1)

          Column() {
            Text('VOL')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Slider({ value: this.volume, min: 0, max: 1, style: SliderStyle.OutSet })
              .blockColor('#000000')
              .selectedColor('#000000')
              .trackColor('#E0E0E0')
              .onChange((value: number) => { this.volume = value })
          }
          .layoutWeight(1)
        }
        .width('100%')
        .space(16)

        Blank().height(24)

        Row() {
          Row() {
            Text('🗑').fontSize(16).fontColor('#888888')
            Blank().width(8)
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .height(48)
          .padding({ left: 24, right: 24 })
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .alignItems(VerticalAlign.Center)
          .onClick(() => { this.pads = this.pads.map(() => false) })

          Row() {
            Text(this.isPlaying ? '❚❚' : '▶')
              .fontSize(16)
              .fontColor('#FFFFFF')
            Blank().width(12)
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor('#FFFFFF')
          }
          .width(140).height(64)
          .borderRadius(32)
          .backgroundColor('#000000')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => { this.isPlaying = !this.isPlaying })
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
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}
