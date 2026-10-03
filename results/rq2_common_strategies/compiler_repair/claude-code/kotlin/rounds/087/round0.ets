@Entry
@Component
struct TeaBrewingPage {
  @State time: string = "02:00"

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
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Black)
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
      Canvas(this.teaCanvasSettings)
        .width(60)
        .height(60)
        .backgroundColor('#FFEFEBE9')
        .borderRadius(30)
        .onReady((ctx: CanvasRenderingContext2D) => {
          const cx = 30
          const cy = 30
          const r = 15
          ctx.strokeStyle = '#FF6D4C41'
          ctx.lineWidth = 2
          ctx.beginPath()
          ctx.arc(cx, cy, r, 0, Math.PI * 2)
          ctx.stroke()
          ctx.beginPath()
          ctx.moveTo(cx, cy - r * 0.6)
          ctx.lineTo(cx, cy + r * 0.5)
          ctx.lineCap = 'round'
          ctx.stroke()
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

      Image($r('sys.media.ohos_ic_public_favorite'))
        .width(24)
        .height(24)
        .fillColor('#FFFFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#FFEEEEEE' })
  }

  private teaCanvasSettings: RenderingContextSettings = new RenderingContextSettings(true)

  @Builder
  TimerDisplay() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.timerCanvasSettings)
        .width(220)
        .height(220)
        .onReady((ctx: CanvasRenderingContext2D) => {
          const cx = 110
          const cy = 110
          const r = 110 - 6

          ctx.strokeStyle = '#FFF5F5F5'
          ctx.lineWidth = 12
          ctx.beginPath()
          ctx.arc(cx, cy, r, 0, Math.PI * 2)
          ctx.stroke()

          ctx.strokeStyle = '#FF6D4C41'
          ctx.lineWidth = 12
          ctx.lineCap = 'round'
          ctx.beginPath()
          ctx.arc(cx, cy, r, -Math.PI / 2, -Math.PI / 2 + (240 * Math.PI / 180))
          ctx.stroke()
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

  private timerCanvasSettings: RenderingContextSettings = new RenderingContextSettings(true)

  @Builder
  ControlButtons() {
    Row() {
      Button() {
        Image($r('sys.media.ohos_ic_public_refresh'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .width(60)
      .height(60)
      .type(ButtonType.Circle)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#FFE0E0E0' })

      Blank().width(24)

      Button() {
        Row() {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(20)
            .height(20)
            .fillColor(Color.White)
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
        Image($r('sys.media.ohos_ic_public_add'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
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

        Image($r('sys.media.ohos_ic_public_select'))
          .width(16)
          .height(16)
          .fillColor('#FFEEEEEE')
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
