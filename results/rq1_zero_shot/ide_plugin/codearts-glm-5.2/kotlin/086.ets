@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State padStates: boolean[] = [
    false, false, false, false,
    false, false, false, false,
    false, false, false, false,
    false, false, false, false
  ]

  getPadLabel(index: number): string {
    const labels: string[] = ['KICK', 'SNARE', 'CLAP', 'HI-HAT', 'TOM 1', 'TOM 2', 'CRASH', 'RIDE', 'PERC 1', 'PERC 2', 'FX 1', 'FX 2']
    if (index < 12) {
      return labels[index]
    }
    return `SMP ${index + 1}`
  }

  clearPads() {
    this.padStates = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
  }

  togglePad(index: number) {
    const newPads = [...this.padStates]
    newPads[index] = !newPads[index]
    this.padStates = newPads
  }

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text('POCKET')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#9E9E9E')
            .letterSpacing(2)
          Text('BEATS-909')
            .fontSize(28)
            .fontWeight(FontWeight.Black)
            .letterSpacing(-1)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Info Display
      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#9E9E9E')
          Text(`${Math.floor(this.bpm)}`)
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
        Circle({ width: 12, height: 12 })
          .fill(this.isPlaying ? '#FF5722' : '#BDBDBD')
      }
      .width('100%')
      .height(80)
      .border({ width: 2, color: '#000000', radius: 4 })
      .backgroundColor('#F5F5F5')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 20 })

      // Pad Grid
      Grid() {
        ForEach(this.padStates, (isActive: boolean, index: number) => {
          GridItem() {
            Column() {
              if (isActive) {
                Circle({ width: 6, height: 6 })
                  .fill('#FFFFFF')
                  .margin({ bottom: 4 })
              }
              Text(this.getPadLabel(index))
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(isActive ? '#FFFFFF' : '#9E9E9E')
            }
            .width('100%')
            .aspectRatio(1)
            .borderRadius(8)
            .backgroundColor(isActive ? '#000000' : '#EEEEEE')
            .border({ width: 1, color: isActive ? '#000000' : '#E0E0E0', radius: 8 })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => this.togglePad(index))
          }
        }, (isActive: boolean, index: number) => `${index}-${isActive}`)
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .width('100%')
      .margin({ top: 24 })
      .height(280)

      // Control Section
      Column() {
        // Sliders Row
        Row() {
          Column() {
            Text('BPM')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
            Slider({
              value: this.bpm,
              min: 60,
              max: 200,
              step: 1,
              style: SliderStyle.OutSet
            })
              .blockColor('#000000')
              .selectedColor('#000000')
              .trackColor('#E0E0E0')
              .onChange((value: number) => this.bpm = value)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)

          Column() {
            Text('VOL')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
            Slider({
              value: this.volume,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .blockColor('#000000')
              .selectedColor('#000000')
              .trackColor('#E0E0E0')
              .onChange((value: number) => this.volume = value)
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .margin({ top: 24 })

        // Transport Buttons
        Row() {
          // Clear Button
          Row() {
            Text('🗑')
              .fontSize(16)
              .fontColor('#9E9E9E')
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ left: 8 })
          }
          .height(48)
          .border({ width: 1, color: '#E0E0E0', radius: 24 })
          .borderRadius(24)
          .padding({ left: 24, right: 24 })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => this.clearPads())

          Blank()

          // Play Button
          Row() {
            Text(this.isPlaying ? '⏸' : '▶')
              .fontSize(16)
              .fontColor('#FFFFFF')
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .height(64)
          .width(140)
          .borderRadius(32)
          .backgroundColor('#000000')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => this.isPlaying = !this.isPlaying)
        }
        .width('100%')
        .margin({ top: 24 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}