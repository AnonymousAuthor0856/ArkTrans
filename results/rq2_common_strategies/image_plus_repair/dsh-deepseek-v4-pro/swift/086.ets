// BeatMakerApp - App entry point (SwiftUI @main App -> ArkUI @Entry @Component)
@Entry
@Component
struct BeatMakerApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    BeatMakerScreen()
    // .preferredColorScheme(.light) -> light color scheme (no direct ArkUI equivalent)
    // .statusBarHidden(true) -> status bar hidden (no direct ArkUI equivalent)
  }
}

// MARK: - Main Screen
@Component
struct BeatMakerScreen {
  // Pure UI State
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = new Array<boolean>(16).fill(false)

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Header
        HeaderSection()
          .padding({ top: 24, left: 24, right: 24 })

        Blank().height(20)

        // LCD Display / Info Panel
        InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        // The Grid (Drum Pads)
        PadGrid({ pads: $pads })
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        // Bottom Controls
        ControlSection({
          bpm: $bpm,
          volume: $volume,
          isPlaying: $isPlaying,
          onClear: () => { this.pads = new Array<boolean>(16).fill(false) }
        })
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
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
      Column({ space: 0 }) {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
          .letterSpacing(2)

        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bolder)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
      }
      .backgroundColor(Color.Transparent)
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
      Row() {
        Column({ space: 0 }) {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')

          Text(`${Math.floor(this.bpm)}`)
            .fontSize(32)
            .fontFamily('monospace')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Circle()
          .fill(this.isPlaying ? '#FF5722' : '#808080') // Orange #FF5722
          .opacity(this.isPlaying ? 1.0 : 0.5)
          .width(12)
          .height(12)
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .width('100%')
    .height(80)
    .backgroundColor('#F5F5F5') // #F5F5F5
    .border({ width: 2, color: '#000000' })
    .borderRadius(4)
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[]
  private padIndices: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]

  build() {
    Grid() {
      ForEach(this.padIndices, (index: number) => {
        GridItem() {
          DrumPad({
            isActive: this.pads[index],
            onPressed: () => { this.pads[index] = !this.pads[index] },
            label: getPadLabel(index)
          })
        }
      }, (index: number) => index.toString())
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
  onPressed: () => void = () => {}
  label: string = ''

  build() {
    Button() {
      Stack() {
        Rect({ radius: 8 })
          .width('100%')
          .height('100%')
          .fill(this.isActive ? '#000000' : '#EEEEEE') // #EEEEEE

        Rect({ radius: 8 })
          .width('100%')
          .height('100%')
          .stroke(this.isActive ? '#000000' : '#E0E0E0') // #E0E0E0
          .strokeWidth(1)

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
      .width('100%')
      .aspectRatio(1)
    }
    .width('100%')
    .backgroundColor(Color.Transparent)
    .onClick(() => { this.onPressed() })
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
      // Sliders Row
      Row({ space: 16 }) {
        // BPM Slider Column
        Column({ space: 0 }) {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)

          Slider({ value: this.bpm, min: 60, max: 200 })
            .selectedColor('#000000')
            .onChange((value: number) => { this.bpm = value })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // VOL Slider Column
        Column({ space: 0 }) {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)

          Slider({ value: this.volume, min: 0, max: 1 })
            .selectedColor('#000000')
            .onChange((value: number) => { this.volume = value })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')

      // Transport Buttons Row
      Row() {
        // Clear Button
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
          .height(48)
        }
        .padding({ left: 24, right: 24 })
        .height(48)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: '#E0E0E0' }) // #E0E0E0
        .borderRadius(24)
        .onClick(() => { this.onClear() })

        Blank()

        // Play Button
        Button() {
          Row({ space: 12 }) {
            if (this.isPlaying) {
              Text('⏸')
                .fontSize(16)
                .fontColor('#FFFFFF')
            } else {
              Text('▶')
                .fontSize(16)
                .fontColor('#FFFFFF')
            }

            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor('#FFFFFF')
          }
          .width(140)
          .height(64)
        }
        .width(140)
        .height(64)
        .backgroundColor('#000000')
        .borderRadius(32)
        .onClick(() => { this.isPlaying = !this.isPlaying })
      }
      .width('100%')
    }
    .width('100%')
  }
}

// MARK: - Helpers

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
