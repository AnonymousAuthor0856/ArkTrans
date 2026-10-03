// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: BeatMakerApp

function emptyPads(): boolean[] {
  return [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
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
    default: return 'SMP ' + (index + 1)
  }
}

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    BeatMakerScreen()
  }
}

// MARK: - Main Screen
@Component
struct BeatMakerScreen {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = emptyPads()

  build() {
    Stack() {
      Column() {
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank().height(20)

        InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        PadGrid({ pads: $pads })
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        ControlSection({
          bpm: $bpm,
          volume: $volume,
          isPlaying: $isPlaying,
          onClear: () => { this.pads = emptyPads() }
        })
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
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
          .fontColor('#808080')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bolder)
          .letterSpacing(-1)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
      }
      .onClick(() => {})
    }
    .width('100%')
  }
}

@Component
struct InfoDisplay {
  bpm: number = 0
  isPlaying: boolean = false

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F5F5F5')
        .borderRadius(4)
        .border({ width: 2, color: '#000000' })

      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')

          Text(Math.round(this.bpm).toString())
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Circle()
          .fill(this.isPlaying ? '#FF5722' : '#808080')
          .width(12)
          .height(12)
          .opacity(this.isPlaying ? 1 : 0.5)
      }
      .padding(16)
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .height(80)
    .width('100%')
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[]
  padIndices: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

  build() {
    Grid() {
      ForEach(this.padIndices, (index: number) => {
        GridItem() {
          DrumPad({
            isActive: this.pads[index],
            onClick: () => { this.pads[index] = !this.pads[index] },
            label: getPadLabel(index)
          })
        }
      }, (index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
  }
}

@Component
struct DrumPad {
  isActive: boolean = false
  onClick: () => void = () => {}
  label: string = ''

  build() {
    Button() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(this.isActive ? '#000000' : '#EEEEEE')
          .borderRadius(8)
          .border({ width: 1, color: this.isActive ? '#000000' : '#E0E0E0' })

        Column({ space: 4 }) {
          if (this.isActive) {
            Circle()
              .fill('#FFFFFF')
              .width(6)
              .height(6)
          }
          Text(this.label)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#FFFFFF' : '#808080')
        }
      }
      .aspectRatio(1)
    }
    .onClick(() => { this.onClick() })
    .width('100%')
  }
}

@Component
struct ControlSection {
  @Link bpm: number
  @Link volume: number
  @Link isPlaying: boolean
  onClear: () => void = () => {}

  build() {
    Column({ space: 24 }) {
      Row({ space: 16 }) {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Slider({ value: this.bpm, min: 60, max: 200, style: SliderStyle.OutSet })
            .selectedColor('#000000')
            .onChange((value: number) => { this.bpm = value })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
          Slider({ value: this.volume, min: 0, max: 1, style: SliderStyle.OutSet })
            .selectedColor('#000000')
            .onChange((value: number) => { this.volume = value })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')

      Row() {
        Button() {
          Row({ space: 8 }) {
            Text('🗑')
              .fontSize(16)
              .fontColor('#808080')
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
          }
          .padding({ left: 24, right: 24 })
          .height(48)
          .alignItems(VerticalAlign.Center)
          .border({ width: 1, color: '#E0E0E0' })
          .borderRadius(24)
        }
        .onClick(() => { this.onClear() })

        Blank()

        Button() {
          Row({ space: 12 }) {
            Text(this.isPlaying ? '⏸' : '▶')
              .fontSize(16)
              .fontColor('#FFFFFF')
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor('#FFFFFF')
          }
          .width(140)
          .height(64)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#000000')
          .borderRadius(32)
        }
        .onClick(() => { this.isPlaying = !this.isPlaying })
      }
      .width('100%')
    }
  }
}
