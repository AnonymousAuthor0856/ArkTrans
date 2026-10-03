import { canvas } from '@kit.ArkGraphics'

@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor('#808080')
        
        Text('Ceremonial Grade')
          .margin({ top: 8 })
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .margin({ top: 48 })

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom Canvas for Bowl
        Canvas(this.getContext())
          .width(160)
          .height(160)
          .onReady((context: canvas.CanvasRenderingContext2D) => {
            const w = context.canvas.width
            const h = context.canvas.height
            
            // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
            context.beginPath()
            context.moveTo(w * 0.15, h * 0.4)
            context.lineTo(w * 0.85, h * 0.4)
            context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
            context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
            context.closePath()
            context.fillStyle = '#333333'
            context.fill()

            // 2. Draw the Liquid (Matcha) inside
            context.beginPath()
            context.ellipse(w * 0.5, h * 0.42 + (h * 0.15 / 2), w * 0.3, h * 0.075, 0, 0, 2 * Math.PI)
            context.fillStyle = '#8BBD52'
            context.fill()

            // 3. Draw Steam (Simple lines)
            context.strokeStyle = 'rgba(128, 128, 128, 0.5)'
            context.lineWidth = 4
            context.lineCap = canvas.LineCap.Round

            // Steam 1
            context.beginPath()
            context.moveTo(w * 0.4, h * 0.3)
            context.lineTo(w * 0.4, h * 0.15)
            context.stroke()

            // Steam 2
            context.beginPath()
            context.moveTo(w * 0.5, h * 0.25)
            context.lineTo(w * 0.5, h * 0.1)
            context.stroke()

            // Steam 3
            context.beginPath()
            context.moveTo(w * 0.6, h * 0.3)
            context.lineTo(w * 0.6, h * 0.15)
            context.stroke()
          })

        // Info Row
        Row() {
          InfoItemComponent({ label: 'TEMP', value: '80°C' })
          InfoItemComponent({ label: 'WATER', value: '70ml' })
          InfoItemComponent({ label: 'BAMBOO', value: 'Whisk' })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)

      // Bottom Section: Instructions & Action
      Column() {
        StepCardComponent({ number: '01', text: 'Sift 2g of matcha powder.' })
        
        StepCardComponent({ number: '02', text: "Add hot water. Whisk in 'M' shape." })
          .margin({ top: 12 })

        Button() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
            
            Text('START TIMER')
              .margin({ left: 8 })
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .height(56)
        .width('100%')
        .margin({ top: 32 })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct InfoItemComponent {
  private label: string = ''
  private value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#808080')
      
      Text(this.value)
        .margin({ top: 4 })
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#000000')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCardComponent {
  private number: string = ''
  private text: string = ''

  build() {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill('#F5F5F5')
        
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      
      Text(this.text)
        .margin({ left: 16 })
        .fontSize(14)
        .fontColor('#4D4D4D') // Approximation of Color(white: 0.3) on white bg
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: '#EEEEEE' })
  }
}