const WHITE: string = '#FFFFFF'
const BLACK: string = '#1C1C1E'
const GRAY: string = '#8E8E93'
const BLUE: string = '#007AFF'
const SOFT_GRAY: string = '#F2F2F7'
const LIGHT_GRAY: string = '#F9F9F9'
const BORDER_GRAY: string = '#EEEEEE'
const DISABLED_GRAY: string = '#D1D1D6'

@Entry
@Component
struct ClimateController {
  @State private targetTemp: number = 21.5
  @State private isActive: boolean = true
  private dialSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private dialContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.dialSettings)

  aboutToAppear(): void {
    setTimeout(() => {
      this.drawDial()
    }, 0)
  }

  private adjustTemp(delta: number): void {
    if (!this.isActive) {
      return
    }
    const next: number = Math.max(16.0, Math.min(30.0, this.targetTemp + delta))
    this.targetTemp = Math.round(next * 10) / 10
    setTimeout(() => {
      this.drawDial()
    }, 0)
  }

  private drawDial(): void {
    const ctx: CanvasRenderingContext2D = this.dialContext
    const size: number = 240
    const stroke: number = 40
    const radius: number = (size - stroke) / 2
    const center: number = size / 2
    const progress: number = (this.targetTemp - 16.0) / 14.0
    const start: number = 135 * Math.PI / 180
    const end: number = (135 + 270 * progress) * Math.PI / 180

    ctx.clearRect(0, 0, size, size)
    ctx.lineWidth = stroke
    ctx.lineCap = 'round'
    ctx.strokeStyle = SOFT_GRAY
    ctx.beginPath()
    ctx.arc(center, center, radius, 0, Math.PI * 2)
    ctx.stroke()

    ctx.strokeStyle = this.isActive ? BLUE : GRAY
    ctx.beginPath()
    ctx.arc(center, center, radius, start, end, false)
    ctx.stroke()

    const knobX: number = center + radius * Math.cos(end)
    const knobY: number = center + radius * Math.sin(end)
    ctx.fillStyle = WHITE
    ctx.beginPath()
    ctx.arc(knobX, knobY, 16, 0, Math.PI * 2)
    ctx.fill()
    ctx.fillStyle = this.isActive ? BLUE : GRAY
    ctx.beginPath()
    ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
    ctx.fill()
  }

  @Builder
  private iconText(symbol: string, color: string = BLACK, size: number = 28): void {
    Text(symbol)
      .fontSize(size)
      .fontColor(color)
      .fontWeight(FontWeight.Medium)
      .textAlign(TextAlign.Center)
  }

  @Builder
  private roundControl(symbol: string, action: () => void): void {
    Button() {
      this.iconText(symbol, this.isActive ? BLACK : DISABLED_GRAY, 31)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.isActive ? SOFT_GRAY : LIGHT_GRAY)
    .border({
      width: this.isActive ? 0 : 1,
      color: BORDER_GRAY
    })
    .enabled(this.isActive)
    .onClick(action)
  }

  @Builder
  private quickAction(symbol: string, label: string, status: string, active: boolean = false): void {
    Column() {
      this.iconText(symbol, active ? WHITE : BLACK, 29)
      Blank()
        .height(8)
      Blank()
        .layoutWeight(1)
      Column() {
        Text(label)
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(active ? WHITE : BLACK)
        Text(status)
          .fontSize(15)
          .fontColor(GRAY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(100)
    .layoutWeight(1)
    .borderRadius(20)
    .backgroundColor(active ? BLACK : SOFT_GRAY)
  }

  build(): void {
    Column() {
      Row() {
        this.iconText('☰', BLACK, 28)
        Blank()
        Column() {
          Text('LIVING ROOM')
            .fontSize(13)
            .fontWeight(FontWeight.Bold)
            .fontColor(GRAY)
            .letterSpacing(2)
          Text('Connected')
            .fontSize(11)
            .fontColor(BLUE)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)
        Blank()
        this.iconText('⚙', BLACK, 27)
      }
      .width('100%')
      .height(48)
      .justifyContent(FlexAlign.SpaceBetween)

      Blank()
        .height(40)

      Column() {
        Stack({ alignContent: Alignment.Center }) {
          Canvas(this.dialContext)
            .width(240)
            .height(240)
            .onReady(() => {
              this.drawDial()
            })
          Column() {
            Text(`${this.targetTemp.toFixed(1)}°`)
              .fontSize(45)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isActive ? BLACK : GRAY)
            Text(this.isActive ? 'COOLING' : 'OFF')
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor(GRAY)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)
        Row() {
          this.roundControl('⌄', () => this.adjustTemp(-0.5))
          Toggle({ type: ToggleType.Switch, isOn: this.isActive })
            .selectedColor(BLACK)
            .switchPointColor(WHITE)
            .width(102)
            .height(56)
            .onChange((value: boolean) => {
              this.isActive = value
            })
          this.roundControl('⌃', () => this.adjustTemp(0.5))
        }
        .width('100%')
        .margin({ top: 32 })
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 0, right: 0 })
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .height(40)

      Column() {
        Text('QUICK ACTIONS')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(GRAY)
          .letterSpacing(1)
          .margin({ bottom: 16 })
          .alignSelf(ItemAlign.Start)

        Row() {
          this.quickAction('↻', 'Fan Speed', 'Auto')
          Blank()
            .width(16)
          this.quickAction('♥', 'Eco Mode', 'On', true)
        }
        .width('100%')
        .height(100)

        Row() {
          this.quickAction('●', 'Timer', 'Set 2h')
          Blank()
            .width(16)
          this.quickAction('⌂', 'Away', 'Off')
        }
        .width('100%')
        .height(100)
        .margin({ top: 16 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WHITE)
    .padding({
      left: 48,
      right: 48,
      top: 16,
      bottom: 24
    })
  }
}
