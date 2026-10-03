const PURE_WHITE: string = '#FFFFFF'
const TEXT_BLACK: string = '#1C1C1E'
const TEXT_GRAY: string = '#8E8E93'
const ACCENT_BLUE: string = '#007AFF'
const SOFT_GRAY_BG: string = '#F2F2F7'
const DISABLED_BG: string = '#F9F9F9'
const DISABLED_ICON: string = '#D1D1D6'
const DISABLED_BORDER: string = '#EEEEEE'

@Entry
@Component
struct Index {
  build() {
    ClimateControllerApp()
  }
}

@Component
struct ClimateControllerApp {
  build() {
    Column() {
      HeaderSection()

      Blank()
        .height(40)

      TemperatureDialSection()

      Blank()
        .height(40)

      ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 24,
      right: 24,
      top: 24,
      bottom: 24
    })
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(PURE_WHITE)
  }
}

@Component
struct HeaderSection {
  build() {
    Column() {
      Blank()
        .height(16)

      Row() {
        Stack() {
          Text('☰')
            .fontSize(32)
            .fontColor(TEXT_BLACK)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
        }
        .width(48)
        .height(48)
        .onClick(() => {
        })

        Column() {
          Text('LIVING ROOM')
            .fontSize(16)
            .fontColor(TEXT_GRAY)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(4)

          Text('Connected')
            .fontSize(24)
            .fontColor(ACCENT_BLUE)
            .fontWeight(FontWeight.Regular)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
          Text('⚙')
            .fontSize(34)
            .fontColor(TEXT_BLACK)
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.Center)
        }
        .width(48)
        .height(48)
        .onClick(() => {
        })
      }
      .width('100%')
      .height(48)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private dialContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)

  private adjustTemp(delta: number): void {
    if (!this.isActive) {
      return
    }

    let newTemp: number = this.targetTemp + delta
    newTemp = Math.max(16.0, Math.min(30.0, newTemp))
    this.targetTemp = Math.round(newTemp * 10) / 10
    this.drawDialSoon()
  }

  private drawDialSoon(): void {
    setTimeout(() => {
      this.drawDial()
    }, 0)
  }

  private drawDial(): void {
    const size: number = 280
    const center: number = size / 2
    const radius: number = 120
    const strokeWidth: number = 40

    const progress: number = (this.targetTemp - 16.0) / (30.0 - 16.0)
    const startAngle: number = 135.0 * Math.PI / 180.0
    const sweepAngle: number = 270.0 * progress * Math.PI / 180.0
    const endAngle: number = startAngle + sweepAngle

    this.dialContext.clearRect(0, 0, size, size)

    this.dialContext.beginPath()
    this.dialContext.lineWidth = strokeWidth
    this.dialContext.lineCap = 'butt'
    this.dialContext.strokeStyle = SOFT_GRAY_BG
    this.dialContext.arc(center, center, radius, 0, Math.PI * 2)
    this.dialContext.stroke()

    this.dialContext.beginPath()
    this.dialContext.lineWidth = strokeWidth
    this.dialContext.lineCap = 'round'
    this.dialContext.strokeStyle = this.isActive ? ACCENT_BLUE : TEXT_GRAY
    this.dialContext.arc(center, center, radius, startAngle, endAngle)
    this.dialContext.stroke()

    const knobX: number = center + radius * Math.cos(endAngle)
    const knobY: number = center + radius * Math.sin(endAngle)

    this.dialContext.beginPath()
    this.dialContext.fillStyle = PURE_WHITE
    this.dialContext.arc(knobX, knobY, 16, 0, Math.PI * 2)
    this.dialContext.fill()

    this.dialContext.beginPath()
    this.dialContext.fillStyle = this.isActive ? ACCENT_BLUE : TEXT_GRAY
    this.dialContext.arc(knobX, knobY, 10, 0, Math.PI * 2)
    this.dialContext.fill()
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.dialContext)
          .width(280)
          .height(280)
          .onReady(() => {
            this.drawDial()
          })
          .onAreaChange(() => {
            this.drawDialSoon()
          })

        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(64)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? TEXT_BLACK : TEXT_GRAY)
            .textAlign(TextAlign.Center)

          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT_GRAY)
            .textAlign(TextAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank()
        .height(32)

      Row({ space: 32 }) {
        RoundControlButton({
          icon: '⌄',
          enabled: this.isActive,
          action: () => {
            this.adjustTemp(-0.5)
          }
        })

        Toggle({
          type: ToggleType.Switch,
          isOn: this.isActive
        })
          .width(58)
          .height(36)
          .selectedColor(TEXT_BLACK)
          .switchPointColor(PURE_WHITE)
          .onChange((value: boolean) => {
            this.isActive = value
            this.drawDialSoon()
          })

        RoundControlButton({
          icon: '⌃',
          enabled: this.isActive,
          action: () => {
            this.adjustTemp(0.5)
          }
        })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RoundControlButton {
  @Prop icon: string = ''
  @Prop enabled: boolean = true
  action: () => void = () => {
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.icon)
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.enabled ? TEXT_BLACK : DISABLED_ICON)
        .textAlign(TextAlign.Center)
        .translate({ y: -2 })
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.enabled ? SOFT_GRAY_BG : DISABLED_BG)
    .border({
      width: this.enabled ? 0 : 1,
      color: this.enabled ? 'transparent' : DISABLED_BORDER
    })
    .onClick(() => {
      if (this.enabled) {
        this.action()
      }
    })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_GRAY)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({
          bottom: 16
        })

      Row({ space: 16 }) {
        QuickActionCard({
          icon: '⟳',
          label: 'Fan Speed',
          status: 'Auto'
        })
          .layoutWeight(1)

        QuickActionCard({
          icon: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
          .layoutWeight(1)
      }
      .width('100%')

      Blank()
        .height(16)

      Row({ space: 16 }) {
        QuickActionCard({
          icon: 'ⓘ',
          label: 'Timer',
          status: 'Set 2h'
        })
          .layoutWeight(1)

        QuickActionCard({
          icon: '⌂',
          label: 'Away',
          status: 'Off'
        })
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop status: string = ''
  @Prop isActive: boolean = false

  build() {
    Column() {
      Text(this.icon)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isActive ? PURE_WHITE : TEXT_BLACK)

      Blank()
        .layoutWeight(1)

      Column() {
        Text(this.label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? PURE_WHITE : TEXT_BLACK)

        Text(this.status)
          .fontSize(13)
          .fontColor(TEXT_GRAY)
          .margin({
            top: 2
          })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .height(100)
    .padding(16)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isActive ? TEXT_BLACK : SOFT_GRAY_BG)
  }
}