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
          .fontWeight(900)
          .letterSpacing(-1)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      // Settings gear icon
      Stack() {
        Canvas()
          .width(28)
          .height(28)
          .onReady((ctx: CanvasRenderingContext2D) => {
            this.drawSettingsIcon(ctx)
          })
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

  private drawSettingsIcon(ctx: CanvasRenderingContext2D): void {
    const cx = 14
    const cy = 14
    const outerR = 10
    const innerR = 5
    const teeth = 8
    ctx.fillStyle = '#000000'
    ctx.beginPath()
    for (let i = 0; i < teeth * 2; i++) {
      const angle = (i * Math.PI) / teeth - Math.PI / 2
      const r = i % 2 === 0 ? outerR : outerR - 3
      const x = cx + r * Math.cos(angle)
      const y = cy + r * Math.sin(angle)
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    ctx.closePath()
    ctx.fill()
    // Center hole
    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(cx, cy, innerR, 0, Math.PI * 2)
    ctx.fill()
    // Screw dot
    ctx.fillStyle = '#000000'
    ctx.beginPath()
    ctx.arc(cx, cy, 1.5, 0, Math.PI * 2)
    ctx.fill()
  }

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
            if (this.isPlaying) {
              // Pause icon: two vertical bars
              Row() {
                Rect({ width: 4, height: 16 })
                  .fill(Color.White)
                Rect({ width: 4, height: 16 })
                  .fill(Color.White)
              }
              .width(16)
              .height(16)
              .justifyContent(FlexAlign.SpaceBetween)
            } else {
              // Play icon: triangle
              Path()
                .width(16)
                .height(16)
                .commands('M0,0 L16,8 L0,16 Z')
                .fill(Color.White)
            }
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

  @Builder
  CustomOutlinedButton(text: string, onClick: () => void) {
    Stack() {
      Row() {
        // Trash icon drawn with shapes
        Column() {
          // Handle
          Rect({ width: 6, height: 2 })
            .fill('#999999')
            .margin({ bottom: 0.5 })
          // Lid
          Rect({ width: 12, height: 1.5 })
            .fill('#999999')
            .margin({ bottom: 0.5 })
          // Body
          Stack() {
            Rect({ width: 11, height: 8 })
              .stroke('#999999')
              .strokeWidth(1.2)
              .fill(Color.Transparent)
            Row() {
              Rect({ width: 1, height: 5 })
                .fill('#999999')
              Rect({ width: 1, height: 5 })
                .fill('#999999')
                .margin({ left: 2, right: 2 })
              Rect({ width: 1, height: 5 })
                .fill('#999999')
            }
            .height(5)
            .justifyContent(FlexAlign.Center)
          }
          .width(12)
          .height(9)
          .alignContent(Alignment.Top)
        }
        .width(16)
        .height(16)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)

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
}
