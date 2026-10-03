class AsColors {
  static readonly pureWhite: string = '#FFFFFFFF'
  static readonly offWhite: string = '#FFFAFAFA'
  static readonly textPrimary: string = '#FF1A1A1A'
  static readonly textSecondary: string = '#FF757575'
  static readonly accentGreen: string = '#FF4CAF50'
  static readonly accentWarning: string = '#FFFF9800'
  static readonly divider: string = '#FFEEEEEE'
  static readonly green10: string = '#1A4CAF50'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Column() {
            Text('Living Room')
              .fontSize(16)
              .fontColor(AsColors.textSecondary)
            Text('AeroSense')
              .fontSize(34)
              .fontWeight(FontWeight.Bold)
              .fontColor(AsColors.textPrimary)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(AsColors.textPrimary)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .backgroundColor(AsColors.offWhite)
            .borderRadius(24)
        }
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Scroll() {
          Column() {
            AirQualityCircle({ aqi: 42 })

            Column() {
              Row() {
                MetricCard({ label: 'Temp', value: '23°C', iconName: 'ⓘ', statusColor: AsColors.textPrimary })
                MetricCard({ label: 'Humidity', value: '45%', iconName: '☑', statusColor: AsColors.accentGreen })
              }
              Row() {
                MetricCard({ label: 'PM 2.5', value: '12', iconName: '☑', statusColor: AsColors.accentGreen })
                MetricCard({ label: 'CO2', value: '850', iconName: '⚠', statusColor: AsColors.accentWarning })
              }
            }
            .margin({ top: 32 })

            Column() {
              Row() {
                Text('⌂')
                  .fontSize(24)
                  .fontColor(AsColors.textPrimary)
                Text('Room Analysis')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AsColors.textPrimary)
                  .margin({ left: 12 })
              }

              Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
                .fontSize(14)
                .fontColor(AsColors.textSecondary)
                .lineHeight(22)
                .margin({ top: 12 })
            }
            .alignItems(HorizontalAlign.Start)
            .padding(20)
            .border({ width: 1, color: AsColors.divider, radius: 20 })
            .margin({ top: 32 })
          }
          .padding({ top: 16, bottom: 16 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .padding({ left: 24, right: 24, bottom: 16 })
      }

      Stack() {
        Column() {
          Column() { Blank() }
            .width('100%')
            .height(1)
            .backgroundColor(AsColors.divider)

          Row() {
            Text('☰')
              .fontSize(24)
              .fontColor(AsColors.textPrimary)
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
              .border({ width: 1, color: AsColors.divider, radius: 24 })

            Row() {
              Text('↻')
                .fontSize(18)
                .fontColor(AsColors.pureWhite)
              Text('Refresh Data')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AsColors.pureWhite)
                .margin({ left: 8 })
            }
            .padding({ left: 24, right: 24, top: 16, bottom: 16 })
            .backgroundColor(AsColors.textPrimary)
            .borderRadius(16)
            .margin({ left: 24, right: 24 })

            Text('+')
              .fontSize(24)
              .fontColor(AsColors.textPrimary)
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
              .border({ width: 1, color: AsColors.divider, radius: 24 })
          }
          .padding(24)
          .backgroundColor(AsColors.pureWhite)
          .width('100%')
        }
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .backgroundColor(AsColors.pureWhite)
    .width('100%')
    .height('100%')
  }
}

@Component
struct AirQualityCircle {
  @Prop aqi: number = 0
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  build() {
    Stack() {
      Canvas(this.ctx)
        .width(220)
        .height(220)
        .onReady(() => {
          this.drawCanvas()
        })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AsColors.textSecondary)
        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(AsColors.textPrimary)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AsColors.accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(AsColors.green10)
          .borderRadius(16)
      }
    }
    .width('100%')
    .height(220)
  }

  drawCanvas() {
    let cx = 110
    let cy = 110
    let lineWidth = 40
    let radius = (220 - lineWidth) / 2
    let startAngle = 135 * Math.PI / 180
    let bgEndAngle = (135 + 270) * Math.PI / 180
    let progressEndAngle = (135 + 110) * Math.PI / 180

    this.ctx.strokeStyle = AsColors.offWhite
    this.ctx.lineWidth = lineWidth
    this.ctx.lineCap = 'round'
    this.ctx.beginPath()
    this.ctx.arc(cx, cy, radius, startAngle, bgEndAngle, false)
    this.ctx.stroke()

    this.ctx.strokeStyle = AsColors.accentGreen
    this.ctx.beginPath()
    this.ctx.arc(cx, cy, radius, startAngle, progressEndAngle, false)
    this.ctx.stroke()

    let dotRadius = 12
    let dotAngle = (135 + 110) * Math.PI / 180
    let dotX = cx + radius * Math.cos(dotAngle)
    let dotY = cy + radius * Math.sin(dotAngle)
    this.ctx.fillStyle = AsColors.pureWhite
    this.ctx.beginPath()
    this.ctx.arc(dotX, dotY, dotRadius / 2, 0, Math.PI * 2)
    this.ctx.fill()
  }
}

@Component
struct MetricCard {
  @Prop label: string = ''
  @Prop value: string = ''
  @Prop iconName: string = ''
  @Prop statusColor: string = '#FFFFFF'

  build() {
    Column() {
      Row() {
        Text(this.iconName)
          .fontSize(20)
          .fontColor(this.statusColor)
        Blank()
      }

      Blank()

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AsColors.textPrimary)
        Text(this.label)
          .fontSize(12)
          .fontColor(AsColors.textSecondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(110)
    .layoutWeight(1)
    .backgroundColor(AsColors.offWhite)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 16 })
  }
}