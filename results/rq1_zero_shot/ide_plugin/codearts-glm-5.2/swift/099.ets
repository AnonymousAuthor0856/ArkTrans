class MbColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly gray50: string = '#80808080'
  static readonly bowl: string = '#FF333333'
  static readonly matcha: string = '#FF8BBD52'
  static readonly buttonBg: string = '#FF556B2F'
  static readonly stepBg: string = '#FFF5F5F5'
  static readonly stepBorder: string = '#FFEEEEEE+'
  static readonly darkGray: string = '#FF4D4D4D'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Blank().height(48)

        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(MbColors.gray)

        Blank().height(8)

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(MbColors.black)

        Blank().layoutWeight(1)

        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Blank().height(40)

        Row() {
          Blank()
          InfoItem({ label: 'TEMP', value: '80°C' })
          Blank()
          InfoItem({ label: 'WATER', value: '70ml' })
          Blank()
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
          Blank()
        }

        Blank().layoutWeight(1)

        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })

        Blank().height(12)

        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

        Blank().height(32)

        Row() {
          Text('▶')
            .fontSize(20)
            .fontColor(MbColors.white)
          Text('START TIMER')
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(MbColors.white)
            .margin({ left: 8 })
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(MbColors.buttonBg)
        .borderRadius(28)

        Blank().height(24)
      }
      .padding(24)
    }
    .backgroundColor(MbColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct MatchaBowlCanvas {
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawCanvas()
      })
  }

  drawCanvas() {
    let w = this.ctx.width
    let h = this.ctx.height

    this.ctx.fillStyle = MbColors.bowl
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.15, h * 0.4)
    this.ctx.lineTo(w * 0.85, h * 0.4)
    this.ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    this.ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    this.ctx.closePath()
    this.ctx.fill()

    this.ctx.fillStyle = MbColors.matcha
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.strokeStyle = MbColors.gray50
    this.ctx.lineWidth = 4
    this.ctx.lineCap = 'round'

    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.4, h * 0.3)
    this.ctx.lineTo(w * 0.4, h * 0.15)
    this.ctx.stroke()

    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.5, h * 0.25)
    this.ctx.lineTo(w * 04 * 0.5, h * 0.1)
    this.ctx.stroke()

    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.6, h * 0.3)
    this.ctx.lineTo(w * 0.6, h * 0.15)
    this.ctx.stroke()
  }
}

@Component
struct InfoItem {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(MbColors.gray50)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(MbColors.black)
        .margin({ top: 4 })
    }
  }
}

@Component
struct StepCard {
  @Prop number: string = ''
  @Prop text: string = ''

  build() {
    Row() {
      Stack() {
        Circle({ width: 32, height: 32 })
          .fill(MbColors.stepBg)
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(MbColors.black)
      }

      Text(this.text)
        .fontSize(14)
        .fontColor(MbColors.darkGray)
        .margin({ left: 16 })
        .layoutWeight(1)
    }
    .padding(16)
    .border({ width: 1, color: MbColors.stepBorder, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}