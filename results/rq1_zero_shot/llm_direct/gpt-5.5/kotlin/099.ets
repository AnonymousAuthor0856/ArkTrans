@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      Column() {
        Blank()
          .height(48)

        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')

        Blank()
          .height(8)

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        MatchaBowlCanvas()

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
        StepCard({ number: '01', content: 'Sift 2g of matcha powder.' })

        Blank()
          .height(12)

        StepCard({ number: '02', content: 'Add hot water. Whisk in \'M\' shape.' })

        Blank()
          .height(32)

        Button({ type: ButtonType.Normal }) {
          Row() {
            Text('▶')
              .fontSize(18)
              .fontColor('#FFFFFF')

            Blank()
              .width(8)

            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor('#556B2F')
        .shadow({ radius: 0 })

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
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawBowl(): void {
    const w: number = 160
    const h: number = 160

    this.context.clearRect(0, 0, w, h)

    this.context.beginPath()
    this.context.moveTo(w * 0.15, h * 0.4)
    this.context.lineTo(w * 0.85, h * 0.4)
    this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    this.context.closePath()
    this.context.fillStyle = '#333333'
    this.context.fill()

    this.context.beginPath()
    this.context.ellipse(
      w * 0.5,
      h * 0.495,
      w * 0.3,
      h * 0.075,
      0,
      0,
      Math.PI * 2
    )
    this.context.fillStyle = '#8BBD52'
    this.context.fill()

    this.context.strokeStyle = 'rgba(211, 211, 211, 0.5)'
    this.context.lineWidth = 4
    this.context.lineCap = 'round'

    this.context.beginPath()
    this.context.moveTo(w * 0.4, h * 0.3)
    this.context.lineTo(w * 0.4, h * 0.15)
    this.context.stroke()

    this.context.beginPath()
    this.context.moveTo(w * 0.5, h * 0.25)
    this.context.lineTo(w * 0.5, h * 0.1)
    this.context.stroke()

    this.context.beginPath()
    this.context.moveTo(w * 0.6, h * 0.3)
    this.context.lineTo(w * 0.6, h * 0.15)
    this.context.stroke()
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
  @Prop content: string

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
      .alignContent(Alignment.Center)

      Blank()
        .width(16)

      Text(this.content)
        .fontSize(14)
        .fontColor('#444444')
    }
    .width('100%')
    .padding(16)
    .border({
      width: 1,
      color: '#EEEEEE',
      radius: 12
    })
    .alignItems(VerticalAlign.Center)
  }
}