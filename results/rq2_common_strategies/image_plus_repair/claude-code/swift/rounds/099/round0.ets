@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF888888')
          .letterSpacing(4)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#FF000000')
          .margin({ top: 8 })
      }
      .width('100%')
      .margin({ top: 48 })

      // Middle Section: Visual Art & Stats
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })
          .margin({ top: 12 })

        Button() {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor(Color.White)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FF556B2F')
        .borderRadius(28)
        .margin({ top: 32 })

        Blank()
          .height(24)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding(24)
  }
}

@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    this.drawMatchaBowl()
  }

  drawMatchaBowl() {
    const ctx = this.context
    const w = 160
    const h = 160

    // 1. Draw the Bowl
    ctx.beginPath()
    ctx.moveTo(w * 0.15, h * 0.4)
    ctx.lineTo(w * 0.85, h * 0.4)
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    ctx.closePath()
    ctx.fillStyle = '#FF333333'
    ctx.fill()

    // 2. Draw the Liquid (Matcha) inside - as ellipse
    ctx.beginPath()
    const ellipseX = w * 0.5
    const ellipseY = h * 0.42 + (h * 0.15) / 2
    const rx = w * 0.3
    const ry = (h * 0.15) / 2
    ctx.ellipse(ellipseX, ellipseY, rx, ry, 0, 0, Math.PI * 2)
    ctx.fillStyle = '#FF8BBD52'
    ctx.fill()

    // 3. Draw Steam
    ctx.strokeStyle = 'rgba(128, 128, 128, 0.5)'
    ctx.lineWidth = 4
    ctx.lineCap = 'round'

    ctx.beginPath()
    ctx.moveTo(w * 0.4, h * 0.3)
    ctx.lineTo(w * 0.4, h * 0.15)
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(w * 0.5, h * 0.25)
    ctx.lineTo(w * 0.5, h * 0.1)
    ctx.stroke()

    ctx.beginPath()
    ctx.moveTo(w * 0.6, h * 0.3)
    ctx.lineTo(w * 0.6, h * 0.15)
    ctx.stroke()
  }

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawMatchaBowl()
      })
  }
}

@Component
struct InfoItem {
  label: string = ''
  value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('rgba(128, 128, 128, 0.5)')
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: string = ''
  text: string = ''

  build() {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#FFF5F5F5')
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)

      Text(this.text)
        .fontSize(14)
        .fontColor('#FF4D4D4D')
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#FFEEEEEE' })
    .borderRadius(12)
    .alignItems(VerticalAlign.Center)
  }
}
