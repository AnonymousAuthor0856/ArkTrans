@Entry
@Component
struct ClimateControllerApp {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  private readonly MIN_TEMP: number = 16.0
  private readonly MAX_TEMP: number = 30.0

  aboutToAppear() {
  }

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
        Canvas() {
          const cx = 12
          const cy = 12
          const r1 = 10
          const r2 = 6
          const teeth = 8
          const ctx = this
          // Gear body
          ctx.beginPath()
          ctx.arc(cx, cy, r1 - 2, 0, Math.PI * 2)
          ctx.fillStyle = '#1C1C1E'
          ctx.fill()
          // Center hole
          ctx.beginPath()
          ctx.arc(cx, cy, r2 - 2, 0, Math.PI * 2)
          ctx.fillStyle = '#FFFFFF'
          ctx.fill()
        }
        .width(24)
        .height(24)
        .margin({ right: 12 })
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
        Row() {
          TemperatureArc({ progress: (this.targetTemp - this.MIN_TEMP) / (this.MAX_TEMP - this.MIN_TEMP), isActive: this.isActive })
        }
        .width(280)
        .height(280)

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
            RoundedRect({ radius: 40 })
              .fill('#F2F2F7')
              .width('100%')
              .height(80)

            // Refresh icon
            Canvas() {
              const ctx = this
              ctx.beginPath()
              ctx.strokeStyle = '#1C1C1E'
              ctx.lineWidth = 2
              ctx.arc(12, 12, 9, 0.3, Math.PI * 2 - 0.3)
              ctx.stroke()
              // Arrow head
              ctx.beginPath()
              ctx.moveTo(20, 4)
              ctx.lineTo(24, 2)
              ctx.lineTo(22, 8)
              ctx.closePath()
              ctx.fillStyle = '#1C1C1E'
              ctx.fill()
            }
            .width(28)
            .height(28)
            .margin({ left: 20 })
          }
          .layoutWeight(1)
          .height(80)

          // Quick Action 2 - Heart (Active)
          Stack({ alignContent: Alignment.Start }) {
            RoundedRect({ radius: 40 })
              .fill('#1C1C1E')
              .width('100%')
              .height(80)

            // Heart icon
            Path()
              .width(28)
              .height(26)
              .commands('M14 24 L3 13 C-1 9 1 3 6 3 C9 3 12 5 14 8 C16 5 19 3 22 3 C27 3 29 9 25 13 Z')
              .fill('#FFFFFF')
              .margin({ left: 20 })
          }
          .layoutWeight(1)
          .height(80)
          .margin({ left: 16 })
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

  build() {
    Canvas() {
      const ctx = this
      const w = 280
      const h = 280
      const cx = w / 2
      const cy = h / 2
      const radius = (w - 40) / 2
      const startAngle = 135
      const sweepAngle = 270 * this.progress
      const endAngle = startAngle + sweepAngle
      const color = this.isActive ? '#007AFF' : '#8E8E93'

      ctx.beginPath()
      ctx.lineWidth = 40
      ctx.lineCap = 'round'
      ctx.strokeStyle = color
      ctx.arc(cx, cy, radius, (startAngle * Math.PI) / 180, (endAngle * Math.PI) / 180)
      ctx.stroke()

      // Knob
      const knobAngleRad = (endAngle * Math.PI) / 180
      const knobX = cx + radius * Math.cos(knobAngleRad)
      const knobY = cy + radius * Math.sin(knobAngleRad)

      // Outer white circle
      ctx.beginPath()
      ctx.arc(knobX, knobY, 16, 0, Math.PI * 2)
      ctx.fillStyle = '#FFFFFF'
      ctx.fill()

      // Inner colored circle
      ctx.beginPath()
      ctx.arc(knobX, knobY, 10, 0, Math.PI * 2)
      ctx.fillStyle = color
      ctx.fill()
    }
    .width(280)
    .height(280)
  }
}

@Component
struct PowerSwitch {
  @Link isActive: boolean

  build() {
    Stack({ alignContent: this.isActive ? Alignment.End : Alignment.Start }) {
      RoundedRect({ radius: 28 })
        .fill(this.isActive ? '#1C1C1E' : '#F2F2F7')
        .width(72)
        .height(40)

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
    .onClick(() => {
      this.isActive = !this.isActive
    })
  }
}
