@Entry
@Component
struct MatchaBrewingScreen {
  private bowlColor: string = '#FF333333'
  private matchaColor: string = '#FF8BBD52'
  private matchaGreen: string = '#FF556B2F'
  private steamColor: string = '#80CCCCCC'

  build() {
    Column() {
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF888888')
          .letterSpacing(4)
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#FF000000')
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 48 })

      Column() {
        Canvas(this.matchaBowlCtx)
          .width(160)
          .height(160)
          .onReady(() => {
            this.drawMatchaBowl()
          })

        Row() {
          this.InfoItemBuilder('TEMP', '80°C')
          this.InfoItemBuilder('WATER', '70ml')
          this.InfoItemBuilder('BAMBOO', 'Whisk')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 40 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

      Column() {
        this.StepCardBuilder('01', 'Sift 2g of matcha powder.')
        Blank()
          .height(12)
        this.StepCardBuilder('02', 'Add hot water. Whisk in \'M\' shape.')

        Button() {
          Row() {
            Text('▶')
              .fontSize(20)
              .fontColor(Color.White)
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .borderRadius(28)
        .backgroundColor(this.matchaGreen)
        .margin({ top: 32 })

        Blank()
          .height(24)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(Color.White)
  }

  private matchaBowlSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private matchaBowlCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.matchaBowlSettings)

  @Builder
  InfoItemBuilder(label: string, value: string) {
    Column() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFCCCCCC')
      Text(value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#FF000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCardBuilder(number: string, text: string) {
    Row() {
      Text(number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FF000000')
        .width(32)
        .height(32)
        .borderRadius(16)
        .backgroundColor('#FFF5F5F5')
        .textAlign(TextAlign.Center)
      Text(text)
        .fontSize(14)
        .fontColor('#FF444444')
        .margin({ left: 16 })
    }
    .width('100%')
    .padding(16)
    .border({ width: 1, color: '#FFEEEEEE', radius: 12 })
    .alignItems(VerticalAlign.Center)
  }

  private drawMatchaBowl() {
    let ctx = this.matchaBowlCtx
    let w = 160
    let h = 160

    ctx.beginPath()
    ctx.moveTo(w * 0.15, h * 0.4)
    ctx.lineTo(w * 0.85, h * 0.4)
    ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9)
    ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4)
    ctx.closePath()
    ctx.fillStyle = this.bowlColor
    ctx.fill()

    ctx.beginPath()
    ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, Math.PI * 2)
    ctx.fillStyle = this.matchaColor
    ctx.fill()

    ctx.strokeStyle = this.steamColor
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
