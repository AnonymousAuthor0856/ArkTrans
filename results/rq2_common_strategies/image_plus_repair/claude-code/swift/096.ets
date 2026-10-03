// AeroSense - Air Quality Monitoring App
// Converted from SwiftUI to ArkTS

// MARK: - Color Constants
class AppColors {
  static readonly PureWhite: string = '#FFFFFFFF'
  static readonly OffWhite: string = '#FFFAFAFA'
  static readonly TextPrimary: string = '#FF1A1A1A'
  static readonly TextSecondary: string = '#FF757575'
  static readonly AccentGreen: string = '#FF4CAF50'
  static readonly AccentWarning: string = '#FFFF9800'
  static readonly DividerColor: string = '#FFEEEEEE'
  static readonly AccentGreenBg: string = '#1A4CAF50'
}

// MARK: - Top Header Component
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

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(AppColors.TextPrimary)
      }
      .width(48)
      .height(48)
      .backgroundColor(AppColors.OffWhite)
      .borderRadius(24)
      .type(ButtonType.Circle)
    }
    .width('100%')
  }
}

// MARK: - Air Quality Circle Component
@Component
struct AirQualityCircle {
  @Prop aqi: number = 42

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.onDraw.bind(this))
        .width(220)
        .height(220)

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TextSecondary)
          .letterSpacing(2)

        Text(this.aqi.toString())
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.TextPrimary)

        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.AccentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(AppColors.AccentGreenBg)
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  private onDraw(canvas: CanvasRenderingContext2D) {
    const lineWidth = 40
    const size = 220
    const radius = (Math.min(size, size) - lineWidth) / 2
    const centerX = size / 2
    const centerY = size / 2

    const startRad = (135 * Math.PI) / 180
    const endRad = ((135 + 270) * Math.PI) / 180

    canvas.beginPath()
    canvas.lineWidth = lineWidth
    canvas.lineCap = 'round'
    canvas.strokeStyle = AppColors.OffWhite
    canvas.arc(centerX, centerY, radius, startRad, endRad, false)
    canvas.stroke()

    const sweepAngle = 270 * (this.aqi / 100)
    const progressEndRad = ((135 + sweepAngle) * Math.PI) / 180
    canvas.beginPath()
    canvas.strokeStyle = AppColors.AccentGreen
    canvas.lineWidth = lineWidth
    canvas.lineCap = 'round'
    canvas.arc(centerX, centerY, radius, startRad, progressEndRad, false)
    canvas.stroke()

    const dotRadius = 6
    const dotX = centerX + radius * Math.cos(progressEndRad)
    const dotY = centerY + radius * Math.sin(progressEndRad)
    canvas.beginPath()
    canvas.fillStyle = AppColors.PureWhite
    canvas.arc(dotX, dotY, dotRadius, 0, Math.PI * 2)
    canvas.fill()
  }
}

// MARK: - Metric Card Component
@Component
struct MetricCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconChar: string = 'i'
  @Prop statusColor: string = AppColors.TextPrimary

  build() {
    Column() {
      Row() {
        Text(this.iconChar)
          .fontSize(20)
          .fontColor(this.statusColor)
        Blank()
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.TextPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(AppColors.TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(110)
    .width('100%')
    .layoutWeight(1)
    .backgroundColor(AppColors.OffWhite)
    .borderRadius(24)
  }
}

// MARK: - Status Banner Component
@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('⌂')
          .fontSize(24)
          .fontColor(AppColors.TextPrimary)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.TextPrimary)
          .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(AppColors.TextSecondary)
        .lineHeight(22)
        .width('100%')
        .margin({ top: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .border({ width: 1, color: AppColors.DividerColor, radius: 20 })
  }
}

// MARK: - Control Icon Component
@Component
struct ControlIcon {
  @Prop iconChar: string = '+'

  build() {
    Button() {
      Text(this.iconChar)
        .fontSize(24)
        .fontColor(AppColors.TextPrimary)
    }
    .width(48)
    .height(48)
    .backgroundColor(AppColors.PureWhite)
    .border({ width: 1, color: AppColors.DividerColor })
    .borderRadius(24)
    .type(ButtonType.Circle)
  }
}

// MARK: - Bottom Control Bar Component
@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(AppColors.DividerColor)
        .strokeWidth(1)

      Row() {
        ControlIcon({ iconChar: '☰' })

        Blank()

        Button() {
          Row() {
            Text('↻')
              .fontSize(18)
              .fontColor(AppColors.PureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.PureWhite)
              .margin({ left: 8 })
          }
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(AppColors.TextPrimary)
        .borderRadius(16)
        .height(56)

        Blank()

        ControlIcon({ iconChar: '+' })
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.PureWhite)
    }
    .width('100%')
  }
}

// MARK: - Main Content Component
@Component
struct MainContent {
  build() {
    Scroll() {
      Column() {
        AirQualityCircle({ aqi: 42 })

        Column() {
          Row() {
            MetricCard({
              label: 'Temp',
              value: '23°C',
              iconChar: 'i',
              statusColor: AppColors.TextPrimary
            })
            MetricCard({
              label: 'Humidity',
              value: '45%',
              iconChar: '✓',
              statusColor: AppColors.AccentGreen
            })
          }
          .width('100%')

          Row() {
            MetricCard({
              label: 'PM 2.5',
              value: '12',
              iconChar: '✓',
              statusColor: AppColors.AccentGreen
            })
            MetricCard({
              label: 'CO2',
              value: '850',
              iconChar: '!',
              statusColor: AppColors.AccentWarning
            })
          }
          .width('100%')
          .margin({ top: 16 })
        }
        .width('100%')

        StatusBanner()
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// MARK: - Main Entry Page
@Entry
@Component
struct AeroSensePage {
  build() {
    Stack() {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.PureWhite)

      Column() {
        Blank()
        BottomControlBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.PureWhite)
  }
}
