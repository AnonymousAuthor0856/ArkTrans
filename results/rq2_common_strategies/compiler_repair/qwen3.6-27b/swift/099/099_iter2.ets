import { Colors } from '@kit.ArkUI'

// MARK: - Helper for Hex Colors
function getHexColor(hex: number): string {
  return `#${hex.toString(16).padStart(6, '0')}`
}

@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Blank().height(48)
        Text('MATCHA RITUAL')
          .fontSize(14)
          .letterSpacing(4)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.Gray)
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Colors.Black)
      }
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Blank().height(40)

        Row() {
          Blank()
          InfoItem({ label: 'TEMP', value: '80°C' })
          Blank()
          InfoItem({ label: 'WATER', value: '70ml' })
          Blank()
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
          Blank()
        }
        .width('100%')
      }
      .layoutWeight(1) // Takes up remaining space
      .alignItems(HorizontalAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank().height(12)
        StepCard({ number: '02', text: 'Add hot water. Whisk in \'M\' shape.' })

        Blank().height(32)

        Button() {
          Row() {
            Image($r('app.media.ic_play')) // Placeholder for play icon
              .width(20)
              .height(20)
              .fillColor(Colors.White)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.White)
          }
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height(56)
        }
        .backgroundColor(getHexColor(0xFF556B2F))
        .borderRadius(28)
        .width('100%')

        Blank().height(24)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .padding(24)
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.White)
  }
}

// MARK: - MatchaBowlCanvas
@Component
struct MatchaBowlCanvas {
  private bowlColor = getHexColor(0xFF333333)
  private matchaColor = getHexColor(0xFF8BBD52)

  build() {
    Canvas()
      .onReady((context: CanvasRenderingContext2D) => {
        const w = context.canvas.width
        const h = context.canvas.height

        // 1. Draw the Bowl
        context.beginPath()
        context.moveTo(w * 0.15, h * 0.4)
        context.lineTo(w * 0.85, h * 0.4)
        context.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
        context.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
        context.closePath()
        context.fillStyle = this.bowlColor
        context.fill()

        // 2. Draw the Liquid (Matcha)
        context.beginPath()
        context.ellipse(w * 0.5, h * 0.42 + (h * 0.15 / 2), w * 0.3, h * 0.075, 0, 0, 2 * Math.PI)
        context.fillStyle = this.matchaColor
        context.fill()

        // 3. Draw Steam
        context.strokeStyle = '#80808080' // Gray with 50% opacity
        context.lineWidth = 4
        context.lineCap = 'round'

        // Steam Line 1
        context.beginPath()
        context.moveTo(w * 0.4, h * 0.3)
        context.lineTo(w * 0.4, h * 0.15)
        context.stroke()

        // Steam Line 2
        context.beginPath()
        context.moveTo(w * 0.5, h * 0.25)
        context.lineTo(w * 0.5, h * 0.1)
        context.stroke()

        // Steam Line 3
        context.beginPath()
        context.moveTo(w * 0.6, h * 0.3)
        context.lineTo(w * 0.6, h * 0.15)
        context.stroke()
      })
      .width('100%')
      .height('100%')
  }
}

// MARK: - InfoItem
@Component
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#80808080') // Light gray with opacity
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.Black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// MARK: - StepCard
@Component
struct StepCard {
  @Prop number: string
  @Prop text: string

  build() {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(getHexColor(0xFFF5F5F5))
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.Black)
      }
      .width(32)
      .height(32)

      Blank().width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor('#4D4D4D4D') // Dark gray equivalent
    }
    .width('100%')
    .padding(16)
    .borderRadius(12)
    .border({ width: 1, color: getHexColor(0xFFEEEEEE) })
  }
}