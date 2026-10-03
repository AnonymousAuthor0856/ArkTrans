@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false
  ]

  padRows: number[][] = [
    [0, 1, 2, 3],
    [4, 5, 6, 7],
    [8, 9, 10, 11],
    [12, 13, 14, 15]
  ]

  build() {
    Stack() {
      Column() {
        this.HeaderSection()

        this.InfoDisplay()

        this.PadGrid()

        this.ControlSection()
      }
      .width('100%')
      .height('100%')
      .padding({
        left: 24,
        right: 24,
        top: 24,
        bottom: 24
      })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .letterSpacing(-1)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('⚙')
          .fontSize(38)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(56)
      .height(56)
      .padding(0)
      .backgroundColor(Color.Transparent)
      .borderRadius(28)
      .onClick(() => {
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 20 })
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')

        Text(Math.round(this.bpm).toString())
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontFamily('monospace')
          .fontColor(Color.Black)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle()
        .width(12)
        .height(12)
        .fill(this.isPlaying ? '#FF5722' : '#BDBDBD')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .backgroundColor('#F5F5F5')
    .border({
      width: 2,
      color: Color.Black,
      radius: 4
    })
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 24 })
  }

  @Builder
  PadGrid() {
    Column({ space: 12 }) {
      ForEach(this.padRows, (row: number[]) => {
        Row({ space: 12 }) {
          ForEach(row, (index: number) => {
            this.DrumPad(index)
          }, (index: number) => index.toString())
        }
        .width('100%')
      }, (row: number[], rowIndex: number) => rowIndex.toString())
    }
    .width('100%')
    .margin({ bottom: 24 })
  }

  @Builder
  DrumPad(index: number) {
    Stack() {
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
          .fontColor(this.pads[index] ? Color.White : '#8E8E93')
          .textAlign(TextAlign.Center)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    }
    .layoutWeight(1)
    .aspectRatio(1)
    .backgroundColor(this.pads[index] ? Color.Black : '#EEEEEE')
    .border({
      width: 1,
      color: this.pads[index] ? Color.Black : '#E0E0E0',
      radius: 8
    })
    .onClick(() => {
      const nextPads: boolean[] = this.pads.slice()
      nextPads[index] = !nextPads[index]
      this.pads = nextPads
    })
  }

  @Builder
  ControlSection() {
    Column({ space: 24 }) {
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
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .blockColor(Color.White)
            .showTips(false)
            .height(40)
            .onChange((value: number) => {
              this.bpm = value
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
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .blockColor(Color.White)
            .showTips(false)
            .height(40)
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      Row() {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row({ space: 8 }) {
            Text('⌫')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8E8E93')

            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .height(48)
          .padding({
            left: 24,
            right: 24
          })
          .alignItems(VerticalAlign.Center)
        }
        .height(48)
        .backgroundColor(Color.Transparent)
        .border({
          width: 1,
          color: '#E0E0E0',
          radius: 24
        })
        .onClick(() => {
          this.pads = [
            false, false, false, false,
            false, false, false, false,
            false, false, false, false,
            false, false, false, false
          ]
        })

        Blank()

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row({ space: 12 }) {
            Text(this.isPlaying ? 'Ⅱ' : '▶')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
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
          .alignItems(VerticalAlign.Center)
        }
        .width(140)
        .height(64)
        .backgroundColor(Color.Black)
        .borderRadius(32)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  getPadLabel(index: number): string {
    switch (index) {
      case 0:
        return 'KICK'
      case 1:
        return 'SNARE'
      case 2:
        return 'CLAP'
      case 3:
        return 'HI-HAT'
      case 4:
        return 'TOM 1'
      case 5:
        return 'TOM 2'
      case 6:
        return 'CRASH'
      case 7:
        return 'RIDE'
      case 8:
        return 'PERC 1'
      case 9:
        return 'PERC 2'
      case 10:
        return 'FX 1'
      case 11:
        return 'FX 2'
      default:
        return `SMP ${index + 1}`
    }
  }
}