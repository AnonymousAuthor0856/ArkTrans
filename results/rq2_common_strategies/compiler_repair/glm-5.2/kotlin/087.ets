// entry/src/main/ets/pages/Index.ets

@Entry
@Component
struct TeaBrewingScreen {
  build() {
    Column() {
      // Top Header
      HeaderSection()

      Blank().height(32)

      // Main Card displaying the selected Tea
      TeaSelectionCard()

      Blank().height(32)

      // Timer Visualization
      TimerDisplay({ time: '02:00' })

      Blank().height(40)

      // Action Buttons
      ControlButtons()

      Blank().layoutWeight(1)

      // Preparation Steps
      PreparationSteps()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(14)
          .fontColor('#9E9E9E')
        Text('Tea Master')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor('#000000')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .padding(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TeaSelectionCard {
  build() {
    Row() {
      // Abstract Tea Icon drawn with Canvas
      Stack() {
        Canvas(this.canvasContext)
          .width(30)
          .height(30)
          .onReady(() => {
            this.drawTeaLeaf()
          })
      }
      .width(60)
      .height(60)
      .backgroundColor('#EFEBE9')
      .borderRadius(30)
      .alignContent(Alignment.Center)

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
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('sys.media.ohos_ic_public_favor'))
        .width(24)
        .height(24)
        .fillColor('#FFCDD2')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(24)
    .alignItems(VerticalAlign.Center)
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawTeaLeaf() {
    const ctx = this.canvasContext
    const w = 30
    const h = 30
    ctx.strokeStyle = '#6D4C41'
    ctx.lineWidth = 2
    ctx.beginPath()
    ctx.arc(w / 2, h / 2, w / 2 - 1, 0, Math.PI * 2)
    ctx.stroke()
    ctx.beginPath()
    ctx.moveTo(w / 2, h / 4)
    ctx.lineTo(w / 2, h * 0.75)
    ctx.lineCap = 'round'
    ctx.stroke()
  }
}

@Component
struct TimerDisplay {
  private time: string = '02:00'
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack() {
      Canvas(this.canvasContext)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawTimerRing()
        })

      Column() {
        Text('Steeping')
          .fontSize(12)
          .fontColor('#9E9E9E')
          .letterSpacing(2)
        Text(this.time)
          .fontSize(48)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(220)
    .height(220)
    .alignContent(Alignment.Center)
  }

  private drawTimerRing() {
    const ctx = this.canvasContext
    const w = 220
    const h = 220
    const centerX = w / 2
    const centerY = h / 2
    const radius = 100

    ctx.lineWidth = 12
    ctx.lineCap = 'round'

    // Background Ring
    ctx.strokeStyle = '#F5F5F5'
    ctx.beginPath()
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
    ctx.stroke()

    // Progress Arc (240 degrees starting from -90)
    ctx.strokeStyle = '#6D4C41'
    ctx.beginPath()
    const startAngle = -Math.PI / 2
    const endAngle = startAngle + (240 * Math.PI) / 180
    ctx.arc(centerX, centerY, radius, startAngle, endAngle)
    ctx.stroke()
  }
}

@Component
struct ControlButtons {
  build() {
    Row() {
      // Reset Button
      Button() {
        Image($r('sys.media.ohos_ic_public_refresh'))
          .width(24)
          .height(24)
          .fillColor('#9E9E9E')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
      .padding(0)

      Blank().width(24)

      // Play/Pause Button
      Button() {
        Row() {
          Image($r('sys.media.ohos_ic_public_play'))
            .width(20)
            .height(20)
            .fillColor('#FFFFFF')
            .margin({ right: 8 })
          Text('Start')
            .fontColor('#FFFFFF')
            .fontSize(16)
        }
      }
      .width(120)
      .height(60)
      .borderRadius(24)
      .backgroundColor('#6D4C41')
      .padding(0)

      Blank().width(24)

      // Add Note Button
      Button() {
        Text('+')
          .fontSize(24)
          .fontColor('#9E9E9E')
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
      .padding(0)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct PreparationSteps {
  build() {
    Column() {
      Text('PREPARATION')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#BDBDBD')
        .margin({ bottom: 12 })

      StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
      StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
      StepItem({ step: '3', text: 'Pour water and wait for timer' })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct StepItem {
  private step: string = ''
  private text: string = ''

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.step)
            .fontSize(11)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
        }
        .width(24)
        .height(24)
        .backgroundColor('#F5F5F5')
        .borderRadius(12)
        .alignContent(Alignment.Center)

        Blank().width(12)

        Text(this.text)
          .fontSize(14)
          .fontColor('#424242')
          .layoutWeight(1)

        Image($r('sys.media.ohos_ic_public_check'))
          .width(16)
          .height(16)
          .fillColor('#EEEEEE')
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color('#FAFAFA')
        .strokeWidth(1)
    }
  }
}