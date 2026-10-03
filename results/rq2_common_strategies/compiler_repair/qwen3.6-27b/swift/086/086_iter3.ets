import { window } from '@kit.ArkUI'

@Entry
@Component
struct BeatMakerApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct ContentView {
  build() {
    Column() {
      BeatMakerScreen()
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarContentColor: '#000000' })
    .systemStatusBarHeight(0) // Simulating hidden status bar effect by pushing content down if needed, or just standard behavior
  }
}

@Component
struct BeatMakerScreen {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = Array<boolean>(16).fill(false)

  build() {
    Column() {
      HeaderSection()
        .padding({ top: 24, left: 24, right: 24 })

      Divider().margin({ top: 20, bottom: 20 }).color('#00000000')

      InfoDisplay({ bpm: this.bpm, isPlaying: this.isPlaying })
        .padding({ left: 24, right: 24 })

      Divider().margin({ top: 24, bottom: 24 }).color('#00000000')

      PadGrid({ pads: $pads })
        .padding({ left: 24, right: 24 })

      Divider().margin({ top: 24, bottom: 24 }).color('#00000000')

      ControlSection({
        bpm: $bpm,
        volume: $volume,
        isPlaying: $isPlaying,
        onClear: () => {
          this.pads = Array<boolean>(16).fill(false)
        }
      })
        .padding({ left: 24, right: 24, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("POCKET")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
          .letterSpacing(2)
        
        Text("BEATS-909")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('app.media.settings')) // Placeholder for gear icon, using system image if available or placeholder
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .type(ButtonType.Normal)
      .backgroundColor('#00000000')
    }
    .width('100%')
  }
}

@Component
struct InfoDisplay {
  bpm: number = 0
  isPlaying: boolean = false

  build() {
    Row() {
      Column() {
        Text("TEMPO")
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        
        Text(`${Math.round(this.bpm)}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontFamily('monospace')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle()
        .width(12)
        .height(12)
        .fill(this.isPlaying ? '#FF0000' : '#808080')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .border({ width: 2, color: '#000000' })
    .backgroundColor('#F5F5F5')
    .borderRadius(4)
  }
}

@Component
struct PadGrid {
  @Link pads: boolean[]

  build() {
    Grid() {
      ForEach(Array<number>.from({ length: 16 }, (_, i: number) => i), (index: number) => {
        GridItem() {
          DrumPad({
            isActive: this.pads[index],
            onClick: () => {
              this.pads[index] = !this.pads[index]
            },
            label: getPadLabel(index)
          })
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .width('100%')
    .aspectRatio(1)
  }
}

@Component
struct DrumPad {
  isActive: boolean = false
  onClick: () => void = () => {}
  label: string = ""

  build() {
    Button() {
      Column() {
        if (this.isActive) {
          Circle()
            .width(6)
            .height(6)
            .fill('#FFFFFF')
            .margin({ bottom: 4 })
        }
        
        Text(this.label)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isActive ? '#FFFFFF' : '#808080')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.isActive ? '#000000' : '#EEEEEE')
    .border({ width: 1, color: this.isActive ? '#000000' : '#E0E0E0' })
    .borderRadius(8)
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
  onClear: () => void = () => {}

  build() {
    Column() {
      Row() {
        Column() {
          Text("BPM")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.bpm, min: 60, max: 200, step: 1 })
            .width('100%')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
            .blockColor('#000000')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Column() {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.volume, min: 0, max: 1, step: 0.01 })
            .width('100%')
            .selectedColor('#000000')
            .trackColor('#E0E0E0')
            .blockColor('#000000')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 24 })

      Row() {
        Button() {
          Row() {
            Image($r('app.media.trash')) // Placeholder for trash icon
              .width(16)
              .height(16)
              .fillColor('#808080')
            
            Text("CLEAR")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#00000000')
        .border({ width: 1, color: '#E0E0E0' })
        .borderRadius(24)
        .height(48)
        .padding({ left: 24, right: 24 })
        .onClick(() => {
          this.onClear()
        })

        Blank()

        Button() {
          Row() {
            if (this.isPlaying) {
              Image($r('app.media.pause')) // Placeholder for pause icon
                .width(16)
                .height(16)
                .fillColor('#FFFFFF')
            } else {
              Image($r('app.media.play')) // Placeholder for play icon
                .width(16)
                .height(16)
                .fillColor('#FFFFFF')
            }
            
            Text(this.isPlaying ? "STOP" : "PLAY")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#000000')
        .borderRadius(32)
        .width(140)
        .height(64)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
    }
  }
}

function getPadLabel(index: number): string {
  switch (index) {
    case 0: return "KICK"
    case 1: return "SNARE"
    case 2: return "CLAP"
    case 3: return "HI-HAT"
    case 4: return "TOM 1"
    case 5: return "TOM 2"
    case 6: return "CRASH"
    case 7: return "RIDE"
    case 8: return "PERC 1"
    case 9: return "PERC 2"
    case 10: return "FX 1"
    case 11: return "FX 2"
    default: return `SMP ${index + 1}`
  }
}