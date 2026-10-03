@Entry
@Component
struct BeatMakerApp {
  build() {
    Column() {
      BeatMakerScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct BeatMakerScreen {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = [false, false, false, false, false, false, false, false,
    false, false, false, false, false, false, false, false]

  build() {
    Column() {
      // Top Header
      HeaderSection()
        .margin({ top: 24, left: 24, right: 24 })

      Blank().height(20)

      // LCD Display / Info Panel
      InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })
        .margin({ left: 24, right: 24 })

      Blank().height(24)

      // The Grid (Drum Pads)
      PadGrid({ pads: $pads })
        .margin({ left: 24, right: 24 })

      Blank().height(24)

      // Bottom Controls
      ControlSection({
        bpm: $bpm,
        volume: $volume,
        isPlaying: $isPlaying,
        onClear: () => {
          this.pads = [false, false, false, false, false, false, false, false,
            false, false, false, false, false, false, false, false]
        }
      })
        .margin({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .letterSpacing(-1)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        // Settings action
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
      .backgroundImage($r('sys.symbol.gearshape_fill'))
      .backgroundImageSize(24, 24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoDisplay {
  @Prop bpm: number
  @Prop isPlaying: boolean

  build() {
    Stack() {
      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')

          Text(`${Math.floor(this.bpm)}`)
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
            .fontFamily('monospace')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Circle()
          .width(12)
          .height(12)
          .fill(this.isPlaying ? '#FF5722' : '#80808080')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#F5F5F5')
    .border({ width: 2, color: '#000000', radius: 4 })
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[]

  build() {
    Grid() {
      ForEach(0, 16) { (index: number) => {
        GridItem() {
          DrumPad({
            isActive: this.pads[index],
            onClick: () => {
              this.pads[index] = !this.pads[index]
            },
            label: getPadLabel(index)
          })
        }
      }}
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
  }
}

@Component
struct DrumPad {
  @Prop isActive: boolean
  onClick: () => void = () => {}
  @Prop label: string

  build() {
    Button() {
      this.onClick()
    }
    .width('100%')
    .aspectRatio(1)
    .backgroundColor(this.isActive ? '#000000' : '#EEEEEE')
    .border({
      width: 1,
      color: this.isActive ? '#000000' : '#E0E0E0',
      radius: 8
    })
    .type(ButtonType.Normal)
    .borderRadius(8)
    .stateEffect(false)
    .padding(0)
    .margin(0)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundImageSize({ width: '100%', height: '100%' })
    .overlay(
      Column() {
        if (this.isActive) {
          Circle()
            .width(6)
            .height(6)
            .fill('#FFFFFF')
        }

        Text(this.label)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isActive ? '#FFFFFF' : '#808080')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
    )
  }
}

@Component
struct ControlSection {
  @Link bpm: number
  @Link volume: number
  @Link isPlaying: boolean
  onClear: () => void = () => {}

  build() {
    Column() {
      // Sliders Row
      Row() {
        // BPM Slider Column
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            onChange: (value: number) => {
              this.bpm = value
            }
          })
            .width('100%')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Blank().width(16)

        // VOL Slider Column
        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')

          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            onChange: (value: number) => {
              this.volume = value
            }
          })
            .width('100%')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')

      Blank().height(24)

      // Transport Buttons Row
      Row() {
        // Clear Button
        Button() {
          this.onClear()
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .borderRadius(24)
        .type(ButtonType.Normal)
        .stateEffect(false)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .overlay(
          Row() {
            Image($r('sys.symbol.trash'))
              .width(16)
              .height(16)
              .fillColor('#808080')

            Blank().width(8)

            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        )

        Blank()

        // Play Button
        Button() {
          this.isPlaying = !this.isPlaying
        }
        .width(140)
        .height(64)
        .backgroundColor('#000000')
        .borderRadius(32)
        .type(ButtonType.Normal)
        .stateEffect(false)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .overlay(
          Row() {
            if (this.isPlaying) {
              Image($r('sys.symbol.pause_fill'))
                .width(16)
                .height(16)
                .fillColor('#FFFFFF')
            } else {
              Image($r('sys.symbol.play_fill'))
                .width(16)
                .height(16)
                .fillColor('#FFFFFF')
            }

            Blank().width(12)

            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor('#FFFFFF')
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        )
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

function getPadLabel(index: number): string {
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
    default: return `SMP ${index + 1}`
  }
}