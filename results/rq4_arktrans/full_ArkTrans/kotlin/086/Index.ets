@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State volume: number = 80
  @State isPlaying: boolean = false
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Header Section
        Row() {
          Column() {
            Text('POCKET')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#9E9E9E')
              .letterSpacing(2)
            
            Text('BEATS-909')
              .fontSize(28)
              .fontWeight(FontWeight.Bolder)
              .letterSpacing(-1)
              .fontColor('#000000')
          }
          
          Blank()
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#000000')
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Blank().height(20)

        // Info Display (Tempo)
        Stack({ alignContent: Alignment.Center }) {
          Row() {
            Column() {
              Text('TEMPO')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#9E9E9E')
              
              Text(`${this.bpm}`)
                .fontSize(32)
                .fontWeight(FontWeight.Medium)
                .fontFamily('monospace')
                .fontColor('#000000')
            }
            
            Blank()
            
            Circle({ width: 12, height: 12 })
              .fill(this.isPlaying ? '#FF5722' : '#CCCCCC')
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .border({ width: 2, color: '#000000', radius: 4 })
        .padding(16)

        Blank().height(24)

        // Pad Grid
        Grid() {
          ForEach(this.pads.map((_, i) => i), (index: number) => {
            GridItem() {
              Stack({ alignContent: Alignment.Center }) {
                Column() {
                  Circle({ width: 6, height: 6 })
                    .fill(this.pads[index] ? '#FFFFFF' : '#9E9E9E')
                  
                  Blank().height(4)
                  
                  Text(this.getPadLabel(index))
                    .fontSize(10)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.pads[index] ? '#FFFFFF' : '#9E9E9E')
                }
                .alignItems(HorizontalAlign.Center)
              }
              .aspectRatio(1)
              .borderRadius(8)
              .backgroundColor(this.pads[index] ? '#000000' : '#EEEEEE')
              .border({ width: 1, color: this.pads[index] ? '#000000' : '#E0E0E0', radius: 8 })
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

        Blank().height(24)

        // Control Section
        Column() {
          Row() {
            Column() {
              Text('BPM')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Slider({ value: this.bpm, min: 60, max: 200 })
                .width('100%')
                .trackColor('#E0E0E0')
                .selectedColor('#000000')
                .onChange((value: number) => {
                  this.bpm = Math.round(value)
                })
            }
            .layoutWeight(1)
            
            Column() {
              Text('VOL')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              
              Slider({ value: this.volume, min: 0, max: 100 })
                .width('100%')
                .trackColor('#E0E0E0')
                .selectedColor('#000000')
                .onChange((value: number) => {
                  this.volume = Math.round(value)
                })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(24)

          Row() {
            // Clear Button
            Button() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(16)
                  .height(16)
                  .fillColor('#9E9E9E')
                
                Blank().width(8)
                
                Text('CLEAR')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#000000')
              }
              .alignItems(VerticalAlign.Center)
            }
            .height(48)
            .borderRadius(24)
            .border({ width: 1, color: '#E0E0E0', radius: 24 })
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              for (let i = 0; i < this.pads.length; i++) {
                this.pads[i] = false
              }
            })

            Blank()

            // Play/Stop Button
            Button() {
              Row() {
                if (this.isPlaying) {
                  // Stop Icon (Square)
                  Rect({ width: 16, height: 16 })
                    .fill('#FFFFFF')
                } else {
                  // Play Icon (Triangle)
                  Path({ commands: 'M 0 0 L 16 8 L 0 16 Z' })
                    .fill('#FFFFFF')
                }
                
                Blank().width(12)
                
                Text(this.isPlaying ? 'STOP' : 'PLAY')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .letterSpacing(1)
              }
              .alignItems(VerticalAlign.Center)
            }
            .height(64)
            .width(140)
            .borderRadius(32)
            .backgroundColor('#000000')
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
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }

  getPadLabel(index: number): string {
    const labels = [
      'KICK', 'SNARE', 'CLAP', 'HI-HAT',
      'TOM 1', 'TOM 2', 'CRASH', 'RIDE',
      'PERC 1', 'PERC 2', 'FX 1', 'FX 2',
      'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16'
    ]
    return labels[index] || ''
  }
}