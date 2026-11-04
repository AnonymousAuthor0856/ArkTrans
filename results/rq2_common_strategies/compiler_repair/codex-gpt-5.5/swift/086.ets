class BeatColors {
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static gray: string = '#808080'
  static panel: string = '#F5F5F5'
  static padIdle: string = '#EEEEEE'
  static border: string = '#E0E0E0'
  static orange: string = '#FF5722'
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

  private labels: string[] = ['KICK', 'SNARE', 'CLAP', 'HI-HAT', 'TOM 1', 'TOM 2', 'CRASH', 'RIDE', 'PERC 1', 'PERC 2', 'FX 1', 'FX 2', 'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16']

  private padActive(index: number): boolean {
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

  private clearPads(): void {
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

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('POCKET')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(BeatColors.gray)
        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(BeatColors.black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Gear')
        .fontSize(14)
        .fontColor(BeatColors.black)
        .backgroundColor('#00000000')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  InfoDisplay() {
    Row() {
      Column() {
        Text('TEMPO')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(BeatColors.gray)
        Text(Math.floor(this.bpm).toString())
          .fontSize(32)
          .fontWeight(FontWeight.Medium)
          .fontColor(BeatColors.black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(12)
        .height(12)
        .fill(this.isPlaying ? BeatColors.orange : '#80808080')
    }
    .width('100%')
    .height(80)
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BeatColors.panel)
    .border({ width: 2, color: BeatColors.black, radius: 4 })
  }

  @Builder
  DrumPad(label: string, index: number) {
    Column({ space: 4 }) {
      if (this.padActive(index)) {
        Circle()
          .width(6)
          .height(6)
          .fill(BeatColors.white)
      }
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.padActive(index) ? BeatColors.white : BeatColors.gray)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.padActive(index) ? BeatColors.black : BeatColors.padIdle)
    .border({ width: 1, color: this.padActive(index) ? BeatColors.black : BeatColors.border, radius: 8 })
    .onClick(() => {
      if (index === 0) { this.p0 = !this.p0 }
      else if (index === 1) { this.p1 = !this.p1 }
      else if (index === 2) { this.p2 = !this.p2 }
      else if (index === 3) { this.p3 = !this.p3 }
      else if (index === 4) { this.p4 = !this.p4 }
      else if (index === 5) { this.p5 = !this.p5 }
      else if (index === 6) { this.p6 = !this.p6 }
      else if (index === 7) { this.p7 = !this.p7 }
      else if (index === 8) { this.p8 = !this.p8 }
      else if (index === 9) { this.p9 = !this.p9 }
      else if (index === 10) { this.p10 = !this.p10 }
      else if (index === 11) { this.p11 = !this.p11 }
      else if (index === 12) { this.p12 = !this.p12 }
      else if (index === 13) { this.p13 = !this.p13 }
      else if (index === 14) { this.p14 = !this.p14 }
      else { this.p15 = !this.p15 }
    })
  }

  @Builder
  PadGrid() {
    Grid() {
      ForEach(this.labels, (label: string, index?: number) => {
        GridItem() {
          this.DrumPad(label, index ? index : 0)
        }
      })
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
    .width('100%')
  }

  @Builder
  ControlSection() {
    Column({ space: 24 }) {
      Row({ space: 16 }) {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BeatColors.black)
          Slider({ value: this.bpm, min: 60, max: 200, step: 1 })
            .onChange((value: number) => {
              this.bpm = value
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Column() {
          Text('VOL')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(BeatColors.black)
          Slider({ value: this.volume, min: 0, max: 1, step: 0.01 })
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      Row() {
        Button('Trash  CLEAR')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(BeatColors.black)
          .height(48)
          .padding({ left: 24, right: 24 })
          .backgroundColor('#00000000')
          .border({ width: 1, color: BeatColors.border, radius: 24 })
          .onClick(() => {
            this.clearPads()
          })

        Blank()
          .layoutWeight(1)

        Button(this.isPlaying ? 'Pause  STOP' : 'Play  PLAY')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(BeatColors.white)
          .width(140)
          .height(64)
          .backgroundColor(BeatColors.black)
          .borderRadius(32)
          .onClick(() => {
            this.isPlaying = !this.isPlaying
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column() {
        Column() { this.HeaderSection() }
          .width('100%')
          .padding({ top: 24, left: 24, right: 24 })

        Blank().height(20)

        Column() { this.InfoDisplay() }
          .width('100%')
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        Column() { this.PadGrid() }
          .width('100%')
          .padding({ left: 24, right: 24 })

        Blank().height(24)

        Column() { this.ControlSection() }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BeatColors.white)
  }
}
