const PureWhite: ResourceColor = '#FFFFFFFF'
const OffWhite: ResourceColor = '#FFFAFAFA'
const TextPrimary: ResourceColor = '#FF1A1A1A'
const TextSecondary: ResourceColor = '#FF757575'
const AccentGreen: ResourceColor = '#FF4CAF50'
const AccentWarning: ResourceColor = '#FFFF9800'
const DividerColor: ResourceColor = '#FFEEEEEE'
const AccentGreenLight: ResourceColor = '#1A4CAF50'

@Entry
@Component
struct AeroSenseApp {
  build() {
    Column() {
      TopHeader()

      Scroll() {
        Column({ space: 32 }) {
          AirQualityCircle({ aqi: 42 })

          Column() {
            Row({ space: 16 }) {
              MetricCard({
                label: 'Temp',
                value: '23°C',
                icon: 'ℹ',
                statusColor: TextPrimary
              })
                .layoutWeight(1)

              MetricCard({
                label: 'Humidity',
                value: '45%',
                icon: '✓',
                statusColor: AccentGreen
              })
                .layoutWeight(1)
            }
            .width('100%')

            Blank()
              .height(16)

            Row({ space: 16 }) {
              MetricCard({
                label: 'PM 2.5',
                value: '12',
                icon: '✓',
                statusColor: AccentGreen
              })
                .layoutWeight(1)

              MetricCard({
                label: 'CO2',
                value: '850',
                icon: '⚠',
                statusColor: AccentWarning
              })
                .layoutWeight(1)
            }
            .width('100%')
          }
          .width('100%')

          StatusBanner()
        }
        .width('100%')
        .padding({
          left: 24,
          right: 24,
          top: 16,
          bottom: 16
        })
      }
      .layoutWeight(1)
      .width('100%')

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
          .fontSize(16)
          .fontColor(TextSecondary)
          .fontWeight(FontWeight.Regular)

        Text('AeroSense')
          .fontSize(28)
          .fontColor(TextPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(OffWhite)
    }
    .width('100%')
    .padding({
      left: 24,
      right: 24,
      top: 24,
      bottom: 24
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(PureWhite)
  }
}

@Component
struct AirQualityCircle {
  aqi: number = 42

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawRing() {
    this.canvasContext.clearRect(0, 0, 220, 220)

    this.canvasContext.beginPath()
    this.canvasContext.lineWidth = 40
    this.canvasContext.lineCap = 'round'
    this.canvasContext.strokeStyle = '#FFFAFAFA'
    this.canvasContext.arc(110, 110, 80, 135 * Math.PI / 180, 405 * Math.PI / 180, false)
    this.canvasContext.stroke()

    this.canvasContext.beginPath()
    this.canvasContext.lineWidth = 40
    this.canvasContext.lineCap = 'round'
    this.canvasContext.strokeStyle = '#FF4CAF50'
    this.canvasContext.arc(110, 110, 80, 135 * Math.PI / 180, 245 * Math.PI / 180, false)
    this.canvasContext.stroke()

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = '#FFFFFFFF'
    this.canvasContext.arc(187, 187, 12, 0, 2 * Math.PI)
    this.canvasContext.fill()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.canvasContext)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawRing()
        })

      Column() {
        Text('AQI')
          .fontSize(14)
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
          .backgroundColor(AccentGreenLight)
          .borderRadius(16)
          .padding({
            left: 12,
            right: 12,
            top: 6,
            bottom: 6
          })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }
}

@Component
struct MetricCard {
  label: string = ''
  value: string = ''
  icon: string = ''
  statusColor: ResourceColor = TextPrimary

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(20)
          .fontColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
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
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(OffWhite)
    .borderRadius(24)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('⌂')
          .fontSize(24)
          .fontColor(TextPrimary)

        Blank()
          .width(12)

        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextPrimary)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TextSecondary)
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .border({
      width: 1,
      color: DividerColor,
      radius: 20
    })
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
        ControlIcon({
          icon: '☰',
          desc: 'Menu'
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row() {
            Text('↻')
              .fontSize(18)
              .fontColor(PureWhite)

            Blank()
              .width(8)

            Text('Refresh Data')
              .fontSize(14)
              .fontColor(PureWhite)
              .fontWeight(FontWeight.Medium)
          }
          .alignItems(VerticalAlign.Center)
        }
        .backgroundColor(TextPrimary)
        .borderRadius(16)
        .padding({
          left: 24,
          right: 24,
          top: 16,
          bottom: 16
        })

        ControlIcon({
          icon: '+',
          desc: 'Add Room'
        })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(PureWhite)
  }
}

@Component
struct ControlIcon {
  icon: string = ''
  desc: string = ''

  build() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text(this.icon)
        .fontSize(24)
        .fontColor(TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(PureWhite)
    .border({
      width: 1,
      color: DividerColor,
      radius: 24
    })
  }
}