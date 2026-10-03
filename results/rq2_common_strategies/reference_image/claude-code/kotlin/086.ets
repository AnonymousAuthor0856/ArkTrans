@Entry
@Component
struct BeatMakerApp {
  @State bpm: number = 120
  @State isPlaying: boolean = false
  @State volume: number = 0.8
  @State pads: boolean[] = new Array(16).fill(false)

  private padLabels: string[] = [
    'KICK', 'SNARE', 'CLAP', 'HI-HAT',
    'TOM 1', 'TOM 2', 'CRASH', 'RIDE',
    'PERC 1', 'PERC 2', 'FX 1', 'FX 2',
    'SMP 13', 'SMP 14', 'SMP 15', 'SMP 16'
  ]

  build() {
    Column() {
      // Top Header
      this.HeaderSection()

      // LCD Display / Info Panel
      this.InfoDisplay()

      // The Grid (Drum Pads)
      this.PadGrid()

      // Bottom Controls (Sliders and Transport)
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
          .fontColor('#999999')
          .letterSpacing(2)
        Text('BEATS-909')
          .fontSize(28)
          .fontWeight(FontWeight.Bolder)
          .letterSpacing(-1)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Canvas(this.settingsCanvas)
          .width(28)
          .height(28)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignContent(Alignment.Center)
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  private settingsCanvas = new CanvasRenderingContext2D()

  @Builder
  InfoDisplay() {
    Stack() {
      Row() {
        Column() {
          Text('TEMPO')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#999999')
          Text(this.bpm.toFixed(0))
            .fontSize(32)
            .fontWeight(FontWeight.Medium)
            .fontFamily('monospace')
            .fontColor(Color.Black)
        }
        .alignItems(HorizontalAlign.Start)

        Circle({ width: 12, height: 12 })
          .fill(this.isPlaying ? '#FF5722' : '#D3D3D3')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(80)
    .border({ width: 2, color: Color.Black, radius: 4 })
    .backgroundColor('#F5F5F5')
    .padding(16)
  }

  @Builder
  PadGrid() {
    Grid() {
      ForEach(this.pads, (item: boolean, index: number) => {
        GridItem() {
          this.DrumPad(index)
        }
      }, (item: boolean, index: number) => index.toString())
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(12)
    .rowsGap(12)
    .width('100%')
    .aspectRatio(1)
  }

  @Builder
  DrumPad(index: number) {
    Stack() {
      Column() {
        if (this.pads[index]) {
          Circle({ width: 6, height: 6 })
            .fill(Color.White)
        }
        Text(this.padLabels[index])
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.pads[index] ? Color.White : '#999999')
          .margin({ top: this.pads[index] ? 4 : 0 })
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pads[index] ? Color.Black : '#EEEEEE')
    .border({
      width: 1,
      color: this.pads[index] ? Color.Black : '#E0E0E0',
      radius: 8
    })
    .borderRadius(8)
    .justifyContent(FlexAlign.Center)
    .alignContent(Alignment.Center)
    .onClick(() => {
      this.pads[index] = !this.pads[index]
    })
  }

  @Builder
  ControlSection() {
    Column() {
      // Sliders Row
      Row() {
        Column() {
          Text('BPM')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          Slider({
            value: this.bpm,
            min: 60,
            max: 200,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
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
            .fontColor(Color.Black)
          Slider({
            value: this.volume,
            min: 0,
            max: 1,
            step: 0.01,
            style: SliderStyle.OutSet
          })
            .blockColor(Color.Black)
            .trackColor('#E0E0E0')
            .selectedColor(Color.Black)
            .onChange((value: number) => {
              this.volume = value
            })
        }
        .layoutWeight(1)
        .margin({ left: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')

      // Transport Buttons
      Row() {
        // Clear Button
        this.CustomOutlinedButton('CLEAR', () => {
          for (let i = 0; i < 16; i++) {
            this.pads[i] = false
          }
        })

        // Play Button (Large)
        Stack() {
          Row() {
            Canvas(this.playIconCanvas)
              .width(16)
              .height(16)
              .onReady(() => {
                this.drawPlayIcon()
              })
            Text(this.isPlaying ? 'STOP' : 'PLAY')
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .margin({ left: 12 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width(140)
        .height(64)
        .backgroundColor(Color.Black)
        .borderRadius(32)
        .justifyContent(FlexAlign.Center)
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
  }

  private playIconCanvas = new CanvasRenderingContext2D()

  private drawPlayIcon(): void {
    const ctx = this.playIconCanvas
    const w = 16
    const h = 16
    ctx.clearRect(0, 0, w, h)
    ctx.fillStyle = '#FFFFFF'
    if (this.isPlaying) {
      // Pause symbol (two bars)
      ctx.fillRect(0, 0, w / 3, h)
      ctx.fillRect(w * 2 / 3, 0, w / 3, h)
    } else {
      // Play symbol (triangle)
      ctx.beginPath()
      ctx.moveTo(0, 0)
      ctx.lineTo(w, h / 2)
      ctx.lineTo(0, h)
      ctx.closePath()
      ctx.fill()
    }
  }

  @Builder
  CustomOutlinedButton(text: string, onClick: () => void) {
    Stack() {
      Row() {
        Canvas(this.trashCanvas)
          .width(16)
          .height(16)
          .onReady(() => {
            this.drawTrashIcon()
          })
        Text(text)
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
    .borderRadius(24)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      onClick()
    })
  }

  private trashCanvas = new CanvasRenderingContext2D()

  private drawTrashIcon(): void {
    const ctx = this.trashCanvas
    ctx.clearRect(0, 0, 16, 16)
    ctx.strokeStyle = '#999999'
    ctx.fillStyle = '#999999'
    ctx.lineWidth = 1.5
    // Trash can body
    ctx.beginPath()
    ctx.rect(3.5, 5, 9, 9)
    ctx.stroke()
    // Trash can lid
    ctx.beginPath()
    ctx.moveTo(2, 4)
    ctx.lineTo(14, 4)
    ctx.stroke()
    // Handle
    ctx.beginPath()
    ctx.rect(6, 2, 4, 2)
    ctx.stroke()
    // Vertical lines inside
    ctx.beginPath()
    ctx.moveTo(6, 7)
    ctx.lineTo(6, 12)
    ctx.moveTo(8, 7)
    ctx.lineTo(8, 12)
    ctx.moveTo(10, 7)
    ctx.lineTo(10, 12)
    ctx.stroke()
  }
}
