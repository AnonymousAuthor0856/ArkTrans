import { ComponentContent, UIContext } from '@kit.ArkUI';

@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column({ space: 0 }) {
      Column({ space: 0 }) {
        Blank().height(48)
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Light)
          .fontColor('#000000')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      Column({ space: 0 }) {
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Blank().height(40)

        Row({ space: 0 }) {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      Column({ space: 0 }) {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank().height(12)
        StepCard({ number: '02', text: "Add hot water. Whisk in 'M' shape." })

        Blank().height(32)

        Button('START TIMER', { type: ButtonType.Normal })
          .width('100%')
          .height(56)
          .borderRadius(28)
          .backgroundColor('#556B2F')
          .fontColor('#FFFFFF')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)

        Blank().height(24)
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
  private bowlColor: string = '#333333'
  private matchaColor: string = '#8BBD52'
  private steamColor: string = '#80D3D3D3'

  build() {
    Canvas(this.renderCanvas)
      .width('100%')
      .height('100%')
  }

  private renderCanvas = (context: CanvasRenderingContext2D) => {
    const w = context.width
    const h = context.height

    // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
    context.beginPath()
    context.moveTo(w * 0.15, h * 0.4)
    context.lineTo(w * 0.85, h * 0.4)
    context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    context.closePath()
    context.fillStyle = this.bowlColor
    context.fill()

    // 2. Draw the Liquid (Matcha) inside
    context.beginPath()
    context.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    context.fillStyle = this.matchaColor
    context.fill()

    // 3. Draw Steam (Simple lines)
    context.strokeStyle = this.steamColor
    context.lineWidth = 4
    context.lineCap = 'round'

    context.beginPath()
    context.moveTo(w * 0.4, h * 0.3)
    context.lineTo(w * 0.4, h * 0.15)
    context.stroke()

    context.beginPath()
    context.moveTo(w * 0.5, h * 0.25)
    context.lineTo(w * 0.5, h * 0.1)
    context.stroke()

    context.beginPath()
    context.moveTo(w * 0.6, h * 0.3)
    context.lineTo(w * 0.6, h * 0.15)
    context.stroke()
  }
}

@Component
struct InfoItem {
  label: string = ''
  value: string = ''

  build() {
    Column({ space: 0 }) {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#D3D3D3')
      Blank().height(4)
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
    Row({ space: 0 }) {
      Text(this.number)
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor('#F5F5F5')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .textAlign(TextAlign.Center)
        .lineHeight(32)

      Blank().width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#A9A9A9')
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#EEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}