class PadLabel {
  name: string

  constructor(name: string) {
    this.name = name
  }
}

@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State volume: number = 0.8
  @State isPlaying: boolean = false
  @State p0: boolean = false
  @State p1: boolean = false
  @State p2: boolean = false
  @State p3: boolean = false
  @State p4: boolean = false
  @State p5: boolean = false
  @State p6: boolean = false
  @State p7: boolean = false
  @State p8: boolean = false
  @State p9: boolean = false
  @State p10: boolean = false
  @State p11: boolean = false
  @State p12: boolean = false
  @State p13: boolean = false
  @State p14: boolean = false
  @State p15: boolean = false

  private labels: PadLabel[] = [
    new PadLabel('KICK'), new PadLabel('SNARE'), new PadLabel('CLAP'), new PadLabel('HI-HAT'),
    new PadLabel('TOM 1'), new PadLabel('TOM 2'), new PadLabel('CRASH'), new PadLabel('RIDE'),
    new PadLabel('PERC 1'), new PadLabel('PERC 2'), new PadLabel('FX 1'), new PadLabel('FX 2'),
    new PadLabel('SMP 13'), new PadLabel('SMP 14'), new PadLabel('SMP 15'), new PadLabel('SMP 16')
  ]

  build() {
    Column() {
      this.HeaderSection()
      this.InfoDisplay()
      this.PadGrid()
      this.ControlSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('⚙')
        .fontSize(24)
        .fontColor(Color.Black)
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Text(Math.round(this.bpm).toString())
          .fontSize(32)
          .fontFamily('monospace')
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Circle()
        .width(12)
        .height(12)
        .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .border({ width: 2, color: Color.Black, radius: 4 })
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .margin({ top: 20 })
  }

  @Builder
  PadGrid() {
    Grid() {
      ForEach(this.labels, (item: PadLabel, index: number) => {
        GridItem() {
          this.DrumPad(index, item.name)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height(336)
    .margin({ top: 24 })
  }

  @Builder
  DrumPad(index: number, label: string) {
    Column() {
      if (this.isPadActive(index)) {
        Circle()
          .width(6)
          .height(6)
          .fill(Color.White)
          .margin({ bottom: 4 })
      }
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isPadActive(index) ? Color.White : Color.Gray)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .border({ width: 1, color: this.isPadActive(index) ? Color.Black : '#E0E0E0', radius: 8 })
    .backgroundColor(this.isPadActive(index) ? Color.Black : '#EEEEEE')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.togglePad(index)
    })
  }

  @Builder
  ControlSection() {
    Column() {
      Row() {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Slider({ value: this.bpm, min: 60, max: 200, step: 1 })
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.bpm = value
            })
        }
        .layoutWeight(1)

        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Slider({ value: this.volume, min: 0, max: 1, step: 0.01 })
            .selectedColor(Color.Black)
            .trackColor('#E0E0E0')
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .layoutWeight(1)
        .margin({ left: 16 })
      }
      .width('100%')

      Row() {
        Button() {
          Row() {
            Text('⌫')
              .fontSize(16)
              .fontColor(Color.Gray)
            Text('CLEAR')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .height(48)
        .padding({ left: 24, right: 24 })
        .border({ width: 1, color: '#E0E0E0', radius: 24 })
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.clearPads()
        })

        Button() {
          Row() {
            Text(this.isPlaying ? 'Ⅱ' : '▶')
              .fontSize(16)
              .fontColor(Color.White)
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ left: 12 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .height(64)
        .width(140)
        .borderRadius(32)
        .backgroundColor(Color.Black)
        .onClick(() => {
          this.isPlaying = !this.isPlaying
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24 })
    }
    .width('100%')
    .margin({ top: 24 })
  }

  isPadActive(index: number): boolean {
    if (index === 0) { return this.p0 }
    if (index === 1) { return this.p1 }
    if (index === 2) { return this.p2 }
    if (index === 3) { return this.p3 }
    if (index === 4) { return this.p4 }
    if (index === 5) { return this.p5 }
    if (index === 6) { return this.p6 }
    if (index === 7) { return this.p7 }
    if (index === 8) { return this.p8 }
    if (index === 9) { return this.p9 }
    if (index === 10) { return this.p10 }
    if (index === 11) { return this.p11 }
    if (index === 12) { return this.p12 }
    if (index === 13) { return this.p13 }
    if (index === 14) { return this.p14 }
    return this.p15
  }

  togglePad(index: number): void {
    if (index === 0) { this.p0 = !this.p0 } else if (index === 1) { this.p1 = !this.p1 } else if (index === 2) { this.p2 = !this.p2 } else if (index === 3) { this.p3 = !this.p3 } else if (index === 4) { this.p4 = !this.p4 } else if (index === 5) { this.p5 = !this.p5 } else if (index === 6) { this.p6 = !this.p6 } else if (index === 7) { this.p7 = !this.p7 } else if (index === 8) { this.p8 = !this.p8 } else if (index === 9) { this.p9 = !this.p9 } else if (index === 10) { this.p10 = !this.p10 } else if (index === 11) { this.p11 = !this.p11 } else if (index === 12) { this.p12 = !this.p12 } else if (index === 13) { this.p13 = !this.p13 } else if (index === 14) { this.p14 = !this.p14 } else { this.p15 = !this.p15 }
  }

  clearPads(): void {
    this.p0 = false
    this.p1 = false
    this.p2 = false
    this.p3 = false
    this.p4 = false
    this.p5 = false
    this.p6 = false
    this.p7 = false
    this.p8 = false
    this.p9 = false
    this.p10 = false
    this.p11 = false
    this.p12 = false
    this.p13 = false
    this.p14 = false
    this.p15 = false
  }
}
