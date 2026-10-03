@Entry
@Component
struct ClimateControllerPage {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private adjustTemp(delta: number): void {
    let newTemp = Math.min(Math.max(this.targetTemp + delta, 16.0), 30.0)
    this.targetTemp = Math.round(newTemp * 10) / 10.0
  }

  build() {
    Stack() {
      Column() { Blank() }
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFFFF')

      Column() {
        HeaderSection()
          .margin({ top: 16 })

        Blank().height(40)

        TemperatureDialSection({
          targetTemp: $targetTemp,
          isActive: $isActive,
          onAdjustTemp: (delta: number) => this.adjustTemp(delta)
        })

        Blank().height(40)

        ControlGridSection()

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Text('☰')
        .fontSize(28)
        .fontColor('#FF1C1C1E')

      Blank()

      Column() {
        Text('LIVING ROOM')
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF8E8E93')
          .letterSpacing(2)
        Text('Connected')
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FF007AFF')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Text('⚙')
        .fontSize(28)
        .fontColor('#FF1C1C1E')
    }
    .width('100%')
  }
}

@Component
struct TemperatureDialSection {
  @Link targetTemp: number
  @Link isActive: boolean
  onAdjustTemp: (delta: number) => void = () => {}

  private get progress(): number {
    return (this.targetTemp - 16.0) / (30.0 - 16.0)
  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        TemperatureDialCanvas({ progress: this.progress, isActive: this.isActive })
          .width(240)
          .height(240)

        Column() {
          Text(this.targetTemp.toFixed(1) + '°')
            .fontSize(45)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#FF1C1C1E' : '#FF8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(15)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF8E8E93')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Blank().height(32)

      Row() {
        RoundControlButton({
          iconSymbol: '∨',
          isEnabled: this.isActive,
          onTap: () => this.onAdjustTemp(-0.5)
        })

        Blank().width(32)

        Toggle({ type: ToggleType.Switch, isOn: this.isActive })
          .onChange((isOn: boolean) => {
            this.isActive = isOn
          })
          .selectedColor('#FF1C1C1E')
          .switchPointColor('#FFFFFFFF')
          .height(32)

        Blank().width(32)

        RoundControlButton({
          iconSymbol: '∧',
          isEnabled: this.isActive,
          onTap: () => this.onAdjustTemp(0.5)
        })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct TemperatureDialCanvas {
  @Prop progress: number = 0.0
  @Prop isActive: boolean = true

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private readonly DIAL_SIZE: number = 240
  private readonly STROKE_WIDTH: number = 40
  private readonly START_ANGLE_DEG: number = 135
  private readonly TOTAL_SWEEP_DEG: number = 270

  aboutToAppear(): void {
    this.drawDial()
  }

  aboutToUpdate(): void {
    this.drawDial()
  }

  private drawDial(): void {
    const size = this.DIAL_SIZE
    const strokeWidth = this.STROKE_WIDTH
    const startAngleDeg = this.START_ANGLE_DEG
    const totalSweepDeg = this.TOTAL_SWEEP_DEG
    const sweepAngleDeg = totalSweepDeg * this.progress
    const endAngleDeg = startAngleDeg + sweepAngleDeg

    const radius = (size - strokeWidth) / 2
    const centerX = size / 2
    const centerY = size / 2

    const startAngleRad = (startAngleDeg * Math.PI) / 180
    const trackEndAngleRad = ((startAngleDeg + totalSweepDeg) * Math.PI) / 180
    const endAngleRad = (endAngleDeg * Math.PI) / 180

    this.ctx.clearRect(0, 0, size, size)

    // Draw background track
    this.ctx.beginPath()
    this.ctx.lineWidth = strokeWidth
    this.ctx.lineCap = 'round'
    this.ctx.strokeStyle = '#FFF2F2F7'
    this.ctx.arc(centerX, centerY, radius, startAngleRad, trackEndAngleRad)
    this.ctx.stroke()

    // Draw progress arc
    if (sweepAngleDeg > 0.01) {
      this.ctx.beginPath()
      this.ctx.lineWidth = strokeWidth
      this.ctx.lineCap = 'round'
      this.ctx.strokeStyle = this.isActive ? '#FF007AFF' : '#FF8E8E93'
      this.ctx.arc(centerX, centerY, radius, startAngleRad, endAngleRad)
      this.ctx.stroke()
    }

    // Draw knob
    const knobX = centerX + radius * Math.cos(endAngleRad)
    const knobY = centerY + radius * Math.sin(endAngleRad)

    this.ctx.beginPath()
    this.ctx.fillStyle = '#FFFFFFFF'
    this.ctx.arc(knobX, knobY, 16, 0, Math.PI * 2)
    this.ctx.fill()

    this.ctx.beginPath()
    this.ctx.fillStyle = this.isActive ? '#FF007AFF' : '#FF8E8E93'
    this.ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
    this.ctx.fill()
  }

  build() {
    Canvas(this.ctx)
      .width(this.DIAL_SIZE)
      .height(this.DIAL_SIZE)
      .onReady(() => {
        this.drawDial()
      })
  }
}

@Component
struct RoundControlButton {
  iconSymbol: string = '+'
  isEnabled: boolean = true
  onTap: () => void = () => {}

  build() {
    Stack() {
      Text(this.iconSymbol)
        .fontSize(28)
        .fontColor(this.isEnabled ? '#FF1C1C1E' : '#FFD1D1D6')
    }
    .width(56)
    .height(56)
    .backgroundColor(this.isEnabled ? '#FFF2F2F7' : '#FFF9F9F9')
    .borderRadius(28)
    .border({
      width: this.isEnabled ? 0 : 1,
      color: this.isEnabled ? '#00000000' : '#FFEEEEEE'
    })
    .onClick(() => {
      if (this.isEnabled) {
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
        .fontColor('#FF8E8E93')
        .margin({ bottom: 16 })

      Row() {
        QuickActionCard({
          iconSymbol: '↻',
          label: 'Fan Speed',
          status: 'Auto',
          isActive: false
        })
        .layoutWeight(1)

        Blank().width(16)

        QuickActionCard({
          iconSymbol: '♥',
          label: 'Eco Mode',
          status: 'On',
          isActive: true
        })
        .layoutWeight(1)
      }
      .width('100%')
      .margin({ bottom: 16 })

      Row() {
        QuickActionCard({
          iconSymbol: 'ⓘ',
          label: 'Timer',
          status: 'Set 2h',
          isActive: false
        })
        .layoutWeight(1)

        Blank().width(16)

        QuickActionCard({
          iconSymbol: '⌂',
          label: 'Away',
          status: 'Off',
          isActive: false
        })
        .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct QuickActionCard {
  iconSymbol: string = '+'
  label: string = ''
  status: string = ''
  isActive: boolean = false

  build() {
    Column() {
      Text(this.iconSymbol)
        .fontSize(24)
        .fontColor(this.isActive ? '#FFFFFFFF' : '#FF1C1C1E')
        .margin({ bottom: 8 })

      Blank()

      Column() {
        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isActive ? '#FFFFFFFF' : '#FF1C1C1E')
        Text(this.status)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor('#FF8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isActive ? '#FF1C1C1E' : '#FFF2F2F7')
    .borderRadius(20)
  }
}
