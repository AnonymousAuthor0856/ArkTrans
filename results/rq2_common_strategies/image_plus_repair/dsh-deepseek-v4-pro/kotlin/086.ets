@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = []

  aboutToAppear(): void {
    for (let i = 0; i < 16; i++) {
      this.pads.push(false)
    }
  }

  private getPadLabel(index: number): string {
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
        return 'SMP ' + (index + 1)
    }
  }

  private togglePad(index: number): void {
    this.pads[index] = !this.pads[index]
    this.pads = this.pads.slice()
  }

  private clearPads(): void {
    const next: boolean[] = []
    for (let i = 0; i < 16; i++) {
      next.push(false)
    }
    this.pads = next
  }

  build() {
    Column() {
      this.headerSection()
      Blank().height(20)
      this.infoDisplay()
      Blank().height(24)
      this.padGrid()
      Blank().height(24)
      this.controlSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  headerSection() {
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

      Text('\u2699')
        .fontSize(24)
        .fontColor('#000000')
        .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  infoDisplay() {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
        Text(Math.floor(this.bpm).toString())
          .fontSize(32)
          .fontFamily('monospace')
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(HorizontalAlign.Start)

      Circle({ width: 12, height: 12 })
        .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .borderRadius(4)
    .border({ width: 2, color: '#000000' })
    .backgroundColor('#F5F5F5')
  }

  @Builder
  padGrid() {
    Grid() {
      ForEach(this.pads, (pad: boolean, index: number) => {
        GridItem() {
          this.drumPad(pad, index)
        }
      }, (pad: boolean, index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
    .width('100%')
  }

  @Builder
  drumPad(isActive: boolean, index: number) {
    Stack() {
      Column() {
        if (isActive) {
          Circle({ width: 6, height: 6 })
            .fill('#FFFFFF')
          Blank().height(4)
        }
        Text(this.getPadLabel(index))
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(isActive ? '#FFFFFF' : '#888888')
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .alignContent(Alignment.Center)
    .borderRadius(8)
    .backgroundColor(isActive ? '#000000' : '#EEEEEE')
    .border({ width: 1, color: isActive ? '#000000' : '#E0E0E0' })
    .onClick(() => {
      this.togglePad(index)
    })
  }

  @Builder
  controlSection() {
    Column() {
      Row() {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          Slider({ value: this.bpm, min: 60, max: 200, step: 1, style: SliderStyle.OutSet })
            .blockColor('#000000')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.bpm = value
            })
        }
        .layoutWeight(1)

        Blank().width(16)

        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          Slider({ value: this.volume, min: 0, max: 1, step: 0.01, style: SliderStyle.OutSet })
            .blockColor('#000000')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .layoutWeight(1)
      }
      .width('100%')

      Blank().height(24)

      Row() {
        this.customOutlinedButton()

        Stack() {
          Row() {
            if (this.isPlaying) {
              Path()
                .width(16)
                .height(16)
                .commands('M0 0 L5 0 L5 16 L0 16 Z M11 0 L16 0 L16 16 L11 16 Z')
                .fill('#FFFFFF')
            } else {
              Path()
                .width(16)
                .height(16)
                .commands('M0 0 L16 8 L0 16 Z')
                .fill('#FFFFFF')
            }
            Blank().width(12)
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontColor('#FFFFFF')
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
          }
          .alignItems(VerticalAlign.Center)
        }
        .width(140)
        .height(64)
        .borderRadius(32)
        .backgroundColor('#000000')
        .alignContent(Alignment.Center)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  @Builder
  customOutlinedButton() {
    Row() {
      Text('\uD83D\uDDD1')
        .fontSize(16)
        .fontColor('#888888')
      Blank().width(8)
      Text('CLEAR')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
    }
    .alignItems(VerticalAlign.Center)
    .height(48)
    .padding({ left: 24, right: 24 })
    .border({ width: 1, color: '#E0E0E0', radius: 24 })
    .onClick(() => {
      this.clearPads()
    })
  }
}
