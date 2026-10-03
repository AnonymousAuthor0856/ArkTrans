@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State padStates: boolean[] = new Array(16).fill(false)

  getPadLabel(index: number): string {
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

  togglePad(index: number) {
    let newStates = [...this.padStates]
    newStates[index] = !newStates[index]
    this.padStates = newStates
  }

  clearPads() {
    this.padStates = new Array(16).fill(false)
  }

  build() {
    Column({ space: 0 }) {
      // Header
      Row() {
        Column({ space: 2 }) {
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
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Black)
          .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(20)

      // Info Display
      Row() {
        Column({ space: 2 }) {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
          Text(`${Math.floor(this.bpm)}`)
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontFamily('monospace')
        }
        .alignItems(HorizontalAlign.Start)

        Circle({ width: 12, height: 12 })
          .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
      }
      .width('100%')
      .height(80)
      .border({ width: 2, color: Color.Black, radius: 4 })
      .backgroundColor('#F5F5F5')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(24)

      // Pad Grid
      Grid() {
        ForEach(this.padStates, (isActive: boolean, index: number) => {
          GridItem() {
            Column({ space: 4 }) {
              if (isActive) {
                Circle({ width: 6, height: 6 })
                  .fill(Color.White)
              }
              Text(this.getPadLabel(index))
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(isActive ? Color.White : Color.Gray)
            }
            .width('100%')
            .aspectRatio(1)
            .backgroundColor(isActive ? Color.Black : '#EEEEEE')
            .borderRadius(8)
            .border({ width: 1, color: isActive ? Color.Black : '#E0E0E0', radius: 8 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => {
              this.togglePad(index)
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .width('100%')
      .layoutWeight(1)

      Blank().height(24)

      // Control Section
      Column({ space: 0 }) {
        // Sliders Row
        Row({ space: 16 }) {
          Column({ space: 4 }) {
            Text('BPM')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
            Slider({
              value: this.bpm,
              min: 60,
              max: 200,
              style: SliderStyle.OutSet
            })
              .trackColor('#E0E0E0')
              .selectedColor(Color.Black)
              .blockColor(Color.Black)
              .onChange((value: number) => {
                this.bpm = value
              })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Column({ space: 4 }) {
            Text('VOL')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
            Slider({
              value: this.volume * 100,
              min: 0,
              max: 100,
              style: SliderStyle.OutSet
            })
              .trackColor('#E0E0E0')
              .selectedColor(Color.Black)
              .blockColor(Color.Black)
              .onChange((value: number) => {
                this.volume = value / 100
              })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')

        Blank().height(24)

        // Transport Buttons
        Row() {
          // Clear Button
          Row({ space: 8 }) {
            Text('🗑')
              .fontSize(14)
              .fontColor(Color.Gray)
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
          }
          .height(48)
          .padding({ left: 24, right: 24 })
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            this.clearPads()
          })

          // Play Button
          Row({ space: 12 }) {
            Text(this.isPlaying ? '⏸' : '▶')
              .fontSize(16)
              .fontColor(Color.White)
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
          }
          .height(64)
          .width(140)
          .backgroundColor(Color.Black)
          .borderRadius(32)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
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
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}