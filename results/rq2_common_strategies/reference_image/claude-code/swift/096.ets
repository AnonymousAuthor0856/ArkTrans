@Entry
@Component
struct AeroSensePage {
  private pureWhite: ResourceColor = '#FFFFFF'
  private offWhite: ResourceColor = '#FAFAFA'
  private textPrimary: ResourceColor = '#1A1A1A'
  private textSecondary: ResourceColor = '#757575'
  private accentGreen: ResourceColor = '#4CAF50'
  private accentWarning: ResourceColor = '#FF9800'
  private dividerColor: ResourceColor = '#EEEEEE'

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        this.TopHeader()
        Scroll() {
          Column({ space: 32 }) {
            this.AirQualityCircle()
            Column({ space: 16 }) {
              Row({ space: 16 }) {
                this.MetricCard({
                  label: 'Temp',
                  value: '23°C',
                  icon: $r('sys.media.ohos_ic_public_info'),
                  statusColor: this.textPrimary
                })
                .layoutWeight(1)
                this.MetricCard({
                  label: 'Humidity',
                  value: '45%',
                  icon: $r('sys.media.ohos_ic_public_arrow_down'),
                  statusColor: this.accentGreen
                })
                .layoutWeight(1)
              }
              Row({ space: 16 }) {
                this.MetricCard({
                  label: 'PM 2.5',
                  value: '12',
                  icon: $r('sys.media.ohos_ic_public_arrow_down'),
                  statusColor: this.accentGreen
                })
                .layoutWeight(1)
                this.MetricCard({
                  label: 'CO2',
                  value: '850',
                  icon: $r('sys.media.ohos_ic_public_warning'),
                  statusColor: this.accentWarning
                })
                .layoutWeight(1)
              }
            }
            this.StatusBanner()
          }
          .padding({ top: 16, bottom: 16 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.pureWhite)

      Column() {
        Blank()
        this.BottomControlBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pureWhite)
  }

  @Builder
  TopHeader() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.textSecondary)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      this.ControlIcon({
        icon: $r('sys.media.ohos_ic_public_settings'),
        bgColor: this.offWhite,
        hasBorder: false
      })
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  AirQualityCircle() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas() {
        Arc(this.getArcOptions(135, 270, false))
          .fill('rgba(0,0,0,0)')
          .stroke(this.offWhite)
          .strokeWidth(40)
          .strokeLineCap(LineCapStyle.Round)
        Arc(this.getArcOptions(135, 113, false))
          .fill('rgba(0,0,0,0)')
          .stroke(this.accentGreen)
          .strokeWidth(40)
          .strokeLineCap(LineCapStyle.Round)
        Circle({ width: 12, height: 12 })
          .fill(this.pureWhite)
          .translate(this.getDotOffsetX(), this.getDotOffsetY())
      }
      .width(220)
      .height(220)

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textSecondary)
          .letterSpacing(2)
        Text('42')
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textPrimary)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(this.accentGreen)
          .opacity(0.1)
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  private getArcOptions(startAngle: number, sweepAngle: number, counterclockwise: boolean): ArcOptions {
    const size = 220
    const lineWidth = 40
    const radius = (size - lineWidth) / 2
    const centerX = size / 2
    const centerY = size / 2
    return {
      x: centerX - radius,
      y: centerY - radius,
      width: radius * 2,
      height: radius * 2,
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle
    }
  }

  private getDotOffsetX(): number {
    const size = 220
    const lineWidth = 40
    const radius = (size - lineWidth) / 2
    const centerX = size / 2
    const angle = (135 + 113) * Math.PI / 180
    return centerX + radius * Math.cos(angle) - 6
  }

  private getDotOffsetY(): number {
    const size = 220
    const lineWidth = 40
    const radius = (size - lineWidth) / 2
    const centerY = size / 2
    const angle = (135 + 113) * Math.PI / 180
    return centerY + radius * Math.sin(angle) - 6
  }

  @Builder
  MetricCard($$: { label: string, value: string, icon: Resource, statusColor: ResourceColor }) {
    Column() {
      Row() {
        Image($$.icon)
          .width(20)
          .height(20)
          .fillColor($$.statusColor)
        Blank()
      }
      .width('100%')
      Blank()
      Column() {
        Text($$.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.textPrimary)
        Text($$.label)
          .fontSize(12)
          .fontColor(this.textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(110)
    .width('100%')
    .backgroundColor(this.offWhite)
    .borderRadius(24)
  }

  @Builder
  StatusBanner() {
    Column() {
      Row() {
        Image($r('sys.media.ohos_ic_public_home'))
          .width(24)
          .height(24)
          .fillColor(this.textPrimary)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(this.textSecondary)
        .lineHeight(22)
        .margin({ top: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .border({ width: 1, color: this.dividerColor, radius: 20 })
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider()
        .color(this.dividerColor)
        .strokeWidth(1)
      Row() {
        this.ControlIcon({
          icon: $r('sys.media.ohos_ic_public_view_list'),
          bgColor: this.pureWhite,
          hasBorder: true
        })
        Blank()
        Button() {
          Row({ space: 8 }) {
            Image($r('sys.media.ohos_ic_public_refresh'))
              .width(18)
              .height(18)
              .fillColor(this.pureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.pureWhite)
          }
        }
        .type(ButtonType.Normal)
        .backgroundColor(this.textPrimary)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        Blank()
        this.ControlIcon({
          icon: $r('sys.media.ohos_ic_public_add'),
          bgColor: this.pureWhite,
          hasBorder: true
        })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.pureWhite)
    }
    .width('100%')
  }

  @Builder
  ControlIcon($$: { icon: Resource, bgColor: ResourceColor, hasBorder: boolean }) {
    Image($$.icon)
      .width(24)
      .height(24)
      .fillColor(this.textPrimary)
      .width(48)
      .height(48)
      .backgroundColor($$.bgColor)
      .borderRadius(24)
      .border($$.hasBorder ? { width: 1, color: this.dividerColor } : undefined)
  }
}
