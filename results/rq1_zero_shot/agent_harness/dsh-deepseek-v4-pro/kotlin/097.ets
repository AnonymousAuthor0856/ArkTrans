@Entry
@Component
struct Index {
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
      Stack() {
        Text('☰').fontSize(24).fontColor('#1C1C1E')
      }
      .width(48).height(48)
      .onClick(() => {})

      Column() {
        Text('LIVING ROOM').fontSize(12).fontColor('#8E8E93').letterSpacing(2).fontWeight(FontWeight.Bold)
        Text('Connected').fontSize(12).fontColor('#007AFF')
      }
      .alignItems(HorizontalAlign.Center)

      Stack() {
        Text('⚙').fontSize(24).fontColor('#1C1C1E')
      }
      .width(48).height(48)
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

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  adjustTemp(delta: number) {
    let newTemp = this.targetTemp + delta
    if (newTemp < 16) {
      newTemp = 16
    }
    if (newTemp > 30) {
      newTemp = 30
    }
    this.targetTemp = Math.round(newTemp * 10) / 10
  }

  build() {
    const progress = (this.targetTemp - 16) / (30 - 16)

    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Canvas(this.ctx)
          .width(240).height(240)
          .onReady(() => { this.drawDial(progress) })

        Column() {
          Text(this.targetTemp + '°')
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
      .width(280).height(280)

      Blank().height(32)

      Row({ space: 32 }) {
        RoundControlButton({ icon: '▼', enabled: this.isActive, onClick: () => { this.adjustTemp(-0.5) } })

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .selectedColor('#1C1C1E')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => { this.isActive = isOn })

        RoundControlButton({ icon: '▲', enabled: this.isActive, onClick: () => { this.adjustTemp(0.5) } })
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  drawDial(progress: number) {
    const ctx = this.ctx
    const w = this.ctx.width
    const h = this.ctx.height
    const cx = w / 2
    const cy = h / 2
    const radius = w / 2

    ctx.strokeStyle = '#F2F2F7'
    ctx.lineWidth = 40
    ctx.beginPath()
    ctx.arc(cx, cy, radius, 0, Math.PI * 2)
    ctx.stroke()

    const startAngle = 135 * Math.PI / 180
    const sweepAngle = 270 * progress * Math.PI / 180
    const active = this.isActive

    ctx.strokeStyle = active ? '#007AFF' : '#8E8E93'
    ctx.lineCap = 'round'
    ctx.beginPath()
    ctx.arc(cx, cy, radius, startAngle, startAngle + sweepAngle)
    ctx.stroke()

    const angleRad = startAngle + sweepAngle
    const kx = cx + radius * Math.cos(angleRad)
    const ky = cy + radius * Math.sin(angleRad)

    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(kx, ky, 16, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = active ? '#007AFF' : '#8E8E93'
    ctx.beginPath()
    ctx.arc(kx, ky, 10, 0, Math.PI * 2)
    ctx.fill()
  }
}

@Component
struct RoundControlButton {
  @Prop icon: string = ''
  @Prop enabled: boolean = true
  onClick: () => void = () => {}

  build() {
    Stack() {
      Text(this.icon)
        .fontSize(28)
        .fontColor(this.enabled ? '#1C1C1E' : '#D1D1D6')
    }
    .width(56).height(56)
    .borderRadius(28)
    .backgroundColor(this.enabled ? '#F2F2F7' : '#F9F9F9')
    .border({ width: 1, color: this.enabled ? '#00000000' : '#EEEEEE' })
    .onClick(() => {
      if (this.enabled) {
        this.onClick()
      }
    })
  }
}

@Component
struct ControlGridSection {
  build() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .margin({ bottom: 16 })

      Row({ space: 16 }) {
        QuickActionCard({ icon: '↻', label: 'Fan Speed', status: 'Auto', isActive: false }).layoutWeight(1)
        QuickActionCard({ icon: '♥', label: 'Eco Mode', status: 'On', isActive: true }).layoutWeight(1)
      }
      .width('100%')

      Blank().height(16)

      Row({ space: 16 }) {
        QuickActionCard({ icon: 'ⓘ', label: 'Timer', status: 'Set 2h', isActive: false }).layoutWeight(1)
        QuickActionCard({ icon: '⌂', label: 'Away', status: 'Off', isActive: false }).layoutWeight(1)
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
    const bgColor = this.isActive ? '#1C1C1E' : '#F2F2F7'
    const fgColor = this.isActive ? '#FFFFFF' : '#1C1C1E'

    Column() {
      Text(this.icon).fontSize(24).fontColor(fgColor)

      Column() {
        Text(this.label).fontSize(12).fontWeight(FontWeight.Bold).fontColor(fgColor)
        Text(this.status).fontSize(12).fontColor('#8E8E93')
      }
    }
    .height(100)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(bgColor)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}
