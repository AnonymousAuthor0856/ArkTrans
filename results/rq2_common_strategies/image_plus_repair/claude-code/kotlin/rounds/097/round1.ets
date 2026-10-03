@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private readonly MIN_TEMP: number = 16.0
  private readonly MAX_TEMP: number = 30.0

  adjustTemp(delta: number): void {
    let newTemp = this.targetTemp + delta
    if (newTemp < this.MIN_TEMP) newTemp = this.MIN_TEMP
    if (newTemp > this.MAX_TEMP) newTemp = this.MAX_TEMP
    this.targetTemp = Math.round(newTemp * 10) / 10
  }

  build() {
    Column() {
      // Header Section
      Row() {
        // Menu Icon
        Column() {
          Column()
            .width(22)
            .height(2)
            .backgroundColor('#1C1C1E')
            .margin({ bottom: 4 })
          Column()
            .width(22)
            .height(2)
            .backgroundColor('#1C1C1E')
            .margin({ bottom: 4 })
          Column()
            .width(22)
            .height(2)
            .backgroundColor('#1C1C1E')
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)

        // Title
        Column() {
          Text('LIVING ROOM')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8E8E93')
            .letterSpacing(2)
          Text('Connected')
            .fontSize(14)
            .fontColor('#007AFF')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        // Settings Icon (gear)
        Column() {
          Text('⚙')
            .fontSize(24)
            .fontColor('#1C1C1E')
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .padding({ top: 16, left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)

      // Temperature Dial Section
      Stack({ alignContent: Alignment.Center }) {
        // Background track circle
        Circle()
          .width(280)
          .height(280)
          .fill(Color.Transparent)
          .stroke('#F2F2F7')
          .strokeWidth(40)

        // Progress arc
        TemperatureArc({ progress: (this.targetTemp - this.MIN_TEMP) / (this.MAX_TEMP - this.MIN_TEMP), isActive: this.isActive })

        // Center text
        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(80)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
          Text(this.isActive ? 'COOLING' : 'OFF')
            .fontSize(18)
            .fontColor('#8E8E93')
            .fontWeight(FontWeight.Medium)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)
      .margin({ top: 40 })

      // Temp Controls Row
      Row() {
        // Down button
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(56)
            .height(56)
            .fill(this.isActive ? '#F2F2F7' : '#F9F9F9')
          Path()
            .width(18)
            .height(12)
            .commands('M0 0 L9 12 L18 0')
            .fill(Color.Transparent)
            .stroke(this.isActive ? '#1C1C1E' : '#D1D1D6')
            .strokeWidth(3)
        }
        .width(56)
        .height(56)
        .onClick(() => {
          if (this.isActive) this.adjustTemp(-0.5)
        })

        // Power Switch
        PowerSwitch({ isActive: $isActive })
          .margin({ left: 32, right: 32 })

        // Up button
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(56)
            .height(56)
            .fill(this.isActive ? '#F2F2F7' : '#F9F9F9')
          Path()
            .width(18)
            .height(12)
            .commands('M0 12 L9 0 L18 12')
            .fill(Color.Transparent)
            .stroke(this.isActive ? '#1C1C1E' : '#D1D1D6')
            .strokeWidth(3)
        }
        .width(56)
        .height(56)
        .onClick(() => {
          if (this.isActive) this.adjustTemp(0.5)
        })
      }
      .margin({ top: 32 })

      // Quick Actions Section
      Column() {
        Text('QUICK ACTIONS')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
          .width('100%')
          .margin({ bottom: 16, top: 40, left: 4 })

        Row() {
          // Quick Action 1 - Refresh
          Stack({ alignContent: Alignment.Start }) {
            Text('↻')
              .fontSize(24)
              .fontColor('#1C1C1E')
              .margin({ left: 20 })
          }
          .layoutWeight(1)
          .height(80)
          .backgroundColor('#F2F2F7')
          .borderRadius(40)
          .justifyContent(FlexAlign.Center)

          // Quick Action 2 - Heart (Active)
          Stack({ alignContent: Alignment.Start }) {
            Text('♥')
              .fontSize(24)
              .fontColor('#FFFFFF')
              .margin({ left: 20 })
          }
          .layoutWeight(1)
          .height(80)
          .backgroundColor('#1C1C1E')
          .borderRadius(40)
          .margin({ left: 16 })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 16 })

      Blank()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TemperatureArc {
  @Link progress: number
  @Link isActive: boolean

  private onCanvasDraw(canvasCtx: CanvasRenderingContext2D): void {
    const w = 280
    const h = 280
    const cx = w / 2
    const cy = h / 2
    const radius = (w - 40) / 2
    const startAngle = 135
    const sweepAngle = 270 * this.progress
    const endAngle = startAngle + sweepAngle
    const color = this.isActive ? '#007AFF' : '#8E8E93'

    canvasCtx.beginPath()
    canvasCtx.lineWidth = 40
    canvasCtx.lineCap = 'round'
    canvasCtx.strokeStyle = color
    canvasCtx.arc(cx, cy, radius, (startAngle * Math.PI) / 180, (endAngle * Math.PI) / 180)
    canvasCtx.stroke()

    const knobAngleRad = (endAngle * Math.PI) / 180
    const knobX = cx + radius * Math.cos(knobAngleRad)
    const knobY = cy + radius * Math.sin(knobAngleRad)

    canvasCtx.beginPath()
    canvasCtx.arc(knobX, knobY, 16, 0, Math.PI * 2)
    canvasCtx.fillStyle = '#FFFFFF'
    canvasCtx.fill()

    canvasCtx.beginPath()
    canvasCtx.arc(knobX, knobY, 10, 0, Math.PI * 2)
    canvasCtx.fillStyle = color
    canvasCtx.fill()
  }

  build() {
    Canvas()
      .width(280)
      .height(280)
      .onReady((ctx: CanvasRenderingContext2D) => {
        this.onCanvasDraw(ctx)
      })
  }
}

@Component
struct PowerSwitch {
  @Link isActive: boolean

  build() {
    Stack({ alignContent: this.isActive ? Alignment.End : Alignment.Start }) {
      Circle()
        .width(34)
        .height(34)
        .fill('#FFFFFF')
        .margin({ left: 3, right: 3 })
        .shadow({ radius: 2, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
    }
    .width(72)
    .height(40)
    .padding({ left: 2, right: 2 })
    .backgroundColor(this.isActive ? '#1C1C1E' : '#F2F2F7')
    .borderRadius(28)
    .onClick(() => {
      this.isActive = !this.isActive
    })
  }
}
