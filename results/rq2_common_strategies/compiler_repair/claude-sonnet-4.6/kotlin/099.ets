@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column({space: 0}) {
      // Top Section: Title
      Column({space: 0}) {
        Blank().height(48)
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column({space: 0}) {
        MatchaBowlCanvas()
        Blank().height(40)
        // Info Row
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

      // Bottom Section: Instructions & Action
      Column({space: 0}) {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank().height(12)
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })
        Blank().height(32)
        Button() {
          Row({space: 0}) {
            Text('▶')
              .fontSize(16)
              .fontColor(Color.White)
            Blank().width(8)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor('#556B2F')
        .shadow({radius: 0, color: Color.Transparent})
        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.White)
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

        // Draw Bowl
        this.context.beginPath()
        this.context.moveTo(w * 0.15, h * 0.4)
        this.context.lineTo(w * 0.85, h * 0.4)
        this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
        this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
        this.context.closePath()
        this.context.fillStyle = '#333333'
        this.context.fill()

        // Draw Matcha liquid (oval)
        this.context.beginPath()
        this.context.ellipse(
          w * 0.5,
          h * 0.42 + h * 0.075,
          w * 0.3,
          h * 0.075,
          0, 0, Math.PI * 2
        )
        this.context.fillStyle = '#8BBD52'
        this.context.fill()

        // Draw Steam lines
        this.context.strokeStyle = 'rgba(211,211,211,0.5)'
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
  label: string = ''
  value: string = ''

  build() {
    Column({space: 0}) {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  number: string = ''
  text: string = ''

  build() {
    Row({space: 0}) {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)
      Blank().width(16)
      Text(this.text)
        .fontSize(14)
        .fontColor('#444444')
    }
    .width('100%')
    .padding(16)
    .border({width: 1, color: '#EEEEEE', radius: 12})
    .alignItems(VerticalAlign.Center)
  }
}