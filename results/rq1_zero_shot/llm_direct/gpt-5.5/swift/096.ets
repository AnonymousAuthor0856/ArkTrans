class AppColors {
  static readonly PureWhite: string = '#FFFFFF'
  static readonly OffWhite: string = '#FAFAFA'
  static readonly TextPrimary: string = '#1A1A1A'
  static readonly TextSecondary: string = '#757575'
  static readonly AccentGreen: string = '#4CAF50'
  static readonly AccentWarning: string = '#FF9800'
  static readonly DividerColor: string = '#EEEEEE'
  static readonly AccentGreen10: string = '#1A4CAF50'
}

@Entry
@Component
struct AeroSenseContentView {
  build() {
    Stack() {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1)
          .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.PureWhite)

      Column() {
        Blank()
          .layoutWeight(1)

        BottomControlBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.PureWhite)
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
          .fontColor(AppColors.TextSecondary)

        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TextPrimary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(AppColors.TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(AppColors.OffWhite)
      .padding(0)
      .onClick(() => {
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
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
              statusColor: AppColors.TextPrimary
            })
              .layoutWeight(1)

            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconText: '✓',
              statusColor: AppColors.AccentGreen
            })
              .layoutWeight(1)
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconText: '✓',
              statusColor: AppColors.AccentGreen
            })
              .layoutWeight(1)

            MetricCard({
              label: 'CO2',
              value: '850',
              iconText: '⚠',
              statusColor: AppColors.AccentWarning
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
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
  }
}

@Component
struct AirQualityCircle {
  aqi: number = 42

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private drawCircle(): void {
    const size: number = 220
    const lineWidth: number = 40
    const radius: number = (size - lineWidth) / 2
    const center: number = size / 2
    const startAngle: number = 135 * Math.PI / 180
    const fullSweep: number = 270 * Math.PI / 180
    const progressSweep: number = 110 * Math.PI / 180
    const endAngle: number = startAngle + progressSweep

    this.context.clearRect(0, 0, size, size)

    this.context.beginPath()
    this.context.lineWidth = lineWidth
    this.context.lineCap = 'round'
    this.context.strokeStyle = AppColors.OffWhite
    this.context.arc(center, center, radius, startAngle, startAngle + fullSweep, false)
    this.context.stroke()

    this.context.beginPath()
    this.context.lineWidth = lineWidth
    this.context.lineCap = 'round'
    this.context.strokeStyle = AppColors.AccentGreen
    this.context.arc(center, center, radius, startAngle, endAngle, false)
    this.context.stroke()

    const dotRadius: number = 12
    const dotX: number = center + radius * Math.cos(endAngle)
    const dotY: number = center + radius * Math.sin(endAngle)

    this.context.beginPath()
    this.context.fillStyle = AppColors.PureWhite
    this.context.arc(dotX, dotY, dotRadius / 2, 0, Math.PI * 2, false)
    this.context.fill()
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.context)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawCircle()
        })
        .onAreaChange(() => {
          this.drawCircle()
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TextSecondary)
          .letterSpacing(2)

        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.TextPrimary)

        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.AccentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(AppColors.AccentGreen10)
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
  statusColor: string = AppColors.TextPrimary

  build() {
    Column() {
      Row() {
        Text(this.iconText)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.statusColor)

        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.TextPrimary)

        Text(this.label)
          .fontSize(12)
          .fontColor(AppColors.TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(16)
    .height(110)
    .width('100%')
    .backgroundColor(AppColors.OffWhite)
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
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TextPrimary)

        Blank()
          .width(12)

        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TextPrimary)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(AppColors.TextSecondary)
        .lineHeight(22)
        .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .border({
      width: 1,
      color: AppColors.DividerColor,
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
        .color(AppColors.DividerColor)

      Row({ space: 16 }) {
        ControlIcon({
          iconText: '☰',
          description: 'Menu'
        })

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor(AppColors.PureWhite)

            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.PureWhite)
          }
          .alignItems(VerticalAlign.Center)
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }
        .backgroundColor(AppColors.TextPrimary)
        .borderRadius(16)
        .padding(0)
        .onClick(() => {
        })

        ControlIcon({
          iconText: '+',
          description: 'Add Room'
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding(24)
      .backgroundColor(AppColors.PureWhite)
    }
    .width('100%')
    .backgroundColor(AppColors.PureWhite)
  }
}

@Component
struct ControlIcon {
  iconText: string = ''
  description: string = ''

  build() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text(this.iconText)
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(AppColors.PureWhite)
    .border({
      width: 1,
      color: AppColors.DividerColor,
      radius: 24
    })
    .padding(0)
    .accessibilityText(this.description)
    .onClick(() => {
    })
  }
}