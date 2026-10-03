@Entry
@Component
struct ContentView {
  build() {
    BeatMakerScreen()
  }
}

@Component
struct BeatMakerScreen {
  @State private bpm: number = 120
  @State private isPlaying: boolean = false
  @State private volume: number = 0.8
  @State private pads: boolean[] = Array(16).fill(false)

  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank()
          .height(20)

        InfoDisplay({
          bpm: this.bpm,
          isPlaying: this.isPlaying
        })
          .padding({ left: 24, right: 24 })

        Blank()
          .height(24)

        PadGrid({
          pads: $pads
        })
          .padding({ left: 24, right: 24 })

        Blank()
          .height(24)

        ControlSection({
          bpm: $bpm,
          volume: $volume,
          isPlaying: $isPlaying,
          onClear: () => {
            this.pads = Array(16).fill(false)
          }
        })
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
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
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .onClick(() => {
        })
    }
    .width('100%')
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
          .fontFamily('monospace')
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Blank()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(this.isPlaying ? '#FF5722' : '#808080')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .backgroundColor('#F5F5F5')
    .border({
      width: 2,
      color: Color.Black
    })
    .borderRadius(4)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[]

  build() {
    Grid() {
      ForEach(this.pads, (item: boolean, index: number) => {
        GridItem() {
          DrumPad({
            isActive: item,
            label: getPadLabel(index),
            onClick: () => {
              const next: boolean[] = this.pads.slice()
              next[index] = !next[index]
              this.pads = next
            }
          })
        }
      }, (_item: boolean, index: number) => `${index}`)
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
  onClick: () => void = () => {
  }

  build() {
    Stack() {
      Column({ space: 4 }) {
        if (this.isActive) {
          Blank()
            .width(6)
            .height(6)
            .borderRadius(3)
            .backgroundColor(Color.White)
        }

        Text(this.label)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isActive ? Color.White : Color.Gray)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .backgroundColor(this.isActive ? Color.Black : '#EEEEEE')
    .borderRadius(8)
    .border({
      width: 1,
      color: this.isActive ? Color.Black : '#E0E0E0'
    })
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct ControlSection {
  @Link bpm: number
  @Link volume: number
  @Link isPlaying: boolean
  onClear: () => void = () => {
  }

  build() {
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
            step: 1
          })
            .selectedColor(Color.Black)
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .showTips(false)
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
            step: 0.01
          })
            .selectedColor(Color.Black)
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .showTips(false)
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      Row() {
        Row({ space: 8 }) {
          Text('⌫')
            .fontSize(16)
            .fontColor(Color.Gray)

          Text('CLEAR')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .borderRadius(24)
        .border({
          width: 1,
          color: '#E0E0E0'
        })
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.onClear()
        })

        Blank()

        Row({ space: 12 }) {
          if (this.isPlaying) {
            Text('Ⅱ')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          } else {
            Text('▶')
              .fontSize(16)
              .fontColor(Color.White)
          }

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
        .alignItems(VerticalAlign.Center)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

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