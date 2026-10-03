@Entry
@Component
struct MatchaBrewingScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawMatchaBowl() {
    const ctx = this.context
    const w = 160
    const h = 160

    ctx.clearRect(0, 0, w, h)

    // Draw steam lines
    ctx.strokeStyle = 'rgba(211,211,211,0.5)'
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

    // Draw bowl body
    ctx.fillStyle = '#333333'
    ctx.beginPath()
    ctx.moveTo(w * 0.15, h * 0.4)
    ctx.lineTo(w * 0.85, h * 0.4)
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    ctx.closePath()
    ctx.fill()

    // Draw matcha liquid (ellipse)
    ctx.fillStyle = '#8BBD52'
    ctx.beginPath()
    const cx = w * 0.5
    const cy = h * 0.42 + h * 0.075
    const rx = w * 0.3
    const ry = h * 0.075
    ctx.ellipse(cx, cy, rx, ry, 0, 0, Math.PI * 2)
    ctx.fill()
  }

  build() {
    Column() {
      // Top Section
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(4)

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 48 })

      // Middle Section
      Column() {
        Canvas(this.context)
          .width(160)
          .height(160)
          .onReady(() => {
            this.drawMatchaBowl()
          })

        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)

      // Bottom Section
      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')

        Blank().height(12)

        this.StepCard('02', "Add hot water. Whisk in 'M' shape.")

        Button() {
          Row() {
            Text('▶')
              .fontColor(Color.White)
              .fontSize(16)
            Text('  START TIMER')
              .fontColor(Color.White)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor('#556B2F')
        .margin({ top: 32 })

        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  InfoItem(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')

      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, text: string) {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')

        Text(number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }

      Text(text)
        .fontSize(14)
        .fontColor('#444444')
        .margin({ left: 16 })
        .layoutWeight(1)
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}