@Entry
@Component
struct ClimateControllerApp {
  build() {
    Column() {
      HeaderSection()
      Blank().height(40)
      TemperatureDialSection()
      Blank().height(40)
      ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Text('☰')
        .fontSize(24)
        .fontColor('#1C1C1E')
        .onClick(() => {})
      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontColor('#8E8E93')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text('Connected')
          .fontSize(12)
          .fontColor('#007AFF')
      }
      .alignItems(HorizontalAlign.Center)
      Text('⚙')
        .fontSize(24)
        .fontColor('#1C1C1E')
        .onClick(() => {})
    }
    .width('100%')
    .padding({ top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureDialSection {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true
  @State progress: number = (21.5 - 16) / 14
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  adjustTemp(delta: number): void {
    let newTemp: number = this.targetTemp + delta
    if (newTemp < 16) {
      newTemp = 16
    }
    if (newTemp > 30) {
      newTemp = 30
    }
    newTemp = Math.round(newTemp * 10) / 10
    this.targetTemp = newTemp
    const newProgress: number = (this.targetTemp - 16) / 14
    animateTo({ duration: 500, curve: Curve.EaseOut }, () => {
      this.progress = newProgress
    })
  }

  drawDial(): void {
    const ctx: CanvasRenderingContext2D = this.context
    const size: number = 240
    const cx: number = size / 2
    const cy: number = size / 2
    const strokeWidth: number = 40
    const startAngleDeg: number = 135
    const sweepAngleDeg: number = 270 * this.progress
    const endAngleDeg: number = startAngleDeg + sweepAngleDeg

    ctx.clearRect(0, 0, size, size)

    ctx.beginPath()
    ctx.arc(cx, cy, 120, 0, 2 * Math.PI)
    ctx.strokeStyle = '#F2F2F7'
    ctx.lineWidth = strokeWidth
    ctx.stroke()

    ctx.beginPath()
    ctx.arc(cx, cy, 100, startAngleDeg * Math.PI / 180, endAngleDeg * Math.PI / 180, false)
    ctx.strokeStyle = this.isActive ? '#007AFF' : '#8E8E93'
    ctx.lineWidth = strokeWidth
    ctx.lineCap = 'round'
    ctx.stroke()
    ctx.lineCap = 'butt'

    const knobRad: number = endAngleDeg * Math.PI / 180
    const knobX: number = cx + 120 * Math.cos(knobRad)
    const knobY: number = cy + 120 * Math.sin(knobRad)

    ctx.beginPath()
    ctx.arc(knobX, knobY, 16, 0, 2 * Math.PI)
    ctx.fillStyle = '#FFFFFF'
    ctx.fill()

    ctx.beginPath()
    ctx.arc(knobX, knobY, 10, 0, 2 * Math.PI)
    ctx.fillStyle = this.isActive ? '#007AFF' : '#8E8E93'
    ctx.fill()
  }

  build() {
    Column() {
      Stack() {
        Canvas(this.context)
          .width(240)
          .height(240)
          .onReady(() => {
            this.drawDial()
          })
        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontColor('#8E8E93')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)
      .alignContent(Alignment.Center)

      Blank().height(32)

      Row() {
        RoundControlButton({ icon: '▼', enabledState: this.isActive, onTap: () => { this.adjustTemp(-0.5) } })
        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor('#1C1C1E')
          .switchPointColor('#FFFFFF')
          .margin({ left: 32, right: 32 })
          .onChange((isOn: boolean) => {
            this.isActive = isOn
          })
        RoundControlButton({ icon: '▲', enabledState: this.isActive, onTap: () => { this.adjustTemp(0.5) } })
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct RoundControlButton {
  @Prop icon: string = ''
  onTap: () => void = () => {}
  @Prop enabledState: boolean = true

  build() {
    Stack() {
      Text(this.icon)
        .fontSize(24)
        .fontColor(this.enabledState ? '#1C1C1E' : '#D1D1D6')
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.enabledState ? '#F2F2F7' : '#F9F9F9')
    .border({ width: 1, color: this.enabledState ? '#00000000' : '#EEEEEE' })
    .onClick(() => {
      if (this.enabledState) {
        this.onTap()
      }
    })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .padding({ bottom: 16 })

      Row() {
        QuickActionCard({ icon: '↻', label: 'Fan Speed', status: 'Auto', isActive: false })
          .layoutWeight(1)
        QuickActionCard({ icon: '♥', label: 'Eco Mode', status: 'On', isActive: true })
          .layoutWeight(1)
          .margin({ left: 16 })
      }
      .width('100%')

      Blank().height(16)

      Row() {
        QuickActionCard({ icon: 'ℹ', label: 'Timer', status: 'Set 2h', isActive: false })
          .layoutWeight(1)
        QuickActionCard({ icon: '⌂', label: 'Away', status: 'Off', isActive: false })
          .layoutWeight(1)
          .margin({ left: 16 })
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
        .fontSize(24)
        .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')

      Column() {
        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isActive ? '#FFFFFF' : '#1C1C1E')
        Text(this.status)
          .fontSize(12)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(20)
    .backgroundColor(this.isActive ? '#1C1C1E' : '#F2F2F7')
  }
}
