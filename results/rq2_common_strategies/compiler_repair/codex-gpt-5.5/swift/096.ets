@Entry
@Component
struct Index {
  private readonly pureWhite: string = '#FFFFFF'
  private readonly offWhite: string = '#FAFAFA'
  private readonly textPrimary: string = '#1A1A1A'
  private readonly textSecondary: string = '#757575'
  private readonly accentGreen: string = '#4CAF50'
  private readonly accentWarning: string = '#FF9800'
  private readonly dividerColor: string = '#EEEEEE'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopHeader()
        this.MainContent()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.pureWhite)
      this.BottomControlBar()
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
          .fontColor(this.textSecondary)
        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(this.textPrimary)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(this.offWhite)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  MainContent() {
    Scroll() {
      Column() {
        this.AirQualityCircle(42)
        Blank().height(32)
        this.MetricsGrid()
        Blank().height(32)
        this.StatusBanner()
        Blank().height(112)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .alignItems(HorizontalAlign.Center)
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  @Builder
  AirQualityCircle(aqi: number) {
    Stack() {
      Progress({ value: 42, total: 100, type: ProgressType.Ring })
        .width(220)
        .height(220)
        .color(this.accentGreen)
        .backgroundColor(this.offWhite)
        .style({ strokeWidth: 40 })
      Circle()
        .width(12)
        .height(12)
        .fill(this.pureWhite)
        .offset({ x: -18, y: 82 })
      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textSecondary)
          .letterSpacing(2)
        Text(aqi.toString())
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textPrimary)
        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accentGreen)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(264)
  }

  @Builder
  MetricsGrid() {
    Column() {
      Row() {
        this.MetricCard('Temp', '23°C', 'i', this.textPrimary)
        Blank().width(16)
        this.MetricCard('Humidity', '45%', '✓', this.accentGreen)
      }
      .width('100%')
      Blank().height(16)
      Row() {
        this.MetricCard('PM 2.5', '12', '✓', this.accentGreen)
        Blank().width(16)
        this.MetricCard('CO2', '850', '!', this.accentWarning)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  MetricCard(label: string, value: string, iconName: string, statusColor: string) {
    Column() {
      Row() {
        Text(iconName)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(statusColor)
        Blank()
      }
      .width('100%')
      Blank()
      Column() {
        Text(value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
        Text(label)
          .fontSize(12)
          .fontColor(this.textSecondary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .height(110)
    .layoutWeight(1)
    .padding(16)
    .backgroundColor(this.offWhite)
    .borderRadius(24)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  StatusBanner() {
    Column() {
      Row() {
        Text('⌂')
          .fontSize(24)
          .fontColor(this.textPrimary)
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .margin({ left: 12 })
      }
      .width('100%')
      Blank().height(12)
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(this.textSecondary)
        .lineHeight(22)
    }
    .width('100%')
    .padding(20)
    .borderRadius(20)
    .border({ width: 1, color: this.dividerColor })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider().color(this.dividerColor)
      Row() {
        this.ControlIcon('☰')
        Blank()
        Button() {
          Row() {
            Text('↻')
              .fontSize(18)
              .fontColor(this.pureWhite)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.pureWhite)
              .margin({ left: 8 })
          }
          .justifyContent(FlexAlign.Center)
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .backgroundColor(this.textPrimary)
        .borderRadius(16)
        Blank()
        this.ControlIcon('+')
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.pureWhite)
    }
    .width('100%')
    .backgroundColor(this.pureWhite)
  }

  @Builder
  ControlIcon(iconName: string) {
    Button() {
      Text(iconName)
        .fontSize(24)
        .fontColor(this.textPrimary)
    }
    .width(48)
    .height(48)
    .borderRadius(24)
    .backgroundColor(this.pureWhite)
    .border({ width: 1, color: this.dividerColor })
  }
}