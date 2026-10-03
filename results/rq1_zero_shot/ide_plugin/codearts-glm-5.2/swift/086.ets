class BmColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly gray50: string = '#80808080'
  static readonly displayBg: string = '#FFF5F5F5'
  static readonly playOrange: string = '#FFFF5722'
  static readonly padInactive: string = '#FFEEEEEE'
  static readonly padStroke: string = '#FFE0E0E0'
}

@Entry
@Component
struct Index {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

  private padLabels: string[] = ['KICK', 'SNARE', 'CLAP', 'HI-HAT', 'TOM 1', 'TOM 2', 'CRASH', 'RIDE', 'PERC 1', 'PERC 2', 'FX 1', 'FX 2', 'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16']

  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('POCKET')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(BmColors.gray)

            Text('BEATS-909')
              .fontSize(28)
              .fontWeight(FontWeight.Black)
              .fontColor(BmColors.black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(BmColors.black)
        }
        .padding({ left: 24, right: 24, top: 24 })

        Blank().height(20)

        Row() {
          Column() {
            Text('TEMPO')
              .fontSize(10)
              .fontWeight(FontWeight.Bold)
              .fontColor(BmColors.gray)

            Text(`${Math.round(this.bpm)}`)
              .fontSize(32)
              .fontWeight(FontWeight.Medium)
              .fontColor(BmColors.black)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Circle({ width: 12, height: 12 })
            .fill(this.isPlaying ? BmColors.playOrange : BmColors.gray50)
        }
        .padding(16)
        .height(80)
        .backgroundColor(BmColors.displayBg)
        .border({ width: 2, color: BmColors.black, radius: 4 })
        .margin({ left: 24, right: 24 })

        Blank().height(24)

        Column() {
          Row() {
            DrumPad({ isActive: this.pads[0], label: this.padLabels[0], padIndex: 0 })
            DrumPad({ isActive: this.pads[1], label: this.padLabels[1], padIndex: 1 })
            DrumPad({ isActive: this.pads[2], label: this.padLabels[2], padIndex: 2 })
            DrumPad({ isActive: this.pads[3], label: this.padLabels[3], padIndex: 3 })
          }
          Row() {
            DrumPad({ isActive: this.pads[4], label: this.padLabels[4], padIndex: 4 })
            DrumPad({ isActive: this.pads[5], label: this.padLabels[5], padIndex: 5 })
            DrumPad({ isActive: this.pads[6], label: this.padLabels[6], padIndex: 6 })
            DrumPad({ isActive: this.pads[7], label: this.padLabels[7], padIndex: 7 })
          }
          Row() {
            DrumPad({ isActive: this.pads[8], label: this.padLabels[8], padIndex: 8 })
            DrumPad({ isActive: this.pads[9], label: this.padLabels[9], padIndex: 9 })
            DrumPad({ isActive: this.pads[10], label: this.padLabels[10], padIndex: 10 })
            DrumPad({ isActive: this.pads[11], label: this.padLabels[11], padIndex: 11 })
          }
          Row() {
            DrumPad({ isActive: this.pads[12], label: this.padLabels[12], padIndex: 12 })
            DrumPad({ isActive: this.pads[13], label: this.padLabels[13], padIndex: 13 })
            DrumPad({ isActive: this.pads[14], label: this.padLabels[14], padIndex: 14 })
            DrumPad({ isActive: this.pads[15], label: this.padLabels[15], padIndex: 15 })
          }
        }
        .margin({ left: 24, right: 24 })

        Blank().height(24)

        Column() {
          Row() {
            Column() {
              Text('BPM')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(BmColors.black)

              Slider({
                value: this.bpm,
                min: 60,
                max: 200,
                step: 1,
              })
                .blockColor(BmColors.black)
                .trackColor(BmColors.padStroke)
                .selectedColor(BmColors.black)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Column() {
              Text('VOL')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor(BmColors.black)

              Slider({
                value: this.volume,
                min: 0,
                max: 1,
                step: 0.01,
              })
                .blockColor(BmColors.black)
                .trackColor(BmColors.padStroke)
                .selectedColor(BmColors.black)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 16 })
          }

          Row() {
            Row() {
              Text('🗑')
                .fontSize(16)
                .fontColor(BmColors.gray)
              Text('CLEAR')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(BmColors.black)
                .margin({ left: 8 })
            }
            .padding({ left: 24, right: 24 })
            .height(48)
            .border({ width: 1, color: BmColors.padStroke, radius: 24 })
            .onClick(() => {
              this.pads = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
            })

            Blank()

            Row() {
              Text(this.isPlaying ? '⏸' : '▶')
                .fontSize(16)
                .fontColor(BmColors.white)
              Text(this.isPlaying ? 'STOP' : 'PLAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(BmColors.white)
                .margin({ left: 12 })
            }
            .width(140)
            .height(64)
            .justifyContent(FlexAlign.Center)
            .backgroundColor(BmColors.black)
            .borderRadius(32)
            .onClick(() => {
              this.isPlaying = !this.isPlaying
            })
          }
          .margin({ top: 24 })
        }
        .padding({ left: 24, right: 24, bottom: 24 })
      }
    }
    .backgroundColor(BmColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct DrumPad {
  @Prop isActive: boolean = false
  @Prop label: string = ''
  @Prop padIndex: number = 0

  build() {
    Column() {
      if (this.isActive) {
        Circle({ width: 6, height: 6 })
          .fill(BmColors.white)
      }

      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? BmColors.white : BmColors.gray)
        .margin({ top: 4 })
    }
    .justifyContent(FlexAlign.Center)
    .layoutWeight(1)
    .aspectRatio(1)
    .backgroundColor(this.isActive ? BmColors.black : BmColors.padInactive)
    .border({ width: 1, color: this.isActive ? BmColors.black : BmColors.padStroke, radius: 8 })
    .margin({ right: 12, bottom: 12 })
    .onClick(() => {
      this.isActive = !this.isActive
    })
  }
}