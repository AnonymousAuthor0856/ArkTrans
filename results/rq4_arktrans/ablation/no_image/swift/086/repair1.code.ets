@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State volume: number = 0.5
  @State isPlaying: boolean = false
  @State pads: boolean[] = new Array(16).fill(false)

  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Column({ space: 0 }) {
              Text('POCKET')
                .letterSpacing(2)
                .fontColor(Color.Gray)
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
              Text('BEATS-909')
                .letterSpacing(-1)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
            }
            Blank()
            Button() {
              Text('Button')
            }.onClick(() => {})
          }

          Blank().height(20)

          Stack() {
            Rect()
              .borderRadius(4)
              .backgroundColor('#F5F5F5')
              .border({ width: 2, color: Color.Black })
            
            Row() {
              Column({ space: 0 }) {
                Text('TEMPO')
                  .fontColor(Color.Gray)
                  .fontSize(10)
                  .fontWeight(FontWeight.Bold)
                Text(`${Math.round(this.bpm)}`)
                  .fontWeight(FontWeight.Medium)
                  .fontSize(32)
                  .fontFamily('monospace')
              }
              Blank()
              Circle()
                .width(12)
                .height(12)
                .fill(this.isPlaying ? '#FF5722' : '#808080')
                .opacity(this.isPlaying ? 1 : 0.5)
            }.padding(16)
          }.height(80)

          Blank().height(24)

          Grid() {
            ForEach(Array.from({ length: 16 }, (_, i: number) => i), (index: number) => {
              GridItem() {
                this.DrumPad({ index: index })
              }
            })
          }
          .columnsTemplate('1fr 1fr 1fr 1fr')
          .columnsGap(12)
          .rowsGap(12)

          Blank().height(24)

          Column({ space: 24 }) {
            Row({ space: 16 }) {
              Column({ space: 0 }) {
                Text('BPM')
                  .fontSize(10)
                  .fontWeight(FontWeight.Bold)
                Slider({ value: this.bpm, min: 60, max: 200 })
                  .selectedColor(Color.Black)
              }
              Column({ space: 0 }) {
                Text('VOL')
                  .fontSize(10)
                  .fontWeight(FontWeight.Bold)
                Slider({ value: this.volume, min: 0, max: 1 })
                  .selectedColor(Color.Black)
              }
            }

            Row() {
              Button() {
                Row({ space: 8 }) {
                  Image($r('app.media.startIcon'))
                    .width(16)
                    .height(16)
                  Text('CLEAR')
                    .fontColor(Color.Black)
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                  Rect()
                    .borderRadius(24)
                    .border({ width: 1, color: '#E0E0E0' })
                }
                .height(48)
                .padding({ left: 24, right: 24 })
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .border({ width: 1, color: '#E0E0E0' })
              }.onClick(() => {
                this.pads.fill(false)
              })

              Blank()

              Button() {
                Row({ space: 12 }) {
                  if (this.isPlaying) {
                    Image($r('app.media.startIcon'))
                      .width(16)
                      .height(16)
                  } else {
                    Image($r('app.media.startIcon'))
                      .width(16)
                      .height(16)
                  }
                  Text(this.isPlaying ? 'STOP' : 'PLAY')
                    .fontColor(Color.White)
                    .letterSpacing(1)
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                }
                .width(140)
                .height(64)
                .justifyContent(FlexAlign.Center)
              }
              .backgroundColor(Color.Black)
              .borderRadius(32)
              .onClick(() => {
                this.isPlaying = !this.isPlaying
              })
            }
          }
        }
      }
    }.width('100%').height('100%')
  }

  @Builder
  DrumPad(params: { index: number }) {
    Column() {
      Text(`${params.index}`)
        .fontSize(10)
        .fontColor(Color.Gray)
    }
    .width('100%')
    .aspectRatio(1)
    .backgroundColor(this.pads[params.index] ? '#FF5722' : '#F5F5F5')
    .borderRadius(8)
    .onClick(() => {
      this.pads[params.index] = !this.pads[params.index]
    })
  }
}