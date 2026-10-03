@Entry
@Component
struct AeroSenseApp {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      this.TopHeader()
      Scroll() {
        Column({ space: 32 }) {
          this.AirQualityCircle()
          this.MetricsGrid()
          this.StatusBanner()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  TopHeader() {
    Row() {
      Column({ space: 4 }) {
        Text('Living Room')
          .fontSize(14)
          .fontColor('#757575')
          .fontWeight(FontWeight.Normal)
        Text('AeroSense')
          .fontSize(24)
          .fontColor('#1A1A1A')
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('⚙')
          .fontSize(22)
          .fontColor('#1A1A1A')
      }
      .width(48)
      .height(48)
      .backgroundColor('#FAFAFA')
      .borderRadius(24)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  AirQualityCircle() {
    Stack() {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawRing()
        })

      Column({ space: 8 }) {
        Text('AQI')
          .fontSize(14)
          .fontColor('#757575')
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text('42')
          .fontSize(80)
          .fontColor('#1A1A1A')
          .fontWeight(FontWeight.Medium)
        Text('Excellent')
          .fontSize(16)
          .fontColor('#4CAF50')
          .backgroundColor('#E8F5E9')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  @Builder
  MetricsGrid() {
    Column({ space: 16 }) {
      Row({ space: 16 }) {
        this.MetricCard('Temp', '23°C', 'ⓘ', '#1A1A1A')
        this.MetricCard('Humidity', '45%', '✓', '#4CAF50')
      }
      .width('100%')

      Row({ space: 16 }) {
        this.MetricCard('PM 2.5', '12', '✓', '#4CAF50')
        this.MetricCard('CO2', '850', '⚠', '#FF9800')
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  MetricCard(label: string, value: string, icon: string, statusColor: string) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column({ space: 2 }) {
        Text(value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text(label)
          .fontSize(12)
          .fontColor('#757575')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(110)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
  }

  @Builder
  StatusBanner() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Text('🏠')
          .fontSize(24)
          .fontColor('#1A1A1A')
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#757575')
        .lineHeight(22)
    }
    .width('100%')
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(20)
    .padding(20)
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider()
        .color('#EEEEEE')
      Row() {
        this.ControlIcon('☰', 'Menu')

        Row({ space: 8 }) {
          Text('↻')
            .fontSize(18)
            .fontColor('#FFFFFF')
          Text('Refresh Data')
            .fontSize(14)
            .fontColor('#FFFFFF')
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#1A1A1A')
        .borderRadius(16)
        .onClick(() => {})

        this.ControlIcon('+', 'Add Room')
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  ControlIcon(icon: string, desc: string) {
    Stack() {
      Text(icon)
        .fontSize(22)
        .fontColor('#1A1A1A')
    }
    .width(48)
    .height(48)
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(24)
    .alignContent(Alignment.Center)
    .accessibilityText(desc)
  }

  private drawRing(): void {
    const ctx: CanvasRenderingContext2D = this.context
    ctx.clearRect(0, 0, 220, 220)
    ctx.lineWidth = 40
    ctx.lineCap = 'round'
    // Background track (135° to 405°)
    ctx.strokeStyle = '#FAFAFA'
    ctx.beginPath()
    ctx.arc(110, 110, 70, Math.PI * 135 / 180, Math.PI * 405 / 180)
    ctx.stroke()
    // Progress track (135° + 110°)
    ctx.strokeStyle = '#4CAF50'
    ctx.beginPath()
    ctx.arc(110, 110, 70, Math.PI * 135 / 180, Math.PI * 245 / 180)
    ctx.stroke()
    // Decor dot at center + offset((w/2)*0.7, (h/2)*0.7)
    ctx.fillStyle = '#FFFFFF'
    ctx.beginPath()
    ctx.arc(110 + 110 * 0.7, 110 + 110 * 0.7, 12, 0, Math.PI * 2)
    ctx.fill()
  }
}
