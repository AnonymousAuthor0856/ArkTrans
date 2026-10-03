@Entry
@Component
struct MatchaRitualPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      // Top Section: Title
      Column() {
        Blank().height(48)
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#888888')
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column() {
        this.MatchaBowl()
        Blank().height(40)
        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')
        Blank().height(12)
        this.StepCard('02', "Add hot water. Whisk in 'M' shape.")
        Blank().height(32)
        Button() {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor('#FFFFFF')
            Blank().width(8)
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
        .onClick(() => {})
        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
  }

  @Builder
  MatchaBowl() {
    Canvas(this.context)
      .width(160)
      .height(160)
      .onReady(() => {
        const w: number = 160
        const h: number = 160

        // 1. Draw the Bowl (trapezoid-like shape with rounded bottom)
        this.context.fillStyle = '#333333'
        this.context.beginPath()
        this.context.moveTo(w * 0.15, h * 0.4)
        this.context.lineTo(w * 0.85, h * 0.4)
        this.context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
        this.context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
        this.context.closePath()
        this.context.fill()

        // 2. Draw the Liquid (Matcha) inside
        this.context.fillStyle = '#8BBD52'
        this.context.beginPath()
        this.context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
        this.context.fill()

        // 3. Draw Steam (simple lines)
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

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
      Blank().height(4)
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, text: string) {
    Row() {
      Stack() {
        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')
      .alignContent(Alignment.Center)

      Blank().width(16)
      Text(text)
        .fontSize(14)
        .fontColor('#444444')
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(12)
    .alignItems(VerticalAlign.Center)
  }
}
