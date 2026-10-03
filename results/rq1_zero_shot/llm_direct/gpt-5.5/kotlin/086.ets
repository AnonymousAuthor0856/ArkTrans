function getPadLabel(index: number): string {
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

@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false
  ]

  build() {
    Column() {
      HeaderSection()

      Blank()
        .height(20)

      InfoDisplay({
        bpm: this.bpm,
        isPlaying: this.isPlaying
      })

      Blank()
        .height(24)

      PadGrid({
        pads: this.pads,
        onPadClick: (index: number) => {
          const next: boolean[] = this.pads.slice()
          next[index] = !next[index]
          this.pads = next
        }
      })

      Blank()
        .height(24)

      ControlSection({
        bpm: this.bpm,
        volume: this.volume,
        isPlaying: this.isPlaying,
        onBpmChange: (value: number) => {
          this.bpm = value
        },
        onVolumeChange: (value: number) => {
          this.volume = value
        },
        onPlayToggle: () => {
          this.isPlaying = !this.isPlaying
        },
        onClear: () => {
          this.pads = this.pads.map(() => false)
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
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
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Black)
          .fontColor(Color.Black)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .stateEffect(false)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct InfoDisplay {
  bpm: number = 120
  isPlaying: boolean = false

  build() {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)

        Text(`${Math.floor(this.bpm)}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .fontFamily('monospace')
      }
      .alignItems(HorizontalAlign.Start)

      Circle()
        .width(12)
        .height(12)
        .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F5F5F5')
    .border({
      width: 2,
      color: Color.Black,
      radius: 4
    })
  }
}

@Component
struct PadGrid {
  pads: boolean[] = []
  onPadClick: (index: number) => void = () => {}

  build() {
    Grid() {
      ForEach(this.pads, (active: boolean, index: number) => {
        GridItem() {
          DrumPad({
            isActive: active,
            label: getPadLabel(index),
            onClick: () => {
              this.onPadClick(index)
            }
          })
        }
        .aspectRatio(1)
      }, (active: boolean, index: number) => `${index}-${active}`)
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
    .width('100%')
  }
}

@Component
struct DrumPad {
  isActive: boolean = false
  label: string = ''
  onClick: () => void = () => {}

  build() {
    Column() {
      if (this.isActive) {
        Circle()
          .width(6)
          .height(6)
          .fill(Color.White)

        Blank()
          .height(4)
      }

      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? Color.White : Color.Gray)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
    .border({
      width: 1,
      color: this.isActive ? Color.Black : '#E0E0E0',
      radius: 8
    })
    .borderRadius(8)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct ControlSection {
  bpm: number = 120
  volume: number = 0.8
  isPlaying: boolean = false
  onBpmChange: (value: number) => void = () => {}
  onVolumeChange: (value: number) => void = () => {}
  onPlayToggle: () => void = () => {}
  onClear: () => void = () => {}

  build() {
    Column() {
      Row() {
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
            .blockColor(Color.Black)
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.onBpmChange(value)
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
            .blockColor(Color.Black)
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.onVolumeChange(value)
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .columnGap(16)

      Blank()
        .height(24)

      Row() {
        CustomOutlinedButton({
          text: 'CLEAR',
          icon: '🗑',
          onClick: this.onClear
        })

        Row() {
          Text(this.isPlaying ? 'Ⅱ' : '▶')
            .fontSize(18)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)

          Blank()
            .width(12)

          Text(this.isPlaying ? 'STOP' : 'PLAY')
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
        }
        .width(140)
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Color.Black)
        .borderRadius(32)
        .onClick(() => {
          this.onPlayToggle()
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

@Component
struct CustomOutlinedButton {
  text: string = ''
  icon: string = ''
  onClick: () => void = () => {}

  build() {
    Row() {
      Text(this.icon)
        .fontSize(16)
        .fontColor(Color.Gray)

      Blank()
        .width(8)

      Text(this.text)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
    }
    .height(48)
    .padding({
      left: 24,
      right: 24
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: '#E0E0E0',
      radius: 24
    })
    .borderRadius(24)
    .backgroundColor(Color.White)
    .onClick(() => {
      this.onClick()
    })
  }
}