class AppTokens {
  static readonly Colors = {
    black: '#FF000000',
    white: '#FFFFFFFF',
    gray: '#FF888888',
    lightGray: '#FFBDBDBD',
    darkGray: '#FF444444',
    matchaGreen: '#FF556B2F',
    bowlColor: '#FF333333',
    matchaLiquid: '#FF8BBD52',
    steamColor: '#80BDBDBD',
    stepBg: '#FFF5F5F5',
    stepBorder: '#FFEEEEEE'
  }
}

@Entry
@Component
struct MatchaBrewingScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.gray)
          .letterSpacing(4)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Light)
          .fontColor(AppTokens.Colors.black)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 48 })

      Column() {
        Canvas(this.context)
          .width(160)
          .height(160)
          .onReady(() => {
            let ctx = this.context
            let w = 160
            let h = 160

            ctx.fillStyle = AppTokens.Colors.bowlColor
            ctx.beginPath()
            ctx.moveTo(w * 0.15, h * 0.4)
            ctx.lineTo(w * 0.85, h * 0.4)
            ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
            ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
            ctx.closePath()
            ctx.fill()

            ctx.fillStyle = AppTokens.Colors.matchaLiquid
            ctx.beginPath()
            ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
            ctx.fill()

            ctx.strokeStyle = AppTokens.Colors.steamColor
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
          })

        Row() {
          InfoItem({ label: 'TEMP', value: '80°C' })
          InfoItem({ label: 'WATER', value: '70ml' })
          InfoItem({ label: 'BAMBOO', value: 'Whisk' })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)

      Column() {
        StepCard({ number: '01', text: 'Sift 2g of matcha powder.' })
        StepCard({ number: '02', text: 'Add hot water. Whisk in \'M\' shape.' })
          .margin({ top: 12 })

        Row() {
          Text('▶')
            .fontSize(20)
            .fontColor(AppTokens.Colors.white)
          Text('START TIMER')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.white)
            .margin({ left: 8 })
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.matchaGreen)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 32, bottom: 24 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(AppTokens.Colors.white)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct InfoItem {
  @Prop label: string
  @Prop value: string

  build() {
    Column() {
      Text(this.label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.lightGray)
      Text(this.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.black)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct StepCard {
  @Prop number: string
  @Prop text: string

  build() {
    Row() {
      Row() {
        Text(this.number)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.black)
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(AppTokens.Colors.stepBg)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Text(this.text)
        .fontSize(14)
        .fontColor(AppTokens.Colors.darkGray)
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: AppTokens.Colors.stepBorder, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}