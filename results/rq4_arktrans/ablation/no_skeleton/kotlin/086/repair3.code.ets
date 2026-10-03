@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 80
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

  build() {
    Column() {
      // === Header Section ===
      Row() {
        Column() {
          Text('POCKET')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#999999')
            .letterSpacing(2)
          Text('BEATS-909')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-1)
        }
        Blank()
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })

      // === Info Display ===
      Column() {
        Row() {
          Column() {
            Text('TEMPO')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor('#999999')
            Text(`${this.bpm}`)
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontFamily('monospace')
          }
          Blank()
          Circle({ width: 12, height: 12 })
            .fill(this.isPlaying ? '#FF5722' : '#CCCCCC')
        }
        .width('100%')
      }
      .width('100%')
      .height(80)
      .border({ width: 2, color: '#000000', radius: 4 })
      .backgroundColor('#F5F5F5')
      .padding(16)
      .margin({ top: 20, left: 24, right: 24 })

      // === Pad Grid ===
      Grid() {
        ForEach(this.pads.map((_, i) => i), (index: number) => {
          GridItem() {
            Column() {
              if (this.pads[index]) {
                Circle({ width: 6, height: 6 })
                  .fill('#FFFFFF')
                Blank().height(4)
              }
              Text(this.getPadLabel(index))
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.pads[index] ? '#FFFFFF' : '#999999')
            }
            .width('100%')
            .aspectRatio(1)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(this.pads[index] ? '#000000' : '#EEEEEE')
            .border({ width: 1, color: this.pads[index] ? '#000000' : '#E0E0E0', radius: 8 })
            .borderRadius(8)
            .onClick(() => {
              this.pads[index] = !this.pads[index]
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(12)
      .columnsGap(12)
      .width('100%')
      .margin({ top: 24, left: 24, right: 24 })

      // === Control Section ===
      Column() {
        // Sliders
        Row() {
          Column() {
            Text('BPM')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
            Slider({ value: this.bpm, min: 60, max: 200 })
              .width('100%')
              .selectedColor('#000000')
              .trackColor('#E0E0E0')
              .blockColor('#000000')
          }
          .layoutWeight(1)

          Column() {
            Text('VOL')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
            Slider({ value: this.volume, min: 0, max: 100 })
              .width('100%')
              .selectedColor('#000000')
              .trackColor('#E0E0E0')
              .blockColor('#000000')
          }
          .layoutWeight(1)
        }
        .width('100%')
        .margin({ top: 24 })

        // Transport Buttons
        Row() {
          // Clear Button
          Row() {
            Image($r('app.media.startIcon'))
              .width(16)
              .height(16)
              .objectFit(ImageFit.Contain)
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ left: 8 })
          }
          .height(48)
          .padding({ left: 24, right: 24 })
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .borderRadius(24)
          .onClick(() => {
            for (let i = 0; i < 16; i++) {
              this.pads[i] = false
            }
          })

          Blank()

          // Play/Stop Button
          Row() {
            if (this.isPlaying) {
              // Pause Icon (Two bars)
              Row() {
                Rect({ width: 5, height: 16 }).fill('#FFFFFF')
                Rect({ width: 5, height: 16 }).fill('#FFFFFF').margin({ left: 6 })
              }
            } else {
              // Play Icon (Triangle)
              Path({ pathData: 'M 0 0 L 16 8 L 0 16 Z' })
                .width(16)
                .height(16)
                .fill('#FFFFFF')
            }
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .height(64)
          .width(140)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .backgroundColor('#000000')
          .borderRadius(32)
          .onClick(() => {
            this.isPlaying = !this.isPlaying
          })
        }
        .width('100%')
        .margin({ top: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  getPadLabel(index: number): string {
    const labels = ['KICK', 'SNARE', 'CLAP', 'HI-HAT', 'TOM 1', 'TOM 2', 'CRASH', 'RIDE', 'PERC 1', 'PERC 2', 'FX 1', 'FX 2', 'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16']
    return labels[index] || `SMP ${index + 1}`
  }
}