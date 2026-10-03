// Translated from 099.swift (Matcha Brewing Screen)

@Entry
@Component
struct Index {
  build() {
    MatchaBrewingScreen()
  }
}

@Component
struct MatchaBrewingScreen {
  build() {
    Stack() {
      Column() {
        Column() {
          Blank().height(48)
          Text('MATCHA RITUAL')
            .fontSize(14)
            .letterSpacing(4)
            .fontWeight(FontWeight.Bold)
            .fontColor('#808080')
          Blank().height(8)
          Text('Ceremonial Grade')
            .fontSize(28)
            .fontWeight(FontWeight.Lighter)
            .fontColor('#000000')
        }

        Column() {
          MatchaBowlCanvas()
            .width(160)
            .height(160)

          Blank().height(40)

          Row() {
            InfoItem({ label: 'TEMP', value: '80°C' })
            Blank()
            InfoItem({ label: 'WATER', value: '70ml' })
            Blank()
            InfoItem({ label: 'BAMBOO', value: 'Whisk' })
          }
          .width('100%')
        }
        .layoutWeight(1)

        Column() {
          StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
          Blank().height(12)
          StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

          Blank().height(32)

          Button() {
            Row({ space: 8 }) {
              Text('▶')
                .fontSize(20)
                .fontColor('#FFFFFF')
              Text('START TIMER')
                .fontSize(16)
                .fontWeight(FontWeight.Semibold)
                .fontColor('#FFFFFF')
            }
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F')
          .borderRadius(28)
          .onClick(() => {})

          Blank().height(24)
        }
        .width('100%')
      }
      .padding(24)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.context)
      .width(160)
      .height(160)
      .onReady(() => {
        const w = 160
        const h = 160

        this.context.fillStyle = '#333333'
        this.context.beginPath()
        this.context.moveTo(w * 0.15, h * 0.4)
        this.context.lineTo(w * 0.85, h * 0.4)
        this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
        this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
        this.context.closePath()
        this.context.fill()

        this.context.fillStyle = '#8BBD52'
        this.context.beginPath()
        this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
        this.context.fill()

        this.context.strokeStyle = '#80808080'
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
        .fontColor('#80808080')
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
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
        Circle()
          .fill('#F5F5F5')
          .width(32)
          .height(32)
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      Blank().width(16)
      Text(this.text)
        .fontSize(14)
        .fontColor('#4D4D4D')
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
  }
}
