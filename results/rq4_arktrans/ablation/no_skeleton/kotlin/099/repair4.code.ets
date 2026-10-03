@Entry
@Component
struct MatchaBrewingScreen {
  build() {
    Column() {
      // Top Section: Title
      Column() {
        Text('MATCHA RITUAL')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(4)
          .fontColor('#808080')
        
        Text('Ceremonial Grade')
          .fontSize(28)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#000000')
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')

      // Middle Section: Visual Art & Stats
      Column() {
        // Custom drawn Matcha Bowl
        Canvas(this.ctx)
          .width(160)
          .height(160)
          .onReady(() => {
            this.drawMatchaBowl()
          })

        // Info Row
        Row() {
          this.InfoItem('TEMP', '80°C')
          this.InfoItem('WATER', '70ml')
          this.InfoItem('BAMBOO', 'Whisk')
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 40 })
      }
      .alignItems(HorizontalAlign.Center)
      .layoutWeight(1)

      // Bottom Section: Instructions & Action
      Column() {
        this.StepCard('01', 'Sift 2g of matcha powder.')
        Column() {
          this.StepCard('02', "Add hot water. Whisk in 'M' shape.")
        }
        .margin({ top: 12 })
        
        Button({ type: ButtonType.Capsule }) {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor('#FFFFFF')
            
            Text('START TIMER')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#556B2F')
        .borderRadius(28)
        .margin({ top: 32 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
  }

  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  private drawMatchaBowl(): void {
    const w = 160
    const h = 160
    
    // 1. Draw the Bowl (Trapezoid-like shape with rounded bottom)
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.15, h * 0.4) // Top Left
    this.ctx.lineTo(w * 0.85, h * 0.4) // Top Right
    this.ctx.quadraticCurveTo(w * 0.9, h * 0.9, w * 0.5, h * 0.9) // Bottom Center
    this.ctx.quadraticCurveTo(w * 0.1, h * 0.9, w * 0.15, h * 0.4) // Back to Top Left
    this.ctx.closePath()
    this.ctx.fillStyle = '#333333'
    this.ctx.fill()
    
    // 2. Draw the Liquid (Matcha) inside
    this.ctx.beginPath()
    this.ctx.ellipse(w * 0.5, h * 0.495, w * 0.3, h * 0.075, 0, 0, 2 * Math.PI)
    this.ctx.fillStyle = '#8BBD52'
    this.ctx.fill()
    
    // 3. Draw Steam (Simple lines)
    this.ctx.strokeStyle = 'rgba(211, 211, 211, 0.5)'
    this.ctx.lineWidth = 4
    this.ctx.lineCap = LineCap.Round
    
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.4, h * 0.3)
    this.ctx.lineTo(w * 0.4, h * 0.15)
    this.ctx.stroke()
    
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.5, h * 0.25)
    this.ctx.lineTo(w * 0.5, h * 0.1)
    this.ctx.stroke()
    
    this.ctx.beginPath()
    this.ctx.moveTo(w * 0.6, h * 0.3)
    this.ctx.lineTo(w * 0.6, h * 0.15)
    this.ctx.stroke()
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
        .fontColor('#000000')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  StepCard(number: string, text: string) {
    Row() {
      Text(number)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width(32)
        .height(32)
        .textAlign(TextAlign.Center)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
      
      Text(text)
        .fontSize(14)
        .fontColor('#A9A9A9')
        .margin({ left: 16 })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(12)
  }
}