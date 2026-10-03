@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State volume: number = 50
  @State isPlaying: boolean = false
  @State pads: boolean[] = [false, false, false, false, false, false, false, false]

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        // HeaderSection
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
              .letterSpacing(-1)
          }
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(100)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')

        Blank().height(20)

        // InfoDisplay
        Stack({ alignContent: Alignment.Center }) {
          Row() {
            Column() {
              Text('TEMPO')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Gray)
              Text(`${Math.floor(this.bpm)}`)
                .fontSize(32)
                .fontWeight(FontWeight.Medium)
                .fontFamily('monospace')
            }
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 12, height: 12 })
                .fill(this.isPlaying ? Color.Red : '#D3D3D3')
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height('100%')
        }
        .width('100%')
        .height(80)
        .backgroundColor('#F5F5F5')
        .padding(16)
        .border({ width: 2, color: Color.Black, radius: 4 })

        Blank().height(24)

        // PadGrid
        Grid() {
          ForEach(this.pads.map((_, i) => i), (index: number) => {
            GridItem() {
              Stack({ alignContent: Alignment.Center }) {
                Column() {
                  Circle({ width: 6, height: 6 })
                    .fill(this.pads[index] ? Color.White : Color.Gray)
                  Blank().height(4)
                  Text(`P${index + 1}`)
                    .fontSize(10)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.pads[index] ? Color.White : Color.Gray)
                }
                .alignItems(HorizontalAlign.Center)
              }
              .aspectRatio(1)
              .backgroundColor(this.pads[index] ? Color.Black : '#EEEEEE')
              .border({ width: 1, color: this.pads[index] ? Color.Black : '#E0E0E0', radius: 8 })
              .onClick(() => {
                this.pads[index] = !this.pads[index]
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr 1fr 1fr')
        .columnsGap(12)
        .rowsGap(12)
        .width('100%')

        Blank().height(24)

        // ControlSection
        Column() {
          Row() {
            Column() {
              Text('BPM')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
              Slider({ value: this.bpm, min: 60, max: 200 })
                .onChange((value: number) => {
                  this.bpm = value
                })
            }
            .layoutWeight(1)

            Column() {
              Text('VOL')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
              Slider({ value: this.volume, min: 0, max: 100 })
                .onChange((value: number) => {
                  this.volume = value
                })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().height(24)

          Row() {
            // CLEAR Button
            Stack({ alignContent: Alignment.Center }) {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(16)
                  .height(16)
                  .fillColor(Color.Gray)
                Blank().width(8)
                Text('CLEAR')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Black)
              }
              .alignItems(VerticalAlign.Center)
            }
            .height(48)
            .padding({ left: 24, right: 24 })
            .border({ width: 1, color: '#E0E0E0', radius: 24 })
            .onClick(() => {
              for (let i = 0; i < this.pads.length; i++) {
                this.pads[i] = false
              }
            })

            // PLAY/STOP Button
            Stack({ alignContent: Alignment.Center }) {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(16)
                  .height(16)
                  .fillColor(Color.White)
                Blank().width(12)
                Text(this.isPlaying ? 'STOP' : 'PLAY')
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                  .letterSpacing(1)
              }
              .alignItems(VerticalAlign.Center)
            }
            .height(64)
            .width(140)
            .backgroundColor(Color.Black)
            .borderRadius(32)
            .onClick(() => {
              this.isPlaying = !this.isPlaying
            })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
  }
}