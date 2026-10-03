const PURE_WHITE: string = '#FFFFFF'
const OFF_WHITE: string = '#FAFAFA'
const TEXT_PRIMARY: string = '#1A1A1A'
const TEXT_SECONDARY: string = '#757575'
const ACCENT_GREEN: string = '#4CAF50'
const ACCENT_WARNING: string = '#FF9800'
const DIVIDER_COLOR: string = '#EEEEEE'
const GREEN_BADGE_BG: string = '#EAF7EA'

@Entry
@Component
struct AeroSensePage {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(PURE_WHITE)

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(PURE_WHITE)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(TEXT_SECONDARY)

        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('⚙')
          .fontSize(28)
          .fontColor(TEXT_PRIMARY)
      }
      .width(48)
      .height(48)
      .backgroundColor(OFF_WHITE)
      .borderRadius(24)
      .onClick(() => {
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MainContent {
  build() {
    Scroll() {
      Column({ space: 32 }) {
        AirQualityCircle({ aqi: 42 })

        Column({ space: 16 }) {
          Row({ space: 16 }) {
            MetricCard({
              label: 'Temp',
              value: '23°C',
              iconText: 'ℹ',
              statusColor: TEXT_PRIMARY
            })
              .layoutWeight(1)

            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconText: '✓',
              statusColor: ACCENT_GREEN
            })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconText: '✓',
              statusColor: ACCENT_GREEN
            })
              .layoutWeight(1)

            MetricCard({
              label: 'CO2',
              value: '850',
              iconText: '⚠',
              statusColor: ACCENT_WARNING
            })
              .layoutWeight(1)
          }
          .width('100%')
        }
        .width('100%')

        StatusBanner()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct AirQualityCircle {
  aqi: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private degreeToRadian(degree: number): number {
    return degree * Math.PI / 180
  }

  private drawGauge(): void {
    const size: number = 220
    const lineWidth: number = 40
    const radius: number = (size - lineWidth) / 2
    const centerX: number = size / 2
    const centerY: number = size / 2
    const startAngle: number = this.degreeToRadian(135)
    const backgroundEndAngle: number = this.degreeToRadian(405)
    const progressEndAngle: number = this.degreeToRadian(245)

    this.context.clearRect(0, 0, size, size)
    this.context.lineWidth = lineWidth
    this.context.lineCap = 'round'

    this.context.beginPath()
    this.context.strokeStyle = OFF_WHITE
    this.context.arc(centerX, centerY, radius, startAngle, backgroundEndAngle, false)
    this.context.stroke()

    this.context.beginPath()
    this.context.strokeStyle = ACCENT_GREEN
    this.context.arc(centerX, centerY, radius, startAngle, progressEndAngle, false)
    this.context.stroke()

    const dotRadius: number = 12
    const dotX: number = centerX + radius * Math.cos(progressEndAngle)
    const dotY: number = centerY + radius * Math.sin(progressEndAngle)

    this.context.beginPath()
    this.context.fillStyle = PURE_WHITE
    this.context.arc(dotX, dotY, dotRadius / 2, 0, Math.PI * 2, false)
    this.context.fill()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawGauge()
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_SECONDARY)
          .letterSpacing(2)

        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT_PRIMARY)

        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ACCENT_GREEN)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(GREEN_BADGE_BG)
          .borderRadius(16)
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
  iconText: string = ''
  statusColor: string = TEXT_PRIMARY

  build() {
    Column() {
      Row() {
        Text(this.iconText)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.statusColor)

        Blank()
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)

        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Regular)
          .fontColor(TEXT_SECONDARY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(110)
    .width('100%')
    .backgroundColor(OFF_WHITE)
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
          .fontColor(TEXT_PRIMARY)

        Blank()
          .width(12)

        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TEXT_SECONDARY)
        .lineHeight(22)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .border({
      width: 1,
      color: DIVIDER_COLOR,
      radius: 20
    })
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .strokeWidth(1)
        .color(DIVIDER_COLOR)

      Row() {
        ControlIcon({
          iconText: '☰',
          description: 'Menu'
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(28)
              .fontColor(PURE_WHITE)

            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(PURE_WHITE)
          }
          .alignItems(VerticalAlign.Center)
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }
        .height(56)
        .backgroundColor(TEXT_PRIMARY)
        .borderRadius(16)
        .onClick(() => {
        })

        ControlIcon({
          iconText: '+',
          description: 'Add Room'
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding(24)
      .backgroundColor(PURE_WHITE)
    }
    .width('100%')
    .backgroundColor(PURE_WHITE)
  }
}

@Component
struct ControlIcon {
  iconText: string = ''
  description: string = ''

  build() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text(this.iconText)
        .fontSize(30)
        .fontColor(TEXT_PRIMARY)
    }
    .width(48)
    .height(48)
    .backgroundColor(PURE_WHITE)
    .border({
      width: 1,
      color: DIVIDER_COLOR,
      radius: 24
    })
    .onClick(() => {
    })
  }
}