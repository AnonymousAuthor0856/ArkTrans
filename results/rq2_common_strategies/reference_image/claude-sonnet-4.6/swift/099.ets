// MatchaBrewingScreen.ets
// ArkTS (ArkUI) 1:1 port of the SwiftUI "Matcha Ritual" brewing screen.

const BOWL_COLOR: string = '#333333'      // dark charcoal bowl
const MATCHA_COLOR: string = '#8BBD52'    // bright matcha green
const OLIVE_COLOR: string = '#556B2F'     // primary container color
const LABEL_GRAY: string = '#BFBFBF'      // LightGray @ 50%
const CARD_BORDER: string = '#EEEEEE'
const CARD_NUMBER_BG: string = '#F5F5F5'
const TEXT_DARK_GRAY: string = '#4D4D4D'

@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // ---------------------------------------------------------------
      // Top section: title
      // ---------------------------------------------------------------
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor(Color.Gray)
          .margin({ top: 48 })

        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor(Color.Black)
          .margin({ top: 8 })
      }
      .width('100%')

      // ---------------------------------------------------------------
      // Middle section: visual art + stats (expands -> SpaceBetween feel)
      // ---------------------------------------------------------------
      Column() {
        MatchaBowlCanvas()

        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      // ---------------------------------------------------------------
      // Bottom section: steps + action button
      // ---------------------------------------------------------------
      Column() {
        Column() {
          StepCard({ number: '01', content: 'Sift 2g of matcha powder.' })
        }
        .width('100%')

        Column() {
          StepCard({ number: '02', content: "Add hot water. Whisk in 'M' shape." })
        }
        .width('100%')
        .margin({ top: 12 })

        Button() {
          Row() {
            Text('▶')
              .fontSize(18)
              .fontColor(Color.White)
              .margin({ right: 8 })

            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor(OLIVE_COLOR)
        .padding(0)
        .stateEffect(true)
        .margin({ top: 32, bottom: 24 })
        .onClick(() => {
          // Placeholder action, same as the SwiftUI version.
        })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// -------------------------------------------------------------------
// MatchaBowlCanvas — custom 2D drawing of the bowl, matcha and steam
// -------------------------------------------------------------------
@Component
struct MatchaBowlCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Canvas(this.ctx)
      .width(160)
      .height(160)
      .onReady(() => {
        this.drawBowl()
      })
  }

  private drawBowl(): void {
    const w: number = this.ctx.width
    const h: number = this.ctx.height

    // 1. Bowl (rounded-bottom trapezoid)
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.15, h * 0.4)
    this.ctx.lineTo(w * 0.85, h * 0.4)
    this.ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    this.ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    this.ctx.closePath()
    this.ctx.fillStyle = BOWL_COLOR
    this.ctx.fill()

    // 2. Matcha liquid (filled oval)
    this.buildEllipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075)
    this.ctx.fillStyle = MATCHA_COLOR
    this.ctx.fill()

    // 3. Steam (three round-capped lines)
    this.ctx.lineWidth = 4
    this.ctx.lineCap = 'round'
    this.ctx.strokeStyle = 'rgba(128,128,128,0.5)'

    this.strokeLine(w * 0.4, h * 0.3, w * 0.4, h * 0.15)
    this.strokeLine(w * 0.5, h * 0.25, w * 0.5, h * 0.1)
    this.strokeLine(w * 0.6, h * 0.3, w * 0.6, h * 0.15)
  }

  // Ellipse built from four cubic bezier arcs (no API-level ellipse() needed)
  private buildEllipse(cx: number, cy: number, rx: number, ry: number): void {
    const k: number = 0.5522847498307936
    this.ctx.beginPath()
    this.ctx.moveTo(cx - rx, cy)
    this.ctx.bezierCurveTo(cx - rx, cy - ry * k, cx - rx * k, cy - ry, cx, cy - ry)
    this.ctx.bezierCurveTo(cx + rx * k, cy - ry, cx + rx, cy - ry * k, cx + rx, cy)
    this.ctx.bezierCurveTo(cx + rx, cy + ry * k, cx + rx * k, cy + ry, cx, cy + ry)
    this.ctx.bezierCurveTo(cx - rx * k, cy + ry, cx - rx, cy + ry * k, cx - rx, cy)
    this.ctx.closePath()
  }

  private strokeLine(x1: number, y1: number, x2: number, y2: number): void {
    this.ctx.beginPath()
    this.ctx.moveTo(x1, y1)
    this.ctx.lineTo(x2, y2)
    this.ctx.stroke()
  }
}

// -------------------------------------------------------------------
// InfoItem — label above value, centered
// -------------------------------------------------------------------
@Component
struct InfoItem {
  @Prop label: string = ''
  @Prop value: string = ''

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(LABEL_GRAY)

      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// -------------------------------------------------------------------
// StepCard — numbered circle + instruction, 1dp rounded outline
// -------------------------------------------------------------------
@Component
struct StepCard {
  @Prop number: string = ''
  @Prop content: string = ''

  build() {
    Row() {
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(CARD_NUMBER_BG)

        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .width(32)
      .height(32)

      Text(this.content)
        .fontSize(14)
        .fontColor(TEXT_DARK_GRAY)
        .layoutWeight(1)
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .borderRadius(12)
    .border({ width: 1, color: CARD_BORDER })
  }
}