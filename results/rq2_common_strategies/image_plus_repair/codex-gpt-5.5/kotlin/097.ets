@Entry
@Component
struct ClimateController {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true
  @State ecoActive: boolean = true
  private ringContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  private readonly black: string = '#1C1C1E'
  private readonly gray: string = '#8E8E93'
  private readonly blue: string = '#007AFF'
  private readonly softGray: string = '#F2F2F7'

  private adjustTemp(delta: number): void {
    this.targetTemp = Math.max(16, Math.min(30, Math.round((this.targetTemp + delta) * 10) / 10))
  }

  private drawDial(): void {
    const ctx = this.ringContext
    const center = 130
    const radius = 110
    const progress = (this.targetTemp - 16) / 14
    ctx.clearRect(0, 0, 260, 260)
    ctx.lineWidth = 20
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.arc(center, center, radius, 0, Math.PI * 2)
    ctx.strokeStyle = this.softGray
    ctx.stroke()
    const startAngle = Math.PI * 0.75
    const endAngle = startAngle + Math.PI * 1.5 * progress
    ctx.beginPath()
    ctx.arc(center, center, radius, startAngle, endAngle)
    ctx.strokeStyle = this.isActive ? this.blue : this.gray
    ctx.stroke()
    const knobX = center + radius * Math.cos(endAngle)
    const knobY = center + radius * Math.sin(endAngle)
    ctx.beginPath()
    ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
    ctx.fillStyle = '#FFFFFF'
    ctx.fill()
    ctx.beginPath()
    ctx.arc(knobX, knobY, 6, 0, Math.PI * 2)
    ctx.fillStyle = this.isActive ? this.blue : this.gray
    ctx.fill()
  }

  @Builder
  private roundControl(symbol: string, delta: number) {
    Text(symbol)
      .fontSize(32)
      .fontColor(this.black)
      .width(56)
      .height(56)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isActive ? this.softGray : '#F9F9F9')
      .borderRadius(28)
      .onClick(() => {
        if (this.isActive) {
          this.adjustTemp(delta)
          this.drawDial()
        }
      })
  }

  @Builder
  private actionButton(icon: string, active: boolean, label: string) {
    Row() {
      Text(icon)
        .fontSize(28)
        .fontColor(active ? '#FFFFFF' : this.black)
        .margin({ left: 44 })
    }
    .width('47.5%')
    .height(48)
    .backgroundColor(active ? this.black : this.softGray)
    .borderRadius(20)
    .onClick(() => {
      if (label === 'Eco Mode') {
        this.ecoActive = !this.ecoActive
      }
    })
  }

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(28)
          .fontColor(this.black)
          .width(48)
          .textAlign(TextAlign.Center)
        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.gray)
            .letterSpacing(3)
          Text('Connected')
            .fontSize(12)
            .fontColor(this.blue)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)
        Text('⚙')
          .fontSize(28)
          .fontColor(this.black)
          .width(48)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(54)
      .padding({ left: 24, right: 24 })
      .margin({ top: 40 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.ringContext)
          .width(260)
          .height(260)
          .onReady(() => this.drawDial())
        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(46)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? this.black : this.gray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.gray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)
      .margin({ top: 50 })

      Row() {
        this.roundControl('⌄', -0.5)
        Text(this.isActive ? '●' : '○')
          .fontSize(32)
          .fontColor(this.isActive ? this.black : this.gray)
          .width(52)
          .height(32)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.isActive = !this.isActive
            this.drawDial()
          })
        this.roundControl('⌃', 0.5)
      }
      .width('100%')
      .margin({ top: 32 })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text('QUICK ACTIONS')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.gray)
          .width('100%')
          .margin({ bottom: 18 })
        Row() {
          this.actionButton('⟳', false, 'Fan Speed')
          Blank().width(16)
          this.actionButton('♥', this.ecoActive, 'Eco Mode')
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 40 })
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
