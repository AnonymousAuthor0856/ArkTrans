@Entry
@Component
struct MatchaBrewingScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawMatchaBowl(): void {
    const w: number = 160
    const h: number = 160

    this.canvasContext.clearRect(0, 0, w, h)

    this.canvasContext.beginPath()
    this.canvasContext.moveTo(w * 0.15, h * 0.4)
    this.canvasContext.lineTo(w * 0.85, h * 0.4)
    this.canvasContext.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    this.canvasContext.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    this.canvasContext.closePath()
    this.canvasContext.fillStyle = '#333333'
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    this.canvasContext.fillStyle = '#8BBD52'
    this.canvasContext.fill()

    this.canvasContext.strokeStyle = 'rgba(211, 211, 211, 0.5)'
    this.canvasContext.lineWidth = 4
    this.canvasContext.lineCap = 'round'

    this.canvasContext.beginPath()
    this.canvasContext.moveTo(w * 0.4, h * 0.3)
    this.canvasContext.lineTo(w * 0.4, h * 0.15)
    this.canvasContext.stroke()

    this.canvasContext.beginPath()
    this.canvasContext.moveTo(w * 0.5, h * 0.25)
    this.canvasContext.lineTo(w * 0.5, h * 0.1)
    this.canvasContext.stroke()

    this.canvasContext.beginPath()
    this.canvasContext.moveTo(w * 0.6, h * 0.3)
    this.canvasContext.lineTo(w * 0.6, h * 0.15)
    this.canvasContext.stroke()
  }

  build() {
    Column() {
      Column() {
        Blank()
          .height(48)

        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')

        Blank()
          .height(8)

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        Canvas(this.canvasContext)
          .width(160)
          .height(160)
          .onReady(() => {
            this.drawMatchaBowl()
          })

        Blank()
          .height(40)

        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Column() {
        StepCard({ number: '01', description: 'Sift 2g of matcha powder.' })

        Blank()
          .height(12)

        StepCard({ number: '02', description: 'Add hot water. Whisk in \'M\' shape.' })

        Blank()
          .height(32)

        Button({ type: ButtonType.Capsule, stateEffect: true }) {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor('#FFFFFF')

            Blank()
              .width(8)

            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)

        Blank()
          .height(24)
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
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')

      Blank()
        .height(4)

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
  @Prop number: string
  @Prop description: string

  build() {
    Row() {
      Stack() {
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')

      Blank()
        .width(16)

      Text(this.description)
        .fontSize(14)
        .fontColor('#444444')
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 12
    })
  }
}