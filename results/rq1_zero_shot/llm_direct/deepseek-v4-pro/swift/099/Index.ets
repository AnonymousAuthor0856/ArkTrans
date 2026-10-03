// MatchaBrewingScreen.ets
import { drawing } from '@kit.ArkGraphics2D';

// Color constants
const COLORS = {
  white: '#FFFFFF',
  gray: '#808080',
  black: '#000000',
  darkOliveGreen: '#556B2F',
  darkCharcoal: '#333333',
  matchaGreen: '#8BBD52',
  lightGray: '#F5F5F5',
  borderGray: '#EEEEEE',
  darkGray: '#4D4D4D'
};

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
          .fontColor(COLORS.gray)
        Blank().height(8)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Light)
          .fontColor(COLORS.black)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)

      // Middle Section: Visual Art & Stats
      Column() {
        MatchaBowlCanvas()
          .width(160)
          .height(160)

        Blank().height(40)

        // Info Row - SpaceEvenly
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
      .justifyContent(FlexAlign.Center)

      // Bottom Section: Instructions & Action
      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        Blank().height(12)
        StepCard({ number: '02', text: 'Add hot water. Whisk in \'M\' shape.' })

        Blank().height(32)

        Button() {
          // No logic required, just a placeholder action
        }
        .width('100%')
        .height(56)
        .backgroundColor(COLORS.darkOliveGreen)
        .borderRadius(28)
        .type(ButtonType.Normal)
        .borderRadius(28)
        .stateEffect(false)

        Row() {
          Image($r('sys.media.ohos_ic_play'))
            .width(20)
            .height(20)
            .fillColor(COLORS.white)
          Text('START TIMER')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.white)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height(56)
        .backgroundColor(COLORS.darkOliveGreen)
        .borderRadius(28)
        .onClick(() => {
          // Placeholder action
        })

        Blank().height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(COLORS.white)
  }
}

// MatchaBowlCanvas Component
@Component
struct MatchaBowlCanvas {
  private bowlColor: string = COLORS.darkCharcoal
  private matchaColor: string = COLORS.matchaGreen

  build() {
    Canvas(this.drawBowl)
      .width('100%')
      .height('100%')
  }

  private drawBowl = (context: drawing.CanvasRenderingContext2D) => {
    const width = context.width
    const height = context.height

    // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
    context.beginPath()
    context.moveTo(width * 0.15, height * 0.4)
    context.lineTo(width * 0.85, height * 0.4)
    context.quadraticCurveTo(width * 0.9, height * 0.9, width * 0.5, height * 0.9)
    context.quadraticCurveTo(width * 0.1, height * 0.9, width * 0.15, height * 0.4)
    context.closePath()
    context.fillStyle = this.bowlColor
    context.fill()

    // 2. Draw the Liquid (Matcha) inside
    context.beginPath()
    context.ellipse(
      width * 0.5,
      height * 0.495,
      width * 0.3,
      height * 0.075,
      0,
      0,
      Math.PI * 2
    )
    context.fillStyle = this.matchaColor
    context.fill()

    // 3. Draw Steam (Simple lines)
    const steamColor = 'rgba(128, 128, 128, 0.5)'
    context.strokeStyle = steamColor
    context.lineWidth = 4
    context.lineCap = 'round'

    // Steam line 1
    context.beginPath()
    context.moveTo(width * 0.4, height * 0.3)
    context.lineTo(width * 0.4, height * 0.15)
    context.stroke()

    // Steam line 2
    context.beginPath()
    context.moveTo(width * 0.5, height * 0.25)
    context.lineTo(width * 0.5, height * 0.1)
    context.stroke()

    // Steam line 3
    context.beginPath()
    context.moveTo(width * 0.6, height * 0.3)
    context.lineTo(width * 0.6, height * 0.15)
    context.stroke()
  }
}

// InfoItem Component
@Component
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('rgba(128, 128, 128, 0.5)')
      Blank().height(4)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.black)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// StepCard Component
@Component
struct StepCard {
  @Prop number: string
  @Prop text: string

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(COLORS.lightGray)
          .width(32)
          .height(32)
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.black)
      }
      .width(32)
      .height(32)

      Blank().width(16)

      Text(this.text)
        .fontSize(14)
        .fontColor(COLORS.darkGray)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .border({
      width: 1,
      color: COLORS.borderGray,
      radius: 12
    })
  }
}