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
                this.MetricCard('Temp', '23°C', 'i', this.textPrimary)
                  .layoutWeight(1)
                this.MetricCard('Humidity', '45%', '✓', this.accentGreen)
                  .layoutWeight(1)
              }
              Row({ space: 16 }) {
                this.MetricCard('PM 2.5', '12', '✓', this.accentGreen)
                  .layoutWeight(1)
                this.MetricCard('CO2', '850', '!', this.accentWarning)
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
        .padding({ left: 24, right: 24, bottom: 16 })
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
      this.CircleIcon('⚙', this.offWhite, this.textPrimary, false)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  AirQualityCircle() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas() {
        Arc({
          x: 20,
          y: 20,
          width: 180,
          height: 180,
          startAngle: 135,
          endAngle: 405
        })
          .fill('rgba(0,0,0,0)')
          .stroke(this.offWhite)
          .strokeWidth(40)
          .strokeLineCap(LineCapStyle.Round)
        Arc({
          x: 20,
          y: 20,
          width: 180,
          height: 180,
          startAngle: 135,
          endAngle: 248
        })
          .fill('rgba(0,0,0,0)')
          .stroke(this.accentGreen)
          .strokeWidth(40)
          .strokeLineCap(LineCapStyle.Round)
        Circle({ width: 12, height: 12 })
          .fill(this.pureWhite)
          .translate(70, 20)
      }
      .width(220)
      .height(220)

      Column({ space: 0 }) {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textSecondary)
          .letterSpacing(2)
        Text('42')
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textPrimary)
          .lineHeight(88)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('rgba(76, 175, 80, 0.1)')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  @Builder
  MetricCard(label: string, value: string, icon: string, statusColor: ResourceColor) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(statusColor)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
        Blank()
      }
      .width('100%')
      Blank()
      Column({ space: 4 }) {
        Text(value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.textPrimary)
        Text(label)
          .fontSize(12)
          .fontColor(this.textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
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
        Text('⌂')
          .fontSize(24)
          .fontColor(this.textPrimary)
          .width(24)
          .height(24)
          .textAlign(TextAlign.Center)
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
        this.CircleIcon('☰', this.pureWhite, this.textPrimary, true)
        Blank()
        Button() {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor(this.pureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.pureWhite)
          }
          .alignItems(VerticalAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor(this.textPrimary)
        .borderRadius(16)
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        Blank()
        this.CircleIcon('+', this.pureWhite, this.textPrimary, true)
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.pureWhite)
    }
    .width('100%')
  }

  @Builder
  CircleIcon(icon: string, bgColor: ResourceColor, iconColor: ResourceColor, hasBorder: boolean) {
    Text(icon)
      .fontSize(24)
      .fontColor(iconColor)
      .textAlign(TextAlign.Center)
      .width(48)
      .height(48)
      .backgroundColor(bgColor)
      .borderRadius(24)
      .border(hasBorder ? { width: 1, color: this.dividerColor } : undefined)
  }
}
