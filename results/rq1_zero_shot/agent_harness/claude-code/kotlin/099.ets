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
          .fontColor('#888888')
          .letterSpacing(4)
        Blank(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 48 })

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom drawn Matcha Bowl
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Blank(40)

        // Info Row
        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank(12)
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

        Blank(32)

        Button() {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor('#FFFFFF')
            Blank(8)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor('#556B2F')
        .shadow({ radius: 0 })
        .onClick(() => {})

        Blank(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
    this.drawBowl()
  }

  private drawBowl() {
    const ctx = this.context
    const w = 160
    const h = 160

    // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
    ctx.beginPath()
    ctx.moveTo(w * 0.15, h * 0.4)
    ctx.lineTo(w * 0.85, h * 0.4)
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    ctx.closePath()
    ctx.fillStyle = '#333333'
    ctx.fill()

    // 2. Draw the Liquid (Matcha) inside - oval
    ctx.beginPath()
    ctx.ellipse(w * 0.5, h * 0.42 + h * 0.075, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    ctx.fillStyle = '#8BBD52'
    ctx.fill()

    // 3. Draw Steam (Simple lines with round caps)
    ctx.strokeStyle = 'rgba(211, 211, 211, 0.5)'
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
      .width(160)
      .height(160)
      .onReady(() => {
        this.drawBowl()
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
        .fontColor('#D3D3D3')
      Blank(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
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
      Text(this.number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width(32)
        .height(32)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)

      Blank(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#555555')
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}
