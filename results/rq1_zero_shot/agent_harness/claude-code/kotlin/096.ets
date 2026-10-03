@Entry
@Component
struct AeroSenseApp {
  private readonly PureWhite: string = '#FFFFFFFF'
  private readonly OffWhite: string = '#FFFAFAFA'
  private readonly TextPrimary: string = '#FF1A1A1A'
  private readonly TextSecondary: string = '#FF757575'
  private readonly AccentGreen: string = '#FF4CAF50'
  private readonly AccentWarning: string = '#FFFF9800'
  private readonly DividerColor: string = '#FFEEEEEE'

  build() {
    Column() {
      this.TopHeader()

      Scroll() {
        Column({ space: 32 }) {
          this.AirQualityCircle(42)

          Column({ space: 16 }) {
            Row({ space: 16 }) {
              this.MetricCard('Temp', '23°C', $r('app.media.info'), this.TextPrimary)
                .layoutWeight(1)
              this.MetricCard('Humidity', '45%', $r('app.media.check'), this.AccentGreen)
                .layoutWeight(1)
            }
            Row({ space: 16 }) {
              this.MetricCard('PM 2.5', '12', $r('app.media.check_circle'), this.AccentGreen)
                .layoutWeight(1)
              this.MetricCard('CO2', '850', $r('app.media.warning'), this.AccentWarning)
                .layoutWeight(1)
            }
          }

          this.StatusBanner()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.PureWhite)
  }

  @Builder
  TopHeader() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontColor(this.TextSecondary)
          .fontWeight(FontWeight.Normal)
        Text('AeroSense')
          .fontSize(28)
          .fontColor(this.TextPrimary)
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Image($r('app.media.settings'))
        .width(24)
        .height(24)
        .fillColor(this.TextPrimary)
        .padding(12)
        .backgroundColor(this.OffWhite)
        .borderRadius(24)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  AirQualityCircle(aqi: number) {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.arcSettings)
        .width(220)
        .height(220)
        .onReady(() => {
          let ctx = this.arcSettings
          ctx.clearRect(0, 0, 220, 220)
          let cx = 110
          let cy = 110
          let radius = 80
          let lineWidth = 40

          ctx.lineWidth = lineWidth
          ctx.lineCap = 'round'

          ctx.strokeStyle = this.OffWhite
          ctx.beginPath()
          ctx.arc(cx, cy, radius, (135 * Math.PI) / 180, (405 * Math.PI) / 180)
          ctx.stroke()

          let sweepAngle = 110
          let startRad = (135 * Math.PI) / 180
          let endRad = ((135 + sweepAngle) * Math.PI) / 180
          ctx.strokeStyle = this.AccentGreen
          ctx.beginPath()
          ctx.arc(cx, cy, radius, startRad, endRad)
          ctx.stroke()

          ctx.fillStyle = this.PureWhite
          ctx.beginPath()
          let dotAngle = endRad
          let dotX = cx + radius * Math.cos(dotAngle)
          let dotY = cy + radius * Math.sin(dotAngle)
          ctx.arc(dotX, dotY, 12, 0, Math.PI * 2)
          ctx.fill()
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontColor(this.TextSecondary)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
        Text(aqi.toString())
          .fontSize(80)
          .fontColor(this.TextPrimary)
          .fontWeight(FontWeight.Medium)
        Text('Excellent')
          .fontSize(16)
          .fontColor(this.AccentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('rgba(76, 175, 80, 0.1)')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  private arcSettings: CanvasRenderingContext2D = new CanvasRenderingContext2D()

  @Builder
  MetricCard(label: string, value: string, icon: Resource, statusColor: string) {
    Column() {
      Row() {
        Image(icon)
          .width(20)
          .height(20)
          .fillColor(statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.TextPrimary)
        Text(label)
          .fontSize(12)
          .fontColor(this.TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(110)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(this.OffWhite)
    .borderRadius(24)
  }

  @Builder
  StatusBanner() {
    Column({ space: 12 }) {
      Row() {
        Image($r('app.media.home'))
          .width(24)
          .height(24)
          .fillColor(this.TextPrimary)
        Text('Room Analysis')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextPrimary)
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(this.TextSecondary)
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: this.DividerColor, radius: 20 })
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider()
        .color(this.DividerColor)
        .strokeWidth(1)

      Row() {
        this.ControlIcon($r('app.media.menu'))

        Button() {
          Row() {
            Image($r('app.media.refresh'))
              .width(18)
              .height(18)
              .fillColor(this.PureWhite)
            Text('Refresh Data')
              .fontSize(14)
              .fontColor(this.PureWhite)
              .margin({ left: 8 })
          }
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor(this.TextPrimary)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })

        this.ControlIcon($r('app.media.add'))
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    }
    .width('100%')
    .backgroundColor(this.PureWhite)
  }

  @Builder
  ControlIcon(icon: Resource) {
    Image(icon)
      .width(20)
      .height(20)
      .fillColor(this.TextPrimary)
      .padding(13)
      .border({ width: 1, color: this.DividerColor, radius: 24 })
  }
}
