class CcColors {
  static readonly pureWhite: string = '#FFFFFFFF'
  static readonly textBlack: string = '#FF1C1C1E'
  static readonly textGray: string = '#FF8E8E93'
  static readonly accentBlue: string = '#FF007AFF'
  static readonly softGrayBg: string = '#FFF2F2F7'
  static readonly lightGrayBg: string = '#FFF9F9F9'
  static readonly lightBorderGray: string = '#FFEEEEEE'
  static readonly disabledIconGray: string = '#FFD1D1D6'
}

@Entry
@Component
struct Index {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta
    if (newTemp < 16.0) newTemp = 16.0
    if (newTemp > 30.0) newTemp = 30.0
    this.targetTemp = Math.round(newTemp * 10) / 10.0
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text('☰')
            .fontSize(28)
            .fontColor(CcColors.textBlack)

          Blank()

          Column() {
            Text('LIVING ROOM')
              .fontSize(13)
              .fontWeight(FontWeight.Bold)
              .fontColor(CcColors.textGray)
            Text('Connected')
              .fontSize(11)
              .fontColor(CcColors.accentBlue)
          }

          Blank()

          Text('⚙')
            .fontSize(28)
            .fontColor(CcColors.textBlack)
        }
        .margin({ top: 16 })

        Blank().height(40)

        Column() {
          Stack() {
            TemperatureDial({
              progress: (this.targetTemp - 16.0) / (30.0 - 16.0),
              isActive: this.isActive
            })
              .width(240)
              .height(240)

            Column() {
              Text(`${this.targetTemp.toFixed(1)}°`)
                .fontSize(45)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.isActive ? CcColors.textBlack : CcColors.textGray)
              Text(this.isActive ? 'COOLING' : 'OFF')
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(CcColors.textGray)
            }
          }
          .width(280)
          .height(280)

          Blank().height(32)

          Row() {
            Text('▼')
              .fontSize(28)
              .fontColor(this.isActive ? CcColors.textBlack : CcColors.disabledIconGray)
              .width(56)
              .height(56)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.isActive ? CcColors.softGrayBg : CcColors.lightGrayBg)
              .borderRadius(28)
              .border({ width: this.isActive ? 0 : 1, color: CcColors.lightBorderGray })
              .onClick(() => {
                if (this.isActive) this.adjustTemp(-0.5)
              })

            Toggle({ type: ToggleType.Switch, isOn: this.isActive })
              .selectedColor(CcColors.textBlack)
              .onChange((isOn: boolean) => {
                this.isActive = isOn
              })
              .margin({ left: 32, right: 32 })

            Text('▲')
              .fontSize(28)
              .fontColor(this.isActive ? CcColors.textBlack : CcColors.disabledIconGray)
              .width(56)
              .height(56)
              .textAlign(TextAlign.Center)
              .backgroundColor(this.isActive ? CcColors.softGrayBg : CcColors.lightGrayBg)
              .borderRadius(28)
              .border({ width: this.isActive ? 0 : 1, color: CcColors.lightBorderGray })
              .onClick(() => {
                if (this.isActive) this.adjustTemp(0.5)
              })
          }
        }

        Blank().height(40)

        Column() {
          Text('QUICK ACTIONS')
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(CcColors.textGray)
            .margin({ bottom: 16 })

          Row() {
            QuickActionCard({ iconName: '↻', label: 'Fan Speed', status: 'Auto', isActive: false })
            QuickActionCard({ iconName: '♥', label: 'Eco Mode', status: 'On', isActive: true })
          }

          Row() {
            QuickActionCard({ iconName: 'ⓘ', label: 'Timer', status: 'Set 2h', isActive: false })
            QuickActionCard({ iconName: '⌂', label: 'Away', status: 'Off', isActive: false })
          }
          .margin({ top: 16 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
      }
      .padding({ left: 24, right: 24 })
    }
    .backgroundColor(CcColors.pureWhite)
    .width('100%')
    .height('100%')
  }
}

@Component
struct TemperatureDial {
  @Prop progress: number = 0.0
  @Prop isActive: boolean = true
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Canvas(this.ctx)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawCanvas()
      })
  }

  drawCanvas() {
    let w = this.ctx.width
    let h = this.ctx.height
    let cx = w / 2
    let cy = h / 2
    let strokeWidth = 40
    let radius = (Math.min(w, h) - strokeWidth) / 2
    let startAngle = 135 * Math.PI / 180
    let sweepAngle = 270 * this.progress
    let endAngle = (135 + sweepAngle) * Math.PI / 180

    this.ctx.strokeStyle = CcColors.softGrayBg
    this.ctx.lineWidth = strokeWidth
    this.ctx.lineCap = 'round'
    this.ctx.beginPath()
    this.ctx.arc(cx, cy, radius, startAngle, (135 + 270) * Math.PI / 180, false)
    this.ctx.stroke()

    this.ctx.strokeStyle = this.isActive ? CcColors.accentBlue : CcColors.textGray
    this.ctx.beginPath()
    this.ctx.arc(cx, cy, radius, startAngle, endAngle, false)
    this.ctx.stroke()

    let knobAngle = (135 + sweepAngle) * Math.PI / 180
    let knobX = cx + radius * Math.cos(knobAngle)
    let knobY = cy + radius * Math.sin(knobAngle)

    this.ctx.fillStyle = CcColors.pureWhite
    this.ctx.beginPath()
    this.ctx.arc(knobX, knobY, 16, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.fillStyle = this.isActive ? CcColors.accentBlue : CcColors.textGray
    this.ctx.beginPath()
    this.ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
    this.ctx.fill()
  }
}

@Component
struct QuickActionCard {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop status: string = ''
  @Prop isActive: boolean = false

  build() {
    Column() {
      Text(this.iconName)
        .fontSize(24)
        .fontColor(this.isActive ? CcColors.pureWhite : CcColors.textBlack)
        .margin({ bottom: 8 })

      Blank()

      Column() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isActive ? CcColors.pureWhite : CcColors.textBlack)
        Text(this.status)
          .fontSize(11)
          .fontColor(CcColors.textGray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(100)
    .layoutWeight(1)
    .backgroundColor(this.isActive ? CcColors.textBlack : CcColors.softGrayBg)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 16 })
  }
}