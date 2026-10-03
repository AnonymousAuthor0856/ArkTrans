@Entry
@Component
struct TeaBrewingScreen {
  private teaCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  private timerCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

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
    .backgroundColor('#FFFFFF')
    .padding(24)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor('#888888')
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#000000')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TeaSelectionCard() {
    Row() {
      Stack() {
        Canvas(this.teaCtx)
          .width(30)
          .height(30)
          .onReady(() => {
            this.drawTeaIcon()
          })
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#EFEBE9')

      Blank().width(16)

      Column() {
        Text('Earl Grey Reserve')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text('Black Tea • 95°C')
          .fontSize(12)
          .fontColor('#8D6E63')
      }
      .layoutWeight(1)

      Text('♥')
        .fontSize(24)
        .fontColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TimerDisplay() {
    Stack() {
      Canvas(this.timerCtx)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawTimer()
        })

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontColor('#888888')
          .letterSpacing(2)
        Text('02:00')
          .fontSize(45)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
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
        Text('↻')
          .fontSize(24)
          .fontColor('#888888')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#00000000')
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {})

      Blank().width(24)

      Button() {
        Row() {
          Text('▶')
            .fontSize(18)
            .fontColor('#FFFFFF')
            .margin({ right: 8 })
          Text('Start')
            .fontSize(16)
            .fontColor('#FFFFFF')
        }
        .alignItems(VerticalAlign.Center)
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#6D4C41')
      .onClick(() => {})

      Blank().width(24)

      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#888888')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#00000000')
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  PreparationSteps() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
        .margin({ bottom: 12 })

      this.StepItem('1', 'Boil fresh water to 95°C')
      this.StepItem('2', 'Add 1 tsp of loose leaf per cup')
      this.StepItem('3', 'Pour water and wait for timer')
    }
    .width('100%')
  }

  @Builder
  StepItem(step: string, text: string) {
    Row() {
      Stack() {
        Text(step)
          .fontSize(11)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor('#F5F5F5')

      Blank().width(12)

      Text(text)
        .fontSize(14)
        .fontColor('#A9A9A9')

      Blank().layoutWeight(1)

      Text('✓')
        .fontSize(16)
        .fontColor('#EEEEEE')
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)

    Divider()
      .color('#FAFAFA')
  }

  private drawTeaIcon() {
    this.teaCtx.clearRect(0, 0, 30, 30)
    this.teaCtx.strokeStyle = '#6D4C41'
    this.teaCtx.lineWidth = 2
    this.teaCtx.beginPath()
    this.teaCtx.arc(15, 15, 15, 0, 2 * Math.PI)
    this.teaCtx.stroke()
    this.teaCtx.beginPath()
    this.teaCtx.lineCap = 'round'
    this.teaCtx.moveTo(15, 7.5)
    this.teaCtx.lineTo(15, 22.5)
    this.teaCtx.stroke()
  }

  private drawTimer() {
    const cx = 110
    const cy = 110
    const radius = 104
    this.timerCtx.clearRect(0, 0, 220, 220)
    this.timerCtx.strokeStyle = '#F5F5F5'
    this.timerCtx.lineWidth = 12
    this.timerCtx.beginPath()
    this.timerCtx.arc(cx, cy, radius, 0, 2 * Math.PI)
    this.timerCtx.stroke()
    this.timerCtx.strokeStyle = '#6D4C41'
    this.timerCtx.lineCap = 'round'
    this.timerCtx.beginPath()
    this.timerCtx.arc(cx, cy, radius, -Math.PI / 2, -Math.PI / 2 + (240 * Math.PI / 180))
    this.timerCtx.stroke()
  }
}
