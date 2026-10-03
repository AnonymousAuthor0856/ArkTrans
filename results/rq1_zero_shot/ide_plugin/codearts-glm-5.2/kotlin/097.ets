class AppTokens {
  static readonly Colors = {
    pureWhite: '#FFFFFFFF',
    textBlack: '#FF1C1C1E',
    textGray: '#FF8E8E93',
    accentBlue: '#FF007AFF',
    softGrayBg: '#FFF2F2F7',
    activeOrange: '#FFFF9500',
    disabledBg: '#FFF9F9F9',
    disabledBorder: '#FFEEEEEE',
    disabledIcon: '#FFD1D1D6',
    transparent: '#00000000'
  }
}

@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true
  private isCanvasReady: boolean = false
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private adjustTemp(delta: number) {
    let newTemp = Math.max(16.0, Math.min(30.0, this.targetTemp + delta))
    this.targetTemp = Math.round(newTemp * 10) / 10.0
    this.drawDial()
  }

  private drawDial() {
    if (!this.isCanvasReady) {
      return
    }
    let ctx = this.context
    let cx = 120
    let cy = 120
    let radius = 100

    ctx.clearRect(0, 0, 240, 240)

    ctx.strokeStyle = AppTokens.Colors.softGrayBg
    ctx.lineWidth = 40
    ctx.lineCap = 'butt'
    ctx.beginPath()
    ctx.arc(cx, cy, radius, 0, Math.PI * 2)
    ctx.stroke()

    let progress = (this.targetTemp - 16) / (30 - 16)
    let sweepAngle = 270 * progress
    let startAngle = 135

    ctx.strokeStyle = this.isActive ? AppTokens.Colors.accentBlue : AppTokens.Colors.textGray
    ctx.lineWidth = 40
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.arc(cx, cy, radius, startAngle * Math.PI / 180, (startAngle + sweepAngle) * Math.PI / 180)
    ctx.stroke()

    let knobAngle = (startAngle + sweepAngle) * Math.PI / 180
    let knobX = cx + radius * Math.cos(knobAngle)
    let knobY = cy + radius * Math.sin(knobAngle)

    ctx.fillStyle = AppTokens.Colors.pureWhite
    ctx.beginPath()
    ctx.arc(knobX, knobY, 16, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = this.isActive ? AppTokens.Colors.accentBlue : AppTokens.Colors.textGray
    ctx.beginPath()
    ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
    ctx.fill()
  }

  build() {
    Column() {
      Row() {
        Text('☰')
          .fontSize(24)
          .fontColor(AppTokens.Colors.textBlack)

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.textGray)
            .letterSpacing(2)
          Text('Connected')
            .fontSize(12)
            .fontColor(AppTokens.Colors.accentBlue)
        }
        .alignItems(HorizontalAlign.Center)

        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.textBlack)
      }
      .width('100%')
      .padding({ top: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Stack() {
          Canvas(this.context)
            .width(240)
            .height(240)
            .onReady(() => {
              this.isCanvasReady = true
              this.drawDial()
            })

          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.isActive ? AppTokens.Colors.textBlack : AppTokens.Colors.textGray)
            Text(this.isActive ? 'COOLING' : 'OFF')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.textGray)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width(280)
        .height(280)

        Row() {
          Row() {
            Text('↓')
              .fontSize(28)
              .fontColor(this.isActive ? AppTokens.Colors.textBlack : AppTokens.Colors.disabledIcon)
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(this.isActive ? AppTokens.Colors.softGrayBg : AppTokens.Colors.disabledBg)
          .border({ width: 1, color: this.isActive ? AppTokens.Colors.transparent : AppTokens.Colors.disabledBorder })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            if (this.isActive) {
              this.adjustTemp(-0.5)
            }
          })

          Toggle({ type: ToggleType.Switch, isOn: this.isActive })
            .selectedColor(AppTokens.Colors.textBlack)
            .onChange((isOn: boolean) => {
              this.isActive = isOn
              this.drawDial()
            })

          Row() {
            Text('↑')
              .fontSize(28)
              .fontColor(this.isActive ? AppTokens.Colors.textBlack : AppTokens.Colors.disabledIcon)
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(this.isActive ? AppTokens.Colors.softGrayBg : AppTokens.Colors.disabledBg)
          .border({ width: 1, color: this.isActive ? AppTokens.Colors.transparent : AppTokens.Colors.disabledBorder })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
          .onClick(() => {
            if (this.isActive) {
              this.adjustTemp(0.5)
            }
          })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 32 })
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 40 })

      Column() {
        Text('QUICK ACTIONS')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.textGray)
          .margin({ bottom: 16 })

        Row() {
          QuickActionCard({ icon: '↻', label: 'Fan Speed', status: 'Auto', isActive: false })
            .layoutWeight(1)
          QuickActionCard({ icon: '♥', label: 'Eco Mode', status: 'On', isActive: true })
            .layoutWeight(1)
            .margin({ left: 16 })
        }
        .width('100%')

        Row() {
          QuickActionCard({ icon: 'ℹ', label: 'Timer', status: 'Set 2h', isActive: false })
            .layoutWeight(1)
          QuickActionCard({ icon: '⌂', label: 'Away', status: 'Off', isActive: false })
            .layoutWeight(1)
            .margin({ left: 16 })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 40 })
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor(AppTokens.Colors.pureWhite)
  }
}

@Component
struct QuickActionCard {
  @Prop icon: string
  @Prop label: string
  @Prop status: string
  @Prop isActive: boolean = false

  build() {
    Column() {
      Text(this.icon)
        .fontSize(24)
        .fontColor(this.isActive ? AppTokens.Colors.pureWhite : AppTokens.Colors.textBlack)

      Column() {
        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? AppTokens.Colors.pureWhite : AppTokens.Colors.textBlack)
        Text(this.status)
          .fontSize(12)
          .fontColor(AppTokens.Colors.textGray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .height(100)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(this.isActive ? AppTokens.Colors.textBlack : AppTokens.Colors.softGrayBg)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}