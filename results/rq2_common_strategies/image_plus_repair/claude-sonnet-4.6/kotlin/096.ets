// Index.ets

// --- Colors ---
const PureWhite = '#FFFFFFFF'
const OffWhite = '#FFFAFAFA'
const TextPrimary = '#FF1A1A1A'
const TextSecondary = '#FF757575'
const AccentGreen = '#FF4CAF50'
const AccentWarning = '#FFFF9800'
const DividerColor = '#FFEEEEEE'
const AccentGreenBg = '#1A4CAF50'

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      // Top Header
      TopHeader()

      // Main Content (scrollable)
      Scroll() {
        Column({ space: 32 }) {
          AirQualityCircle({ aqi: 42 })
          MetricsGrid()
          StatusBanner()
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Control Bar
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(14)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Normal)
        Text('AeroSense')
          .fontSize(28)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Text('⚙')
          .fontSize(20)
          .fontColor(TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(OffWhite)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct AirQualityCircle {
  @Prop aqi: number = 42
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          const ctx = this.context
          const cx = 110
          const cy = 110
          const radius = 90
          const strokeWidth = 20

          // Background track
          ctx.beginPath()
          ctx.arc(cx, cy, radius, (135 * Math.PI) / 180, (405 * Math.PI) / 180)
          ctx.strokeStyle = OffWhite
          ctx.lineWidth = strokeWidth
          ctx.lineCap = 'round'
          ctx.stroke()

          // Progress track (AQI 42 ~ 40% of 270 degrees)
          ctx.beginPath()
          ctx.arc(cx, cy, radius, (135 * Math.PI) / 180, (245 * Math.PI) / 180)
          ctx.strokeStyle = AccentGreen
          ctx.lineWidth = strokeWidth
          ctx.lineCap = 'round'
          ctx.stroke()
        })

      Column() {
        Text('AQI')
          .fontSize(12)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Medium)
        Text('Excellent')
          .fontSize(16)
          .fontColor(AccentGreen)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AccentGreenBg)
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(280)
  }
}

@Component
struct MetricCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconText: string = ''
  @Prop statusColor: string = TextPrimary

  build() {
    Column() {
      Row() {
        Text(this.iconText)
          .fontSize(18)
          .fontColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(110)
    .padding(16)
    .backgroundColor(OffWhite)
    .borderRadius(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct MetricsGrid {
  build() {
    Column({ space: 16 }) {
      Row({ space: 16 }) {
        MetricCard({
          label: 'Temp',
          value: '23°C',
          iconText: 'ℹ',
          statusColor: TextPrimary
        })
          .layoutWeight(1)
        MetricCard({
          label: 'Humidity',
          value: '45%',
          iconText: '✓',
          statusColor: AccentGreen
        })
          .layoutWeight(1)
      }
      .width('100%')

      Row({ space: 16 }) {
        MetricCard({
          label: 'PM 2.5',
          value: '12',
          iconText: '✔',
          statusColor: AccentGreen
        })
          .layoutWeight(1)
        MetricCard({
          label: 'CO2',
          value: '850',
          iconText: '⚠',
          statusColor: AccentWarning
        })
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct StatusBanner {
  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Text('🏠')
          .fontSize(20)
          .fontColor(TextPrimary)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
      }
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TextSecondary)
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: DividerColor, radius: 20 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DividerColor)
        .strokeWidth(1)

      Row() {
        // Menu icon button
        Button({ type: ButtonType.Circle }) {
          Text('☰')
            .fontSize(18)
            .fontColor(TextPrimary)
        }
        .width(48)
        .height(48)
        .backgroundColor(PureWhite)
        .border({ width: 1, color: DividerColor, radius: 24 })

        // Refresh Data button
        Button() {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor(PureWhite)
            Text('Refresh Data')
              .fontSize(14)
              .fontColor(PureWhite)
              .fontWeight(FontWeight.Medium)
          }
        }
        .backgroundColor(TextPrimary)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .height(52)

        // Add icon button
        Button({ type: ButtonType.Circle }) {
          Text('+')
            .fontSize(22)
            .fontColor(TextPrimary)
        }
        .width(48)
        .height(48)
        .backgroundColor(PureWhite)
        .border({ width: 1, color: DividerColor, radius: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(PureWhite)
  }
}