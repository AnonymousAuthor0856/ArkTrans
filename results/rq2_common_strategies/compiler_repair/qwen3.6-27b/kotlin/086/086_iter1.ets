import { router } from '@kit.ArkUI'

@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: Array<boolean> = new Array(16).fill(false)

  build() {
    Column() {
      // Top Header
      this.HeaderSection()

      Spacer().height(20)

      // LCD Display / Info Panel
      this.InfoDisplay()

      Spacer().height(24)

      // The Grid (Drum Pads)
      this.PadGrid()

      Spacer().height(24)

      // Bottom Controls (Sliders and Transport)
      this.ControlSection()
    }
    .width('100%')
    .height('100%')
    .padding({ left: 24, right: 24, top: 50, bottom: 30 }) // Adjusted for safe area simulation
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("POCKET")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)
        
        Text("BEATS-909")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(-1)
      }

      Blank()

      Button('', { type: ButtonType.Circle, stateEffect: false })
        .width(40)
        .height(40)
        .onClick(() => { /* No-op */ })
        .build() {
          Image($r('app.media.settings_icon')) // Placeholder for Settings Icon
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column() {
        Text("TEMPO")
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        
        Text(`${this.bpm}`)
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontFamily('monospace')
      }

      Blank()

      Circle({ width: 12, height: 12 })
        .fill(this.isPlaying ? Color.Red : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .borderRadius(4)
    .border({ width: 2, color: Color.Black })
    .backgroundColor('#F5F5F5')
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PadGrid() {
    GridContainer() {
      ForEach(this.pads, (isActive: boolean, index: number) => {
        GridItem() {
          this.DrumPad(index)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .gaps({ row: 12, column: 12 })
    .width('100%')
    .aspectRatio(1)
  }

  @Builder
  DrumPad(index: number) {
    Column() {
      if (this.pads[index]) {
        Circle({ width: 6, height: 6 })
          .fill(Color.White)
        Spacer().height(4)
      }

      Text(this.getPadLabel(index))
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.pads[index] ? Color.White : Color.Gray)
    }
    .width('100%')
    .aspectRatio(1)
    .borderRadius(8)
    .backgroundColor(this.pads[index] ? Color.Black : '#EEEEEE')
    .border({ width: 1, color: this.pads[index] ? Color.Black : '#E0E0E0', radius: 8 })
    .onClick(() => {
      this.pads[index] = !this.pads[index]
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ControlSection() {
    Column() {
      // Sliders Row
      Row() {
        Column() {
          Text("BPM")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.bpm, min: 60, max: 200 })
            .width('100%')
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .blockColor(Color.Black)
            .onChange((value: number) => {
              this.bpm = Math.round(value)
            })
        }
        .layoutWeight(1)

        Column() {
          Text("VOL")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
          
          Slider({ value: this.volume * 100, min: 0, max: 100 })
            .width('100%')
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .blockColor(Color.Black)
            .onChange((value: number) => {
              this.volume = value / 100
            })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 24 })
      .justifyContent(FlexAlign.SpaceBetween)

      // Transport Buttons
      Row() {
        // Clear Button
        Button("CLEAR", { type: ButtonType.Capsule, stateEffect: false })
          .width(100)
          .height(48)
          .backgroundColor(Color.Transparent)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .fontSize(12)
          .onClick(() => {
            this.pads = new Array(16).fill(false)
          })

        Blank()

        // Play Button (Large)
        Button(this.isPlaying ? "STOP" : "PLAY", { type: ButtonType.Capsule, stateEffect: false })
          .width(140)
          .height(64)
          .backgroundColor(Color.Black)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .fontSize(14)
          .letterSpacing(1)
          .onClick(() => {
            this.isPlaying = !this.isPlaying
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
  }

  getPadLabel(index: number): string {
    const labels: Array<string> = [
      "KICK", "SNARE", "CLAP", "HI-HAT",
      "TOM 1", "TOM 2", "CRASH", "RIDE",
      "PERC 1", "PERC 2", "FX 1", "FX 2",
      "SMP 13", "SMP 14", "SMP 15", "SMP 16"
    ]
    return labels[index] || `SMP ${index + 1}`
  }
}