@Entry
@Component
struct Index {
  build() {
    Column() {
      Column() {
        Blank().height(48)
        Text('MATCHA RITUAL').fontSize(14).letterSpacing(4).fontWeight(FontWeight.Bold).fontColor('#9E9E9E')
        Blank().height(8)
        Text('Ceremonial Grade').fontSize(28).fontWeight(FontWeight.Lighter).fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        MatchaBowlCanvas()

        Blank().height(40)

        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank().height(12)
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

        Blank().height(32)

        Button() {
          Row() {
            Text('▶').fontSize(20).fontColor('#FFFFFF')
            Blank().width(8)
            Text('START TIMER').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
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
  }
}

@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.ctx)
      .width(160).height(160)
      .onReady(() => { this.drawBowl() })
  }

  drawBowl() {
    const ctx = this.ctx
    const w = this.ctx.width
    const h = this.ctx.height

    ctx.fillStyle = '#333333'
    ctx.beginPath()
    ctx.moveTo(w * 0.15, h * 0.4)
    ctx.lineTo(w * 0.85, h * 0.4)
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    ctx.closePath()
    ctx.fill()

    ctx.fillStyle = '#8BBD52'
    ctx.beginPath()
    ctx.ellipse(w * 0.5, h * 0.42 + h * 0.075, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    ctx.fill()

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
  }
}

@Component
struct InfoItem {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.label).fontSize(10).fontWeight(FontWeight.Bold).fontColor('#D3D3D3')
      Blank().height(4)
      Text(this.value).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
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
        Text(this.number).fontSize(12).fontWeight(FontWeight.Bold).fontColor('#000000')
      }
      .width(32).height(32)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')

      Blank().width(16)

      Text(this.text).fontSize(14).fontColor('#444444')
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}
