@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = new Array<boolean>(16).fill(false)

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // === Header Section ===
        Row() {
          Column() {
            Text('POCKET').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#999999').letterSpacing(2)
            Text('BEATS-909').fontSize(28).fontWeight(FontWeight.Black).letterSpacing(-1)
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent)
        }.width('100%')
        .padding({ top: 24, left: 24, right: 24 })

        // Spacer 20
        Blank().height(20)

        // === Info Display ===
        Column() {
          Row() {
            Column() {
              Text('TEMPO').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#999999')
              Text(`${Math.round(this.bpm)}`).fontSize(32).fontWeight(FontWeight.Medium).fontFamily('monospace')
            }
            Blank()
            Circle().width(12).height(12).fill(this.isPlaying ? '#FF5722' : '#99999999')
          }.padding(16)
        }.width('100%').height(80).borderRadius(4).border({ width: 2, color: '#000000' }).backgroundColor('#F5F5F5')
        .margin({ left: 24, right: 24 })

        // Spacer 24
        Blank().height(24)

        // === Pad Grid ===
        Grid() {
          ForEach(Array.from({ length: 16 }, (_, i: number) => i), (index: number) => {
            GridItem() {
              this.DrumPad(index)
            }
          })
        }.columnsTemplate('1fr 1fr 1fr 1fr').rowsGap(12).columnsGap(12).width('100%')
        .margin({ left: 24, right: 24 })

        // Spacer 24
        Blank().height(24)

        // === Control Section ===
        Column() {
          // Sliders Row
          Row() {
            Column() {
              Text('BPM').fontSize(10).fontWeight(FontWeight.Bold)
              Slider({ value: this.bpm, min: 60, max: 200 }).width('100%')
            }.layoutWeight(1)
            
            Column() {
              Text('VOL').fontSize(10).fontWeight(FontWeight.Bold)
              Slider({ value: this.volume, min: 0, max: 1 }).width('100%')
            }.layoutWeight(1)
          }.width('100%').margin({ bottom: 24 })

          // Transport Buttons Row
          Row() {
            // Clear Button
            Button() {
              Row() {
                Image($r('app.media.startIcon')).width(16).height(16)
                Text('CLEAR').fontSize(12).fontWeight(FontWeight.Bold).margin({ left: 8 })
              }
            }.width('100%').height(48).borderRadius(24).border({ width: 1, color: '#E0E0E0' }).backgroundColor(Color.Transparent)
            .onClick(() => {
              this.pads = new Array<boolean>(16).fill(false)
            })

            Blank()

            // Play Button
            Button() {
              Row() {
                Image($r('app.media.startIcon')).width(16).height(16)
                Text(this.isPlaying ? 'STOP' : 'PLAY').fontSize(12).fontWeight(FontWeight.Bold).letterSpacing(1).margin({ left: 12 })
              }
            }.width(140).height(64).borderRadius(32).backgroundColor('#000000')
            .onClick(() => {
              this.isPlaying = !this.isPlaying
            })
          }.width('100%')
        }.width('100%')
        .margin({ left: 24, right: 24, bottom: 24 })
      }.width('100%').height('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%')
  }

  @Builder
  DrumPad(index: number) {
    Button() {
      Column() {
        if (this.pads[index]) {
          Circle().width(6).height(6).fill('#FFFFFF')
        }
        Text(this.getPadLabel(index)).fontSize(10).fontWeight(FontWeight.Bold).fontColor(this.pads[index] ? '#FFFFFF' : '#999999').margin({ top: 4 })
      }
    }.aspectRatio(1).borderRadius(8)
    .backgroundColor(this.pads[index] ? '#000000' : '#EEEEEE')
    .border({ width: 1, color: this.pads[index] ? '#000000' : '#E0E0E0', radius: 8 })
    .onClick(() => {
      this.pads[index] = !this.pads[index]
    })
  }

  getPadLabel(index: number): string {
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
}