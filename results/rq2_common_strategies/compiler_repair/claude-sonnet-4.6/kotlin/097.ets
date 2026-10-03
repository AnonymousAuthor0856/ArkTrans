import { curves } from '@kit.ArkUI'

// --- Colors ---
const PureWhite = '#FFFFFFFF'
const TextBlack = '#FF1C1C1E'
const TextGray = '#FF8E8E93'
const AccentBlue = '#FF007AFF'
const SoftGrayBg = '#FFF2F2F7'

@Entry
@Component
struct ClimateControllerApp {
  build() {
    Column({ space: 0 }) {
      HeaderSection()
      Blank().height(40)
      TemperatureDialSection()
      Blank().height(40)
      ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(PureWhite)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Button({ type: ButtonType.Circle }) {
        Text('☰').fontSize(20).fontColor(TextBlack)
      }
      .width(44)
      .height(44)
      .backgroundColor(Color.Transparent)

      Column() {
        Text('LIVING ROOM')
          .fontSize(11)
          .fontColor(TextGray)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text('Connected')
          .fontSize(12)
          .fontColor(AccentBlue)
      }
      .alignItems(HorizontalAlign.Center)

      Button({ type: ButtonType.Circle }) {
        Text('⚙').fontSize(20).fontColor(TextBlack)
      }
      .width(44)
      .height(44)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 16 })
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true
  @State animatedProgress: number = (21.5 - 16) / (30 - 16)
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private bgContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private arcContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta
    newTemp = Math.min(30, Math.max(16, newTemp))
    this.targetTemp = Math.round(newTemp * 10) / 10
    this.animatedProgress = (this.targetTemp - 16) / (30 - 16)
  }

  drawBackground() {
    const ctx = this.bgContext
    ctx.clearRect(0, 0, 240, 240)
    const cx = 120, cy = 120, r = 100
    ctx.beginPath()
    ctx.arc(cx, cy, r, 0, Math.PI * 2)
    ctx.strokeStyle = SoftGrayBg
    ctx.lineWidth = 20
    ctx.stroke()
  }

  drawArc() {
    const ctx = this.arcContext
    ctx.clearRect(0, 0, 240, 240)
    const cx = 120, cy = 120, r = 100
    const startAngle = (135 * Math.PI) / 180
    const sweepAngle = (270 * this.animatedProgress * Math.PI) / 180

    if (sweepAngle > 0) {
      ctx.beginPath()
      ctx.arc(cx, cy, r, startAngle, startAngle + sweepAngle)
      ctx.strokeStyle = this.isActive ? AccentBlue : TextGray
      ctx.lineWidth = 20
      ctx.lineCap = 'round'
      ctx.stroke()
    }

    // Draw knob
    const endAngle = startAngle + sweepAngle
    const kx = cx + r * Math.cos(endAngle)
    const ky = cy + r * Math.sin(endAngle)

    ctx.beginPath()
    ctx.arc(kx, ky, 10, 0, Math.PI * 2)
    ctx.fillStyle = PureWhite
    ctx.fill()

    ctx.beginPath()
    ctx.arc(kx, ky, 6, 0, Math.PI * 2)
    ctx.fillStyle = this.isActive ? AccentBlue : TextGray
    ctx.fill()
  }

  build() {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.bgContext)
          .width(240)
          .height(240)
          .onReady(() => {
            this.drawBackground()
          })

        Canvas(this.arcContext)
          .width(240)
          .height(240)
          .onReady(() => {
            this.drawArc()
          })

        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? TextBlack : TextGray)
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(13)
            .fontColor(TextGray)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank().height(32)

      Row({ space: 32 }) {
        RoundControlButton({
          label: '↓',
          onClickHandler: () => {
            this.adjustTemp(-0.5)
            this.drawArc()
          },
          isEnabled: this.isActive
        })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .onChange((isOn: boolean) => {
            this.isActive = isOn
            this.drawArc()
          })
          .selectedColor(TextBlack)
          .switchPointColor(PureWhite)
          .width(51)
          .height(31)

        RoundControlButton({
          label: '↑',
          onClickHandler: () => {
            this.adjustTemp(0.5)
            this.drawArc()
          },
          isEnabled: this.isActive
        })
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RoundControlButton {
  label: string = ''
  onClickHandler: () => void = () => {}
  isEnabled: boolean = true

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.label)
        .fontSize(28)
        .fontColor(this.isEnabled ? TextBlack : '#FFD1D1D6')
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.isEnabled ? SoftGrayBg : '#FFF9F9F9')
    .border({ width: 1, color: this.isEnabled ? Color.Transparent : '#FFEEEEEE', radius: 28 })
    .onClick(() => {
      if (this.isEnabled) {
        this.onClickHandler()
      }
    })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column({ space: 0 }) {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGray)
        .width('100%')
        .margin({ bottom: 16 })

      Row({ space: 16 }) {
        QuickActionCard({
          iconText: '↻',
          label: 'Fan Speed',
          status: 'Auto',
          isActive: false
        })
        QuickActionCard({
          iconText: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
      }
      .width('100%')

      Blank().height(16)

      Row({ space: 16 }) {
        QuickActionCard({
          iconText: '⏱',
          label: 'Timer',
          status: 'Set 2h',
          isActive: false
        })
        QuickActionCard({
          iconText: '⌂',
          label: 'Away',
          status: 'Off',
          isActive: false
        })
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct QuickActionCard {
  iconText: string = ''
  label: string = ''
  status: string = ''
  isActive: boolean = false

  build() {
    Column() {
      Text(this.iconText)
        .fontSize(22)
        .fontColor(this.isActive ? PureWhite : TextBlack)
        .margin({ bottom: 8 })

      Column({ space: 2 }) {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? PureWhite : TextBlack)
        Text(this.status)
          .fontSize(12)
          .fontColor(TextGray)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .backgroundColor(this.isActive ? TextBlack : SoftGrayBg)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}