@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Stack() {
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
            .width(160)
            .height(160)

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
        .width('100%')
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        Column() {
          StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })

          Blank()
            .height(12)

          StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

          Blank()
            .height(32)

          Button({ type: ButtonType.Normal, stateEffect: false }) {
            Row({ space: 8 }) {
              Text('▶')
                .fontSize(20)
                .fontColor('#FFFFFF')

              Text('START TIMER')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .width('100%')
            .height(56)
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
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private draw() {
    const w = this.context.width
    const h = this.context.height

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
    this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    this.context.fillStyle = '#8BBD52'
    this.context.fill()

    this.context.lineWidth = 4
    this.context.lineCap = 'round'
    this.context.strokeStyle = 'rgba(128, 128, 128, 0.5)'

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
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.draw()
      })
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
        .fontColor('rgba(128, 128, 128, 0.5)')

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
  @Prop number: string = ''
  @Prop text: string = ''

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

      Text(this.text)
        .fontSize(14)
        .fontColor('#4D4D4D')
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