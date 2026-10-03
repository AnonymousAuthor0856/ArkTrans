@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State volume: number = 0.8
  @State isPlaying: boolean = false
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Column({ space: 0 }) {
            Text('POCKET').fontColor('#999999').fontSize(14).fontWeight(FontWeight.Bold)
            Text('BEATS-909').fontSize(28).fontWeight(FontWeight.Bold)
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent)
        }
        
        Blank().height(20)
        
        Stack() {
          Rect().borderRadius(4).backgroundColor('#F5F5F5').border({ width: 2, color: Color.Black })
          
          Row() {
            Column({ space: 0 }) {
              Text('TEMPO').fontColor('#999999').fontSize(10).fontWeight(FontWeight.Bold)
              Text(`${this.bpm}`).fontWeight(FontWeight.Medium).fontSize(32).fontFamily('monospace')
            }
            Blank()
            Circle().width(12).height(12).fill(this.isPlaying ? '#FF5733' : '#CCCCCC')
          }.padding(16)
        }.height(80)
        
        Blank().height(24)
        
        Grid() {
          ForEach(Array.from({ length: 16 }, (_, i: number) => i), (index: number) => {
            GridItem() {
              this.DrumPad({ index: index })
            }
          })
        }.columnsTemplate('1fr 1fr 1fr 1fr').rowsGap(12).columnsGap(12)
        
        Blank().height(24)
        
        Column({ space: 24 }) {
          Row({ space: 16 }) {
            Column({ space: 0 }) {
              Text('BPM').fontSize(10).fontWeight(FontWeight.Bold)
              Slider({ value: this.bpm, min: 60, max: 200 }).selectedColor(Color.Black).trackColor('#E0E0E0')
            }
            Column({ space: 0 }) {
              Text('VOL').fontSize(10).fontWeight(FontWeight.Bold)
              Slider({ value: this.volume, min: 0, max: 1 }).selectedColor(Color.Black).trackColor('#E0E0E0')
            }
          }
          
          Row() {
            Button() {
              Row({ space: 8 }) {
                Image($r('app.media.startIcon')).width(16).height(16)
                Text('CLEAR').fontColor(Color.Black).fontSize(12).fontWeight(FontWeight.Bold)
              }.padding({ left: 24, right: 24 }).height(48)
            }.backgroundColor(Color.Transparent).borderRadius(24).border({ width: 1, color: '#E0E0E0' })
            
            Blank()
            
            Button() {
              Row({ space: 12 }) {
                if (this.isPlaying) {
                  Image($r('app.media.startIcon')).width(16).height(16)
                } else {
                  Image($r('app.media.startIcon')).width(16).height(16)
                }
                Text(this.isPlaying ? 'STOP' : 'PLAY').fontColor(Color.White).fontSize(12).fontWeight(FontWeight.Bold)
              }.width(140).height(64)
            }.backgroundColor(Color.Black).borderRadius(32)
          }
        }
      }
    }.width('100%').height('100%')
  }
  
  @Builder
  DrumPad(params: { index: number }) {
    Button() {
      Text(this.getPadLabel(params.index)).fontColor(this.pads[params.index] ? Color.White : '#999999').fontSize(14).fontWeight(FontWeight.Bold)
    }
    .backgroundColor(this.pads[params.index] ? '#FF5733' : '#F0F0F0')
    .borderRadius(12)
    .onClick(() => {
      this.pads[params.index] = !this.pads[params.index]
    })
  }
  
  getPadLabel(index: number): string {
    const labels = ['KICK', 'SNARE', 'CLAP', 'HI-HAT', 'TOM 1', 'TOM 2', 'CRASH', 'RIDE', 'PERC 1', 'PERC 2', 'FX 1', 'FX 2', 'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16']
    return labels[index] || ''
  }
}