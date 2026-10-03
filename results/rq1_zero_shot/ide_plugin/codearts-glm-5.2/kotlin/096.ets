class AppTokens {
  static readonly Colors = {
    pureWhite: '#FFFFFFFF',
    offWhite: '#FFFAFAFA',
    textPrimary: '#FF1A1A1A',
    textSecondary: '#FF757575',
    accentGreen: '#FF4CAF50',
    accentGreen10: '#1A4CAF50',
    accentWarning: '#FFFF9800',
    divider: '#FFEEEEEE'
  }
}

@Entry
@Component
struct AeroSenseApp {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  build() {
    Column() {
      Row() {
        Column() {
          Text('Living Room')
            .fontSize(16)
            .fontColor(AppTokens.Colors.textSecondary)
          Text('AeroSense')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.textPrimary)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Row() {
          Text('⚙')
            .fontSize(24)
            .fontColor(AppTokens.Colors.textPrimary)
        }
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor(AppTokens.Colors.offWhite)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ top: 24, bottom: 24, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          Stack() {
            Canvas(this.context)
              .width(220)
              .height(220)
              .onReady(() => {
                let ctx = this.context
                let cx = 110
                let cy = 110
                let radius = 90

                ctx.strokeStyle = AppTokens.Colors.offWhite
                ctx.lineWidth = 40
                ctx.lineCap = 'round'
                ctx.beginPath()
                ctx.arc(cx, cy, radius, 135 * Math.PI / 180, 405 * Math.PI / 180)
                ctx.stroke()

                ctx.strokeStyle = AppTokens.Colors.accentGreen
                ctx.lineWidth = 40
                ctx.lineCap = 'round'
                ctx.beginPath()
                ctx.arc(cx, cy, radius, 135 * Math.PI / 180, 245 * Math.PI / 180)
                ctx.stroke()

                ctx.fillStyle = AppTokens.Colors.pureWhite
                ctx.beginPath()
                ctx.arc(187, 187, 12, 0, Math.PI * 2)
                ctx.fill()
              })

            Column() {
              Text('AQI')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.textSecondary)
                .letterSpacing(2)
              Text('42')
                .fontSize(80)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.textPrimary)
              Text('Excellent')
                .fontSize(16)
                .fontColor(AppTokens.Colors.accentGreen)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .borderRadius(16)
                .backgroundColor(AppTokens.Colors.accentGreen10)
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .height(220)

          Row() {
            MetricCard({ label: 'Temp', value: '23°C', icon: 'ℹ', statusColor: AppTokens.Colors.textPrimary })
              .layoutWeight(1)
            MetricCard({ label: 'Humidity', value: '45%', icon: '✓', statusColor: AppTokens.Colors.accentGreen })
              .layoutWeight(1)
              .margin({ left: 16 })
          }
          .width('100%')

          Row() {
            MetricCard({ label: 'PM 2.5', value: '12', icon: '◉', statusColor: AppTokens.Colors.accentGreen })
              .layoutWeight(1)
            MetricCard({ label: 'CO2', value: '850', icon: '⚠', statusColor: AppTokens.Colors.accentWarning })
              .layoutWeight(1)
              .margin({ left: 16 })
          }
          .width('100%')
          .margin({ top: 16 })

          Column() {
            Row() {
              Text('⌂')
                .fontSize(24)
                .fontColor(AppTokens.Colors.textPrimary)
              Text('Room Analysis')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTokens.Colors.textPrimary)
                .margin({ left: 12 })
            }
            .alignItems(VerticalAlign.Center)

            Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
              .fontSize(14)
              .fontColor(AppTokens.Colors.textSecondary)
              .lineHeight(22)
              .margin({ top: 12 })
          }
          .width('100%')
          .padding(20)
          .border({ width: 1, color: AppTokens.Colors.divider, radius: 20 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Column() {
        Divider()
          .color(AppTokens.Colors.divider)
          .strokeWidth(1)

        Row() {
          Row() {
            Text('☰')
              .fontSize(24)
              .fontColor(AppTokens.Colors.textPrimary)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .border({ width: 1, color: AppTokens.Colors.divider })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Row() {
            Text('↻')
              .fontSize(18)
              .fontColor(AppTokens.Colors.pureWhite)
            Text('Refresh Data')
              .fontSize(14)
              .fontColor(AppTokens.Colors.pureWhite)
              .margin({ left: 8 })
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
          .borderRadius(16)
          .backgroundColor(AppTokens.Colors.textPrimary)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Row() {
            Text('+')
              .fontSize(24)
              .fontColor(AppTokens.Colors.textPrimary)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .border({ width: 1, color: AppTokens.Colors.divider })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.pureWhite)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.pureWhite)
  }
}

@Component
struct MetricCard {
  @Prop label: string
  @Prop value: string
  @Prop icon: string
  @Prop statusColor: string

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(20)
          .fontColor(this.statusColor)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.textPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(AppTokens.Colors.textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .height(110)
    .padding(16)
    .borderRadius(24)
    .backgroundColor(AppTokens.Colors.offWhite)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}