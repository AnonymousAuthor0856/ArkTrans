@Entry
@Component
struct TeaBrewingPage {
  @State time: string = "02:00"

  private teaCanvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private teaCanvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.teaCanvasSettings)

  private timerCanvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private timerCanvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.timerCanvasSettings)

  build() {
    Column() {
      this.HeaderSection()

      Blank().height(32)

      this.TeaSelectionCard()

      Blank().height(32)

      this.TimerDisplay()

      Blank().height(40)

      this.ControlButtons()

      Blank().layoutWeight(1)

      this.PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text("Good Morning,")
          .fontSize(14)
          .fontColor(Color.Gray)
        Text("Tea Master")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text("⚙")
          .fontSize(22)
          .fontColor(Color.Black)
      }
      .width(48)
      .height(48)
      .type(ButtonType.Circle)
      .backgroundColor('#FFF5F5F5')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Canvas(this.teaCanvasCtx)
        .width(60)
        .height(60)
        .backgroundColor('#FFEFEBE9')
        .borderRadius(30)
        .onReady(() => {
          const cx = 30
          const cy = 30
          const r = 15
          this.teaCanvasCtx.strokeStyle = '#FF6D4C41'
          this.teaCanvasCtx.lineWidth = 2
          this.teaCanvasCtx.beginPath()
          this.teaCanvasCtx.arc(cx, cy, r, 0, Math.PI * 2)
          this.teaCanvasCtx.stroke()
          this.teaCanvasCtx.lineCap = 'round'
          this.teaCanvasCtx.beginPath()
          this.teaCanvasCtx.moveTo(cx, cy - r * 0.6)
          this.teaCanvasCtx.lineTo(cx, cy + r * 0.5)
          this.teaCanvasCtx.stroke()
        })

      Column() {
        Text("Earl Grey Reserve")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text("Black Tea • 95°C")
          .fontSize(12)
          .fontColor('#FF8D6E63')
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      .alignItems(HorizontalAlign.Start)

      Text("♥")
        .fontSize(24)
        .fontColor('#FFFFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#FFEEEEEE' })
  }

  @Builder
  TimerDisplay() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.timerCanvasCtx)
        .width(220)
        .height(220)
        .onReady(() => {
          const cx = 110
          const cy = 110
          const r = 110 - 6

          this.timerCanvasCtx.strokeStyle = '#FFF5F5F5'
          this.timerCanvasCtx.lineWidth = 12
          this.timerCanvasCtx.beginPath()
          this.timerCanvasCtx.arc(cx, cy, r, 0, Math.PI * 2)
          this.timerCanvasCtx.stroke()

          this.timerCanvasCtx.strokeStyle = '#FF6D4C41'
          this.timerCanvasCtx.lineWidth = 12
          this.timerCanvasCtx.lineCap = 'round'
          this.timerCanvasCtx.beginPath()
          this.timerCanvasCtx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + (240 * Math.PI / 180))
          this.timerCanvasCtx.stroke()
        })

      Column() {
        Text("Steeping")
          .fontSize(12)
          .fontColor(Color.Gray)
          .letterSpacing(2)
        Text(this.time)
          .fontSize(40)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
  }

  @Builder
  ControlButtons() {
    Row() {
      Button() {
        Text("↻")
          .fontSize(22)
          .fontColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#FFE0E0E0' })

      Blank().width(24)

      Button() {
        Row() {
          Text("▶")
            .fontSize(18)
            .fontColor(Color.White)
          Text("Start")
            .fontSize(16)
            .fontColor(Color.White)
            .margin({ left: 8 })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#FF6D4C41')

      Blank().width(24)

      Button() {
        Text("+")
          .fontSize(28)
          .fontColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#FFE0E0E0' })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text("PREPARATION")
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFD3D3D3')
        .margin({ bottom: 12 })

      this.StepItem("1", "Boil fresh water to 95°C")
      this.StepItem("2", "Add 1 tsp of loose leaf per cup")
      this.StepItem("3", "Pour water and wait for timer")
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StepItem(step: string, text: string) {
    Column() {
      Row() {
        Text(step)
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
          .backgroundColor('#FFF5F5F5')
          .borderRadius(12)

        Text(text)
          .fontSize(14)
          .fontColor('#FF616161')
          .margin({ left: 12 })
          .layoutWeight(1)

        Text("✓")
          .fontSize(14)
          .fontColor('#FFEEEEEE')
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color('#FFFAFAFA')
        .strokeWidth(1)
    }
    .width('100%')
  }
}
